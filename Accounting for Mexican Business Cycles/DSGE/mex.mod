%The Mexican Great Recession: a business cycle accounting approach
%Code by João Ricardo M. G. Costa Filho
close all;

de  = xlsread('data','Plan1',['F','13',':','F','97']);   %observed real exchange rate shocks
dy  = xlsread('data','Plan1',['E','13',':','E','97']);   %observed HP filtered per capita output cycle
dy2 = xlsread('data','Plan1',['G','13',':','G','97']);   %observed Log linear filtered per capita output cycle

%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------
var y d r c k x m e l tby lambda;  %Endogenous variables

varexo ee;

parameters 
beta gamma delta phi alpha mu omega psi rhoe rbar sige dbar cons1 cons2 cons3 cons4 ybar lbar kbar mbar xbar cbar tbybar lambdabar;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%--------------------------------------------------------------------------------------------------------------------------------------
beta=0.98;     %Discount factor (Kim)
gamma=2;       %intertemporal elasticity of substitution (SG)
delta=0.1;     %rate of depreciation (SG)
%delta=0.064;  %rate of depreciation (Kim)
phi=0.028;     %cost of capital adjustment (SG)
alpha=0.4;     %share of domestic capital in the production (Kim)
mu=0.3;        %intermediate imported goods share in the production 
omega=1.455;   %exponent of labor in utility function (SG)
rhoe=0.73;     %AR1 of real exchange rate process (Table 2, Flexible prices column)
psi=0.000742;  % (SG)
sige=0.01;     %
dbar=0.7442;   %equilibrium aggregate level of foreign debt

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
cbar=ybar-rbar*dbar-xbar+mbar;
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
%var ee = sige; 
var ee;
periods 1:85;
values (de);
end;

steady;

simul(periods=85);

t = [1994:0.25:2015]';
%__________________________________________________________________________
%%%HP Filter

%%Tequila crisis
%dya=dy(1:20);
%start1=1994;
%t1 = [start1:0.25:1998.75]';
%plot(t1,oo_.endo_simul(1,1:20)/10,'b--',t1,dya,'k');


%%Great Recession
%dyb=dy(60:85);
%t2 =t(60:85)'; 
%plot(t2,oo_.endo_simul(1,60:85)/10,'b--',t2,dyb,'k');


%%Great Recession
%dyb=dy(53:85);
%start2=2007;
%t2 = [start2:0.25:2015]'; 
%plot(t2,oo_.endo_simul(1,53:85)/10,'b--',t2,dyb,'k');
%__________________________________________________________________________
%%%Log linear detrending

%%Tequila crisis
dy2a=dy2(1:20);
start1=1994;
t1 = [start1:0.25:1998.75]';
plot(t1,oo_.endo_simul(1,1:20)/10,'k--','Linewidth',3); hold on;
plot(t1,dy2a,'k-','Linewidth',3); 
axis([min(t1(1:20)) max(t1(1:20)) -0.16 0.08]);
XLABEL('1995 crisis')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure18', 'jpg');
hold off;

%%Great Recession
dy2b=dy2(53:85);
start2=2007;
t2 = [start2:0.25:2015]'; 
plot(t2,oo_.endo_simul(1,53:85)/10,'k--','Linewidth',3); hold on;
plot(t2,dy2b,'k-','Linewidth',3); 
axis([min(t2(1:20)) max(t2(1:20)) -0.06 0.05]);
XLABEL('2008 crisis')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure19', 'jpg');
hold off;

%full plot
%plot(t,oo_.endo_simul(1,1:85)/10,'b--',t,dy,'k');
%plotyy(oo_.endo_simul(1,1:85)/10,'b--',dy,'k');
%plotyy(de,'r',dy,'k');
