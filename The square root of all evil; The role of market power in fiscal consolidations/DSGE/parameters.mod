/*
The square root of all evil: the role of market power in Fiscal consolidations
Brito, P., Costa, L., Costa Filho, J.R., and Santos, C.

Correspondence: 

João Ricardo Costa Filho: joaocostafilho.com

This is a free software: you can redistribute it and/or modify it under                                                                
the terms of the GNU General Public License as published by the Free                                                                  
Software Foundation, either version 3 of the License, or (at your option)                                                              
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                          

*/

%----------------------------------------------------------------
% Parâmetros
%----------------------------------------------------------------

parameters psi  ${\psi}$        (long_name='demand´s scaling factor')
         sigma  ${\sigma}$      (long_name='price-elasticity of demand')
         alpha  ${\alpha}$      (long_name='1 - alpha: labor exponent in the production function')
           phi  ${\phi}$        (long_name='firm´s future demand sensitivity to current sales')
           eta  ${\eta}$        (long_name='firm´s demand "depreciation"')
         gamma  ${\gamma}$      (long_name='elasticity of intertemporal substitution')
         omega  ${\omega}$      (long_name='exponent of labor in utility function')
           rho  ${\rho}$        (long_name='discount rate')
         zetaA  ${\zeta^A}$     (long_name='persistence of the productivity process')
         zetaG  ${\zeta^G}$     (long_name='persistence in the government-spending process')
         zetai  ${\zeta^i}$     (long_name='persistence in the nominal interest rate process')
        zetaPF  ${\zeta^{PF} }$ (long_name='persistence in the foreign prices process')
         kappa  ${\kappa}$      (long_name='interest rate sensitivity to savings')
             n  ${n}$           (long_name='share of imported goods in total consumption')
             s  ${s}$           (long_name='elasticity of substitution between domestic and imported goods')
        varphi  ${\varphi}$     (long_name='adjusment costs scaling parameter')
        gshare  ${gs}$
            nx  ${nx}$
;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------


%%%% Households block
rho   = ( ( 1 + 0.09 )^( 1 / 4 ) ) - 1 ;    
gamma = 2;                                 
omega = 1.455;                             
omega = 1.5;                              
n     = 0.5;                             
s     = 2.5;                              
kappa = 0.00742;                            

%%%% Government block
zetaG  = 0.9;                             
gshare = 0.33;


%%%%% Rest of the world block
zetai  = 0.9;                               
zetaPF = 0.8;                             
nx     = -0.08;

% Firms block
sigma      = s;                                  
phi        = 0.5;      
eta        = 0.5 / 4;                    
zetaA      = 0.9;                               
alpha      = 1/3;                              
%varphi    = 0.2;                              

%Demand scaling factor consistent with steady state value for hours of work
psi        = .55;
ebar       = 1 / psi;
PDbar      = 0.95;
pDbar      = PDbar;
PFbar      = 1;
PDbar      = 0.95;
Pbar       = (  ( 1 - n ) * PDbar ^ ( 1 - s ) + n * PFbar ^( 1 - s ) ) ^ ( 1 / ( 1 - s ) );
ybar       = eta * ebar / phi;
METRbar    = ( pDbar * ybar ) / ( sigma * ebar );
lambdafbar = METRbar / ( Pbar * ( rho + eta ) );
Hbar       = 1865 /( 365 * 14 );
Wbar       = Hbar ^ ( omega - 1 ) * Pbar;
Ybar       = ybar;
Abar       = Ybar / Hbar ^ ( 1 - alpha );
MLCbar     = Wbar / ( ( 1 - alpha ) * Abar ^ ( 1 / ( 1 - alpha ) ) ) * ybar ^( alpha / ( 1 - alpha ) );
MRbar      = ( 1 - 1 / sigma ) * pDbar;
varphi     = ( MLCbar - MRbar ) / ( Pbar * lambdafbar ); 
