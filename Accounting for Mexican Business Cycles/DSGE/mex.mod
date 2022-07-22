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
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

%Endogenous variables

var q       ${\hat q}$       (long_name='gross output')
    y       ${\hat y}$       (long_name='value-added output')
    d       ${\hat d}$       (long_name='foreign debt')
    c       ${\hat c}$       (long_name='conusmption')
    r       ${\hat r}$       (long_name='real interest rate')
    k       ${\hat k}$       (long_name='capital')
    x       ${\hat x}$       (long_name='investment')
    m       ${\hat m}$       (long_name='intermediates goods imports')
    e       ${\hat e}$       (long_name='real exchange rate')
    l       ${\hat l}$       (long_name='hours of work')
    tby     ${\hat tby}$     (long_name='trade balance / GDP')
    lambda  ${\lambda}$      (long_name='Lagrange multiplier')
;

%Exogenous variables

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
delta = 0.025;
phi   = 0.028;    % cost of capital adjustment
phi = 0.1;
alpha = 0.4;      % share of domestic capital in the production
mu    = 0.1;      % intermediate imported goods share in the gross production 
mu    = 0.07;
omega = 1.455;    % exponent of labor in utility function (SG)
rhoe  = 0.73;     % AR1 of real exchange rate process
rhoe = 0.5;
psi   = 0.000742; % Real interest rate sensitivity to debt
psi   = 0.01;
dbar  = 0.7442;   % foreign debt  


%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------
model(linear); 

%%%%%% Steady state %%%%%%

#cons1     = mu^mu;                                                                                    % auxiliary constant
#cons2     = ( ( ( 1 / beta - 1 + delta )^( -1 ) ) * ( 1 - mu ) * alpha )^( alpha * ( 1 - mu ) );      % auxiliary constant
#cons3     = ( ( 1 - alpha ) * ( 1 - mu ) )^( ( ( 1 - alpha ) * ( 1 - mu ) ) / omega );  % auxiliary constant
#cons4     = 1 / ( 1 - ( mu + alpha * ( 1 - mu ) + ( 1 - alpha ) * ( 1 - mu ) / omega ) );     % auxiliary constant
#qbar      = ( cons1 * cons2 * cons3 )^ cons4;                                                         % gross output
#lbar      = ( ( 1 - alpha ) * ( 1 - mu ) * qbar )^( 1 / omega );                                      % hours of work
#kbar      = ( 1 - mu ) * alpha * qbar * ( 1 / beta + delta -1 )^( -1 );                               % capital stock
#mbar      = mu * qbar;                                                                                % intermediates goods imports
#xbar      = delta * kbar;                                                                             % investment
#rbar      = 1 / beta - 1;                                                                             % real interest rate
#ybar      = qbar - mbar;                                                                              % value-added output
#cbar      = ybar - rbar * dbar - xbar - mbar;                                                         % consumption
#lambdabar = ( cbar - ( omega^(-1) * ( lbar^omega ) ) )^( -gamma );                                    % Lagrange multiplier
#tbybar    = 1 - ( cbar + xbar + mbar ) / ybar;                                                        % Trade balance over GDP


%%%%%% Log-linear dynamic system %%%%%%


[name = 'foreign debt dynamics']
dbar * d = ( 1 + rbar ) * dbar * d(-1) + rbar * r(-1) - qbar * q + cbar * c + xbar * x + mbar * e + m;

[name = 'gross output']
q = mu * m + ( 1 - mu ) * alpha * k(-1) + ( 1 - mu ) * ( 1 - alpha ) * l;

[name = 'real exchange rate dynamics']
e = rhoe * e(-1) + ee;

[name = 'capital acumulation']
k = ( 1 - delta ) * k(-1) + xbar * x;

[name = 'FOC debt']
lambda = lambda(+1) + beta * rbar * r;

[name = 'FOC consumption']
-( 1 / gamma ) * lambdabar^( -( 1 / gamma ) ) * lambda = cbar * c - ( lbar^omega ) * l;

[name = 'FOC hours of work']

( 1 - alpha ) * ( 1 - mu ) * qbar * q = omega * ( lbar^omega ) * l;

[name = 'FOC capital']
lambdabar * lambda = beta * ( lambdabar * lambda(+1) * ( 1 - delta + ( 1 - mu ) * alpha * ( qbar / kbar ) ) + kbar * lambdabar * phi * ( k(+1) - k ) + ( qbar / kbar ) * ( 1 - mu ) * alpha * ( q(+1) - k ) );

[name = 'FOC intermediates goods']
mu * ( qbar / mbar ) * ( q - m ) = e;

[name = 'trade balance']
ybar * tbybar * tby = (cbar + xbar ) * y - cbar * c - xbar * x;

[name = 'Real interest rate']
rbar * r = psi * dbar * d;

[name = 'Value-added output']
ybar * y = qbar * q - mbar * ( e + q );

end;

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Solving and simulating the model
%--------------------------------------------------------------------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%% 1995 crisis %%%%%%%%%%%%%%%%%%%% 

de = xlsread('data','Sheet1',['C','2',':','C','21']);   % real exchange rate shocks - 1994Q1-1998Q3
dy = xlsread('data','Sheet1',['D','2',':','D','21']);   % log-linear filtered per capita output cycle - 1994Q1-1998Q3

shocks;
var ee;
periods 1:20;
values (de);
end;

steady;
simul(periods=100);

t = [1994:0.25:1998.75]';
figure
plot(t,oo_.endo_simul(2,1:20)*100,'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
%ylim([min( dy )*1.2 max( dy )*1.1])
xlabel('1995 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure9', 'jpg');
hold off;

%%%%%%%%%%%%%%%%%%%% 2008 crisis %%%%%%%%%%%%%%%%%%%% 

de = xlsread('data','Sheet1',['C','57',':','C','86']);   % real exchange rate shocks - 2007Q4-2015Q1
dy = xlsread('data','Sheet1',['D','57',':','D','86']);   % log-linear filtered per capita output cycle - 2007Q4-2015Q1

shocks;
var ee;
periods 1:30;
values (de);
end;

steady;
simul(periods=100);

t = [2007.75:0.25:2015]';
figure 
%plot(t, oo_.endo_simul(2,4:33) * 100, 'k--', 'Linewidth', 3 ); hold on;
plot(t, oo_.endo_simul(2,1:30) * 100, 'k--', 'Linewidth', 3 ); hold on;
%plot(t, dy, 'k-', 'Linewidth', 3 ); 
plot(t, dy, 'k-', 'Linewidth', 3 ); 
axis("square")
xlim([min( t ) max( t )])
%ylim([min( dy )*1.2 max( dy )*1.1])
xlabel('2008 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure10', 'jpg');
hold off;

%%%%% Covid crisis %%%%%

de = xlsread('data','Sheet1',['C','104',':','C','109']);   % real exchange rate shocks - 2019Q3-2020Q4
dy = xlsread('data','Sheet1',['D','104',':','D','109']);   % log-linear filtered per capita output cycle - 2019Q3-2020Q4

shocks;
var ee;
periods 1:6;
values (de);
end;

steady;
simul(periods=100);

t = [2019.75:0.25:2021]'; 
figure
plot(t,oo_.endo_simul(2,1:6)*100,'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
%ylim([min( dy )*1.2 max( dy )*1.1])
xlabel('Covid crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthWest')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure11', 'jpg');
hold off;
