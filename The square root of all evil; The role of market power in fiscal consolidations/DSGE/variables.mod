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
% Endogenous variables endógenas
%----------------------------------------------------------------

var      C  ${C}$            (long_name='aggregate consumption')
         H  ${H}$            (long_name='aggregate hours of work')
    lambda  ${\lambda}$      (long_name='household´s co-state variable')
         P  ${P}$            (long_name='aggregate price index')
         W  ${W}$            (long_name='wage rate')
         B  ${B}$            (long_name='stock of net foreign assets')
         y  ${y}$            (long_name='individual output')
         Y  ${Y}$            (long_name='aggregate value-added output')
        PI  ${\Pi}$          (long_name='aggregate profits')
       MLC  ${MLC}$          (long_name='marginal labor cost')
        mu  ${\mu}$          (long_name='individual markup')
         e  ${\varepisilon}$ (long_name='demand shifter')
   lambdaf  ${\lambda^f}$    (long_name='firm´s co-state variable')
         D  ${D}$            (long_name='firm´s quantity demanded')    
        CD  ${C^D}$          (long_name='consumption of domestic goods')
        CF  ${C^F}$          (long_name='consumption of foreign goods')
        pD  ${p^D}$          (long_name='individual domestic-goods price')
        PD  ${P^D}$          (long_name='domestic-goods price index')
        PF  ${P^F}$          (long_name='foreign-goods price index')
        GD  ${G^D}$          (long_name='government consumption of domestic goods')
        GF  ${G^F}$          (long_name='government consumption of foreign goods')
        AC  ${AC}$           (long_name='aggregate adjustment costs')
       ACD  ${ACD}$          (long_name='adjustment costs purchased with domestic goods')
       ACF ${ACF}$           (long_name='adjustment costs purchased with imported goods')        
         G ${C^F}$           (long_name='government consumption')
         T ${C^F}$           (long_name='lump-sum taxes')
         A ${C^F}$           (long_name='aggregate productivity')
         X ${X}$             (long_name='exports')
         i ${C^F}$           (long_name='nominal interest rate')
        MR ${MR}$            (long_name='marginal revenue')
      METR ${METR}$          (long_name='marginal effect of the demand shifter on total revenue')
       MAC ${MAC}$           (long_name='marginal adjustment cost')
      LMAC ${LMAC}$          (long_name='lagged marginal adjustment cost')
      MEAC ${MEAC}$          (long_name='marginal effect of the demand shifter on the adjustment cost')
     LMEAC ${LMEAC}$         (long_name='lagged marginal effect of the demand shifter on the adjustment cost')
;


%----------------------------------------------------------------
% Exogenous variables
%----------------------------------------------------------------  

varexo sA ${s_A}$ (long_name='productivity shock') 
       sG ${s_A}$ (long_name='government spending shock')
       si ${s_A}$ (long_name='interest rate shock')
      sPF  ${s_A}$ (long_name='foreign price shock')
;



%----------------------------------------------------------------
% Sunspot
% Implementation of the DSGE simulation follows Farmer and Khramov JECD 2015 paper: 
% "Solving and estimating indeterminate DSGE models"
%----------------------------------------------------------------  

%var    LMEACS  (long_name='lambdaf forecasting error');

%varexo LMEACsunspot (long_name='lambdaf sunspot');



