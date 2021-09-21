% The square root of all evil: the role of market power in Fiscal consolidations
% Brito, P., Costa, L., Costa Filho, J., and Santos, C.
% Correspondence: João Ricardo Costa Filho; joao.costa@fgv.br
% We implement the DSGE simulation following Farmer and Khramov JECD 2015 paper: 
% "Solving and estimating indeterminate DSGE models"

//////////////////////////////////////////////////////////////////////////////////////////////////
//This is a free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.  See <http://www.gnu.org/licenses/> for more information.
//////////////////////////////////////////////////////////////////////////////////////////////////

close all;

%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

%% Endogenous variables

var C, H, lambda, P, W, B, y, Y, PI, pD, MC, theta, mu, e, CD, CF, PD, PF, GD, GF, G, T, A, i, X, AC, ACD, ACF, lambdaS, thetaS, yS, pDS, YS, PS;

% C       :  aggregate real consumption
% H       :  aggregate hours of work
% P       :  aggregate price index,
% lambda  :  households' Hamiltonian multiplier
% W       :  wage rate
% B       :  stock of net assets
% PI      :  aggregate profits
% T       :  lump-sum tax
% G       :  aggregate real government consumption
% p       :  individual price
% MC      :  individual marginal cost,
% theta   :  firms' Hamiltonian multiplier
% y       :  individual output
% e       :  demand shifter
% A       :  productivity
% mu      :  individual markup
% Y       :  aggregate real output, as value added
% X       :  aggregate real net exports
% i       :  nominal interest rate
% AC      : aggregate adjustment costs
% ACD     : adjustment costs purchased with domestic goods 
% ACF     : adjustment costs purchased with imported goods
% lambdaS :
% thetaS  :
% yS      :
% pDS     :
% YS      :
% PS      :

%% Exogenous variables

varexo sA, sG, si, sPF, sunspot, sunspot2, sunspot3, sunspot4, sunspot5, sunspot6; 

% sA : productivity shock
% sG : government spending shock
% si : interest rate shock
% sunspot, sunspot2, sunspot3, sunspot4, sunspot5, sunspot6

parameters 
psi sigma alpha phi eta gamma omega rho zetaA zetaG zetai zetaPF kappa n s varphi;

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

%%%%% Rest of the world block
zetai = 0.9;                              % persistence in the nominal interest rate process
zetaPF = 0.9;                              % persistence in the foreign prices process

% Firms block
sigma = s;                                % price-elasticity of demand 
phi   = 0.75;                             % firm's future demand sensitivity to current sales
eta = 0.5 / 4;                            % Firm's demand "depreciation"
zetaA = 0.9;                              % persistence of the productivity process
psi = .3183969939;                        % Demand scaling factor consistent with steady state value for hours of work
alpha = 1/3;                              % 1 - alpha: labor exponent in the production function
varphi = 0.1;                            % adjusment costs scaling parameter

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

%remover esta equação e colocar a law of motion do PF

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
theta * phi =   MC -  ( sigma - 1 ) / sigma * pD - varphi / sigma * ( pD / pD(-1) - 1 ) * P * Y * pD / pD(-1) * 1 / y;

% eq ()
[name = 'Theta equation'] 
theta * ( ( 1 + rho ) ) = 1 / sigma *  pDS * yS / e - varphi / sigma * ( pDS / pD - 1 ) * pDS / pD * PS * YS / e - ( 1 - eta ) * thetaS;

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
Y = C + G + pD * X / P - ( PF / P ) * ( CF + GF + ACF );

% eq. ()
[name = 'Aggregate profits']
PI = P * Y - W * H - AC;

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

C      = .3888022471;
H      = 373 / 1022;
lambda = 19.36773881;
P      = .9740708240;
W      = .6157691063;
B      = 1.873004022;
y      = .5234555284;
Y      = y;
PI     = .2851451095;
pD     = .9500000000;
MC     = .6440021245;
theta  = .2878444180e-1;
mu     = pD / MC;
e      = 3.140733170;
CD     = .2090320441;
CF     = .1801404830;
PD     = pD;
PF     = 1;
GD     = .9490780787e-1;
GF     = .8179003572e-1;
G      = .1765297236;
T      = P * G;
A      = 1.024962163;
i      = rho;
X      = .2327788399;
AC     = 0;
ACD    = 0;
ACF    = 0;

lambdaS = lambda;
thetaS  = theta;
yS      = y;
YS      = Y;
PS      = P; 
pDS     = pD;   

end;

steady;
%check;
resid;

%model_diagnostics;

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Simulation
%--------------------------------------------------------------------------------------------------------------------------------------

%dgov     = xlsread('sG','Sheet1',['B','2',':','B','17']);   %estimated shocks from the SVAR 
drate     = xlsread('si','Sheet1',['B','2',':','B','17']);   %estimated shocks from Duarte

%shocks;
%var sG;
%periods 1:16;
%values (dgov);
%end;

%shocks;
%var si;
%periods 1:16;
%values (drate);
%end;

%simul(periods=16);

shocks;
var sG  = 0.03;
var sA  = 0.03;
var sPF = 0.03;
end;

stoch_simul(ar=1, order=1, irf=20)  PD PF MC mu W CD CF H GD GF C i e Y G X;


%% Simulate moments and variance decomposition

%stoch_simul(ar=1, order=1, irf=0, periods = 300)  PD MC mu W CD CF H GD GF C i e Y G;


%y0     = oo_.dr.ys;
%dr     = oo_.dr;
%iorder = 1;
%y_     = simult_( y0, dr, dgov, iorder );


%corrcoef([mu_sG(1:8) Y_sG(1:8)])

%var sG;
%periods 1:16;
%values (dgov);
%end;

%simul(periods=16);

%plot( oo_.endo_simul( 13, : )./ ( .9500000000 / .6440021245) * 100 );  

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

%mu = mu_sG;
%Y = Y_sG;
%C = C_sG;
%i = i_sG;
%e = e_sG;
%G = G_sG;

%filename = 'dsge.xlsx';
%dados = [ Y mu C i e G ]; 
%xlRange='A2';
%sheet=1;
%xlswrite(filename,dados,sheet,xlRange);
%names = { "Y" "mu" "C" "i" "e" "G" };
%xlRange='A1';
%xlswrite(filename,names,sheet,xlRange);
