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
% 4. Solving and simulating the model
%--------------------------------------------------------------------------------------------------------------------------------------

//initial (pre-infection) steady state used in simulations 
initval;
y=y_ss; 
k=k_ss;
n=n_ss;
w=w_ss;
rk=rk_ss;
x=x_ss;
c=c_ss;
s=1;
i=0; 
r=0; 
ns =ns_ss;
ni=ni_ss; 
nr=nr_ss; 
cs=cs_ss;
ci=ci_ss;
cr=cr_ss;
tau=tau_ss;
lambtilde=lambtilde_ss;
lamtau=lamtau_ss;
lami=lami_ss;
lams=lams_ss;
lamr=lamr_ss;
dd=0;
pop=1;
dcs=dcs_ss;
dns=dns_ss;
dci=dci_ss;
dni=dni_ss;
dw=dw_ss;
dlams=dlams_ss;
dlamtau=dlamtau_ss;
dlambtilde=dlambtilde_ss;
dlami=dlami_ss;
dlamr=dlamr_ss; 
dcr=dcr_ss;
dnr=dnr_ss;
drk=drk_ss;
rr=rr_ss;
Rb=Rb_ss; 
pie=pie_ss; 
mc=mc_ss; 
F=F_ss; 
Kf=Kf_ss; 
dF=1; 
dKf=1; 
pbreve=1; 
dpie=1;
yF=y_ss; 
kF=k_ss;
nF=n_ss;
wF=w_ss;
rkF=rk_ss;
xF=x_ss;
cF=c_ss;
sF=1;
iF=0; 
rF=0; 
nsF=ns_ss;
niF=ni_ss; 
nrF=nr_ss; 
csF=cs_ss;
ciF=ci_ss;
crF=cr_ss;
tauF=tau_ss;
lambtildeF=lambtilde_ss;
lamtauF=lamtau_ss;
lamiF=lami_ss;
lamsF=lams_ss;
lamrF=lamr_ss;
ddF=0;
popF=1;
dcsF=dcs_ss;
dnsF=dns_ss;
dciF=dci_ss;
dniF=dni_ss;
dwF=dw_ss;
dlamsF=dlams_ss;
dlamtauF=dlamtau_ss;
dlambtildeF=dlambtilde_ss;
dlamiF=dlami_ss;
dlamrF=dlamr_ss; 
dcrF=dcr_ss;
dnrF=dnr_ss;
drkF=drk_ss;
rrF=rr_ss;
RbF=Rb_ss; 
pieF=pie_ss; 
mcF=mc_ss;
FF=FF_ss; 
KfF=KfF_ss;
dFF=1; 
dKfF=1; 
pbreveF=1; 
dpieF=1;
muc = muc_ss;
mun = mun_ss;
mul = mul_ss;
ro = ro_ini;
end;

//calculate residuals of dynamic equations with provided steady state
//and then invoke steady state computation followed by another check.
resid;
steady;
resid;
 
 
//set unknown type state variables to zero. Initialize initial seed 
M_.endo_histval=oo_.steady_state;
M_.endo_histval(strmatch('i',M_.endo_names,'exact'))=i_ini;
M_.endo_histval(strmatch('s',M_.endo_names,'exact'))=1-i_ini;
M_.endo_histval(strmatch('iF',M_.endo_names,'exact'))=i_ini;
M_.endo_histval(strmatch('sF',M_.endo_names,'exact'))=1-i_ini;

 
//Back up on price stickiness parameter (if nonzero); use homotopy below
//to impose final desired value.
M_.params(strmatch('xi',M_.param_names,'exact'))=xi_final/1.2;
M_.params(strmatch('ro_ini',M_.param_names,'exact')) = ro_final/4;

//Define Shock Sequences for the consumption,labour and "social tax", as well as for their common AR Parameter

%% Baseline

sequence_of_shocks_consumption =  [0.25;zeros(32,1);0.029;zeros(5,1);0.12];                                                                               
sequence_of_shocks_labour      =  [0.23;zeros(32,1);0.02;zeros(5,1);0.09];                                                      
sequence_of_shocks_random      =  [0.55;zeros(32,1);0.13;zeros(5,1);0.67];  
sequence_of_shocks_persistency =  [0.00;zeros(5,1); (0.00)];     

%% Only the consumption restrictions shock

%sequence_of_shocks_consumption =  [0.25;zeros(32,1);0.029;zeros(5,1);0.12];                                                                               
%sequence_of_shocks_labour      =  [0.00;zeros(32,1);0.000;zeros(5,1);0.00];                                                      
%sequence_of_shocks_random      =  [0.00;zeros(32,1);0.00;zeros(5,1);0.00];  
%sequence_of_shocks_persistency =  [0.00;zeros(5,1); (0.00)];     

%% Only the labor restrictions shock

%sequence_of_shocks_consumption =  [0.00;zeros(32,1);0.00;zeros(5,1);0.00];                                                                               
%sequence_of_shocks_labour      =  [0.23;zeros(32,1);0.02;zeros(5,1);0.09];                                                      
%sequence_of_shocks_random      =  [0.00;zeros(32,1);0.00;zeros(5,1);0.00];  
%sequence_of_shocks_persistency =  [0.00;zeros(5,1); (0.00)];     
 
%% Only the social restrictions shock

%sequence_of_shocks_consumption =  [0.00;zeros(32,1);0.00;zeros(5,1);0.00];                                                                               
%sequence_of_shocks_labour      =  [0.00;zeros(32,1);0.00;zeros(5,1);0.00];                                                      
%sequence_of_shocks_random      =  [0.55;zeros(32,1);0.13;zeros(5,1);0.67];  
%sequence_of_shocks_persistency =  [0.00;zeros(5,1); (0.00)];   

%% No restrictions

%sequence_of_shocks_consumption =  [0.00;zeros(32,1);0.00;zeros(5,1);0.00];                                                                               
%sequence_of_shocks_labour      =  [0.00;zeros(32,1);0.00;zeros(5,1);0.00];                                                      
%sequence_of_shocks_random      =  [0.00;zeros(32,1);0.00;zeros(5,1);0.00];  
%sequence_of_shocks_persistency =  [0.00;zeros(5,1); (0.00)]; 

//Define timing of shocks -> taken from policy announcements and stringency index
shocks;
var muc_innov;
periods 12:51;                                    
values (sequence_of_shocks_consumption);
var mun_innov;
periods 12:51;                                     
values (sequence_of_shocks_labour);
var mul_innov;
periods 12:51;                                     
values (sequence_of_shocks_random);
var ro_innov;
periods 45:51;                                     
values (sequence_of_shocks_persistency);
end;
 
 
//solve and simulate model
options_.slowc=1;
options_.simul.maxit=100;
simul(periods=500,stack_solve_algo=0);
 

//Homotopy for pi3, xi and ro parameters (otherwise no solution if you set them to final values right away)

pi3_final_steps_vec=[pi3_final/3:0.007:pi3_final,pi3_final];
for pi3_final_step=pi3_final_steps_vec
    pi3_final_step
    M_.params(strmatch('pi3',M_.param_names,'exact'))=pi3_final_step;
    [oo_.endo_simul, oo_.deterministic_simulation] = sim1(oo_.endo_simul, oo_.exo_simul, oo_.steady_state, M_, options_); //simulate using previous solution as initial guess
end

xi_final_steps_vec=[M_.params(strmatch('xi',M_.param_names,'exact')):0.005:xi_final];
for xi_final_step=xi_final_steps_vec
    xi_final_step
    M_.params(strmatch('xi',M_.param_names,'exact'))=xi_final_step;
    [oo_.endo_simul, oo_.deterministic_simulation] = sim1(oo_.endo_simul, oo_.exo_simul, oo_.steady_state, M_, options_); //simulate using previous solution as initial guess
end

//Can leave out homotopy for ro here, but for other calibrations it might be needed
//ro_ini_final_steps_vec=[M_.params(strmatch('ro_ini',M_.param_names,'exact')):0.01:ro_final,ro_final];
//for ro_ini_final_step=ro_ini_final_steps_vec
  //  ro_ini_final_step
  //  M_.params(strmatch('ro_ini',M_.param_names,'exact'))=ro_ini_final_step;
  //  [oo_.endo_simul, oo_.deterministic_simulation] = sim1(oo_.endo_simul, oo_.exo_simul, oo_.steady_state, M_, options_); //simulate using previous solution as initial guess
//end



//Simulate model with final (desired, calibrated) values for pi1,pi2,pi3 and xi 
M_.params(strmatch('pi1',M_.param_names,'exact'))=pi1_final;
M_.params(strmatch('pi2',M_.param_names,'exact'))=pi2_final;
M_.params(strmatch('pi3',M_.param_names,'exact'))=pi3_final;
M_.params(strmatch('xi',M_.param_names,'exact'))=xi_final;
M_.params(strmatch('ro_ini',M_.param_names, 'exact'))=ro_final;
[oo_.endo_simul, oo_.deterministic_simulation] = sim1(oo_.endo_simul, oo_.exo_simul, oo_.steady_state, M_, options_); //simulate using previous solution as initial guess
dyn2vec(M_, oo_, options_);   //convert simulation results to model variable names defined above    
   