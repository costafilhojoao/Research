%What if? The role of market power in the Portuguese twin recessions
%Brito, P.; Costa, L.; Costa-Filho, J.; Santos, C..
%Correspondence: João Ricardo Costa Filho; joao.costa@fgv.br

close all;

%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

%Endogenous variables
var c h d g y P A r w PI lambda theta nxy varepsilon MgC mu;

% c  : consumption
% h  : hours of work
% d  : foreign debt
% g  : government expenditure
% y  : output
% P  : price
% A  : total factor productivity
% r  : real interest rate
% w  : real wage
% PI : firms' profits
% lambda :
% theta :
% nxy:
% varepsilon

%Exogenous variables
varexo ea eg; 

% ea :
% eg :

parameters 
psi sigma alpha phi eta beta kappa gamma omega xi rhoa rhog siga sige rstar hbar doy goy;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------
psi   = .6666666709;
sigma = 2.9;
alpha = 1/3;         %share of domestic capital in the production
phi   = 0.75; 
eta   = 0.5;  
beta  = 1 / ( ( 1 + 0.09 )^( 1 / 4 ) ); 
%beta = 1/1.02;
%kappa = 0.000742;
kappa = 1;
gamma = 2;        %intertemporal elasticity of substitution
omega = 1.455;    %exponent of labor in utility function 
xi    = 0.028;    %cost of capital adjustment
rhoa  = 0.9;
rhog  = 0.8;
siga  = 0.01;
sige  = 0.1;
doy   = 0;        %equilibrium aggregate level of foreign debt
hbar  = 1865 / ( 365 * 24 );
%hbar  = 1865 / ( 365 * 14 );
rstar = 1/beta - 1;
goy   = 0.341;

%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------

model; 

#Abar = 1;
#dbar = 0;
#ybar = A * h ^ ( 1 - alpha );
#gbar = goy * y;

%% Firms
% eq. (36) - Profits
PI = P * y - w * h / P;

% eq. (37) - Price dynamics 
P = ( psi * varepsilon(-1) / y ) ^ ( 1 / sigma );

% eq. (39) - Production function
y = A * h ^ ( 1 - alpha );

% eq. (40) - Exogenous technological process
log( A ) = ( 1 - rhoa) * log( Abar ) + rhoa * log ( A(-1) ) + ea;

% eq. (41) - 
varepsilon = phi * y + ( 1 - eta ) * varepsilon(-1); 

% eq. (43) - Implicit Labor demand
( 1 - alpha) * y / h * ( P * ( sigma - 1 ) / sigma + theta * phi ) = w / P;

% eq. (44) - 
theta = beta / sigma * P(+1) * y(+1) / varepsilon + beta * theta(+1) * ( 1 - eta );

%% Households

% eq. (47) - Foreign debt dynamics
d = ( 1 + r ) * d(-1) - w / P * h - PI / P + c + g; 

%eq. (49) - Interest rate dynamics
r = rstar + kappa * ( exp( d(-1) - dbar ) - 1 );

%eq. (51) - Euler equation
lambda = beta * lambda(+1) * ( 1 + rstar + kappa * ( exp( d(-1) - dbar ) - 1 ) );

%eq. (54) - Marginal utility of consumption
( c - ( h ^ omega ) / omega ) ^ ( - gamma ) = lambda;

%eq. (55) - Implicit labor Supply
h ^ ( omega - 1 ) * (  ( c - ( h ^ omega ) / omega ) ^ ( - gamma ) ) = w * lambda / P;

%% Closing the model

%eq. (57) - Trade balance
1 - c/y - g/y = nxy;

%eq. (58) - Exogenous process for government spending
log( g ) = ( 1 - rhog) * log( gbar ) + rhog * log ( g(-1) ) - eg;

MgC = w / ( ( 1 - alpha ) * y / h );

mu = P / MgC;

end;
%--------------------------------------------------------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Steady State
%--------------------------------------------------------------------------------------------------------------------------------------

%steady_state_model;
initval;
A          = 1;
P          = ( psi * phi / eta ) ^ ( 1 / sigma );
r          = rstar;
theta      = beta * eta / (sigma * phi ) * P * ( 1 -  beta * ( 1 - eta ) ) ^ -1;
h          = hbar;
y          = A * h ^ ( 1 - alpha );
varepsilon = phi * y / eta;
w          = P* ( ( 1 - alpha ) * y / h * ( P * ( sigma - 1 ) / sigma + theta * phi ) );
PI         = P * y - w / P * h;
d          = doy * y;
g          = goy * y;
nxy        = r * d / y;
c          = y - g - nxy * y;
lambda     = ( c - ( h ^ omega ) / omega ) ^ -gamma; 
MgC        = ( w / ( ( 1 - alpha ) * y / h ) ) / P;
mu         = P / MgC;

end;

steady;
resid;

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Impulse-response functions
%--------------------------------------------------------------------------------------------------------------------------------------

shocks;
var eg  = 0.2;
end;

steady;

stoch_simul(hp_filter = 1600, order = 1, irf = 20);

a = oo_.irfs.mu_eg(1,:);
m = [0, a ];

plot(1:21, m ) 
title('Markup')




