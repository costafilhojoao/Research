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
* type "dynare name" (where name stands for how you named your mod-file; in our case, 'mex') into the command window


*/
close all;


%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

%Endogenous variables

var q       ${\hat q}$       (long_name='gross output')
    y       ${\hat y}$       (long_name='value-added output')
    d       ${\hat d}$       (long_name='foreign debt')
    c       ${\hat c}$       (long_name='consumption')
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
beta gamma delta phi alpha mu omega psi rhoe;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------

beta  = 0.9665;   % Discount factor
gamma = 2;        % intertemporal elasticity of substitution
delta = 0.0075;   % depreciation rate
phi   = 0.028;    % cost of capital adjustment (SG)
alpha = 0.61;     % share of domestic capital in the production
mu    = 0.0667;   % intermediate imported goods share in the gross production
omega = 2.1765;   % exponent of labor in utility function
rhoe  = 0.9864;    % AR(1) coeficient of the foreign prices / domestic prices ratio dynamics
psi   = 0.000742; % Real interest rate sensitivity to debt (SG)

%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------
model(linear); 

%%%%%% Steady state %%%%%%

#cons1     = mu^mu;                                                                                    % auxiliary constant
#cons2     = ( ( ( 1 / beta - 1 + delta )^( -1 ) ) * ( 1 - mu ) * alpha )^( alpha * ( 1 - mu ) );      % auxiliary constant
#cons3     = ( ( 1 - alpha ) * ( 1 - mu ) )^( ( ( 1 - alpha ) * ( 1 - mu ) ) / omega );                % auxiliary constant
#cons4     = 1 / ( 1 - ( mu + alpha * ( 1 - mu ) + ( 1 - alpha ) * ( 1 - mu ) / omega ) );             % auxiliary constant

#qbar      = ( cons1 * cons2 * cons3 )^ cons4;                                                         % gross output
#lbar      = ( ( 1 - alpha ) * ( 1 - mu ) * qbar )^( 1 / omega );                                      % hours of work
#kbar      = ( 1 - mu ) * alpha * qbar * ( 1 / beta + delta -1 )^( -1 );                               % capital stock
#mbar      = mu * qbar;                                                                                % intermediates goods imports
#xbar      = delta * kbar;                                                                             % investment
#rbar      = 1 / beta - 1;                                                                             % real interest rate
#ybar      = qbar - mbar;                                                                              % value-added output
#dbar      = 0.0695 * ybar;                                                                              % foreign debt
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

steady;

stoch_simul(ar=1, order=1, nograph) q, y, d, c, r, k, x, m, e, l, tby, lambda; 