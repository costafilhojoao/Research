
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

%% Impulse-Response Functions (IRF)

horizon = 20;
Sirf = zeros( size(state,1), horizon );   % States IRF matrix
Xirf = zeros( size(control,1), horizon);  % Control IRF matrix

shocks = [ 0 0.01 zeros(8,1)' ]'; %vector of shocks

Sirf(:,1) = B * shocks;  % The initial value (at the time of the shocks) for the state variables
Xirf(:,1) = D * shocks;  % The initial value (at the time of the shocks) for the control variables

for j = 2:horizon
    Sirf(:,j) = A * Sirf(:,j-1);
    Xirf(:,j) = C * Sirf(:,j-1);
end

figure
subplot(2,2,1)
plot(1:horizon, ( Xirf( oo_.dr.inv_order_var( find( endogenous == "Y") ),:) / oo_.steady_state( find( endogenous == "Y") ) ) * 100, 'k-') 
axis("square")
title( 'Output (%)' )
hold on
   
subplot(2,2,2)
plot(1:horizon, ( Xirf( oo_.dr.inv_order_var( find( endogenous == "mu") ),:) / oo_.steady_state( find( endogenous == "mu") ) ) * 100, 'k-')
axis("square")
title('Markup (%)')
hold on

subplot(2,2,3)
plot(1:horizon, ( Xirf( oo_.dr.inv_order_var( find( endogenous == "H") ),:) / oo_.steady_state( find( endogenous == "H") ) ) * 100, 'k-')
axis("square")
title('Hours (%)')
hold on

subplot(2,2,4)
plot(1:horizon, ( Xirf( oo_.dr.inv_order_var( find( endogenous == "W") ),:) / oo_.steady_state( find( endogenous == "W") ) ) * 100, 'k-')
axis("square")
title('Wages (%)')
hold off

%% Random Simulation

rand('seed', 1301)
horizon = 20;

shocks = [ ones(M_.exo_nbr,1)' ]';

shocks = shocks * ( rand( 1, horizon ) ) / 100;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

figure
subplot(1,2,1)
plot(1:horizon, ( Xsim( oo_.dr.inv_order_var( find( endogenous == "Y") ),:) / oo_.steady_state( find( endogenous == "Y") ) ) * 100, 'k-') 
axis("square")
title( 'Output (%)' )
hold on
   
subplot(1,2,2)
plot(1:horizon, ( Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:) / oo_.steady_state( find( endogenous == "mu") ) ) * 100, 'k-') 
axis("square")
title('Markup (%)')
hold on

%% Simulation

% check the position of the state variables
oo_.dr.inv_order_var( state )

% check the position of the control variables
oo_.dr.inv_order_var( control )

S_variables_names = M_.endo_names(state);

X_variables_names = M_.endo_names(control);

%a) government spending shock

dgov  = xlsread('sG','Sheet1',['B','2',':','B','19']);   %estimated shocks from the SVAR; 2010Q4-2014Q4

horizon = size(dgov,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(2,2:horizon) = dgov;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

mu = xlsread('mu','Sheet1',['B','63',':','B','80']);   %estimated markups; 2010Q3-2014Q4

mu = mu / mu(1) * 100;

musim = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim = musim / musim(1) * 100;

figure
plot(2010.5:0.25:2014.75, musim(1:size(mu)), 'b--','Linewidth',2,'DisplayName','Model'); hold on;
plot(2010.5:0.25:2014.75, mu,                'k-', 'Linewidth',2,'DisplayName','Data')
xlim([min(2010.5:0.25:2014.75) max(2010.5:0.25:2014.75)])
axis("square")
legend( 'Location','southeast','Orientation','horizontal')
title('Markup'); hold off;
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\3. Brasil\figure6', 'jpg')

%yyaxis left
%plot(1:horizon-1, musim(1:size(mu)), 'b-')
%axis("square")
%yyaxis right
%plot(1:horizon-1, mu, 'k--')
%title('Markup')


%b) government spending shock + interest rate shock

drate = xlsread('si','Sheet1',['B','5',':','B','17']);   %estimated shocks from Duarte; 2010Q4-2013Q4

dgov  = dgov(1:length(drate));

horizon = size(drate,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(2,2:horizon) = dgov;
shocks(3,2:horizon) = drate;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim = musim / musim(1) * 100;

figure
plot(2010.5:0.25:2013.75, musim, 'b--','Linewidth',2,'DisplayName','Model'); hold on;
plot(2010.5:0.25:2013.75, mu(1:length(musim)),                'k-', 'Linewidth',2,'DisplayName','Data')
xlim([min(2010.5:0.25:2013.75) max(2010.5:0.25:2013.75)])
axis("square")
legend( 'Location','southeast','Orientation','horizontal')
title('Markup'); hold off;
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\3. Brasil\figure6', 'jpg')



%c) government spending shock + interest rate shock + Foreign prices shock

sPF = xlsread('sPF','Sheet1',['B','2',':','B','14']);  % 2010Q4-2013Q4

shocks = zeros(M_.exo_nbr, horizon);

shocks(2,2:horizon) = dgov;
shocks(3,2:horizon) = drate;
shocks(4,2:horizon) = sPF;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim = musim / musim(1) * 100;

figure
plot(2010.5:0.25:2013.75, musim, 'b--','Linewidth',2,'DisplayName','Model'); hold on;
plot(2010.5:0.25:2013.75, mu(1:length(musim)),                'k-', 'Linewidth',2,'DisplayName','Data')
xlim([min(2010.5:0.25:2013.75) max(2010.5:0.25:2013.75)])
axis("square")
legend( 'Location','southeast','Orientation','horizontal')
title('Markup'); hold off;
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\3. Brasil\figure6', 'jpg')




%d) government spending shock + Foreign prices shock

dgov  = xlsread('sG','Sheet1',['B','2',':','B','19']);   %estimated shocks from the SVAR; 2010Q4-2014Q4
sPF = xlsread('sPF','Sheet1',['B','2',':','B','18']);  % 2010Q4-2013Q4

horizon = size(dgov,1)+1;

shocks = zeros(M_.exo_nbr, horizon);

shocks(2,2:horizon) = dgov;
shocks(4,2:horizon) = sPF;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim = musim / musim(1) * 100;

figure
plot(2010.5:0.25:2014.75, musim, 'b--','Linewidth',2,'DisplayName','Model'); hold on;
plot(2010.5:0.25:2014.75, mu(1:length(musim)),                'k-', 'Linewidth',2,'DisplayName','Data')
xlim([min(2010.5:0.25:2014.75) max(2010.5:0.25:2014.75)])
axis("square")
legend( 'Location','southeast','Orientation','horizontal')
title('Markup'); hold off;
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\3. Brasil\figure6', 'jpg')




%e) government spending shock + interest rate shock + Foreign prices shock
%+ TFP shock

sA = xlsread('sA','Sheet1',['B','2',':','B','14']);  % 2010Q4-2013Q4

shocks = zeros(M_.exo_nbr, horizon);

shocks(1,2:horizon) = sA;
shocks(2,2:horizon) = dgov;
shocks(3,2:horizon) = drate;
shocks(4,2:horizon) = sPF;

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

%Ssim(:,1)  = xlsread('S_initial','Sheet1',['B','2',':','B','14']);  %
%Xsim(:,1)  = xlsread('X_initial','Sheet1',['B','2',':','A','22']);  %

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim = oo_.steady_state( find( endogenous == "mu") ) + Xsim( oo_.dr.inv_order_var( find( endogenous == "mu") ),:);
musim = musim / musim(1) * 100;

figure
plot(2010.5:0.25:2013.75, musim, 'b--','Linewidth',2,'DisplayName','Model'); hold on;
plot(2010.5:0.25:2013.75, mu(1:length(musim)),                'k-', 'Linewidth',2,'DisplayName','Data')
xlim([min(2010.5:0.25:2013.75) max(2010.5:0.25:2013.75)])
axis("square")
legend( 'Location','southeast','Orientation','horizontal')
title('Markup'); hold off;
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\3. Brasil\figure6', 'jpg')

