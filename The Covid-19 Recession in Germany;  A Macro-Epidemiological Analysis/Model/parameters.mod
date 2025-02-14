/*

The Covid-19 Recession in Germany: A Macro-Epidemiological Analysis
Krause, Costa, and Costa-Filho (2025)

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
* type "dynare name" (where name stands for how you named your mod-file) into the command window

This code was originally written by Eichenbaum, Rebelo and Trabandt (2020),'Epidemics in the New Keynesian Model' and adpted by Willi Krause.

For Matlab R2021a and DYNARE 4.6.1.

*/

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Parameters and Calibration
%--------------------------------------------------------------------------------------------------------------------------------------

parameters 
xi rpi rx gam pi1 pi2 pi3 pir pid betta i_ini A theta 
alfa inc_target n_target delta g_ss eta xi_flex ro_ini; //add autoregressive parameters for lockdowns
 

betta      = 0.9693^(1/52) ;         //Weekly household discount factor. Controls ss interest rate 
pid        = ((1/1.8)*7*0.0055)/14;  //Weekly probability of dying 
pir        = 7/14 - pid;             //Weekly probability of recovering

delta      = 0.1/52;                 //capital depreciation rate (weekly)
alfa       = 2/3;                    //labor share

gam        = 1.33;                   //Steady state price markup;  

xi         = 0.9808;                 //Calvo price stickiness in actual economy (weekly) 0.9808
xi_flex    = 0;                      //Calvo price stickiness in flexible price economy (weekly)

rpi        = 1.5;                    //Taylor rule coefficient inflation
rx         = 0.5/52;                 //Taylor rule coefficient output gap     

n_target   = 22.46;                  //Calibration target for weekly hours
inc_target = 1162;                   // Calibration target for weekly income
eta=0.205;                           //Calibration target for gov. cons to GDP ratio 0.21

i_ini      = 0.0003;                //Initial seed of infection 0.0003
ro_ini     = 0.9123;                //Initial value of the autocorrelation parameter for the tax (lockdown) shocks


format long;

//Calibation targets for shares of pi-terms in T-function in SIR model

pi1_shr_target = 0.18;  //share of T_0 jump due to consumption-based infections
pi2_shr_target = 0.18;  //share of T_0 jump due to work-based infections
pi3_shr_target = (1 - pi1_shr_target - pi2_shr_target);   //share of T_0 jump due general infections
RplusD_target  = 0.15;               // 0.2


//pre-infection steady states
y_ss= inc_target;
n_ss= n_target;
mc_ss= 1/gam;
w_ss=mc_ss*alfa*y_ss/n_ss;
rk_ss=1/betta-1+delta;
kn_ss=(1-alfa)*w_ss/alfa/rk_ss;       //capital to output ratio
yk_ss=(y_ss/n_ss)/kn_ss;              //output per capita relative to capital
A=(y_ss/n_ss)^alfa*yk_ss^(1-alfa);
k_ss=(y_ss/A/n_ss^alfa)^(1/(1-alfa));
x_ss=delta*k_ss;
g_ss=eta*y_ss;
c_ss=(1-eta)*y_ss-x_ss;
g_ss=y_ss-c_ss-x_ss;
ns_ss=n_ss;
cs_ss=c_ss;
tau_ss=0;
s_ss=1;
i_ss=0;
r_ss=0;
lambtilde_ss=1/cs_ss;
ci_ss=cs_ss;
cr_ss=cs_ss;
theta=lambtilde_ss*w_ss/ns_ss;
ni_ss=lambtilde_ss*w_ss/theta;
nr_ss=ns_ss;
lams_ss=(log(cs_ss)-theta/2*ns_ss^2 + lambtilde_ss*(w_ss*ns_ss-cs_ss) ) / ( 1/betta-1 );
lamr_ss=(log(cr_ss)-theta/2*nr_ss^2 + lambtilde_ss*(w_ss*nr_ss-cr_ss) ) / ( 1/betta-1 );
lami_ss=(log(ci_ss)-theta/2*ni_ss^2 + lambtilde_ss*(w_ss*ni_ss-ci_ss) + pir*lamr_ss) / ( 1/betta-1+pir+pid );
lamtau_ss=lami_ss-lams_ss;
rr_ss=1/betta;
dcs_ss=1;
dns_ss=1;
dci_ss=1;
dni_ss=1;
dw_ss=1;
dlams_ss=1;
dlamtau_ss=1; 
dlambtilde_ss=1;
dlami_ss=1;
dlamr_ss=1;
dcr_ss=1;
dnr_ss=1;
drk_ss=1;
Kf_ss=1/(1-betta*xi)*gam*mc_ss*lambtilde_ss*y_ss;
F_ss=1/(1-betta*xi)*lambtilde_ss*y_ss;
pie_ss=1;
Rb_ss=rr_ss;
KfF_ss=1/(1-betta*xi_flex)*gam*mc_ss*lambtilde_ss*y_ss;
FF_ss=1/(1-betta*xi_flex)*lambtilde_ss*y_ss;
muc_ss = 0;
mun_ss = 0;
mul_ss = 0;


//Some useful command window output
cons_share=c_ss/y_ss
inv_share=x_ss/y_ss
gov_share=g_ss/y_ss
value_of_life=1/(1-betta)*(log(c_ss)-theta/2*n_ss^2)*c_ss
value_of_life = 1/(1-betta)*y_ss
ann_capoutputratio=k_ss/(52*y_ss)
thetaval=theta
Aval=A
 
//calibrate the pi's in the transmission (tau) - function
go_calibrate_pi;
 

//final numbers for pi1,pi2,pi3 and xi will be imposed below using homotopy
pi1_final=pi1;
pi2_final=pi2;
pi3_final=pi3;
xi_final=xi;
ro_final = ro_ini;

//put scaled down values of pi1,pi2,pi3 into Dynare M_. structure
//if you put the final numbers from the get go, no solution will be found
//use smaller numbers first then compute a solution. Then use the solution 
//as an initial guess for slightly larger values. Proceed using this homotopy 
//until final values are imposed (all below, after model block). 
//In practice, only homotopy over pi3 necessary
M_.params(strmatch('pi1',M_.param_names,'exact'))=pi1_final;
M_.params(strmatch('pi2',M_.param_names,'exact'))=pi2_final;
M_.params(strmatch('pi3',M_.param_names,'exact'))=pi3_final/3;
//Homotopy setup for xi is done after the model block.