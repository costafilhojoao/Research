

clear;

clc;

beta  = 0.96;     % Discount factor
gamma = 2;        % intertemporal elasticity of substitution
delta = 0.03;     % depreciation rate
phi   = 0.028;    % cost of capital adjustment (SG)
alpha = 0.61;     % share of domestic capital in the production
mu    = 0.03;     % intermediate imported goods share in the gross production 
omega = 1.455;    % exponent of labor in utility function (SG)
omega = 2.1765;    % exponent of labor in utility function 
rhoe  = 0.86;     % AR coeficient of the real exchange rate process
psi   = 0.000742; % Real interest rate sensitivity to debt (SG)  
psi   = 0.000000001;
 


%%%%%% Steady state %%%%%%

cons1     = mu^mu;                                                                                    % auxiliary constant
cons2     = ( ( ( 1 / beta - 1 + delta )^( -1 ) ) * ( 1 - mu ) * alpha )^( alpha * ( 1 - mu ) );      % auxiliary constant
cons3     = ( ( 1 - alpha ) * ( 1 - mu ) )^( ( ( 1 - alpha ) * ( 1 - mu ) ) / omega );                % auxiliary constant
cons4     = 1 / ( 1 - ( mu + alpha * ( 1 - mu ) + ( 1 - alpha ) * ( 1 - mu ) / omega ) );             % auxiliary constant

qbar      = ( cons1 * cons2 * cons3 )^ cons4;                                                         % gross output
lbar      = ( ( 1 - alpha ) * ( 1 - mu ) * qbar )^( 1 / omega );                                      % hours of work
kbar      = ( 1 - mu ) * alpha * qbar * ( 1 / beta + delta -1 )^( -1 );                               % capital stock
mbar      = mu * qbar;                                                                                % intermediates goods imports
xbar      = delta * kbar;                                                                             % investment
rbar      = 1 / beta - 1;                                                                             % real interest rate
ybar      = qbar - mbar;                                                                              % value-added output
dbar      = 0.02 * ybar;                                                                              % foreign debt
cbar      = ybar - rbar * dbar - xbar - mbar;                                                         % consumption
lambdabar = ( cbar - ( omega^(-1) * ( lbar^omega ) ) )^( -gamma );                                    % Lagrange multiplier
tbybar    = 1 - ( cbar + xbar + mbar ) / ybar;     

qbar