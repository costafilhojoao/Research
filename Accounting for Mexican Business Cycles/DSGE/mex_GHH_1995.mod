/*
Accounting for Mexican Business Cycles
Brinca and Costa-Filho (2022)

Correspondence: 

João Ricardo Costa Filho; joao.filho@novasbe.pt
https://sites.google.com/site/joaoricardocostafilho

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
* type "dynare mex_GHH" (or how you named your mod-file) into the command window


*/
close all;

%--------------------------------------------------------------------------------------------------------------------------------------
% 0. Data for the simulations
%--------------------------------------------------------------------------------------------------------------------------------------

de = xlsread('data','Sheet1',['C','2',':','C','21']);   % real exchange rate shocks - 1994Q1-1998Q3
dy = xlsread('data','Sheet1',['D','2',':','D','21']);   % log-linear filtered per capita output cycle - 1994Q1-1998Q3


%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------
%var y d r c k x m e l tby lambda;  %Endogenous variables

var y       ${\hat y}$       (long_name='output deviation from steady state')
    d       ${\hat d}$       (long_name='foreign debt deviation from steady state')
    c       ${\hat c}$       (long_name='conusmption deviation from steady state')
    r       ${\hat r}$       (long_name='real interest rate deviation from steady state')
    k       ${\hat k}$       (long_name='capital deviation from steady state')
    x       ${\hat x}$       (long_name='investment deviation from steady state')
    m       ${\hat m}$       (long_name='intermediates goods imports deviation from steady state')
    e       ${\hat e}$       (long_name='real exchange rate deviation from steady state')
    l       ${\hat l}$       (long_name='hours of work deviation from steady state')
    tby     ${\hat tby}$     (long_name='trade balance / GDP deviation from steady state')
    lambda  ${\lambda}$      (long_name='Lagrange multiplier deviation from steady state')
;

varexo ee  (long_name='real exchange rate shock')
;

parameters 
beta gamma delta phi alpha mu omega psi rhoe rbar dbar cons1 cons2 cons3 cons4 ybar lbar kbar mbar xbar cbar tbybar lambdabar;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------
beta=0.98;     %Discount factor (Kim)
gamma=2;       %intertemporal elasticity of substitution (SG)
delta=0.1;     %rate of depreciation (SG)
%delta=0.064;  %rate of depreciation (Kim)
phi=0.028;     %cost of capital adjustment (SG)
alpha=0.4;     %share of domestic capital in the production (Kim)
mu=0.1;        %intermediate imported goods share in the production 
omega=1.455;   %exponent of labor in utility function (SG)
rhoe=0.73;     %AR1 of real exchange rate process (Table 2, Flexible prices column)
psi=0.000742;  % (SG)


%% Steady state values %%

dbar=0.7442;   % foreign debt

rbar=1/beta-1; % real interest rate
cons1=mu^mu;   % auxiliary constant
cons2=(((1/beta-1+delta)^(-1))*(1-mu)*alpha)^alpha;
cons3=((((1-alpha)*(1-mu))^(1/omega))^(1-alpha))^(1-mu);
cons4=1/(1-mu-alpha*(1-mu)-(((1-alpha)*(1-mu))/(omega)));
ybar=(cons1*cons2*cons3)^(1/cons4);
lbar=((1-alpha)*(1-mu)*ybar)^(1/omega);
kbar=(1-mu)*alpha*ybar*(1/beta + delta -1)^(-1);
mbar=mu*ybar;
xbar=delta*kbar;
cbar=ybar-rbar*dbar-xbar+mbar;
tbybar=1-(cbar+xbar+mbar)/ybar;
lambdabar=(cbar-(omega^(-1)*(lbar^omega)))^(-gamma);
%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------
model(linear); 

dbar*d=(1+rbar)*dbar*d(-1)+rbar*r(-1)-ybar*y+cbar*c+xbar*x+mbar*e+m;
y=mu*m+(1-mu)*alpha*k(-1)+(1-mu)*(1-alpha)*l;
e=rhoe*e(-1)+ee;
k=delta*x+(1-delta)*k(-1);
lambda=lambda(+1)+beta*rbar*r;
-(1/gamma)*lambdabar^(-(1/gamma))*lambda=cbar*c-(lbar^omega)*l;
(1-alpha)*(1-mu)*ybar*y=omega*(lbar^omega)*l;
lambdabar*lambda=beta*(lambdabar*lambda(+1)*(1-delta+(1-mu)*alpha*(ybar/kbar))+kbar*lambdabar*phi*(k(+1)-k)+(ybar/kbar)*(1-mu)*alpha*(y(+1)-k));
mu*(ybar/mbar)*(y-m)=e;
ybar*tbybar*tby=xbar*x-cbar*c+mbar*e+mbar*m-(cbar-xbar-mbar)*y;
rbar*r=psi*dbar*d;
end;
%--------------------------------------------------------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Simulation
%--------------------------------------------------------------------------------------------------------------------------------------

shocks;
var ee;
periods 1:20;
values (de);
end;

steady;

simul(periods=20);

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Model vs Data (1994/1995 crisis)
%--------------------------------------------------------------------------------------------------------------------------------------

t = [1994:0.25:1998.75]';
plot(t,oo_.endo_simul(1,1:20)*100,'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
axis([min(t) max(t) -14 11]);
xlabel('1995 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure18', 'jpg');
hold off;
