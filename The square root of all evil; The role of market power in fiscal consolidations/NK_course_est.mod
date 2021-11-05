//Dynare set-up:  One-Sector NK Model with capital and costs of investment and with non-distortionary taxes
//With Flexi price block, indexing and habit in consumption
//With price dispersion
//(c) CIMS Univeristy of Surrey
//The Science and  Art of DSGE Modelling: Construction, Calibration, Estimation and Policy
//////////////////////////////////////////////////////////////////////////////////////////////////
//This is a free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.  See <http://www.gnu.org/licenses/> for more information.
////////////////////////////////////////////////////////////////////////////////////////////////// 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%DECLARATION OF ENDOGENOUS VARIABLES%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var LAMBDA LAMBDAC LAMBDAN Rex h WP YW Y PWP K I  
tax C A G X Q XX Z1 Z2 MC H Htilde J Jtilde PIE 
PIEtilde Rn INVPIE RR RnRn YY CC hh WPWP II KK Delta;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%DECLARATION OF OBSERVABLE VARIABLES%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var dy pinfobs robs;  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%DECLARATION OF EXOGENOUS VARIABLES%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varexo epsA epsG epsM;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%DECLARATION OF PARAMETERS%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
parameters gy alp c zzeta betta delta sigma_c rhoA rhoG Ass phiX xi hab gammap alpha_r alpha_pie alpha_y varrho cy iy;
parameters trend conspie consr;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%CALIBRATION OF PARAMETERS%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gy=0.2;
varrho=0.6073;
alp=0.70;
zzeta=7.0;
c=1/zzeta;
betta=0.9871;
delta=0.0250;
sigma_c=2.0;
phiX=1.24;
xi=0.75;
hab=0;
gammap=0;
%MP rule
alpha_r=0.7;
alpha_pie=1.5;
alpha_y=0.3;
%Choice of Units
Ass=1;
%shock persistence
rhoA=0.7;
rhoG=0.7;

trend=0.4;
consr=(1.0/betta-1)*100; % ss nominal interest rate
conspie=0; % quarterly ss inflation rate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%STEADY STATE RELATIONSHIPS%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iy=((1-alp)*delta)/((1/betta-1+delta));
cy=1-iy-gy;


// ----------------------------
// *** DSGE-Model-equations ***
// ----------------------------
model;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%Single period utility%%
%%%%%%%%%%%%%%%%%%%%%%%%%
LAMBDA=((((C-hab*C(-1))^(1-varrho))*((1-h)^varrho))^(1-sigma_c)-1)/(1-sigma_c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Marginal utility of consumption%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LAMBDAC=((C-hab*C(-1))^(1-varrho)*(1-h)^varrho)^(1-sigma_c)*(1-varrho)/(C-hab*C(-1));

%%%%%%%%%%%%%%%%%%
%%Euler equation%%
%%%%%%%%%%%%%%%%%%
LAMBDAC=betta*XX(+1);
XX=(Rn(-1))/(PIE)*LAMBDAC;

%%%%%%%%%%%%%%%%%%%%%
%%Labour supply foc%%
%%%%%%%%%%%%%%%%%%%%%
LAMBDAN=-((C-hab*C(-1))^(1-varrho)*(1-h)^varrho)^(1-sigma_c)*varrho/(1-h);
-LAMBDAN/LAMBDAC=WP;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Wholesale and retail sector relation%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y=(1-c)*YW/Delta;


%%%%%%%%%%%%%%%%%%%%%%
%%Price Dispersion%%%%
%%%%%%%%%%%%%%%%%%%%%%
Delta=xi*(PIEtilde^zzeta)*Delta(-1)+(1-xi)*(J/H)^(-zzeta);


%%%%%%%%%%%%%%%%%%%%%%%
%%Production Function%%
%%%%%%%%%%%%%%%%%%%%%%%
YW=((A*h)^alp)*(K(-1))^(1-alp)/Delta;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Wholesale firms FOC for labour%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PWP*(alp*YW)/h=WP;

%%%%%%%%%%%%%%%%%%%%%%%
%%Resource constraint%%
%%%%%%%%%%%%%%%%%%%%%%%
Y=C+G+I;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Capital law of motion%%%%%
%%Costs of investment case%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=I/I(-1);
K=I*(1-phiX*(X-1)^2.0)+(1-delta)*K(-1);

%%%%%%%%%%%%%%
%%Investment%%
%%%%%%%%%%%%%%
Z1=2.0*phiX*(X-1)*X*Q/(Rex);
Q*(1- phiX*(X-1)^2.0-2.0*X*phiX*(X-1))+Z1(+1)=1;

%%%%%%%%%%%%%%%
%%Fischer Eqn%%
%%%%%%%%%%%%%%%
INVPIE=1/PIE;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Real Ex-Post Interest Rate%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rex=(Rn(-1))*INVPIE;

%%%%%%%%%%%%%
%%Tobin's Q%%
%%%%%%%%%%%%%
Z2=(1-alp)*PWP*YW/K(-1)+(1-delta)*Q;
(Rn)*INVPIE(+1)=Z2(+1)/Q;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Balance budget constraint%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G=h*WP*tax;

%%%%%%%%%%%%%%%%%%%%%%
%%Inflation Dynamics%%
%%%%%%%%%%%%%%%%%%%%%%
H-xi*betta*Htilde(+1)=Y*LAMBDAC;
J-xi*betta*Jtilde(+1)=(1/(1-(1/zzeta)))*Y*LAMBDAC*MC;
Htilde=(PIEtilde^(zzeta-1))*H;
Jtilde=PIEtilde^zzeta*J;
1=xi*(PIEtilde^(zzeta-1))+(1-xi)*((J/H)^(1-zzeta));
PIEtilde=PIE/PIE(-1)^gammap;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Mark-up Monopolistic pricing%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
MC=PWP;

%%%%%%%%%%%%%%%
%%Taylor rule%%
%%%%%%%%%%%%%%%
log((Rn)/(STEADY_STATE(Rn)))=alpha_r*log((Rn(-1))/(STEADY_STATE(Rn)))+(alpha_pie*log((PIE)/(STEADY_STATE(PIE))))+alpha_y*log((Y/STEADY_STATE(Y)))+epsM;


%%%%%%%%%%%%%%%%%%%
%%Shock processes%%
%%%%%%%%%%%%%%%%%%%
log(A)-log(STEADY_STATE(A))=rhoA*(log(A(-1))-log(STEADY_STATE(A)))+epsA;
log(G)-log(STEADY_STATE(G))=rhoG*(log(G(-1))-log(STEADY_STATE(G)))+epsG;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Variables in deviation form%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
YY=Y/STEADY_STATE(Y);
KK=K/STEADY_STATE(K);
II=I/STEADY_STATE(I);
CC=C/STEADY_STATE(C);
WPWP=WP/STEADY_STATE(WP);
hh=h/STEADY_STATE(h);
RR=(Rex)/(STEADY_STATE(Rex));
RnRn=(Rn)/(STEADY_STATE(Rn));

%%%%%%%%%%%%%%%%%%%%%%%%
%%Measurment equations%%
%%%%%%%%%%%%%%%%%%%%%%%%
dy=log(YY)-log(YY(-1))+trend;
pinfobs = log(PIE/STEADY_STATE(PIE))+conspie;
robs = log(RnRn)+consr;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%SPECIFICATION OF SHOCKS%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
shocks;
var epsA; stderr 0.01;
var epsG; stderr 0.01;
var epsM; stderr 0.01;
end;

//steady;
//check;
//stoch_simul(periods=0,order=1, irf=40) Q PIE RnRn YY CC II hh WPWP RR;
//write_latex_dynamic_model;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%BAYESIAN ESTIMATION STARTS HERE%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
estimated_params;
// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
// Priors used as in SW07
//
stderr epsA,     INV_GAMMA_PDF,0.1,2; //technology
stderr epsG,     INV_GAMMA_PDF,0.5,2; //government spending - rescaled stderr/gy
stderr epsM,     INV_GAMMA_PDF,0.1,2; //interest rate rule

rhoA,            BETA_PDF,0.5,0.20;//AR1 technology
rhoG,            BETA_PDF,0.5,0.20;//AR1 government spending

phiX,            NORMAL_PDF,2.00, 1.50; //investment adj cost
sigma_c,         NORMAL_PDF,1.50, 0.375;//consumption utility
hab,             BETA_PDF,  0.70, 0.10; //habit
xi,              BETA_PDF,  0.50, 0.10; //calvo prices
gammap,          BETA_PDF,  0.50, 0.15; //indexation prices
alp,             NORMAL_PDF,0.70, 0.05; //labour share
alpha_pie,       NORMAL_PDF,1.50, 0.25; //feedback inflation
alpha_r,         BETA_PDF,  0.75, 0.10; //lagged interest rate
alpha_y,         NORMAL_PDF,0.125,0.05; //feedback output gap 

conspie,        GAMMA_PDF, 0.625,0.1;  //quarterly ss inflation rate;
trend,          NORMAL_PDF,0.40,0.10;  //common quarterly trend growth rate
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%DECLARATION OF OBSERVABLE VARIABLES%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
varobs dy pinfobs robs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%sample periods 84:1-04:4
%%4 quarters for initialisation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
//estimation 1st stage - search for the posterior mode only
estimation(datafile=usmodel_data,mode_compute=4,first_obs=143,presample=4,
              prefilter=0,mh_replic=0,mh_nblocks=1,mh_jscale=0.40,mh_drop=0.2,plot_priors=0);

//estimation MCMC when modes already exist
//estimation(datafile=usmodel_data,mode_compute=0,first_obs=143,presample=4,mode_file=NKlinear_est_mode,
//              prefilter=0,mh_replic=250000,mh_nblocks=1,mh_jscale=0.40,mh_drop=0.2);

//estimation when modes already exist and using the existing MH replications
//estimation(datafile=usmodel_data,mode_compute=0,first_obs=143,presample=4,mode_file=NKlinear_est_mode,
//              prefilter=0,mh_replic=0,mh_nblocks=1,mh_jscale=0.40,mh_drop=0.2,load_mh_file);