/*
The square root of all evil: the role of market power in Fiscal consolidations
Brito, P., Costa, L., Costa Filho, J., and Santos, C.

Correspondence: 

Jo�o Ricardo Costa Filho: joaocostafilho.com

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
* type "dynare model" (or how you named your mod-file) into the command window
*/

%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

%% Endogenous variables

var      C ${C}$ (long_name='aggregate consumption')
         H ${H}$ (long_name='aggregate hours of work')
    lambda ${\lambda}$ (long_name='household�s co-state variable')
         P ${P}$ (long_name='aggregate price index')
         W ${W}$ (long_name='wage rate')
         B ${B}$ (long_name='stock of net foreign assets')
         y ${y}$ (long_name='individual output')
         Y ${Y}$ (long_name='aggregate value-added output')
        PI ${\Pi}$ (long_name='aggregate profits')
        pD ${p^D}$ (long_name='individual domestic price')
        xD ${x^D}$ (long_name='proportional variation of the individual price')
        MC ${MC}$ (long_name='marginal cost')
     theta ${\theta}$ (long_name='firm�s co-state variable')
        mu ${\mu}$ (long_name='individual markup')
         e ${\varepisilon}$ (long_name='demand shifter')
   lambdaf ${\lambda^f}$ (long_name='firm�s co-state variable')
         m ${m}$ (long_name='fimr�s optimal choice component')
       chi ${\chi}$ (long_name='firm�s demand component')  
         D ${D}$ (long_name='firm�s quantity demanded')    
        CD ${C^D}$ (long_name='consumption of domestic goods')
        CF ${C^F}$ (long_name='consumption of foreign goods')
        PD ${P^D}$ (long_name='domestic-goods price index')
        PF ${P^F}$ (long_name='foreign-goods price index')
        GD ${G^D}$ (long_name='government consumption of domestic goods')
        GF ${G^F}$ (long_name='government consumption of foreign goods')
        AC ${AC}$ (long_name='aggregate adjustment costs')
       ACD ${ACD}$ (long_name='adjustment costs purchased with domestic goods')
       ACF ${ACF}$ (long_name='adjustment costs purchased with imported goods')        
         G ${C^F}$ (long_name='government consumption')
         T ${C^F}$ (long_name='lump-sum taxes')
         A ${C^F}$ (long_name='aggregate productivity')
         X ${X}$ (long_name='exports')
         i ${C^F}$ (long_name='nominal interest rate')

%lambdaS, 
%thetaS, 
%yS,
% pDS,
% YS,
% PS;

% lambdaS : lambda forecasting error*
% thetaS  : theta forecasting error*
% yS      : y forecasting error*
% pDS     : pD forecasting error*
% YS      : Y forecasting error*
% PS      : P forecasting error*
;

% *Implementation of the DSGE simulation follows Farmer and Khramov JECD 2015 paper: 
% "Solving and estimating indeterminate DSGE models"


%% Exogenous variables

varexo sA ${s_A}$ (long_name='productivity shock') 
       sG ${s_A}$ (long_name='government spending shock')
       si ${s_A}$ (long_name='interest rate shock')
      sPF  ${s_A}$ (long_name='foreign price shock')
;

%, sunspot, sunspot2, sunspot3, sunspot4, sunspot5, sunspot6; 

parameters 
psi sigma alpha phi eta gamma omega rho zetaA zetaG zetai zetaPF kappa n s varphi, gshare, nx;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------


%%%% Households block
rho   = ( ( 1 + 0.09 )^( 1 / 4 ) ) - 1 ;  % discount rate 
gamma = 2;                                % elasticity of intertemporal substitution
omega = 1.455;                            % exponent of labor in utility function 
omega = 1.5;                              % exponent of labor in utility function 
n     = 0.5;                              % share of imported goods in total consumption
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


% Firms block
sigma = s;                                % price-elasticity of demand 
phi   = 0.5;                              % firm's future demand sensitivity to current sales
eta = 0.5 / 4;                            % Firm's demand "depreciation"
zetaA = 0.6;                              % persistence of the productivity process
alpha = 1/3;                              % 1 - alpha: labor exponent in the production function
varphi = 0.2;                             % adjusment costs scaling parameter

%Demand scaling factor consistent with steady state value for hours of work
%psi = eta /  phi * ( 1 - alpha ) / ( Hbar * Wbar ) * ( thetabar * phi + (sigma - 1 ) / sigma * pDbar );
psi = .55;



%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------

model; 


%%%%%%%%%%%%% Household block %%%%%%%%%%%%% 

[name = 'Household s demand for domestic goods']
CD = ( 1 - n ) * ( PD / P ) ^( - s) * C;

[name = 'Household s demand for imported goods']
CF = n * ( PF / P ) ^( - s) * C;

[name = 'FOC for consumption']
( C - ( H ^ omega ) / omega ) ^ ( - gamma ) = lambda * P;

[name = 'FOC for labour (hours)']
H ^ ( omega - 1 ) * (  ( C - ( H ^ omega ) / omega ) ^ ( - gamma ) ) = W * lambda;

[name = 'Euler equation']
%lambdaS * ( 1 +  i ) = ( 1 + rho )  * lambda;
lambda(+1) * ( 1 +  i ) = ( 1 + rho )  * lambda;

%[name = 'S: lambda forecasting error']
%lambdaS - lambdaS(-1) = sunspot;

[name = 'Budget constraint'] 
B = ( 1 + i(-1) ) * B(-1) + W * H + PI - T - P * C;

[name = 'Aggregate consumption']
C = ( ( 1 - n )^( 1 / s ) * CD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * CF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

[name = 'Price index']
P = ( ( 1 - n ) * PD ^ ( 1 - s ) + n * PF ^ ( 1 - s ) )^ ( 1 / ( 1 - s ) );  


%%%%%%%%%%%%% Government block %%%%%%%%%%%%%

[name = 'Balanced budget (Ricardian equivalence)']
P * G = T;

[name = 'Exogenous process of government spending']
log( G ) = ( 1 - zetaG) * log( STEADY_STATE(G) ) + zetaG * log ( G(-1) ) + sG;

%[name = 'Goverment expenditure']
%G = ( ( 1 - n )^( 1 / s ) * GD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * GF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

[name = 'Government s demand for domestic goods']
GD = ( 1 - n ) * ( PD / P ) ^( - s) * G;

[name = 'Government s demand for domestic goods']
GF = n * ( PF / P ) ^( - s) * G;


%%%%%%%%%%%%% Rest of the world block %%%%%%%%%%%%%

[name = 'Process of the nominal interest rates']
i = ( 1 - zetai ) * STEADY_STATE(i) + zetai * i(-1) + kappa * ( exp( STEADY_STATE(B) / ( STEADY_STATE(P) * STEADY_STATE(Y) ) - B / ( Y * P )  ) - 1 ) + si;

[name = 'Exogenous process foreign prices']
log( PF ) = ( 1 - zetaPF) * log( STEADY_STATE(PF) ) + zetaPF * log ( PF(-1) ) + sPF;


%%%%%%%%%%%%% Firms block %%%%%%%%%%%%%

[name = 'Adjustment costs']
AC = varphi / 2 * ( pD / pD(-1) - 1 ) ^2 * P * Y;

%[name = 'Adjustment costs composition']
%AC = ( ( 1 - n )^( 1 / s ) * ACD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * ACF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

[name = 'Share of adjustment costs purchased via domestic goods']
ACD = ( ( 1 - n ) * ( PD / P ) ^( - s) ) * AC;

[name = 'Share of adjustment costs purchased via imported goods']
ACF = ( n * ( PF / P ) ^( - s) ) * AC;

[name = 'firm�s demanded quantity']
D = CD + GD + X + ACD;

[name = 'firm�s demand component']
chi = psi * D * PD ^ sigma; 

[name = 'Pricing equation']
pD * ( lambdaf + y ) - varphi * P * Y * ( xD - 1 ) * xD - sigma * y * m = 0;

[name = ' equation']
pD * lambdaf - ( 1 + rho ) ^ ( - 1 ) * ( pD(+1) * ( y(+1) + lambdaf(+1) ) - sigma * y(+1) * m(+1) ) = 0;

[name = 'Theta equation'] 
theta - ( 1 + rho ) ^ ( - 1 ) * ( ( 1 - eta ) * theta(+1) + chi(+1) * pD(+1)^( -sigma ) * m(+1) ) = 0;

%[name = 'S: pD forecasting error']
%pDS - pDS(-1) = sunspot2;

%[name = 'S: theta forecasting error']
%thetaS - thetaS(-1) = sunspot3;

%[name = 'S: y forecasting error']
%yS - yS(-1) = sunspot4;

%[name = 'S: Y forecasting error']
%YS - YS(-1) = sunspot5;

%[name = 'S: P forecasting error']
%PS - PS(-1) = sunspot6;

[name = 'Marginal cost'] 
MC = ( W / ( ( 1 - alpha ) * A ^ ( 1 / ( 1 - alpha ) ) ) ) * y ^ ( alpha / ( 1 - alpha ) )  ;

[name = 'Individual markup']
mu = pD / MC;

[name = 'Law of motion for the demand shifter']
e = phi * y + ( 1 - eta ) * e(-1);

[name = 'Exogenous process of productivity']
log( A ) = ( 1 - zetaA) * log( STEADY_STATE(A) ) + zetaA * log ( A(-1) ) + sA;

[name = ' euqation']
m = pD - MC + phi * theta;

[name = 'proportional price-variation']
pD = xD * pD(-1);


%%%%%%%%%%%%% Aggregation block %%%%%%%%%%%%%

[name = 'Aggregate domestic price level']
PD = ( psi * e(-1) ) ^( -1 / ( sigma - 1 ) ) * pD;

[name = 'Aggregate output']
Y = ( psi * e(-1) ) ^( 1 / ( sigma - 1 ) ) * A * H ^ ( 1 - alpha );

[name = 'Aggregate resources']
Y = C + G + PD * X / P - ( PF / P ) * ( CF + GF + ACF );

[name = 'Aggregate profits']
PI = P * Y - W * H;

[name = 'Individual output']
y = ( ( psi * e(-1) ) ^( - 1 / ( sigma - 1 ) ) ) * Y;

end;

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Steady State
%--------------------------------------------------------------------------------------------------------------------------------------

steady_state_model;
%initval;

%%% calibrated values
H      = 1865 /( 365 * 14 );
PF     = 1;
PD     = 0.95;
e      = 1 / psi;

%%% calculated values
%PD     = ( ( P ^( 1 - s) - n * PF ^( 1 - s ) ) / ( 1 - n) ) ^ ( 1 / ( 1 - s ) );
P       = (  ( 1 - n ) * PD ^ ( 1 - s ) + n * PF ^( 1 - s ) ) ^ ( 1 / ( 1 - s ) );
i       = rho;
W       = H ^ ( omega - 1 ) * P;
pD      = PD;
AC      = 0;
ACD     = 0;
ACF     = 0;
y       = eta * e / phi;
Y       = y;
A       = Y / H ^ ( 1 - alpha );
PI      = P * Y - W * H;
G       = gshare * Y;
T       = P * G;
GD      = ( 1 - n ) * ( PD / P ) ^ ( - s ) * G;
GF      = n * ( PF / P ) ^ ( - s ) * G;
MC      = W / ( ( 1 - alpha ) * A ^ ( 1 / ( 1 - alpha ) ) ) * y ^( alpha / ( 1 - alpha ) );
mu      = pD / MC;
C       = Y - G - nx * Y;
CD      = ( 1 - n ) * ( PD / P ) ^ ( - s ) * C;
CF      = n * ( PF / P ) ^ ( - s ) * C;
B       = ( T + P * C - W * H - PI ) / i;
X       = ( nx * Y * P + PF * ( CF + GF ) ) / PD;
D       = CD + GD + X;
chi     = psi * D * PD ^ sigma;
theta   = ( rho + eta - chi * pD ^ -sigma * phi ) ^ ( - 1 ) * ( pD - MC ) ;
m       = pD - MC + phi * theta;
xD      = 1;
lambdaf = y / pD * ( sigma * m - pD );
lambda = ( C - H ^omega / omega ) ^ ( -gamma ) / P;


lambdaS = lambda;
thetaS  = theta;
yS      = y;
YS      = Y;
PS      = P; 
pDS     = pD;   

end;

steady;
check;
resid;

model_diagnostics;

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Simulation
%--------------------------------------------------------------------------------------------------------------------------------------

stoch_simul(ar=1, order=1, irf=16, nograph) C, H, lambda, P, W, B, y, Y, PI, pD, MC, theta, mu, e, CD, CF, PD, PF, GD, GF, T, G, A, i, X, AC, ACD, ACF;

%store the results into the following matlab objects:

oo_base = oo_;
M_base  = M_;
