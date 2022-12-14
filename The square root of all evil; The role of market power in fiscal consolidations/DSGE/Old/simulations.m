
%% Housekeeping

close all;
clear;

%% Dynamic pricing with nominal rigidity model

%dynare model12;

dynare model;      % baseline model with dynamic pricing and nominal price rigidity
dynare model_NK;   % New Keynesian version o model with nominal price rigidity but without dynamic pricing
dynare model_RBC;  % Real Business Cycles version wihtou nominal price rigidity and dynamic pricing

clearvars -except oo_base M_base oo_NK M_NK oo_RBC M_RBC; clc;
%clearvars -except oo_ M_, oo_base_M_;

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

% NK model
A_NK = [];
B_NK = [];
C_NK = [];
D_NK = [];

% RBC model
A_RBC =[];
B_RBC =[];
C_NK = [];
D_NK = [];

%state variables
state = M_base.state_var';

%control variables
control = [1:1:size(oo_base.dr.ghu,1)]';

%remove state variables from control variables vector
for j = 1:size(state,1)
    
    control( control == state(j) ) = [];

end

% baseline matrices
A = [oo_base.dr.ghx( oo_base.dr.inv_order_var( state ), : ) ];
B = [oo_base.dr.ghu( oo_base.dr.inv_order_var( state ), : ) ];
C = [oo_base.dr.ghx( oo_base.dr.inv_order_var( control ), : ) ];
D = [oo_base.dr.ghu( oo_base.dr.inv_order_var( control ), : ) ];

% NK matrices
A_NK = [oo_NK.dr.ghx( oo_NK.dr.inv_order_var( state ), : ) ];
B_NK = [oo_NK.dr.ghu( oo_NK.dr.inv_order_var( state ), : ) ];
C_NK = [oo_NK.dr.ghx( oo_NK.dr.inv_order_var( control ), : ) ];
D_NK = [oo_NK.dr.ghu( oo_NK.dr.inv_order_var( control ), : ) ];

% RBC matrices
A_RBC = [oo_RBC.dr.ghx( oo_RBC.dr.inv_order_var( state ), : ) ];
B_RBC = [oo_RBC.dr.ghu( oo_RBC.dr.inv_order_var( state ), : ) ];
C_RBC = [oo_RBC.dr.ghx( oo_RBC.dr.inv_order_var( control ), : ) ];
D_RBC = [oo_RBC.dr.ghu( oo_RBC.dr.inv_order_var( control ), : ) ];

%exogenous variables names
exogenous = M_base.exo_names;  

%endogenous variables names
endogenous = M_base.endo_names;  

%% Simulations

% check the position of the state variables
oo_base.dr.inv_order_var( state )

% check the position of the control variables
oo_base.dr.inv_order_var( control )

S_variables_names = M_base.endo_names(state);

X_variables_names = M_base.endo_names(control);

% Shocks

si = xlsread('si','Sheet1',['B','5',':','B','17']);                            % from Duarte; 2010Q4-2013Q4
sG  = xlsread('sG','Sheet1',['B','2',':','B','19']); sG  = sG(1:length(si));   % estimated shocks from the SVAR; 2010Q4-2014Q4
sPF = xlsread('sPF','Sheet1',['B','2',':','B','14']);                          % 2010Q4-2013Q4

% Observed data

mu = xlsread('mu','Sheet1',['B','63',':','B','76']);                           % estimated markups; 2010Q3-2013Q4
mu = mu / mu(1) * 100;

y = xlsread('y','Sheet1',['B','2',':','B','15']);                           % estimated markups; 2010Q3-2013Q4
y = y / y(1) * 100;

%% Simulation 1: government spending shock

horizon = size(sG,1)+1;

shocks = zeros(M_base.exo_nbr, horizon);

shocks(2,2:horizon) = sG; % government spending shock

%{

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end


musim1 = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim1 = musim1 / musim1(1) * 100;

ysim1 = oo_.steady_state( find( endogenous == "Y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim1 = ysim1 / ysim1(1) * 100;

%}

%% Simulation 2:government spending shock + interest rate shock

shocks(3,2:horizon) = si;  % interest rate shock

% baseline model

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim2 = oo_base.steady_state( find( endogenous == "mu") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "mu") ),:);
musim2 = musim2 / musim2(1) * 100;

ysim2 = oo_base.steady_state( find( endogenous == "Y") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim2 = ysim2 / ysim2(1) * 100;


% NK model

Ssim_NK = zeros( size(state,1), horizon);
Xsim_NK = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim_NK(:,j) = A_NK * Ssim_NK(:,j-1) + B_NK * shocks(:,j);
    Xsim_NK(:,j) = C_NK * Ssim_NK(:,j-1) + D_NK * shocks(:,j);
    
end

musim2_NK = oo_NK.steady_state( find( endogenous == "mu") ) + Xsim_NK( oo_NK.dr.inv_order_var( find( endogenous == "mu") ),:);
musim2_NK = musim2_NK / musim2_NK(1) * 100;

ysim2_NK = oo_NK.steady_state( find( endogenous == "Y") ) + Xsim_NK( oo_NK.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim2_NK = ysim2_NK / ysim2_NK(1) * 100;

% RBC model

Ssim_RBC = zeros( size(state,1), horizon);
Xsim_RBC = zeros( size(control,1), horizon);


for j = 2:horizon
    
    Ssim_RBC(:,j) = A_RBC * Ssim_RBC(:,j-1) + B_RBC * shocks(:,j);
    Xsim(:,j) = C_RBC * Ssim_RBC(:,j-1) + D_RBC * shocks(:,j);
    
end

musim2_RBC = oo_RBC.steady_state( find( endogenous == "mu") ) + Xsim_RBC( oo_RBC.dr.inv_order_var( find( endogenous == "mu") ),:);
musim2_RBC = musim2_RBC / musim2_RBC(1) * 100;

ysim2_RBC = oo_RBC.steady_state( find( endogenous == "Y") ) + Xsim_RBC( oo_RBC.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim2_RBC = ysim2_RBC / ysim2_RBC(1) * 100;

%% Simulation 3: government spending shock + interest rate shock + foreign prices shock

shocks(4,2:horizon) = sPF;               % foreign prices shock

% baseline model

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);


for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim3 = oo_base.steady_state( find( endogenous == "mu") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "mu") ),:);
musim3 = musim3 / musim3(1) * 100;

ysim3 = oo_base.steady_state( find( endogenous == "Y") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim3 = ysim3 / ysim3(1) * 100;

% NK model

Ssim_NK = zeros( size(state,1), horizon);
Xsim_NK = zeros( size(control,1), horizon);


for j = 2:horizon
    
    Ssim_NK(:,j) = A_NK * Ssim_NK(:,j-1) + B_NK * shocks(:,j);
    Xsim_NK(:,j) = C_NK * Ssim_NK(:,j-1) + D_NK * shocks(:,j);
    
end

musim3_NK = oo_NK.steady_state( find( endogenous == "mu") ) + Xsim_NK( oo_NK.dr.inv_order_var( find( endogenous == "mu") ),:);
musim3_NK = musim3_NK / musim3_NK(1) * 100;

ysim3_NK = oo_NK.steady_state( find( endogenous == "Y") ) + Xsim_NK( oo_NK.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim3_NK = ysim3_NK / ysim3_NK(1) * 100;

% RBC model

Ssim_RBC = zeros( size(state,1), horizon);
Xsim_RBC = zeros( size(control,1), horizon);


for j = 2:horizon
    
    Ssim_RBC(:,j) = A_RBC * Ssim_RBC(:,j-1) + B_RBC * shocks(:,j);
    Xsim_RBC(:,j) = C_RBC * Ssim_RBC(:,j-1) + D_RBC * shocks(:,j);
    
end

musim3_RBC = oo_RBC.steady_state( find( endogenous == "mu") ) + Xsim_RBC( oo_RBC.dr.inv_order_var( find( endogenous == "mu") ),:);
musim3_RBC = musim3_RBC / musim3_RBC(1) * 100;

ysim3_RBC = oo_RBC.steady_state( find( endogenous == "Y") ) + Xsim_RBC( oo_RBC.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim3_RBC = ysim3_RBC / ysim3_RBC(1) * 100;

%% Simulation 4: government spending shock + foreign prices shock

%{

shocks = zeros(M_.exo_nbr, horizon);

shocks(2,2:horizon) = sG;
shocks(4,2:horizon) = sPF;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim4 = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim4 = musim4 / musim4(1) * 100;

ysim4 = oo_.steady_state( find( endogenous == "Y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim4 = ysim4 / ysim4(1) * 100;


%% Simulation 5: interest rate shock + foreign prices shock

shocks = zeros(M_.exo_nbr, horizon);

shocks(2,2:horizon) = sG;
shocks(4,2:horizon) = sPF;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim5 = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim5 = musim5 / musim5(1) * 100;

ysim5 = oo_.steady_state( find( endogenous == "Y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim5 = ysim5 / ysim5(1) * 100;


%}

%% Graph

t = 2010.5:0.25:2013.75;

figure('Position', get(0, 'Screensize'))
subplot(1,2,1)
plot( t, musim2, 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;    % Simulation 2s (government spending shock + interest rate shock)
plot( t, musim3, 'r','Linewidth',3.5,'DisplayName','Simulation 3s');             % Simulation 3s (government spending shock + interest rate shock + foreign prices shock)
plot( t, musim2_NK, 'b--','Linewidth',2,'DisplayName','NK 2s');                  % NK 2s
plot( t, musim3_NK, 'b','Linewidth',2,'DisplayName','NK 3s');                    % NK 3s
plot( t, musim2_RBC, 'g--','Linewidth',2,'DisplayName','RBC 2s');                % RBC 2s
plot( t, musim3_RBC, 'g','Linewidth',2,'DisplayName','RBC 3s');                  % RBC 3s
plot( t, mu,     'k-', 'Linewidth',3.5,'DisplayName','Data')                       % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal', 'NumColumns',2)
title('Markup'); hold off;

subplot(1,2,2)
plot( t, ysim2, 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;     % Simulation 2s (government spending shock + interest rate shock)
plot( t, ysim3, 'r','Linewidth',3.5,'DisplayName','Simulation 3s');              % Simulation 3s (government spending shock + interest rate shock + foreign prices shock)
plot( t, ysim2_NK, 'b--','Linewidth',2,'DisplayName','NK 2s');                    % NK 2s
plot( t, ysim3_NK, 'b','Linewidth',2,'DisplayName','NK 3s');                      % NK 3s
plot( t, ysim2_RBC, 'g--','Linewidth',2,'DisplayName','RBC 2s');                  % RBC 2s
plot( t, ysim3_RBC, 'g','Linewidth',2,'DisplayName','RBC 3s');                     % RBC 3s    
plot( t, y,     'k-', 'Linewidth',3.5,'DisplayName','Data')                        % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southwest','Orientation','horizontal', 'NumColumns',2)
title('Output'); hold off;
exportgraphics(gcf,'myplot.jpg','Resolution',300)
%saveas(gcf, 'output and markup', 'jpg')