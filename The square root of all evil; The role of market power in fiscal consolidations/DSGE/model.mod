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
lambda(+1) * ( 1 +  i(+1) ) = ( 1 + rho )  * lambda;

[name = 'Budget constraint'] 
B = ( 1 + i ) * B(-1) + W * H + PI - T - P * C;

%[name = 'Aggregate consumption']
%C = ( ( 1 - n )^( 1 / s ) * CD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * CF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

[name = 'Price index']
P = ( ( 1 - n ) * PD ^ ( 1 - s ) + n * PF ^ ( 1 - s ) )^ ( 1 / ( 1 - s ) );  


%%%%%%%%%%%%% Government block %%%%%%%%%%%%%

[name = 'Balanced budget (Ricardian equivalence)']
P * G = T;

[name = 'Exogenous process of government spending']
log( G ) = ( 1 - zetaG ) * log( STEADY_STATE(G) ) + zetaG * log ( G(-1) ) + sG;

[name = 'Goverment expenditure']
G = ( ( 1 - n )^( 1 / s ) * GD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * GF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

[name = 'Government s demand for domestic goods']
GD = ( 1 - n ) * ( PD / P ) ^( - s) * G;

[name = 'Government s demand for domestic goods']
GF = n * ( PF / P ) ^( - s) * G;


%%%%%%%%%%%%% Rest of the world block %%%%%%%%%%%%%

[name = 'Process of the nominal interest rates']
i = ( 1 - zetai ) * STEADY_STATE(i) + zetai * i(-1) + kappa * ( exp( STEADY_STATE(B) / ( STEADY_STATE(P) * STEADY_STATE(Y) ) - B / ( Y * P )  ) - 1 ) + si;

[name = 'Exogenous process foreign prices']
log( PF ) = ( 1 - zetaPF ) * log( STEADY_STATE(PF) ) + zetaPF * log ( PF(-1) ) + sPF;


%%%%%%%%%%%%% Firms block %%%%%%%%%%%%%

[name = 'Adjustment costs']
AC = varphi / 2 * ( pD / pD(-1) - 1 ) ^2 * P * Y;

%[name = 'Adjustment costs composition']
%AC = ( ( 1 - n )^( 1 / s ) * ACD ^ ( ( s - 1 ) / s ) + n ^( 1 / s ) * ACF ^ ( ( s - 1 ) / s )  ) ^ ( s / ( s - 1 ) );

[name = 'Share of adjustment costs purchased via domestic goods']
ACD = ( ( 1 - n ) * ( PD / P ) ^( - s) ) * AC;

[name = 'Share of adjustment costs purchased via imported goods']
ACF = ( n * ( PF / P ) ^( - s) ) * AC;

[name = 'Firm´s demanded quantity']
D = CD + GD + X + ACD;

[name = 'Marginal Revenue']
MR = ( 1 - 1 / sigma ) * pD;

[name = 'marginal effect of the demand shifter on total revenue']
METR = pD * y / ( sigma * e(-1) );

[name = 'Marginal labor cost'] 
MLC = ( W / ( ( 1 - alpha ) * A ^ ( 1 / ( 1 - alpha ) ) ) ) * y ^ ( alpha / ( 1 - alpha ) )  ;

[name = 'Marginal adjustment cost'] 
MAC = -( phi * Y * P ) / ( sigma * y ) * ( pD / pD(-1) - 1 ) * pD / pD(-1);

[name = 'Lagged marginal adjustment cost'] 
LMAC = - MAC * y / y(-1);

[name = 'Marginal effect of the demand shifter on the adjustment cost'] 
MEAC = ( phi * Y * P ) / ( sigma * e(-1) ) * ( pD / pD(-1) - 1 ) * pD / pD(-1);

[name = 'Lagged effect of the demand shifter on the adjustment cost'] 
LMEAC = - MEAC * e(-1) / e(-2);

[name = 'Law of motion for the demand shifter']
e = phi * y + ( 1 - eta ) * e(-1);

[name = 'Pricing equation']
MR + varphi * P * lambdaf = MLC + MAC + P / ( 1 + rho ) * ( LMAC(+1) / P(+1) );
%(1 - sigma ) * y(+1) + sigma * W(+1) / ( 1 - alpha ) * H(+1) * ( y(+1) / A(+1) )^-1 * 1 / pD(+1) - varphi * ( pD(+1) / pD - 1 ) * pD^-1 * P(+1) * Y(+1) + ( 1 + rho )^-1 * ( varphi * ( pD(+2) / pD(+1) - 1 ) * P(+2) * Y(+2) * pD(+2) * pD(+2)^2  );                                                                    

[name = 'Optimal demand shifter']
1 / ( 1 + rho ) * ( ( METR(+1) - MEAC(+1) ) / P(+1) ) + ( 1 / ( 1 + rho )^2 ) * ( LMEAC(+2) / P(+2) ) - lambdaf + ( 1 - eta ) / ( 1 + rho ) * lambdaf(+1) = 0;


[name = 'Exogenous process of productivity']
log( A ) = ( 1 - zetaA) * log( STEADY_STATE(A) ) + zetaA * log ( A(-1) ) + sA;

[name = 'Individual markup']
mu = pD / MLC;

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

%%%%%%%%%%%%% Sunspot block %%%%%%%%%%%%%

%[name = 'S: lambda forecasting error']
%LMEACS - LMEACS(-1) = LMEACsunspot;

end;