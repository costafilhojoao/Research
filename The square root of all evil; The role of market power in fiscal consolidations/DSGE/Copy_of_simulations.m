
%% Housekeeping

close all;
clear;

%% Dynamic pricing with nominal rigidity model

%dynare model12;

dynare dynamic;      % baseline model with dynamic pricing and nominal price rigidity

clearvars -except oo_dynamic M_dynamic; %clc;

% Dynare postestimation information

% M_.exo_names: exogenous variables
% M_.endo_names: endogenous variables 

% M_.state_var: the position of the state variables

%% State Space

% state space representation: 
% S_t = A * S_{t-1} + B * e_{t}, 
% X_t = C * S_{t-1} + D * e_{t};

%initiate the matrices

% baseline model
A = [];
B = [];
C = [];
D = [];

%state variables
state = M_dynamic.state_var';

%control variables
control = [1:1:size(oo_dynamic.dr.ghu,1)]';

%remove state variables from control variables vector
for j = 1:size(state,1)
    
    control( control == state(j) ) = [];

end

% baseline matrices
A = [oo_dynamic.dr.ghx( oo_dynamic.dr.inv_order_var( state ), : ) ];
B = [oo_dynamic.dr.ghu( oo_dynamic.dr.inv_order_var( state ), : ) ];
C = [oo_dynamic.dr.ghx( oo_dynamic.dr.inv_order_var( control ), : ) ];
D = [oo_dynamic.dr.ghu( oo_dynamic.dr.inv_order_var( control ), : ) ];

%exogenous variables names
exogenous = M_dynamic.exo_names;  

%endogenous variables names
endogenous = M_dynamic.endo_names;  

%% Simulations

% check the position of the state variables
oo_dynamic.dr.inv_order_var( state )

% check the position of the control variables
oo_dynamic.dr.inv_order_var( control )

S_variables_names = M_dynamic.endo_names(state);

X_variables_names = M_dynamic.endo_names(control);

% Shocks

si  = xlsread('si','Sheet1',['B','5',':','B','17']);                           % from Duarte; 2010Q4-2013Q4
sG  = xlsread('sG','Sheet1',['B','2',':','B','19']); sG  = sG(1:length(si));   % estimated shocks from the SVAR; 2010Q4-2014Q4
sPF = xlsread('sPF','Sheet1',['B','2',':','B','14']);                          % 2010Q4-2013Q4

% Observed data

mu = xlsread('mu','Sheet1',['B','63',':','B','76']);                           % estimated markups; 2010Q3-2013Q4
mu = mu / mu(1) * 100;

y = xlsread('y','Sheet1',['B','2',':','B','15']);                              % estimated markups; 2010Q3-2013Q4
y = y / y(1) * 100;

%% Simulation 1: government spending shock

horizon = size(sG,1)+1;

shocks = zeros(M_dynamic.exo_nbr, horizon);

shocks(2,2:horizon) = sG;

% baseline model

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim1 = oo_dynamic.steady_state( find( endogenous == "mu") ) + Xsim( oo_dynamic.dr.inv_order_var( find( endogenous == "mu") ),:);
musim1 = musim1 / musim1(1) * 100;

ysim1 = oo_dynamic.steady_state( find( endogenous == "Y") ) + Xsim( oo_dynamic.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim1 = ysim1 / ysim1(1) * 100;% government spending shock

%% Simulation 2:government spending shock + interest rate shock

shocks(3,2:horizon) = si;                                                      % interest rate shock

% baseline model

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim2 = oo_dynamic.steady_state( find( endogenous == "mu") ) + Xsim( oo_dynamic.dr.inv_order_var( find( endogenous == "mu") ),:);
musim2 = musim2 / musim2(1) * 100;

ysim2 = oo_dynamic.steady_state( find( endogenous == "Y") ) + Xsim( oo_dynamic.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim2 = ysim2 / ysim2(1) * 100;


%% Simulation 3: government spending shock + interest rate shock + foreign prices shock

shocks(4,2:horizon) = sPF;               % foreign prices shock

% baseline model

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);


for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim3 = oo_dynamic.steady_state( find( endogenous == "mu") ) + Xsim( oo_dynamic.dr.inv_order_var( find( endogenous == "mu") ),:);
musim3 = musim3 / musim3(1) * 100;

ysim3 = oo_dynamic.steady_state( find( endogenous == "Y") ) + Xsim( oo_dynamic.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim3 = ysim3 / ysim3(1) * 100;


%% Graph

t = 2010.5:0.25:2013.75;

figure('Position', get(0, 'Screensize'))
subplot(1,2,1)
plot( t(1:length(t)), musim1(1:length(t)), 'b--','Linewidth',2,'DisplayName','Simulation 1s'); hold on;    % Simulation 1s (government spending shock)
%plot( t(1:length(t)), musim2(1:length(t)), 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;    % Simulation 2s (government spending shock + interest rate shock)
%plot( t(1:length(t)), musim3(1:length(t)), 'r','Linewidth',3.5,'DisplayName','Simulation 3s');             % Simulation 3s (government spending shock + interest rate shock + foreign prices shock)
plot( t(1:length(t)), mu(1:length(t)),     'k-', 'Linewidth',3.5,'DisplayName','Data')                     % Data
xlim([min( t(1:length(t)) ) max( t(1:length(t)) )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal', 'NumColumns',2)
title('Markup'); hold off;

subplot(1,2,2)
plot( t(1:length(t)), ysim1(1:length(t)), 'b--','Linewidth',2,'DisplayName','Simulation 1s'); hold on;     % Simulation 1s (government spending shock)
%plot( t(1:length(t)), ysim2(1:length(t)), 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;     % Simulation 2s (government spending shock + interest rate shock)
%plot( t(1:length(t)), ysim3(1:length(t)), 'r','Linewidth',3.5,'DisplayName','Simulation 3s');              % Simulation 3s (government spending shock + interest rate shock + foreign prices shock)
plot( t(1:length(t)), y(1:length(t)),     'k-', 'Linewidth',3.5,'DisplayName','Data')                      % Data
xlim([min( t(1:length(t)) ) max( t(1:length(t)) )])
axis("square")
legend( 'Location','southwest','Orientation','horizontal', 'NumColumns',2)
title('Output'); hold off;
exportgraphics(gcf,'myplot.jpg','Resolution',300)
