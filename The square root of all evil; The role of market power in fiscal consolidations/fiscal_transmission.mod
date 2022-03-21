vc lembra % ----------------------------------------------------------------------------------
% DSGE Models - Seminário
% Thais Palanca
% ----------------------------------------------------------------------------------
% Paper: What Accounts for the Changes in U.S. Fiscal Policy Transmission?
% - Bibiie, Meier, Müller
%  Replicação das IRF da figura 1
% ----------------------------------------------------------------------------------

var c_a c_n c y pi r w b t d_s n n_a n_n g;                                              % endogenous variables
varexo eg;                                                                     % exogenous variables
parameters lambda phi_pi phi_g phi_b eta rho1 rho2 sigma G_y T_y tal phi F alpha beta B_py epsilon N;        % parameters

%----------------------------------------------------------------
% Parameter calibration
%----------------------------------------------------------------
%uncontroversial values
beta = 0.9926375; %desconto intertemporal
G_y = 0.2;        %gov. expenditure share
tal = 0.3;        %income tax
B_py = 0;         %debt on SS 
epsilon = 6;      %necessary for 20% marrk up on SS
alpha = 0.85;     %
sigma = 2;
N = 0.25;          %spend one-fourth of their time endowment working


%Estimated parameters
lambda = 0.509;    %proportion of non asset-holders
phi_pi = 1.012;
phi_b = -0.070;
phi_g = 0.168;
eta = 0.510;
rho1 = 1.028;
rho2 = -0.063;

T_y = G_y - tal;
F = 1/(epsilon-1);
phi = ((1-tal)*(1-N))/(N*(1-G_y));

%----------------------------------------------------------------
% Model
%----------------------------------------------------------------

model(linear);

% Euler equation - asset holders (1)
c_a = c_a(+1) - ((1/sigma)*(r-pi(+1))) + ((1 + (T_y/(1-G_y)))*((1/sigma)-1))*(n_a(+1) - n_a);

%consumo - non asset holders (2)
c_n = (((1-tal)*(w+n_n))-(T_y*t))/(1-G_y);

% Labor supply - non-asset holders (3)
n_n = ((phi/(1+phi))*(-(T_y)/(1-G_y+T_y)))*(w-t);

%labor supply - asset holders (4)
n_a = (w - c_a)/(N/(1-N));

%mercado de trabalho (5)
n = lambda*n_n + (1-lambda)*n_a;

%Consumo agregado (6)
c = lambda*c_n + (1-lambda)*c_a;

%função produção (7);
y = (1+F)*n;

%inflação (8)
pi = (beta*pi(+1))+(((1-alpha)*(1-(alpha*beta)))/alpha)*w;

%%%Governo%%%
%dívida (9)
b = (b(-1)+ G_y*g(-1) - T_y*t(-1) - (tal*y(-1)))/beta;

%deficit primario (10)
d_s = G_y*g - T_y*t;

%Regra fiscal (11)
d_s = eta*d_s(-1) + phi_g*G_y*g + phi_b*b;

%Regra monetária (12)
r = phi_pi*pi(+1);

% equilíbrio do mercado de bens e serviços (13)
y = G_y*g+(1-G_y)*c;
 
%choque fiscal - AR(2) (14)
g = rho1*g(-1) + rho2*(g(-2)) +eg;           
end;


%----------------------------------------------------------------
% Shock calibration
%----------------------------------------------------------------
shocks;
var eg = 1;
end;


%----------------------------------------------------------------
% Model checks: stability and steady-state
%----------------------------------------------------------------
check;
resid(1);
steady;

%--------------------------------------------------------------------------------------------------
% Solution, estimation, simulation, etc
%--------------------------------------------------------------------------------------------------

% Solve baseline model
stoch_simul(hp_filter = 1600, order = 1, irf = 20, nograph) g y w c b;
oo_1975=oo_;

% Set a new calibration for 1983-1004 parameters
set_param_value('lambda',0.347)
set_param_value('phi_pi',1.771)
set_param_value('phi_b',-0.117)
set_param_value('phi_g',0.644)
set_param_value('eta',0.71)
set_param_value('rho1',0.638)
set_param_value('rho2',0.270)


% Solve model for 1983-1004 parameters
stoch_simul(hp_filter = 1600, order = 1, irf = 20, nograph) g y w c b;
oo_1983=oo_;  

T = 20; % Tamanho da IRF
irfs = nan(5,T,2);         % Cria vetor que salva a IRF de todos os modelos

% Salvando as IRFs no primeiro modelo
irfs(1,:,1) = oo_1975.irfs.g_eg';
irfs(2,:,1) = oo_1975.irfs.y_eg';
irfs(3,:,1) = oo_1975.irfs.w_eg';
irfs(4,:,1) = oo_1975.irfs.c_eg';
irfs(5,:,1) = oo_1975.irfs.b_eg';

% Salvando as IRFs no segundo modelo
irfs(1,:,2) = oo_1983.irfs.g_eg';
irfs(2,:,2) = oo_1983.irfs.y_eg';
irfs(3,:,2) = oo_1983.irfs.w_eg';
irfs(4,:,2) = oo_1983.irfs.c_eg';
irfs(5,:,2) = oo_1983.irfs.b_eg';



%Gráficos 

X = 0:20
Y = -1:2
Z = 0:0
figure

for i = 1:5 
  subplot(1,2,1)
   plot(1:T,irfs(1,:,1)) 
   axis([1,20, -1, 1.5], "square")
   title('Spending (1957-1979)')
   hold on
   plot(X,Z)
   
   hold on
   subplot(1,2,2)
   plot(1:T,irfs(1,:,2))
   axis([1,20, -1, 1.5], "square")
   title('Spending (1983-2004)')
   hold on
   plot(X,Z)
   
   end
   
   
figure

for i = 1:5 
  subplot(1,2,1)
   plot(1:T,irfs(2,:,1)) 
   axis([1,20, -1,1], "square")
   title('Output (1957-1979)')
   hold on
   plot(X,Z)
   
   hold on
   subplot(1,2,2)
   plot(1:T,irfs(2,:,2))
   axis([1,20, -1, 1], "square")
   title('Output (1983-2004)')
   hold on
   plot(X,Z)
   
   end
   
   
figure

for i = 1:5 
  subplot(1,2,1)
   plot(1:T,irfs(3,:,1)) 
   axis([1,20, -0.5,0.7], "square")
   title('Real Wage (1957-1979)')
   hold on
   plot(X,Z)
   
   hold on
   subplot(1,2,2)
   plot(1:T,irfs(3,:,2))
   axis([1,20, -0.5, 0.7], "square")
   title('Real Wage (1983-2004)')
   hold on
   plot(X,Z)
   
   end
   
figure

for i = 1:5 
  subplot(1,2,1)
   plot(1:T,irfs(4,:,1)) 
   axis([1,20, -0.5,0.7], "square")
   title('Consumption (1957-1979)')
   hold on
   plot(X,Z)
   
   hold on
   subplot(1,2,2)
   plot(1:T,irfs(4,:,2))
   axis([1,20, -0.5, 0.7], "square")
   title('Consumption (1983-2004)')
   hold on
   plot(X,Z)
   
   end
   
figure

for i = 1:5 
  subplot(1,2,1)
   plot(1:T,irfs(5,:,1)) 
   axis([1,20, -1,1.5], "square")
   title('Debt (1957-1979)')
   hold on
   plot(X,Z)
   
   hold on
   subplot(1,2,2)
   plot(1:T,irfs(5,:,2))
   axis([1,20, -1, 1.5], "square")
   title('Debt (1983-2004)')
   hold on
   plot(X,Z)
   
   end 