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


%% Simulation 1: 1995 crisis

% Observed data
dy1995 = xlsread('data','Sheet1',['C','2',':','C','15']); % log-linear filtered per capita output cycle - 1994Q1-1997Q2
% Shocks
de = xlsread('data','Sheet1',['D','2',':','D','15']);     % real exchange rate shocks - 1994Q1-1997Q2

horizon = size(de,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(1,2:horizon) = de; 

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

y1995 = oo_.steady_state( find( endogenous == "y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "y") ),:);

%% Simulation 2: 2008 crisis

% Observed data
dy2008 = xlsread('data','Sheet1',['C','60',':','C','86']); % log-linear filtered per capita output cycle - 2008Q3-2015Q1
% Shocks
de = xlsread('data','Sheet1',['D','60',':','D','86']);     % real exchange rate shocks - 2008Q3-2015Q1

horizon = size(de,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(1,2:horizon) = de; 

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

y2008 = oo_.steady_state( find( endogenous == "y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "y") ),:);

%% Simulation 3: Covid crisis

% Observed data
dycovid = xlsread('data','Sheet1',['C','104',':','C','109']); % log-linear filtered per capita output cycle - 2019Q3-2020Q4
% Shocks
de = xlsread('data','Sheet1',['D','104',':','D','109']);      % real exchange rate shocks - 2019Q3-2020Q4

horizon = size(de,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(1,2:horizon) = de; 

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

ycovid = oo_.steady_state( find( endogenous == "y") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "y") ),:);

%% Model vs Data

%%%%% 1995 crisis %%%%% 
t = [1994:0.25:1997.25]';
model = y1995;
data = dy1995;
figure
plot(t, model(2:length(model) ),'k--','Linewidth',3); hold on;
plot(t,data,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
xlabel('2008 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\2nd Round\figure8a', 'jpg');
hold off;


%%%%% 2008 crisis  %%%%% 
t = [2008.5:0.25:2015]';
model = y2008;
data = dy2008;
figure
plot(t, model(2:length(model) ),'k--','Linewidth',3); hold on;
plot(t,data,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
xlabel('2008 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\2nd Round\figure8b', 'jpg');
hold off;

%%%%% Covid crisis %%%%%

t = [2019.75:0.25:2021]';
model = ycovid;
data = dycovid;
figure
plot(t, model(2:length(model) ),'k--','Linewidth',3); hold on;
plot(t,data,'k-','Linewidth',3);
axis("square")
xlim([min( t ) max( t )])
xlabel('Covid crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthWest')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\2nd Round\figure11', 'jpg');
hold off;


