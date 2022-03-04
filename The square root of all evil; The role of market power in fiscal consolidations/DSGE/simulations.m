
%% Housekeeping

close all;
clear;

%% Dynamic pricing with nominal rigidity model

%dynare model12;

dynare model13;

clearvars -except oo_ M_;

% Dynare postestimation information

% M_.exo_names: exogenous variables
% M_.endo_names: endogenous variables 

% M_.state_var: the position of the state variables

%% State Space

% state space representation: 
% S_t = A * S_{t-1} + B * e_{t}, 
% X_t = C * S_{t-1} + D * e_{t};

%initiate the matrices

A=[];
B=[];
C=[];
D=[];

%state variables
state = M_.state_var';

%control variables
control = [1:1:size(oo_.dr.ghu,1)]';

%remove state variables from control variables vector
for j = 1:size(state,1)
    
    control( control == state(j) ) = [];

end

A = [oo_.dr.ghx( oo_.dr.inv_order_var( state ), : ) ];

B = [oo_.dr.ghu( oo_.dr.inv_order_var( state ), : ) ];

C = [oo_.dr.ghx( oo_.dr.inv_order_var( control ), : ) ];

D = [oo_.dr.ghu( oo_.dr.inv_order_var( control ), : ) ];

%exogenous variables names
exogenous = M_.exo_names;  

%endogenous variables names
endogenous = M_.endo_names;  

%% Simulations

% check the position of the state variables
oo_.dr.inv_order_var( state )

% check the position of the control variables
oo_.dr.inv_order_var( control )

S_variables_names = M_.endo_names(state);

X_variables_names = M_.endo_names(control);

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

shocks = zeros(M_.exo_nbr, horizon);

shocks(2,2:horizon) = sG;

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


%% Simulation 2:government spending shock + interest rate shock

shocks(3,2:horizon) = si;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim2 = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim2 = musim2 / musim2(1) * 100;

ysim2 = oo_.steady_state( find( endogenous == "Y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim2 = ysim2 / ysim2(1) * 100;


%% Simulation 3: government spending shock + interest rate shock + foreign prices shock

shocks(4,2:horizon) = sPF;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim3 = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim3 = musim3 / musim3(1) * 100;

ysim3 = oo_.steady_state( find( endogenous == "Y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim3 = ysim3 / ysim3(1) * 100;


%% Simulation 4: government spending shock + foreign prices shock

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


%% Graph

t = 2010.5:0.25:2013.75;

subplot(1,2,1)
%figure
plot( t, musim1, 'y--','Linewidth',2,'DisplayName','Simulation 1'); hold on;  % Simulation 1: government spending shock
plot( t, musim2, 'g--','Linewidth',2,'DisplayName','Simulation 2');           % Simulation 2: government spending shock + interest rate shock
plot( t, musim3, 'b--','Linewidth',2,'DisplayName','Simulation 3');           % Simulation 3: government spending shock + interest rate shock + foreign prices shock
plot( t, musim4, 'r--','Linewidth',2,'DisplayName','Simulation 4');           % Simulation 4: government spending shock + foreign prices shock
plot( t, musim5, 'ms','Linewidth',2,'DisplayName','Simulation 5');          % Simulation 5: interest rate shock + foreign prices shock
plot( t, mu,     'k-', 'Linewidth',2,'DisplayName','Data')                    % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal')
title('Markup'); hold off;
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\3. Brasil\figure6', 'jpg')

subplot(1,2,2)
%figure
plot( t, ysim1, 'y--','Linewidth',2,'DisplayName','Simulation 1'); hold on;  % Simulation 1: government spending shock
plot( t, ysim2, 'g--','Linewidth',2,'DisplayName','Simulation 2');           % Simulation 2: government spending shock + interest rate shock
plot( t, ysim3, 'b--','Linewidth',2,'DisplayName','Simulation 3');           % Simulation 3: government spending shock + interest rate shock + foreign prices shock
plot( t, ysim4, 'r--','Linewidth',2,'DisplayName','Simulation 4');           % Simulation 4: government spending shock + foreign prices shock
plot( t, ysim5, 'ms','Linewidth',2,'DisplayName','Simulation 5');            % Simulation 5: interest rate shock + foreign prices shock
plot( t, y,     'k-', 'Linewidth',2,'DisplayName','Data')                    % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal')
title('Output'); hold off;