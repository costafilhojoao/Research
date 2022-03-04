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

var C, H, P, W, B, Y, MC, mu, e, PD, PF, G, A, i, X;

% C       : aggregate real consumption
% H       : aggregate hours of work
% P       : aggregate price index,
% W       : wage rate
% B       : stock of net assets
% Y       : aggregate real output, as value added
% MC      : individual marginal cost,
% mu      : individual markup
% e       : demand shifter
% PD
% PF
% G       : aggregate real government consumption
% A       : productivity
% i       : nominal interest rate
% X       : aggregate real net exports

% *Implementation of the DSGE simulation follows Farmer and Khramov JECD 2015 paper: 
% "Solving and estimating indeterminate DSGE models"


%% Exogenous variables

varexo sA, sG, si, sPF; 

% sA : productivity shock
% sG : government spending shock
% si : interest rate shock


parameters 
psi sigma alpha phi eta gamma omega rho zetaA zetaG zetai zetaPF kappa n s varphi, g, nx;
a1, a2, a3, a4, a5, a6, a7, a8, a9 a10, a11, a12, a13, a14, a15, a16, a17, a18;
Hbar, PDbar, PFbar, Pbar, Wbar, pDbar, thetabar, MCbar, mubar, ebar, ybar, Ybar, Gbar, Tbar;
GFbar, Cbar, CDbar, CFbar, ibar, PIbar, Xbar, Bbar, Abar;
;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------

%%%% Households block
rho   = ( ( 1 + 0.09 )^( 1 / 4 ) ) - 1 ;  % discount rate 
gamma = 2;                                % elasticity of intertemporal substitution
omega = 1.455;                            % exponent of labor in utility function 
n     = 0.5;                              % share of imported goods into total consumption
s     = 2.9;                              % elasticity of substitution between domestic and imported goods
kappa = 0.00742;                          % interest rate sensitivity to savings


%%%% Government block
zetaG = 0.9;                              % persistence in the government-spending process
g     = 0.3372392;


%%%%% Rest of the world block
zetai = 0.9;                              % persistence in the nominal interest rate process
zetaF = 0.9;                             % persistence in the foreign prices process
nx = -0.08;


%%%% Firms block
sigma  = s;                               % price-elasticity of demand 
phi    = 0.5;                             % firm's future demand sensitivity to current sales
eta    = 0.5 / 4;                         % Firm's demand "depreciation"
zetaA  = 0.6;                             % persistence of the productivity process
alpha  = 1/3;                             % 1 - alpha: labor exponent in the production function
varphi = 0.1;                             % adjusment costs scaling parameter

%%%% Steady State

Hbar      = 373 / 1022;
PDbar     = .96;
PFbar     = 1;
Pbar      = (  ( 1 - n ) * PDbar ^ ( 1 - s ) + n * PFbar ^( 1 - s ) ) ^ ( 1 / ( 1 - s ) );
Wbar      = Hbar ^ ( omega - 1 ) * Pbar;
pDbar     = PDbar;
thetabar  = 1 / ( sigma * ( 2 + rho - eta ) ) * pDbar * eta / phi;
MCbar     = ( sigma - 1 ) / sigma * pDbar + thetabar * phi;
mubar     = pDbar / MCbar;
ebar      = 1 / psi;
ybar      = eta * ebar / phi  ;
Ybar      = ybar;
Gbar      = g * Ybar;
Tbar      = Pbar * Gbar;
GDbar     = ( 1 - n ) * ( PDbar/ Pbar ) ^ ( - s ) * Gbar;
GFbar     = n * ( PFbar / Pbar ) ^ ( - s ) * Gbar;
Cbar      = Ybar - Gbar - nx * Ybar;
CDbar     = ( 1 - n ) * ( PDbar / Pbar ) ^ ( - s ) * Cbar;
CFbar     = n * ( PFbar / Pbar ) ^ ( - s ) * Cbar;
%lambda = ( ( C - H ^omega / omega )^-gamma ) / P;
ibar      = rho;
PIbar     = Pbar * Ybar - Wbar * Hbar;
Xbar      = Pbar / PDbar * ( nx * Ybar + PFbar / Pbar * ( CFbar + GFbar ) );
Bbar      = ( Tbar + Pbar * Cbar - Wbar * Hbar - PIbar ) / ibar;
Abar      = etabar / ( phi * psi ) * Hbar ^ ( alpha - 1 );

% Demand scaling factor consistent with steady state value for hours of work
psi = eta /  phi * ( 1 - alpha ) / ( Hbar * Wbar ) * ( thetabar * phi + (sigma - 1 ) / sigma * pDbar ); 

%%%% Auxiliary parameters

a1  = gamma * ( Cbar - Hbar ^ omega / omega ) ^ (-1 );
a2  = ( 1 - n ) ^ ( 1 / s ) * CDbar ^ ( ( s - 1 ) / s ) * s;
a3  = n ^ ( 1 / s ) * CFbar ^ ( ( s - 1 ) / s ) * s;
a4  = ( ( 1 - n )^( 1 / s ) * CDbar ^ ( ( s - 1 ) / s ) * s + n ^( 1 / s ) * CFbar ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) ) * s;
a5  = Cbar ^ ( ( s - 1 ) / s )  ) - a4;
a6  = ( 1 - n ) ^( 1 / s ) * GDbar ^ ( ( s - 1 ) / s )  );
a7  = n ^( 1 / s ) * GFbar ^ ( ( s - 1 ) / s )  );
a8  = Gbar ^ ( ( s - 1 ) / s )  ) - a7 * s;
a9  = a6 * s - a7 * s;
a10 = Hbar * Wbar * ( 1 - PIBar );
a11 = PIbar * Pbar * Ybar - Tbar - Pbar * Cbar;
a12 = PIbar * Pbar * Ybar;
a13 = ( sigma - 1 ) / sigma * pDbar + varphi / sigma * Pbar * Ybar / ybar;
a14 = varphi / sigma * Pbar * Ybar / ybar;
a15 = ( 1 + rho ) / phi * a13 + varphi / ( sigma * ebar ) * Pbar * Ybar - ( 1 - eta ) / phi * a14; 
a16 = ybar * pDbar * ( 1 + 1 / ( sigma - 1 ) ) * 1 / ( sigma * ebar );
a17 = ybar * pDbar / ( sigma * ebar );
a18 = 1 / ( sigma * ebar ) * ( ybar * pDbar - varphi * Pbar * Ybar ) + ( 1 - eta ) / phi * a13;

%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------

model(linear); 

[name = '8b']
a1 * ( 1 - Cbar ) * C = ( omega - 1 ) * H + P - W;

[name = '9b']
a1 * ( Hbar ^ omega * H(+1) - Cbar * C(+1) ) - P(+1) + ibar / ( 1 + ibar ) * i = a1 * ( Hbar ^ omega * H - Cbar * C ) - P;

[name = '5b']
Bbar * B = ( 1 + ibar ) * Bbar * B(-1) + Bbar * ibar * i(-1) + a10 * ( W + H ) + a11 P + a12 * Y - Tbar * G - Pbar * Cbar * C;

[name = '14b']
a5 * C = a4 * P - a2 * PD - a2 * PF;

[name = '69a'] 
Pbar ^ ( 1 - s ) * P = ( 1 - n ) * PDbar ^( 1 - s ) * PD + n  * PFbar ^( 1 - s ) * PF;

[name = '20a']
G = zetaG * G(-1) + sG;

[name = '23b']
a8 * G = a9 * P - s * ( a6 * PD + a7 * PF );

[name = '29a']
ibar * i = zetai * i(-1) + Bbar * kappa / (Pbar * Ybar) * ( P + Y - B(-1) ) + si;

[name = '50b']
( 1 + rho ) / phi * MCbar * MC - a14 * ( P + 1 / ( sigma - 1 ) * e(-1) ) - a14 * ( 1 + rho ) / phi * ( P(-1) + 1 / ( sigma - 1 ) * e(-2) = a18 * P(+1) + ( a18 / (sigma - 1 ) - a16 ) * e + a17 * Y(+1) - ( 1 - eta ) * MCbar * MC(+1);

[name = '']
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


%%%%% Observation equations (the relation between model's variables and observed variables)

%Y_obs  = log( Y )  - log( Y(-1) );
%mu_obs = log( mu ) - log( mu(-1) );
%T_obs  = log( T )  - log( T(-1) );

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
G      = g * Y;
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

%shocks;
%var sA  = 0.01;
%var sG = 0.01 * 0.175648098965480;
%var sG = dgov;
%end;

stoch_simul(ar=1, order=1, irf=16) C, H, lambda, P, W, B, y, Y, PI, pD, MC, theta, mu, e, CD, CF, PD, PF, GD, GF, T, G, A, i, X, AC, ACD, ACF;