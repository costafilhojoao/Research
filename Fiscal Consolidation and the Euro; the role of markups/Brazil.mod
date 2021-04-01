%The Brazilian depression
%Code by João Ricardo M. G. Costa Filho
close all;

dinv   = xlsread('data','Plan1',['E','74',':','E','83']);   %observed Log linear filtered per capita investment cycle
dgov   = xlsread('data','Plan1',['F','74',':','F','83']);   %observed Log linear filtered per capita gov spending cycle
dy     = xlsread('data','Plan1',['G','74',':','G','83']);   %observed Log linear filtered per capita output cycle
dbndes = xlsread('data','Plan1',['H','74',':','H','83']);   %observed Log linear filtered per capita output cycle

%-----------------------------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%-----------------------------------------------------------------------------------------------------------------------------------------------------------

var Y I C lambda W L R varlambda Q S Sp Sg phi N Ne Nn eta v Rk x z psi A K U xi delta In pi pistar P Pm Bg i B phic F Z G;  %Endogenous variables (39)

varexo exi ea ei eg epsi; %Exogenous variables (4)

parameters 
beta h chi varphi Omega omega theta alpha Ubar deltabar zeta rho rhoxi rhoa etai epsilon gamma gammap kappapi kappay GoY Cbar lambdabar Wbar Lbar Rbar
Qbar Sbar Spbar Sgbar phibar Nbar Nebar Nnbar etabar vbar Rkbar xbar zbar psibar Ybar Kbar Ibar Inbar pibar pistarbar Pstarbar Pbar Pmbar Fbar Zbar
Bgbar ibar Gbar Bbar tau nu phicbar;

%-----------------------------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibration
%-----------------------------------------------------------------------------------------------------------------------------------------------------------
beta=0.99;      %Discount factor
h=0.815;        %Habit parameter
chi=3.409;      %Relative utility weight of labor
varphi=0.276;   %Inverse Frisch elasticity of labor supply
Omega=0.381;    %Fraction of capital that can be diverted
omega=0.002;    %Proportional transfer to the entering bankers 
theta=0.972;    %Survival rate of the bankers
alpha=0.4;      %Capital share 
zeta=7.200;     %Elasticity of marginal depreciation with respect to utilization rate
rhoxi=0.9;
rhoa=0.8;
etai=1.728;     %Inverse elasticity of net investment to the price of capital
epsilon=4.167;
gamma=0.779;    %Probability of keeping prices fixed
gammap=0.241;   %Measure of price indexation
kappapi=1.5;    %Inflation coefficient of the Taylor rule
kappay=0.5/4;   %Output gap coefficient of the Taylor rule  
rho=0.8;
GoY=0.2;        %Steady state proportion of government expenditures
tau=0.1;         %SOURCEEEE
nu=0.8;         %SOURCEEEE

%Steady State
lambdabar=2.3742;
Cbar=1.0621;
Wbar=0.2516;
Lbar=1.7112832183; %2013 = 1711.2832183
Bbar=1.0759;
Ybar=1.3599;
Pmbar=0.4726;
Kbar=1.0347;
Pbar=1;
Pstarbar=Pbar;
pibar=0;
pistarbar=1;
Rbar=1/beta;
Qbar=1;
deltabar=0.05; 
Ubar=(deltabar*(1+zeta))^(1/(1+zeta));
Rkbar=-(deltabar-Ubar^(1+zeta)-Qbar)/Qbar;
Inbar=0;
%phibar=(1-Rbar*theta)/(omega+(Rkbar-Rbar)*theta); %LEVERAGE RATIO --> 4 in the paper; USE 2???
phibar=1.5;
phicbar=phibar*(1/(1-psi));
zbar=1;
xbar=zbar;
etabar=(theta-1)/(zbar*beta*theta-1);
vbar=((1-theta)*(Rkbar-Rbar)*beta)/(1-beta*theta*xbar);
psibar=0.4; %(average 2003-2010??? Credit BNDES/GDP)
ibar=Rbar-1;
Sbar=Kbar;
Ibar=deltabar*Kbar;
Nnbar=omega*Qbar*Sbar;
Nebar=theta*((Rkbar-Rbar)*phibar+Rbar)*phibar*Kbar;
Nbar=Nebar+Nnbar;
Bgbar=psibar*Qbar*Sbar;
Sgbar=psibar*Sbar;
Spbar=Sbar-Sgbar;
Fbar=Ybar*Pmbar/(1-gamma*beta);
Zbar=Ybar/(1-gamma*beta);
Gbar=GoY*Ybar;

%-----------------------------------------------------------------------------------------------------------------------------------------------------------
% 3. Model 
%-----------------------------------------------------------------------------------------------------------------------------------------------------------
model(linear); 

//Households (5)

C(-1)-C-beta*h*(C-C(+1))=lambda*((Cbar-h*Cbar)^2)*lambdabar/Cbar;
lambdabar*Wbar*(lambda+W)=L*chi*varphi*Lbar^varphi;
Rbar*beta*(R(+1)+lambda(+1))=lambda;
varlambda=lambda(+1)-lambda;
Cbar*C=Wbar*Lbar*(W+L)+Bbar*(Rbar*(R(-1)+B(-1))-B);

//Financial intermediates (10)

Qbar*Sbar*(Q+S)=Nbar*phibar*(N+phi);
phi=eta+v*(vbar/(Omega-vbar));
vbar*v=beta*((1-theta)*(varlambda*(Rkbar-Rbar)+Rkbar(-1)*Rk(-1)-Rbar*R)+theta*xbar*vbar*(varlambda+x+v(+1)));
eta=theta*beta*zbar*(varlambda+z+eta(+1));
xbar*x=zbar*(phi(+1)+z-phi);
zbar*z=phibar*phi*(Rkbar-Rbar)+Rkbar*Rk*(phibar-1)-Rbar*phibar*R;
Nbar*N=Nebar*Ne+Nnbar*Nn;
Nebar*Ne=theta*Nbar*(phibar*(Rkbar*Rk(-1)-Rbar*R(-1)+phi(-1))+Rbar*R(-1)+N(-1)*((Rkbar-Rbar)*phibar+Rbar));
Nn=Q+S(-1);

// Credit Policy (5)

Qbar*Sbar*(Q+S)=phicbar*Nbar*(phic+N);
phic=phi+(psibar/(1-psibar))*psi;
Bg=psi+Q+S;
S=Sp+Sg;
Sg=psi+S;

// Intermediate goods firms (7)

Y=A+alpha*(K(-1)+xi+U)+(1-alpha)*L;
alpha*Pmbar*Ybar*(Pm+Y-U)=Kbar*(zeta*U+K(-1)-xi);
(1-alpha)*(Pm+Y-L)=W;
deltabar*delta=(Ubar^(1+zeta))*U;
Rkbar*(Rk+Q)=alpha*Pmbar*Ybar/Kbar*(Pm(+1)+Y(+1)-K)+Q(+1)+xi(+1)-deltabar*(delta(+1)+xi(+1));
xi=rhoxi*xi(-1)+exi;
A=rhoa*A(-1)+ea;

// Capital producing firms (2)

Q=etai*(In-In(-1))-beta*((lambda(+1)-lambda)-etai*(In(+1)-In));
In=Ibar*I-deltabar*(delta+xi+K(-1));

// Final goods producers (4)

pi=(1-gamma)*pistar+gamma*pi(-1);
pistar=F+pi-Z;
Fbar*F=Ybar*Pmbar*(Y+Pm);
Zbar*Z=Ybar*Y;

// Government and Central Bank (7)

Ybar*Y=Cbar*C+Ibar*I+tau*psibar*Qbar*Kbar*(psi+Q+K);
K=xi+K(-1)+In;
Gbar*G+tau*psibar*Qbar*Kbar*(psi+Q+K)=Bgbar*(Rkbar*Rk(-1)-Rbar*R(-1)+(Rkbar-Rbar)*Bg(-1));
i=kappapi*pi(+1)+kappay*Y+i(-1)+ei;
ibar*i=Rbar*(P(+1)-P+R);
psibar*psi=nu*(Rk-R)+epsi;
Gbar*G=Gbar*G(-1)+eg;

end;
%-----------------------------------------------------------------------------------------------------------------------------------------------------------
shocks;

var epsi;
periods 1:10;
values (dbndes);
end;

steady;

simul(periods=82);

t = [2014.25:0.25:2016.5]';

%check;

%stoch_simul(ar=1,irf=20)  Y;

plot(t,oo_.endo_simul(1,1:10)/10,'b--',t,dy,'k');

