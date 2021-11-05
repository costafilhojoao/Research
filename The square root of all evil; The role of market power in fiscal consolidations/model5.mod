%What if? The role of market power in the Portuguese twin recessions
%Correspondence: João Ricardo Costa Filho; joao.costa@fgv.br
% We follow Farmer, Khramov Nicolò JECD 2015 paper: "Solving and estimating indeterminate DSGE models"

//////////////////////////////////////////////////////////////////////////////////////////////////
//This is a free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.  See <http://www.gnu.org/licenses/> for more information.
//////////////////////////////////////////////////////////////////////////////////////////////////

close all;

%--------------------------------------------------------------------------------------------------------------------------------------
% 0. Data for the quantitaive exercises
%--------------------------------------------------------------------------------------------------------------------------------------

%dgov   = xlsread('data','Sheet1',['B','2',':','B','101']);   %observed Log-detrended government spending 
%dgov   = xlsread('data','Sheet1',['B','2',':','B','26']);   %observed Log-detrended government spending 

%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

%Endogenous variables
var C, H, lambda, P, W, B, y, Y, PI, pD, MC, theta, mu, e, CD, CF, PD, PF, GD, GF, G, T, A, i, X, AC, ACD, ACF, lambdaS, thetaS, yS, pDS, YS, PS;

% C      :  aggregate real consumption
% H      :  aggregate hours of work
% P      :  aggregate price index,
% lambda :  households' Hamiltonian multiplier
% W      :  wage rate
% B      :  stock of net assets
% PI     :  aggregate profits
% T      :  lump-sum tax
% G      :  aggregate real government consumption
% p      :  individual price
% MC     :  individual marginal cost,
% theta  :  firms' Hamiltonian multiplier
% y      :  individual output
% e      :  demand shifter
% A      :  productivity
% mu     :  individual markup
% Y      :  aggregate real output, as value added
% X      :  aggregate real net exports
% i      :  nominal interest rate
%AC, ACD, ACF

%Exogenous variables
varexo sA sG, si, sunspot, sunspot2, sunspot3, sunspot4, sunspot5, sunspot6; 

% sA : productivity shock
% sG : government spending shock
% si : interest rate shock

parameters 
psi sigma alpha phi eta gamma omega rho zetaA zetaG zetai zetaX kappa n s varphi;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------
sigma = 2.9;                              % price-elasticity of demand 
s = sigma;
n = 0.5;
alpha = 1/3;                              % 1 - alpha: share of labor in the production
phi   = 0.75;                             % future demand sensitivity to current sales
eta = 0.5 / 4;
rho   = ( ( 1 + 0.09 )^( 1 / 4 ) ) - 1 ;  % discount rate 
gamma = 2;                                % elasticity of intertemporal substitution
omega = 1.455;                            % exponent of labor in utility function 
zetaA = 0.9;                              % technology process autoregressive weight
zetaG = 0.9;                              % government spending process autoregressive weight
zetai = 0.9;
zetaX = 0.9;
kappa = 0.00742;
psi = .3105276180;
varphi = 1;

%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------

model; 

%%%%% Household block
% [1] eq. () - FOC for consumption
[name = 'FOC for consumption']
( C - ( H ^ omega ) / omega ) ^ ( - gamma ) = lambda * P;

% [2] eq. () - FOC for labour (hours)
[name = 'FOC for labour (hours)']
H ^ ( omega - 1 ) * (  ( C - ( H ^ omega ) / omega ) ^ ( - gamma ) ) = W * lambda;

% [3] eq. () - Euler equation
[name = 'Euler equation']
%lambda(+1) * ( 1 +  i ) = ( 1 + rho )  * lambda;

lambdaS * ( 1 +  i ) = ( 1 + rho )  * lambda;

%[4]
lambdaS - lambdaS(-1) = sunspot;

% [5] eq. () - Budget constraint
[name = 'Budget constraint'] 
B = ( 1 + i(-1) ) * B(-1) + W * H + PI - T - P * C;

% [6] eq. () - Aggregate consumption
[name = 'Aggregate consumption']
C = ( ( 1 - n )^( 1 / s ) * CD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * CF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

% [7] eq. () - Household's domestic-produced goods demand
[name = 'Household s domestic-produced goods demand']
CD = ( 1 - n ) * ( PD / P ) ^( - s) * C;

% [8] eq. () - Household's imported goods demand
[name = 'Household s imported goods demand']
CF = n * ( PF / P ) ^( - s) * C;

% [9] eq. () - Price index
[name = 'Price index']
P = ( ( 1 - n ) * PD ^ ( 1 - s ) + n * PF ^ ( 1 - s ) )^ ( 1 / ( 1 - s ) );  

%%%%% Government block
% [10] eq. () - Balanced budget (Ricardian equivalence)
[name = 'Balanced budget (Ricardian equivalence)']
P * G = T;

% [11] eq. () - Exogenous process of government spending
[name = 'Exogenous process of government spending']
log( G ) = ( 1 - zetaG) * log( STEADY_STATE(G) ) + zetaG * log ( G(-1) ) + sG;

% [12] eq. () - Goverment expenditure
[name = 'Goverment expenditure']
G = ( ( 1 - n )^( 1 / s ) * GD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * GF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

% [13] eq. () - Government's domestic-produced goods demand
[name = 'Government s domestic-produced goods demand']
GD = ( 1 - n ) * ( PD / P ) ^( - s) * G;

% [14] eq. () - Government's imported goods demand
[name = 'Government s imported goods demand']
GF = n * ( PF / P ) ^( - s) * G;

%%%%% Rest of the world block

% [16] eq. () - Exogenous process of nominal interest rates 
%i = ( 1 - zetai ) * STEADY_STATE(i) + zetai * i(-1) + kappa * ( exp( STEADY_STATE(B) / ( STEADY_STATE(P) * STEADY_STATE(Y) ) - B / ( P * Y )  ) - 1 ) + si;

[name = 'Exogenous process of nominal interest rates']
i = ( 1 - zetai ) * STEADY_STATE(i) + zetai * i(-1) + kappa * ( exp( STEADY_STATE(B) - B  ) - 1 ) + si;

%%%%% Firms block

% [17] eq. () - Adjustment costs
[name = 'Adjustment costs']
AC = varphi / 2 * ( pD / pD(-1) - 1 ) ^2 * P * Y;

% [18] eq. () - 
[name = 'Adjustment costs composition']
AC = ( ( 1 - n )^( 1 / s ) * ACD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * ACF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

% [19] eq. () - 
[name = 'Share of adjustment costs purchased via domestic goods']
ACD = ( ( 1 - n ) * ( PD / P ) ^( - s) ) * AC;

% [20] eq. () - 
[name = 'Share of adjustment costs purchased via imported goods']
ACF = ( n * ( PF / P ) ^( - s) ) * AC;

% [21] eq. () - pricing equation
%( ( sigma - 1 ) / sigma ) * pD - MC + phi * theta = 0;

[name = 'Pricing equation']
theta * phi =   MC -  ( sigma - 1 ) / sigma * pD - varphi / sigma * ( pD / pD(-1) - 1 ) * P * Y * pD / pD(-1) * 1 / y;

% [22] eq () - 
%1 / sigma * ( pD(+1) * y(+1) / e ) - ( 1 - eta ) * theta(+1) = ( 1 + rho ) * theta;

%1 / sigma * ( pDS * yS / e ) - ( 1 - eta ) * thetaS = ( 1 + rho ) * theta;

1 / sigma * ( pDS * yS / e ) - ( 1 - eta ) * thetaS - varphi / sigma * ( pDS / pD - 1 ) * P(+1) * YS / e * pDS / pD = theta * ( 1 + rho );

%[23]
pDS - pDS(-1) = sunspot4;

%[24]
thetaS - thetaS(-1) = sunspot2;

%[25]
yS - yS(-1) = sunspot3;

%[25]
YS - YS(-1) = sunspot5;

%[25]
PS - PS(-1) = sunspot6;


% [17] eq. () - Marginal cost
MC = ( W / ( ( 1 - alpha ) * A ^ ( 1 / ( 1 - alpha ) ) ) ) * y ^ ( alpha / ( 1 - alpha ) )  ;

% [18] eq. () - Individual markup
mu = pD / MC;

% [19] eq. () - Law of motion for the demand shifter
e = phi * y + ( 1 - eta ) * e(-1);

% [20] eq. () - Exogenous process of productivity
log( A ) = ( 1 - zetaA) * log( STEADY_STATE(A) ) + zetaA * log ( A(-1) ) + sA;

%%%%% Aggregation block

% [21] eq. () - Aggregate domestic price-level
PD = ( psi * e(-1) ) ^( -1 / ( sigma - 1 ) ) * pD;

% [22] eq. () - Aggregate output
Y = ( psi * e(-1) ) ^( 1 / ( sigma - 1 ) ) * A * H ^ ( 1 - alpha );

% [23] eq. () - Aggregate resources
%Y = C + G + X - PF / P * ( CF + GF );

Y = C + G + X + ACD - PF / P * ( CF + GF + ACF );

% [24] eq. () - Aggregate profits
%PI = PD * Y - W * H;

%PI = PD * Y - W * H - AC;

% [25] eq. ()
y = ( ( psi * e(-1) ) ^( - 1 / ( sigma - 1 ) ) ) * Y;

end;
%--------------------------------------------------------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Steady State
%--------------------------------------------------------------------------------------------------------------------------------------

steady_state_model;
%initval;

C      = .3557175818;
H      = 373 / 1022;
lambda = 27.19198925;
P      = .9461895912;
W      = .5981436922;
B      = 1.138337472;
y      = .5367209131;
Y      = y;
PI     = .2647439322;
pD     = .9000000000;
MC     = .6101072758;
theta  = .2726947119e-1;
mu     = pD / MC;
e      = 3.220325478;
CD     = .2056405421;
CF     = .1514997855;
PD     = pD;
PF     = 1;
GD     = .1046381317;
GF     = .7708914954e-1;
G      = .1810033313;
T      = P * G;
A      = 1.050936705;
i      = rho;
X      = .2415889343;
AC     = 0;
ACD    = 0;
ACF    = 0;


lambdaS = lambda;
thetaS  = theta;
yS      = y; 
pDS    = pD;   

end;

%qz_zero_threshold = 1e-15;
steady;
%resid;

model_diagnostics;

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Simulation
%--------------------------------------------------------------------------------------------------------------------------------------

shockA = oo_.steady_state(23) * 0.01;
shockG = oo_.steady_state(21) * 0.03;

shocks;
var sG = shockG;
var sA = shockA;
end;

stoch_simul(ar=1, order=1,irf=100)  PD MC mu W CD CF H GD GF C i e Y;

%var sG;
%periods 1:29;
%values (dgov);
%end;

%simul(periods=29);



%--------------------------------------------------------------------------------------------------------------------------------------
% 6. Bayesian estimation 
%--------------------------------------------------------------------------------------------------------------------------------------

%estimated_params;

%par     distribution     parameters
%sigma,   normal_pdf,     .84,.05; 
%s,       normal_pdf,     .38, .03;
%phi,     inv_gamma_pdf,  .078, inf;
%eta,     inv_gamma_pdf,  .082, inf;
%end;
%varobs Y C G X mu;
%estimation(datafile=simudata,mh_replic=1000,mh_jscale=.5);
 
%TBD