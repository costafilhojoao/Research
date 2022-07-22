%{
Accounting for Mexican Business Cycles
Brinca and Costa-Filho (2022)

Correspondence: 

João Ricardo Costa Filho; joao.filho@novasbe.pt
joaocostafilho.com

This is a free software: you can redistribute it and/or modify it under                                                               
the terms of the GNU General Public License as published by the Free                                                                  
Software Foundation, either version 3 of the License, or (at your option)                                                              
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                          

%}


%% Housekeeping

close all;
clear;

%% Solve the model

%dynare mex;  
dynare Copy_of_mex

clearvars -except oo_ M_; clc;

% Dynare postestimation information

% M_.exo_names: exogenous variables
% M_.endo_names: endogenous variables 

% M_.state_var: the position of the state variables

%% State Space

% state space representation: 
% S_t = A * S_{t-1} + B * e_{t}, 
% X_t = C * S_{t-1} + D * e_{t};

%initiate the matrices

A = [];
B = [];
C = [];
D = [];

%state variables
state = M_.state_var';

%control variables
control = [1:1:size(oo_.dr.ghu,1)]';

%remove state variables from control variables vector
for j = 1:size(state,1)
    
    control( control == state(j) ) = [];

end

% baseline matrices
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

S_variables_names = M_.endo_names_long(state);

X_variables_names = M_.endo_names_long(control);


%% Simulation 1: 2008 crisis

% Shocks
de = xlsread('data','Sheet1',['C','57',':','C','86']);   % real exchange rate shocks - 2007Q4-2015Q1

% Observed data
dy2008 = xlsread('data','Sheet1',['D','57',':','D','86']); % log-linear filtered per capita output cycle - 2007Q4-2015Q1;

horizon = size(de,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(1,2:horizon) = de; 

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

y2008 = oo_.steady_state( find( endogenous == "y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "y") ),:);

%% Simulation 2: 1995 crisis

% Shocks
de = xlsread('data','Sheet1',['C','2',':','C','10']); % real exchange rate shocks - 1994Q1-1998Q3

% Observed data
dy1995 = xlsread('data','Sheet1',['D','2',':','D','10']);  % log-linear filtered per capita output cycle - 1994Q1-1998Q3

horizon = size(de,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(1,2:horizon) = de; 

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

y1995 = oo_.steady_state( find( endogenous == "y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "y") ),:);

%% Simulation 3: Covid crisis

% Shocks
de = xlsread('data','Sheet1',['C','105',':','C','109']);   % real exchange rate shocks - 2019Q3-2020Q4

% Observed data
dycovid = xlsread('data','Sheet1',['D','105',':','D','109']); dycovid = [0 dycovid']';   % log-linear filtered per capita output cycle - 2019Q3-2020Q4; 2019Q2 set equal to zero

horizon = size(de,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(1,2:horizon) = de; 

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

ycovid = oo_.steady_state( find( endogenous == "y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "y") ),:);

%% Model vs Data

% 2008 crisis 
t = [2007.75:0.25:2015]';  %2007Q4-2015Q1
model = y2008;
data = dy2008;
figure
plot(t, model(2:length(model) ) * 100,'k--','Linewidth',3); hold on;
plot(t,data,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
ylim([min( data )*1.1 max( data )*1.1])
xlabel('2008 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
%saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure19', 'jpg');
hold off;
%{
% 1995 crisis
t = [1993.75:0.25:1996]';
model = y1995;
data = dy1995;
figure
plot(t,model*100,'k--','Linewidth',3); hold on;
plot(t,data,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
%ylim([min( data )*1.4 max( data )*1.1])
xlabel('1995 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
%saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure19', 'jpg');
hold off;

% Covid crisis
t = [2019.75:0.25:2021]'; 
model = ycovid;
data = dycovid;
figure
plot(t,model*100,'k--','Linewidth',3); hold on;
plot(t,data,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
%ylim([min( data )*1.1 max( data )*1.1])
xlabel('Covid crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
%saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure19', 'jpg');
hold off;




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
%}



