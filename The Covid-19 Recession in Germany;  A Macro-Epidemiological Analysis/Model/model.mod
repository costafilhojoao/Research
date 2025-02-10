/*

The Covid-19 Recession in Germany: A Macro-Epidemiological Analysis
Krause, Costa, and Costa-Filho (2025)

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
* type "dynare name" (where name stands for how you named your mod-file; in our case, 'mex') into the command window

This code was originally written by Eichenbaum, Rebelo and Trabandt (2020),'Epidemics in the New Keynesian Model' and adpted by Willi Krause.

For Matlab R2021a and DYNARE 4.6.1.

*/

%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------

model;
//Keep in mind that Dynare wants state variables denoted with t-1 which differs 
//from the timing convention used in the manuscript where state variables 
//are denoted with time subscript t. All model equations have been implemented
//using the Dynare timing convention. 
 
//Note that we use Dynare's time stacking (two point boundary value) algorithm to 
//solve the nonlinear model. The two points are the initial pre-infection steady state
//and the terminal steady state. Dynare solves for the model transition dynamics between 
//these two points that satisfy all nonlinear model equations. By default, Dynare 
//assumes that the terminal steady state is the same as the initial steady state which 
//is not true in our model. The economy will not return to the initial (pre-infection) 
//steady state after the epidemic has ended. Since the terminal steady state depends on 
//epidemic dynamics and policies, we dont know the terminal value of the new steady state.
//In other words the terminal steady state is an endogenous function of the transition 
//dynamics. Now, the model has many LEVEL variables dated t+1 which implies that Dynare will
//replace the value of these variables at the end of the simulation by their pre-infection steady
//state variables. We dont want this for the reason described above. So, we dont write 
//level variables dated t+1 but use a transformation of that variable. Specifically, 
//we replace model variables, say, X(+1) by X*dX(+1) and introduce the new variable dX=X/X(-1). 
//Note that when substituting dX(+1) back into X*dX(+1) we get the original model formulation, 
//i.e. X(+1). With this transformation, Dynare now replaces dX(+1) at the end of the simulation 
//with its pre-infection steady state which is correct since the growth rate of a variable 
//in the pre- and terminal steady states is the same.


/////////////////////////////////////////////////////// 
//equilibrium equations: actual (sticky price) economy  
//////////////////////////////////////////////////////
//define common lockdown processes for both economies first
//note that the SAME tax values occur in both the flexible and the sticky price economy, so they are only defined once here.

//1 Process consumption lockdowns
muc = ro*muc(-1) + muc_innov;

//2 Process labour lockdowns
mun = ro*mun(-1) + mun_innov;

//3 Process random meetings lockdowns
mul = ro*mul(-1) + mul_innov;

//4 AR Process persistency for lockdowns
ro = ro(-1) + ro_innov;

//5 Production 
y=pbreve*A*k(-1)^(1-alfa)*n^alfa;

//6 Marginal cost
mc=1/(A*alfa^alfa*(1-alfa)^(1-alfa))*w^alfa*rk^(1-alfa);

//7 Cost mininizing inputs
w=mc*alfa*A*n^(alfa-1)*k(-1)^(1-alfa);

//8 Law of motion capital
k=x+(1-delta)*k(-1);

//9 Aggregate resources
y=c+x+g_ss;

//10 Aggregate hours
n=s(-1)*ns+i(-1)*ni+r(-1)*nr;

//11 Aggregate consumption
c=s(-1)*cs+i(-1)*ci+r(-1)*cr;

//12 New infections
tau=pi1*s(-1)*cs*i(-1)*ci+pi2*s(-1)*ns*i(-1)*ni+pi3*s(-1)*i(-1)*(1-mul);

//13 Total susceptibles
s=s(-1)-tau;

//14 Total infected
i=i(-1)+tau-(pir+pid)*i(-1);

//15 Total recovered
r=r(-1)+pir*i(-1);

//16 Total deaths 
dd=dd(-1)+pid*i(-1);

//17 Total population
pop=pop(-1)-pid*i(-1);

//18 First order condition, consumption susceptibles
1/cs=lambtilde*(1 + muc)-lamtau*pi1*i(-1)*ci;

//19 First order condition, consumption infected
1/ci=lambtilde*(1 + muc);

//20 First order condition, consumption recovered
1/cr=lambtilde*(1 + muc);

//21 First order condition, hours susceptibles
theta*ns=lambtilde*w*(1-mun)+lamtau*pi2*i(-1)*ni;

//22 First order condition, hours infected
theta*ni=lambtilde*w*(1-mun);

//23 First order condition, hours recovered
theta*nr=lambtilde*w*(1-mun);

//24 First order condition, capital
lambtilde=betta*(rk*drk(+1)+(1-delta))*lambtilde*dlambtilde(+1);

//25 First order condition, new infected
lami=lamtau+lams;

//26 First order condition, susceptibles
log(cs*dcs(+1))-theta/2*(ns*dns(+1))^2
+lamtau*dlamtau(+1)*(pi1*cs*dcs(+1)*i*ci*dci(+1)+pi2*ns*dns(+1)*i*ni*dni(+1)+pi3*i*(1-mul(+1)))
+lambtilde*dlambtilde(+1)*(w*dw(+1)*ns*dns(+1)*(1-mun(+1))-cs*dcs(+1)*(1 + muc(+1)) )
-lams/betta+lams*dlams(+1);

//27 First order condition, infected
log(ci*dci(+1))-theta/2*(ni*dni(+1))^2
+lambtilde*dlambtilde(+1)*( w*dw(+1)*ni*dni(+1)*(1-mun(+1))-ci*dci(+1)*(1 + muc(+1)) )
-lami/betta+lami*dlami(+1)*(1-pir-pid)+lamr*dlamr(+1)*pir;

//28 First order condition, recovered
log(cr*dcr(+1))-theta/2*(nr*dnr(+1))^2
+lambtilde*dlambtilde(+1)*( w*dw(+1)*nr*dnr(+1)*(1-mun(+1))-cr*dcr(+1)*(1 + muc(+1)) )
-lamr/betta+lamr*dlamr(+1);

//29 First order condition, bonds
lambtilde=betta*Rb/(pie*dpie(+1))*lambtilde*dlambtilde(+1);
 
//30 Real interest rate
rr=Rb/(pie*dpie(+1));

//31 Nonlinear price setting 1
Kf=gam*mc*lambtilde*y+betta*xi*(pie*dpie(+1))^(gam/(gam-1))*Kf*dKf(+1);

//32 Nonlinear price setting 2
F=lambtilde*y+betta*xi*(pie*dpie(+1))^(1/(gam-1))*F*dF(+1);

//33 Nonlinear price setting 3
Kf=F*( (1-xi*pie^(1/(gam-1)) ) / (1-xi) )^(-(gam-1));

//34 Inverse price dispersion
pbreve^(-1)=(1-xi)*( (1-xi*pie^(1/(gam-1)))/(1-xi) )^gam
 + xi*pie^(gam/(gam-1))/pbreve(-1);

//35 Taylor rule
Rb=STEADY_STATE(Rb)+rpi*log(pie/STEADY_STATE(pie))+rx*log(y/yF);

//Auxilliary variables: gross growth rates of variables with non-zero 
//pre-infection steady states. These variables are needed to calculate
//numerically accurate simulations when the terminal steady state differs
//from the pre-infection steady state and if you do not know the terminal 
//steady state a priori since it depends on the epidemic dynamics.
dF=F/F(-1);
dKf=Kf/Kf(-1);  
dpie=pie/pie(-1);
dcs=cs/cs(-1);
dns=ns/ns(-1);
dci=ci/ci(-1);
dni=ni/ni(-1);
dw=w/w(-1);
dlams=lams/lams(-1);
dlamtau=lamtau/lamtau(-1);
dlambtilde=lambtilde/lambtilde(-1);
dlami=lami/lami(-1);
dlamr=lamr/lamr(-1);
dcr=cr/cr(-1);
dnr=nr/nr(-1);
drk=rk/rk(-1);


//////////////////////////////////////////////// 
//equilibrium equations: flexible price economy
//////////////////////////////////////////////// 
//1 Production
yF=pbreveF*A*kF(-1)^(1-alfa)*nF^alfa;

//2 Marginal cost
mcF=1/(A*alfa^alfa*(1-alfa)^(1-alfa))*wF^alfa*rkF^(1-alfa);

//3 Cost minimizing inputs
wF=mcF*alfa*A*nF^(alfa-1)*kF(-1)^(1-alfa);

//4 Law of motion for capital
kF=xF+(1-delta)*kF(-1);

//5 Aggregate Resources
yF=cF+xF+g_ss;

//6 Aggregate hours
nF=sF(-1)*nsF+iF(-1)*niF+rF(-1)*nrF;

//7 Aggregate consumption
cF=sF(-1)*csF+iF(-1)*ciF+rF(-1)*crF;

//8 New infected
tauF=pi1*sF(-1)*csF*iF(-1)*ciF+pi2*sF(-1)*nsF*iF(-1)*niF+pi3*sF(-1)*iF(-1)*(1-mul);

//9 Total suseptibles
sF=sF(-1)-tauF;

//10 Total infected
iF=iF(-1)+tauF-(pir+pid)*iF(-1);

//11 Total recovered
rF=rF(-1)+pir*iF(-1);

//12 Total deaths 
ddF=ddF(-1)+pid*iF(-1);

//13 Total population
popF=popF(-1)-pid*iF(-1);

//14 First order condition, consumption susceptibles
1/csF=lambtildeF*(1 + muc)-lamtauF*pi1*iF(-1)*ciF;

//15 First order condition, consumption infected
1/ciF=lambtildeF*(1 + muc);

//16 First order condition, consumption recovered
1/crF=lambtildeF*(1 + muc);

//17 First order condition, hours susceptibles
theta*nsF=lambtildeF*wF*(1-mun)+lamtauF*pi2*iF(-1)*niF;

//18 First order condition, hours infected
theta*niF=lambtildeF*wF*(1-mun);

//19 First order condition, hours recovered
theta*nrF=lambtildeF*wF*(1-mun);

//20 First order condition, capital
lambtildeF=betta*(rkF*drkF(+1)+(1-delta))*lambtildeF*dlambtildeF(+1);

//21 First order condition, new infected
lamiF=lamtauF+lamsF;

//22 First order condition, susceptibles
log(csF*dcsF(+1))-theta/2*(nsF*dnsF(+1))^2
+lamtauF*dlamtauF(+1)*(pi1*csF*dcsF(+1)*iF*ciF*dciF(+1)+pi2*nsF*dnsF(+1)*iF*niF*dniF(+1)+pi3*iF*(1-mul(+1)))
+lambtildeF*dlambtildeF(+1)*( wF*dwF(+1)*nsF*dnsF(+1)*(1-mun(+1)) -csF*dcsF(+1)*(1 + muc(+1)) )
-lamsF/betta+lamsF*dlamsF(+1);

//23 First order condition, infected
log(ciF*dciF(+1))-theta/2*(niF*dniF(+1))^2
+lambtildeF*dlambtildeF(+1)*( wF*dwF(+1)*niF*dniF(+1)*(1-mun(+1))-ciF*dciF(+1)*(1 + muc(+1)) )
-lamiF/betta+lamiF*dlamiF(+1)*(1-pir-pid)+lamrF*dlamrF(+1)*pir;

//24 First order condition, recovered
log(crF*dcrF(+1))-theta/2*(nrF*dnrF(+1))^2
+lambtildeF*dlambtildeF(+1)*( wF*dwF(+1)*nrF*dnrF(+1)*(1-mun(+1)) -crF*dcrF(+1)*(1 + muc(+1)) )
-lamrF/betta+lamrF*dlamrF(+1);

//25 First order condition, bonds
lambtildeF=betta*RbF/(pieF*dpieF(+1))*lambtildeF*dlambtildeF(+1);

//26 Real interest rate
rrF=RbF/(pieF*dpieF(+1));

//27 Nonlinear price setting 1
KfF=gam*mcF*lambtildeF*yF+betta*xi_flex*(pieF*dpieF(+1))^(gam/(gam-1))*KfF*dKfF(+1);

//28 Nonlinear price setting 2
FF=lambtildeF*yF+betta*xi_flex*(pieF*dpieF(+1))^(1/(gam-1))*FF*dFF(+1);

//29 Nonlinear price setting 3
KfF=FF*( (1-xi_flex*pieF^(1/(gam-1)) ) / (1-xi_flex) )^(-(gam-1));

//30 Inverse price dispersion
pbreveF^(-1)=(1-xi_flex)*( (1-xi_flex*pieF^(1/(gam-1)))/(1-xi_flex) )^gam
 + xi_flex*pieF^(gam/(gam-1))/pbreveF(-1);

//31 Taylor rule
RbF=STEADY_STATE(Rb)+rpi*log(pieF/STEADY_STATE(pieF))+rx*log(yF/yF);

//Auxilliary variables: gross growth rates of variables with non-zero 
//pre-infection steady states. These variables are needed to calculate
//numerically accurate simulations when the terminal steady state differs
//from the pre-infection steady state and if you do not know the terminal 
//steady state a priori since it depends on the epidemic dynamics.
dFF=FF/FF(-1);
dKfF=KfF/KfF(-1);  
dpieF=pieF/pieF(-1);
dcsF=csF/csF(-1);
dnsF=nsF/nsF(-1);
dciF=ciF/ciF(-1);
dniF=niF/niF(-1);
dwF=wF/wF(-1);
dlamsF=lamsF/lamsF(-1);
dlamtauF=lamtauF/lamtauF(-1);
dlambtildeF=lambtildeF/lambtildeF(-1);
dlamiF=lamiF/lamiF(-1);
dlamrF=lamrF/lamrF(-1);
dcrF=crF/crF(-1);
dnrF=nrF/nrF(-1);
drkF=rkF/rkF(-1);
end; 