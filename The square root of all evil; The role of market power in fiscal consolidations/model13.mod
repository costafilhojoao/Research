/*
The square root of all evil: the role of market power in Fiscal consolidations
Brito, P., Costa, L., Costa Filho, J., and Santos, C.
Correspondence: João Ricardo Costa Filho; joao.costa@fgv.br

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

*/

/* 
 * 1. make sure you set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
 *  otherwise Matlab will say "Undefined function 'dynare' for input arguments of type 'char'."
 *
 * 2. make sure that your Matlab-path is set to the folder where your .mod-file is saved; otherwise Dynare will not find the mod-file
 *  otherwise Dynare will say "Error using dynare (line 96); DYNARE: can't open myRBCmodel.mod"
 *  You can set the path for example by right-clicking on the name of the file in the gray status-bar 
 *  of the editor and choosing "Change current folder to..."

 * 3. Type "dynare myRBCmodel" (or how you named your mod-file) into the command window
*/


%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

%% Endogenous variables

var C, H, lambda, P, W, B, y, Y, PI, pD, MC, theta, mu, e, CD, CF, PD, PF, GD, GF, T, G, A, i, X, AC, ACD, ACF, lambdaS, thetaS, yS, pDS, YS, PS;

% C       : aggregate real consumption
% H       : aggregate hours of work
% P       : aggregate price index,
% lambda  : households' Hamiltonian multiplier
% W       : wage rate
% B       : stock of net assets
% PI      : aggregate profits
% T       : lump-sum tax
% G       : aggregate real government consumption
% p       : individual price
% MC      : individual marginal cost,
% theta   : firms' Hamiltonian multiplier
% y       : individual output
% e       : demand shifter
% A       : productivity
% mu      : individual markup
% Y       : aggregate real output, as value added
% X       : aggregate real net exports
% i       : nominal interest rate
% AC      : aggregate adjustment costs
% ACD     : adjustment costs purchased with domestic goods 
% ACF     : adjustment costs purchased with imported goods
% lambdaS : lambda forecasting error*
% thetaS  : theta forecasting error*
% yS      : y forecasting error*
% pDS     : pD forecasting error*
% YS      : Y forecasting error*
% PS      : P forecasting error*


% *Implementation of the DSGE simulation follows Farmer and Khramov JECD 2015 paper: 
% "Solving and estimating indeterminate DSGE models"


%% Exogenous variables

varexo sA, sG, si, sPF, sunspot, sunspot2, sunspot3, sunspot4, sunspot5, sunspot6; 

% sA : productivity shock
% sG : government spending shock
% si : interest rate shock
% sunspot, sunspot2, sunspot3, sunspot4, sunspot5, sunspot6

parameters 
psi sigma alpha phi eta gamma omega rho zetaA zetaG zetai zetaPF kappa n s varphi, gshare, nx, Hbar, pDbar, PFbar, PDbar Pbar Wbar thetabar;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------

%%%% Households block
rho   = ( ( 1 + 0.09 )^( 1 / 4 ) ) - 1 ;  % discount rate 
gamma = 2;                                % elasticity of intertemporal substitution
omega = 1.455;                            % exponent of labor in utility function 
omega = 1.5;                            % exponent of labor in utility function 
Hbar = 373 / 1022;
n     = 0.5;                              % share of imported goods into total consumption
s     = 2.9;                              % elasticity of substitution between domestic and imported goods
s     = 2.5;                              % elasticity of substitution between domestic and imported goods
kappa = 0.00742;                          % interest rate sensitivity to savings


%%%% Government block
zetaG  = 0.98;                            % persistence in the government-spending process
gshare = 0.3372392;
gshare = 0.33;

%%%%% Rest of the world block
zetai = 0.9;                              % persistence in the nominal interest rate process
zetaPF = 0.25;                            % persistence in the foreign prices process
nx = -0.08;
PFbar     = 1;


% Firms block
sigma = s;                                % price-elasticity of demand 
phi   = 0.5;                              % firm's future demand sensitivity to current sales
eta = 0.5 / 4;                            % Firm's demand "depreciation"
zetaA = 0.6;                              % persistence of the productivity process

Pbar      = 0.95;
pDbar     = ( ( Pbar ^( 1 - s) - n * PFbar ^( 1 - s ) ) / ( 1 - n) ) ^ ( 1 / ( 1 - s ) );
PDbar     = pDbar;
Wbar      = Hbar ^ ( omega - 1 ) * Pbar;
thetabar = 1 / ( sigma * ( 2 + rho - eta ) ) * pDbar * eta / phi;
alpha = 1/3;                              % 1 - alpha: labor exponent in the production function

%Demand scaling factor consistent with steady state value for hours of work
psi = eta /  phi * ( 1 - alpha ) / ( Hbar * Wbar ) * ( thetabar * phi + (sigma - 1 ) / sigma * pDbar );

varphi = 0.2;                             % adjusment costs scaling parameter


%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------

model; 

%%%%%%%%%%%%% Household block %%%%%%%%%%%%% 

% eq. ()
[name = 'FOC for consumption']
( C - ( H ^ omega ) / omega ) ^ ( - gamma ) = lambda * P;

% eq. ()
[name = 'FOC for labour (hours)']
H ^ ( omega - 1 ) * (  ( C - ( H ^ omega ) / omega ) ^ ( - gamma ) ) = W * lambda;

% eq. ()
[name = 'Euler equation']
lambdaS * ( 1 +  i ) = ( 1 + rho )  * lambda;

%
[name = 'S: lambda forecasting error']
lambdaS - lambdaS(-1) = sunspot;

% eq. ()
[name = 'Budget constraint'] 
B = ( 1 + i(-1) ) * B(-1) + W * H + PI - T - P * C;

% eq. ()
[name = 'Aggregate consumption']
C = ( ( 1 - n )^( 1 / s ) * CD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * CF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

% eq. ()
[name = 'Household s demand for domestic goods']
CD = ( 1 - n ) * ( PD / P ) ^( - s) * C;

% eq. ()
[name = 'Household s demand for imported goods']
CF = n * ( PF / P ) ^( - s) * C;

% eq. ()
%[name = 'Price index']
%P = ( ( 1 - n ) * PD ^ ( 1 - s ) + n * PF ^ ( 1 - s ) )^ ( 1 / ( 1 - s ) );  

%%%%%%%%%%%%% Government block %%%%%%%%%%%%%

% eq. ()
[name = 'Balanced budget (Ricardian equivalence)']
P * G = T;

% eq. ()
[name = 'Exogenous process of government spending']
log( G ) = ( 1 - zetaG) * log( STEADY_STATE(G) ) + zetaG * log ( G(-1) ) + sG;

% eq. ()
[name = 'Goverment expenditure']
G = ( ( 1 - n )^( 1 / s ) * GD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * GF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

% eq. ()
[name = 'Government s demand for domestic goods']
GD = ( 1 - n ) * ( PD / P ) ^( - s) * G;

% eq. ()
[name = 'Government s demand for domestic goods']
GF = n * ( PF / P ) ^( - s) * G;

%%%%%%%%%%%%% Rest of the world block %%%%%%%%%%%%%

% eq. () 
[name = 'Exogenous process of the nominal interest rates']
i = ( 1 - zetai ) * STEADY_STATE(i) + zetai * i(-1) + kappa * ( exp( STEADY_STATE(B) / ( STEADY_STATE(P) * STEADY_STATE(Y) ) - B / ( Y * P )  ) - 1 ) + si;


% eq. ()
[name = 'Exogenous process foreign prices']
log( PF ) = ( 1 - zetaPF) * log( STEADY_STATE(PF) ) + zetaPF * log ( PF(-1) ) + sPF;


%%%%%%%%%%%%% Firms block %%%%%%%%%%%%%

% eq. ()
[name = 'Adjustment costs']
AC = varphi / 2 * ( pD / pD(-1) - 1 ) ^2 * P * Y;

% [18] eq. () - 
%[name = 'Adjustment costs composition']
%AC = ( ( 1 - n )^( 1 / s ) * ACD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * ACF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

% [19] eq. () - 
[name = 'Share of adjustment costs purchased via domestic goods']
ACD = ( ( 1 - n ) * ( PD / P ) ^( - s) ) * AC;

% [20] eq. () - 
[name = 'Share of adjustment costs purchased via imported goods']
ACF = ( n * ( PF / P ) ^( - s) ) * AC;

% eq. ()
[name = 'Pricing equation']

theta * phi =   MC -  ( sigma - 1 ) / sigma * pD - ( varphi / sigma ) * P * Y / y * ( pD / pD(-1) - 1 ) * ( pD / pD(-1) );

% eq ()
[name = 'Theta equation'] 
theta * ( 1 + rho ) = 1 / sigma *  pDS * yS / e - ( varphi / sigma ) * ( pDS / pD - 1 ) * pDS / pD * PS * YS / e  -  ( 1 - eta ) * thetaS;

%
[name = 'S: pD forecasting error']
pDS - pDS(-1) = sunspot2;

%
[name = 'S: theta forecasting error']
thetaS - thetaS(-1) = sunspot3;

%
[name = 'S: y forecasting error']
yS - yS(-1) = sunspot4;

%
[name = 'S: Y forecasting error']
YS - YS(-1) = sunspot5;

%
[name = 'S: P forecasting error']
PS - PS(-1) = sunspot6;

% eq. ()
[name = 'Marginal cost'] 
MC = ( W / ( ( 1 - alpha ) * A ^ ( 1 / ( 1 - alpha ) ) ) ) * y ^ ( alpha / ( 1 - alpha ) )  ;

% eq. () 
[name = 'Individual markup']
mu = pD / MC;

% eq. () 
[name = 'Law of motion for the demand shifter']
e = phi * y + ( 1 - eta ) * e(-1);

% eq. ()
[name = 'Exogenous process of productivity']
log( A ) = ( 1 - zetaA) * log( STEADY_STATE(A) ) + zetaA * log ( A(-1) ) + sA;

%%%%% Aggregation block

% eq. ()
[name = 'Aggregate domestic price level']
PD = ( psi * e(-1) ) ^( -1 / ( sigma - 1 ) ) * pD;

% eq. () 
[name = 'Aggregate output']
Y = ( psi * e(-1) ) ^( 1 / ( sigma - 1 ) ) * A * H ^ ( 1 - alpha );

% eq. ()
[name = 'Aggregate resources']
Y = C + G + PD * X / P - ( PF / P ) * ( CF + GF + ACF );

% eq. ()
[name = 'Aggregate profits']
PI = P * Y - W * H;

% eq. ()
[name = 'Individual output']
y = ( ( psi * e(-1) ) ^( - 1 / ( sigma - 1 ) ) ) * Y;

end;

%--------------------------------------------------------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Steady State
%--------------------------------------------------------------------------------------------------------------------------------------

steady_state_model;
%initval;

H      = Hbar;
pD     = pDbar;
PF     = PFbar;
PD     = pD;
P      = (  ( 1 - n ) * PD ^ ( 1 - s ) + n * PF ^( 1 - s ) ) ^ ( 1 / ( 1 - s ) );
W      = H ^ ( omega - 1 ) * P;
theta  = 1 / ( sigma * ( 2 + rho - eta ) ) * pD * eta / phi;
MC     = ( sigma - 1 ) / sigma * pD + theta * phi;
mu     = pD / MC;
e      = 1 / psi;
y      = eta * e / phi  ;
Y      = y;
G      = gshare * Y;
T      = P * G;
GD     = ( 1 - n ) * ( PD / P ) ^ ( - s ) * G;
GF     = n * ( PF / P ) ^ ( - s ) * G;
C      = Y - G - nx * Y;
CD     = ( 1 - n ) * ( PD / P ) ^ ( - s ) * C;
CF     = n * ( PF / P ) ^ ( - s ) * C;
lambda = ( ( C - H ^omega / omega )^-gamma ) / P;
i      = rho;
PI     = P * Y - W * H;
X      = P / PD * ( nx * Y + PF / P * ( CF + GF ) );
B      = ( T + P * C - W * H - PI ) / i;
A      = eta / ( phi * psi ) * H ^ ( alpha - 1 );
AC     = 0;
ACD    = 0;
ACF    = 0;


lambdaS = lambda;
thetaS  = theta;
yS      = y;
YS      = Y;
PS      = P; 
pDS     = pD;   

YY    = 0;
MUMU  = 0;
WW    = 0;
MCMC  = 0;
PDPD  = 0;
PFPF  = 0;
CDCD  = 0;
CFCF  = 0;
HH    = 0;
GDGD  = 0;
GFGF  = 0;
CC    = 0;
ii    = 0;
ee    = 0;
XX    = 0;

%Y_obs  = 0;
%mu_obs = 0;
%T_obs  = 0;

end;

steady;
%check;
resid;

%varobs YY, MUMU, WW, HH;
%varobs YY, MUMU, WW;

%model_diagnostics;

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Simulation
%--------------------------------------------------------------------------------------------------------------------------------------

%%%% Impulse-response functions

shocks;
var sA  = 0.01;
var sG = 0.01 * 0.175648098965480;
%var sG = dgov;
end;

stoch_simul(ar=1, order=1, irf=16, nograph) C, H, lambda, P, W, B, y, Y, PI, pD, MC, theta, mu, e, CD, CF, PD, PF, GD, GF, T, G, A, i, X, AC, ACD, ACF;