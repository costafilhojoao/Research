/*
Accounting for Mexican Business Cycles
Brinca and Costa-Filho (2022)

Correspondence: 

Jo�o Ricardo Costa Filho; joao.filho@novasbe.pt
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

%Exogenous variables

varexo ee  (long_name='real exchange rate shock')
;

parameters 
beta gamma delta phi alpha mu omega psi rhoe dbar;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------

beta  = 0.98;     % Discount factor
beta= 0.99;
gamma = 2;        % intertemporal elasticity of substitution
delta = 0.1;      % rate of depreciation
delta = 0.064;   % rate of depreciation (Kim)
delta = 0.025;
phi   = 0.028;    % cost of capital adjustment
alpha = 0.4;      % share of domestic capital in the production
mu    = 0.1;      % intermediate imported goods share in the gross production 
mu = 0.05;
omega = 1.455;    % exponent of labor in utility function (SG)
rhoe  = 0.73;     % AR1 of real exchange rate process
rhoe = 0.7;
psi   = 0.000742; % Real interest rate sensitivity to debt
dbar  = 0.7442;   % foreign debt  
%dbar = 20;

%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------
model; 

%%%%%% Dynamic system %%%%%%

[name = 'foreign debt dynamics']
d = ( 1 + r(-1) ) * d(-1) - q + c + x + phi/2 * ( k - k(-1) )^2 + e * m;

[name = 'gross output']
q = ( m^mu ) * ( ( k(-1)^alpha ) * ( l^( 1 - alpha ) ) )^( 1 - mu );

[name = 'real exchange rate dynamics']
log( e ) = rhoe * log( e(-1) ) + ee;

[name = 'capital acumulation']
k = ( 1 - delta ) * k(-1) + x;

[name = 'FOC debt']
lambda = beta * lambda(+1) * ( 1 + r );

[name = 'FOC consumption']
lambda = ( c - ( l^omega ) / omega )^(-gamma);

[name = 'FOC hours of work']
( 1 - alpha ) * ( 1 - mu ) * q = l^omega;

[name = 'FOC capital']
lambda * ( 1 + phi * ( k - k(-1) ) )  = beta * lambda(+1) * ( phi * ( k(+1) - k ) + 1 - delta + ( 1 - mu ) * alpha * q(+1) / k );

[name = 'FOC intermediates goods']
mu * q / m = e;

[name = 'Value-added output']
y = q - m * e;

[name = 'trade balance']
tby = 1 - c / y - x / y - ( phi/2 * ( k - k(-1) )^2 ) / y;

[name = 'Real interest rate']
r = steady_state( r )  + psi * exp( d - dbar ) - 1;



end;

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Steady State
%--------------------------------------------------------------------------------------------------------------------------------------

steady_state_model;

%cons1     = mu^mu;                                                                                    % auxiliary constant
%cons2     = ( ( ( 1 / beta + delta -1 )^( -1 ) ) * ( 1 - mu ) * alpha )^ ( alpha * (1 - mu ) );      % auxiliary constant
%cons3     = ( ( 1 - alpha ) * ( 1 - mu ) )^( ( 1 - alpha ) * ( 1 - mu ) ) / omega;  % auxiliary constant
%cons4     = 1 / ( 1 - ( mu + alpha * ( 1 - mu ) + ( ( 1 - alpha ) * ( 1 - mu ) ) / ( omega ) ) );     % auxiliary constant
%q      = ( cons1 * cons2 * cons3 )^ cons4;                                                         % gross output
q      = ( ( mu^mu ) * ( ( ( 1 / beta + delta -1 )^( -1 ) ) * ( 1 - mu ) * alpha )^ ( alpha * ( 1 - mu ) ) * ( ( 1 - alpha ) * ( 1 - mu ) )^( ( ( 1 - alpha ) * ( 1 - mu ) ) / omega ) ) ^ ( 1 / ( 1 - ( mu + alpha * ( 1 - mu ) + ( ( 1 - alpha ) * ( 1 - mu ) ) / ( omega ) ) ) ); 
l      = ( ( 1 - alpha ) * ( 1 - mu ) * q )^( 1 / omega );                                      % hours of work
k      = ( 1 - mu ) * alpha * q * ( 1 / beta + delta -1 )^( -1 );                               % capital stock
e      = 1;
m      = mu * q / e;                                                                                % intermediates goods imports
x      = delta * k;                                                                             % investment
r      = 1 / beta - 1;                                                                             % real interest rate
y      = q - e * m;                                                                              % value-added output
d      = dbar;
c      = y - r * d - x - m;                                                         % consumption
lambda = ( c - ( omega^(-1) * ( l^omega ) ) )^( -gamma );                                    % Lagrange multiplier
tby    = 1 - ( c + x + m ) / y;                                                        % Trade balance over GDP


end;

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Solving and simulating the model
%--------------------------------------------------------------------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%% 2008 crisis %%%%%%%%%%%%%%%%%%%% 

de = xlsread('data','Sheet1',['C','54',':','C','86']);   % real exchange rate shocks - 2007Q1-2015Q1
dy = xlsread('data','Sheet1',['D','54',':','D','86']);   % log-linear filtered per capita output cycle - 2007Q1-2015Q1

shocks;
var ee;
periods 1:33;
values (de);
end;

steady;
simul(periods=100);

t = [2007:0.25:2015]';
figure 
plot(t,oo_.endo_simul(2,1:33)*100,'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
axis([min(t) max(t) -10 6]);
xlabel('2008 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
%saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acad�micos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure19', 'jpg');
hold off;

%%%%%%%%%%%%%%%%%%%% 1995 crisis %%%%%%%%%%%%%%%%%%%% 

de = xlsread('data','Sheet1',['C','2',':','C','21']);   % real exchange rate shocks - 1994Q1-1998Q3
dy = xlsread('data','Sheet1',['D','2',':','D','21']);   % log-linear filtered per capita output cycle - 1994Q1-1998Q3

de = xlsread('data','Sheet1',['C','5',':','C','21']);   % real exchange rate shocks - 1994Q4-1998Q3
dy = xlsread('data','Sheet1',['D','5',':','D','21']);   % log-linear filtered per capita output cycle - 1994Q4-1998Q3

shocks;
var ee;
%periods 1:20;
periods 1:17;
values (de);
end;

steady;
simul(periods=100);


t = [1994:0.25:1998.75]';
t = [1994.75:0.25:1998.75]';
figure
%plot(t,oo_.endo_simul(2,1:20)*100,'k--','Linewidth',3); hold on;
plot(t,oo_.endo_simul(2,1:17)*100,'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
%axis([min(t) max(t) -14 11]);
xlabel('1995 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
%saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acad�micos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure18', 'jpg');
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
axis([min(t) max(t) -18 3]);
xlabel('Covid crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthWest')
%saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acad�micos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure20', 'jpg');
hold off;


%steady;
%check;

%stoch_simul(ar=1, order=1, nograph) q y d r c k x m e l tby lambda;
