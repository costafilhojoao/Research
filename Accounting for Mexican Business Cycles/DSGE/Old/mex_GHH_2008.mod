/*
Accounting for Mexican Business Cycles
Brinca and Costa-Filho (2022)

Correspondence: 

João Ricardo Costa Filho; joao.filho@novasbe.pt
joaocostafilho.com

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
* type "dynare name" (where name stands for how you named your mod-file) into the command window


*/
close all;

%--------------------------------------------------------------------------------------------------------------------------------------
% 0. Data for the simulations
%--------------------------------------------------------------------------------------------------------------------------------------

de = xlsread('data','Sheet1',['C','54',':','C','86']);   % real exchange rate shocks - 2007Q1-2015Q1
dy = xlsread('data','Sheet1',['D','54',':','D','86']);   % log-linear filtered per capita output cycle - 2007Q1-2015Q1


%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------
%var q y d r c k x m e l tby lambda;  %Endogenous variables

var q       ${\hat q}$       (long_name='gross output')
    y       ${\hat y}$       (long_name='value-added output')
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
beta gamma delta phi alpha mu omega psi rhoe dbar;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------

beta  = 0.98;     % Discount factor
gamma = 2;        % intertemporal elasticity of substitution
delta = 0.1;      % rate of depreciation
delta = 0.064;   % rate of depreciation (Kim)
phi   = 0.028;    % cost of capital adjustment
alpha = 0.4;      % share of domestic capital in the production
mu    = 0.1;      % intermediate imported goods share in the gross production 
omega = 1.455;    % exponent of labor in utility function (SG)
rhoe  = 0.73;     % AR1 of real exchange rate process
psi   = 0.000742; % Real interest rate sensitivity to debt
dbar  = 0.7442;   % foreign debt  

%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------
model(linear); 

%%%% Steady state values %%%%

#cons1     = mu^mu;                                                                                    % auxiliary constant
#cons2     = ( ( ( 1 / beta - 1 + delta )^( -1 ) ) * ( 1 - mu ) * alpha )^ ( alpha * (1 - mu ) );      % auxiliary constant
#cons3     = ( ( ( 1 - alpha ) * ( 1 - mu ) )^( 1 / omega ) )^( ( 1 - alpha ) * ( 1 - mu ) ) / omega;  % auxiliary constant
#cons4     = 1 / ( 1 - ( mu + alpha * ( 1 - mu ) + ( ( 1 - alpha ) * ( 1 - mu ) ) / ( omega ) ) );     % auxiliary constant
#qbar      = ( cons1 * cons2 * cons3 )^ cons4;                                                         % gross output
#lbar      = ( ( 1 - alpha ) * ( 1 - mu ) * qbar )^( 1 / omega );                                      % hours of work
#kbar      = ( 1 - mu ) * alpha * qbar * ( 1 / beta + delta -1 )^( -1 );                               % capital stock
#mbar      = mu * qbar;                                                                                % intermediates goods imports
#xbar      = delta * kbar;                                                                             % investment
#rbar      = 1 / beta - 1;                                                                             % real interest rate
#ybar      = qbar - mbar;                                                                              % value-added output
#cbar      = ybar - rbar * dbar - xbar + mbar;                                                         % consumption
#lambdabar = ( cbar - ( omega^(-1) * ( lbar^omega ) ) )^( -gamma );                                    % Lagrange multiplier
#tbybar    = 1 - ( cbar + xbar + mbar ) / ybar;                                                        % Trade balance over GDP

[name = 'foreign debt dynamics']
dbar * d= ( 1 + rbar ) * dbar * d(-1) + rbar * r(-1) - qbar * q + cbar * c + xbar * x + mbar * e + m;

[name = 'gross output']
q = mu * m + ( 1 - mu ) * alpha * k(-1) + ( 1 - mu ) * ( 1 - alpha ) * l;

[name = 'real exchange rate dynamics']
e = rhoe * e(-1) + ee;

[name = 'capital acumulation']
k = delta * x + ( 1 - delta ) * k(-1);

[name = 'FOC debt']
lambda = lambda(+1) + beta * rbar * r;

[name = 'FOC consumption']
-( 1 / gamma ) * lambdabar^( -( 1 / gamma ) ) * lambda = cbar * c - ( lbar^omega ) * l;

[name = 'FOC hours of work']

( 1 - alpha ) * ( 1 - mu ) * qbar * q = omega * ( lbar^omega ) * l;

[name = 'FOC capital']
lambdabar * lambda = beta * ( lambdabar * lambda(+1) * ( 1 - delta + ( 1 - mu ) * alpha * ( qbar / kbar ) ) + kbar * lambdabar * phi * ( k(+1) - k ) + ( qbar / kbar ) * ( 1 - mu ) * alpha * ( q(+1) - k ) );

[name = 'FOC intermediates goods']
mu * ( qbar / mbar ) * ( q - m )=e;

[name = 'trade balance']
ybar*tbybar*tby=xbar*x-cbar*c+mbar*e+mbar*m-(cbar-xbar-mbar)*y;

[name = 'Real interest rate']
rbar*r=psi*dbar*d;

[name = 'Value-added output']
ybar * y = qbar * q - mbar * ( e + q );

end;
%--------------------------------------------------------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Simulation
%--------------------------------------------------------------------------------------------------------------------------------------

shocks;
var ee;
periods 1:33;
values (de);
end;

steady;

simul(periods=108);

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Model vs Data (2008 crisis)
%--------------------------------------------------------------------------------------------------------------------------------------

t = [2007:0.25:2015]'; 
plot(t,oo_.endo_simul(2,1:33)*100,'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
axis([min(t) max(t) -10 6]);
xlabel('2008 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure19', 'jpg');
hold off;