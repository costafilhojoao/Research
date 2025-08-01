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

@#include "variables.mod"

@#include "parameters.mod"

@#include "model.mod"

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Steady State
%--------------------------------------------------------------------------------------------------------------------------------------

steady_state_model;

%%% calibrated values
H      = 1865 /( 365 * 14 );
PF     = 1;
PD     = 0.95;
e      = 1 / psi;

%%% calculated values
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
MLC     = W / ( ( 1 - alpha ) * A ^ ( 1 / ( 1 - alpha ) ) ) * y ^( alpha / ( 1 - alpha ) );
mu      = pD / MLC;
C       = Y - G - nx * Y;
CD      = ( 1 - n ) * ( PD / P ) ^ ( - s ) * C;
CF      = n * ( PF / P ) ^ ( - s ) * C;
B       = ( T + P * C - W * H - PI ) / i;
X       = ( nx * Y * P + PF * ( CF + GF ) ) / PD;
D       = CD + GD + X;
MAC     = 0;
LMAC    = 0;
MEAC    = 0;
LMEAC   = 0;
MR      = ( 1 - 1 / sigma ) * pD;
METR    = ( pD * y ) / ( sigma * e );
%lambdaf = METR / ( ( rho + eta ) * P );
lambdaf = ( MLC - MR ) / ( varphi * P );
lambda  = ( C - H ^omega / omega ) ^ ( -gamma ) / P;

end;

%steady(nocheck);
steady;

%check;
resid;


%model_diagnostics;

