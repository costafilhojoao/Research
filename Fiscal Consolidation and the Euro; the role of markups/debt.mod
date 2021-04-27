%Porto 2012, Replication of Schmitt-Grohe and Uribe JIE-2003
%Code by Prof. Alper Çeniz
%Adapted by Diana and João Ricardo M. G. Costa Filho
close all;

%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------
var y c i k h a tby d r lambda;
    
varexo ea;

parameters 
beta gamma delta phi alpha omega rho psi2 
ybar kbar ibar hbar cbar tbbar siga rbar dbar;

%----------------------------------------------------------------
% 2. Calibration
%----------------------------------------------------------------
beta=.96;    %discount factor
gamma=2;     %intertemporal elasticity of substitution
delta=.1;    %rate of depreciation
phi=.028;    %cost of capital adjustment
alpha=.32;   %share of capital 
omega=1.455; %exponent of labor in utility function
rho=.42;     %AR1 of tech process
rbar=0.04;   %(1/beta-1) is NOT 0.04. To make the calibration the same use rbar!!!
siga=0.0129;
dbar=0.7442;
psi2=0.000742;
ybar=((alpha/(r+delta))^(alpha/(1-alpha-(1-alpha)/omega)))*(1-alpha)^(((1-alpha)/omega)*1/(1-alpha-(1-alpha)/omega);
hbar=((1-alpha)*ybar)^(1/omega);
kbar=ybar*alpha/(rbar+delta);
ibar=delta*kbar;
cbar=ybar-ibar-r*dbar;
tbbar=1-(cbar+ibar)/ybar;
lambdabar=(cbar-(hbar^-omega)/omega);
a=rho*a(-1)+ea;
%----------------------------------------------------------------
% 3. Model 
%----------------------------------------------------------------
model(linear); 

y=a+alpha*k(-1)+(1-alpha)*h; 
k=delta*i+(1-delta)*k(-1); 
lambda(-1)=lambda+((psi2*dbar)/1+rbar)*d; 
cbar*c=hbar^omega*h-1/gamma*lambdabar;
omega*h=y;
lambda= phi*(kbar*(k-k(-1))+beta*alpha*ybar/kbar*(y-k)+beta*phi*kbar*(k(+1)-k); 
phi*(k-k(-1))=beta*(alpha/kbar*ybar/kbar*y(+1)-alpha/kbar*ybar/kbar*k+phi*(k(+1)-k)); 
a=rho*a(-1)+ea; 
rbar*r=psi2*dbar*d;
tby=(cbar+ibar)/ybar*y-cbar/ybar*c-ibar/ybar*i;
end;
%----------------------------------------------------------------
shocks;
var ea  = siga^2;
end;

steady;

stoch_simul(ar=1,irf=10)  y c i h tby a d r;

%----------------------------------------------------------------
% 5. Some Results 
%----------------------------------------------------------------
statistic1 = sqrt(diag(oo_.var(1:6,1:6)))./sqrt(oo_.var(1,1));

table('Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),var_list_(1:6,:),statistic1,10,8,4)


