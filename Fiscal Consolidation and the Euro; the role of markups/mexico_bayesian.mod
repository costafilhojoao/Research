%The Mexican Great Recession: a business cycle accounting approach
%Code by João Ricardo M. G. Costa Filho
close all;

%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------
var d r y c k x m e l tby lambda;  %Endogenous variables

varexo ee;

parameters 
beta gamma delta phi alpha mu omega psi rhoe rbar sige dbar cons1 cons2 cons3 cons4 ybar lbar kbar mbar xbar cbar tbybar lambdabar;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------
beta=0.99;     %discount factor
gamma=2;       %intertemporal elasticity of substitution (SG)
delta=0.1;     %rate of depreciation (SG)
phi=0.028;     %cost of capital adjustment (SG)
alpha=0.4;     %share of domestic capital in the production (Kim)
mu=0.3;        %imported goods share of output (Mexican national accounts)
omega=1.455;   %exponent of labor in utility function (SG)
rhoe=0.43;     %AR1 of real exchange rate process 
psi=0.000742;  % (SG)
sige=0.01;     %
dbar=0.7442;   %equilibrium aggregate level of foreign debt (SG)

rbar=1/beta-1;
cons1=mu^mu;
cons2=(((1/beta-1+delta)^(-1))*(1-mu)*alpha)^alpha;
cons3=((((1-alpha)*(1-mu))^(1/omega))^(1-alpha))^(1-mu);
cons4=1/(1-mu-alpha*(1-mu)-(((1-alpha)*(1-mu))/(omega)));
ybar=(cons1*cons2*cons3)^(1/cons4);
lbar=((1-alpha)*(1-mu)*ybar)^(1/omega);
kbar=(1-mu)*alpha*ybar*(1/beta + delta -1)^(-1);
mbar=mu*ybar;
xbar=delta*kbar;
cbar = ybar-rbar*dbar-xbar+mbar;
tbybar=1-(cbar+xbar+mbar)/ybar;
lambdabar=(cbar-(omega^(-1)*(lbar^omega)))^(-gamma);
%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%--------------------------------------------------------------------------------------------------------------------------------------
model(linear); 

dbar*d=(1+rbar)*dbar*d(-1)+rbar*r(-1)-ybar*y+cbar*c+xbar*x+mbar*e+m;
y=mu*m+(1-mu)*alpha*k(-1)+(1-mu)*(1-alpha)*l;
e=rhoe*e(-1)+ee;
k=delta*x+(1-delta)*k(-1);
lambda=lambda(+1)+beta*rbar*r;
-(1/gamma)*lambdabar^(-(1/gamma))*lambda=cbar*c-(lbar^omega)*l;
(1-alpha)*(1-mu)*ybar*y=omega*(lbar^omega)*l;
lambdabar*lambda=beta*(lambdabar*lambda(+1)*(1-delta+(1-mu)*alpha*(ybar/kbar))+kbar*lambdabar*phi*(k(+1)-k)+(ybar/kbar)*(1-mu)*alpha*(y(+1)-k));
mu*(ybar/mbar)*(y-m)=e;
ybar*tbybar*tby=xbar*x-cbar*c+mbar*e+mbar*m-(cbar-xbar-mbar)*y;
rbar*r=psi*dbar*d;
end;
%--------------------------------------------------------------------------------------------------------------------------------------
shocks;
var ee = sige; 
end;

steady;

varobs y;      %Observed variables (data); should be less or equal the number of shocks, otherwise you will not have enough degrees of freedom

stoch_simul(ar=1,irf=20)  y c l x;

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Bayesian estimation 
%--------------------------------------------------------------------------------------------------------------------------------------

estimated_params;

%Parameter name, prior shape, mu, sigma

stderr ee,       INV_GAMMA_PDF,      0.5, inf;        %real exchange rate
rhoe,            NORMAL_PDF,         0.5, 0.2;        %AR1 real exchange rate
omega,           NORMAL_PDF,         2, 0.5;          %disutility of labor
gamma,           NORMAL_PDF,         1.5, 1.5;        %intertemporal elasticity of substitution
phi,             INV_GAMMA_PDF,      0.03, 0.375;     %costs of accumulating capital
psi,             INV_GAMMA_PDF,      0.5, 0.1;        %interest rate elasticity
dbar,            NORMAL_PDF,         0.80, 0.5;       %equilibrium value for debt
%mu,              INV_GAMMA_PDF,      0.06, 0.2;       %intermediate imported goods share in the production

end;

%mode_compute=4 - Chris Sims algoritm; mh_replic=100000 - metropolis algorithms; mode_compute=6 - Monte Carlo Simulations mh_nblocks=2 - two runs that we can compare; mh_drop=0.2 drop the first 20% obs; mh_jscale=0.5 scale of jumping distribution (variance-covariance)

estimation(datafile=mexico,mode_compute=6,first_obs=1,presample=4,prefilter=0,mh_replic=100000,mh_nblocks=2, mh_jscale=0.5,mh_drop=0.2);

