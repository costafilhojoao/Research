
%% Housekeeping

close all;
clear;

%% Dynamic pricing with nominal rigidity model

model = 1; % choose the model: 1 for the RBC model, 2 for the NK model.

if model == 1
    dynare RBC;
else
    dynare NK;
end

clearvars -except oo_ M_ model;


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

%variables names
S_variables_names = M_.endo_names(state);
X_variables_names = M_.endo_names(control);

%vector of shocks
if model == 1
    shocks = [ 1 ];      % TFP shock;
else
    shocks = [ 0 0 1 ]'; % Monetary shock (NK model)
end

Sirf(:,1) = B * shocks;  % The initial value (at the time of the shocks) for the state variables
Xirf(:,1) = D * shocks;  % The initial value (at the time of the shocks) for the control variables

for j = 2:horizon
    Sirf(:,j) = A * Sirf(:,j-1);
    Xirf(:,j) = C * Sirf(:,j-1);
end

% Graphs

if model == 1
    %TFP shock;
    
    figure('Position', get(0, 'Screensize'))
    subplot(2,2,1)
    plot(1:horizon,Xirf( find( X_variables_names == "y") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 ) 
    axis("square")
    xlim([1 horizon])
    title( 'Output (%)' )
    hold on

    subplot(2,2,2)
    plot(1:horizon, Xirf( find( X_variables_names == "c") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 ) 
    axis("square")
    xlim([1 horizon])
    title('Consumption (%)')
    hold on

    subplot(2,2,3)
    plot(1:horizon, Xirf( find( X_variables_names == "w") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 )
    axis("square")
    xlim([1 horizon])
    title('Wages (%)')
    hold on

    subplot(2,2,4)
    plot(1:horizon, Xirf( find( X_variables_names == "r") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 )
    axis("square")
    xlim([1 horizon])
    title('Real interest rate (p.p.)')
    hold off
    exportgraphics(gcf,'myplot.jpg','Resolution',300)
else
    
    % Monetary shock (NK model)
    
    figure('Position', get(0, 'Screensize'))
    subplot(2,2,1)
    plot(1:horizon,Xirf( find( X_variables_names == "y") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 ) 
    axis("square")
    xlim([1 horizon])
    title( 'Output (%)' )
    hold on

    subplot(2,2,2)
    plot(1:horizon, Xirf( find( X_variables_names == "pi") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 ) 
    axis("square")
    xlim([1 horizon])
    title('Inflation (p.p.)')
    hold on

    subplot(2,2,3)
    plot(1:horizon, Sirf( find( S_variables_names == "i") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 )
    axis("square")
    xlim([1 horizon])
    title('Nomnial interest rate (p.p.)')
    hold on

    subplot(2,2,4)
    plot(1:horizon, Sirf - Xirf( 2,:) , 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2)
    axis("square")
    xlim([1 horizon])
    title('Ex-post real interest rate (p.p.)')
    hold off
    exportgraphics(gcf,'myplot.jpg','Resolution',300)

end

%% Simulations - Sequence of random shocks

if model == 1
    
    e = [ 1 1 1 1 0 0 0 0 ]'; %TFP shock;
    
    horizon = size(e,1)+1;

    shocks_names = M_.exo_names;

    shocks = zeros(M_.exo_nbr, horizon);

    shocks( find( shocks_names == "e"),2:horizon) = e;
    
else
    e_m = [ 1 1 1 1 0 0 0 0 ]'; % Monetary shock (NK model)
    
    horizon = size(e_m,1)+1;

    shocks_names = M_.exo_names;

    shocks = zeros(M_.exo_nbr, horizon);

    shocks( find( shocks_names == "e_m"),2:horizon) = e_m;

end

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end


% Graphs

if model == 1
    
    % TFP shock;
    
    figure('Position', get(0, 'Screensize'))
    subplot(2,2,1)
    plot(1:horizon,Xsim( find( X_variables_names == "y") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 ) 
    axis("square")
    xlim([1 horizon])
    title( 'Output (%)' )
    hold on

    subplot(2,2,2)
    plot(1:horizon, Xsim( find( X_variables_names == "c") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 ) 
    axis("square")
    xlim([1 horizon])
    title('Consumption (%)')
    hold on

    subplot(2,2,3)
    plot(1:horizon, Xsim( find( X_variables_names == "w") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 )
    axis("square")
    xlim([1 horizon])
    title('Wages (%)')
    hold on

    subplot(2,2,4)
    plot(1:horizon, Xsim( find( X_variables_names == "r") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 )
    axis("square")
    xlim([1 horizon])
    title('Real interest rate (p.p.)')
    hold off
    exportgraphics(gcf,'myplot.jpg','Resolution',300)
    
else
    
    % Monetary shock (NK model)
    
    figure('Position', get(0, 'Screensize'))
    subplot(2,2,1)
    plot(1:horizon,Xsim( find( X_variables_names == "y") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 ) 
    axis("square")
    xlim([1 horizon])
    title( 'Output (%)' )
    hold on

    subplot(2,2,2)
    plot(1:horizon, Xsim( find( X_variables_names == "pi") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 ) 
    axis("square")
    xlim([1 horizon])
    title('Inflation (p.p.)')
    hold on

    subplot(2,2,3)
    plot(1:horizon, Ssim( find( S_variables_names == "i") ,:), 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2 )
    axis("square")
    xlim([1 horizon])
    title('Nomnial interest rate (p.p.)')
    hold on

    subplot(2,2,4)
    plot(1:horizon, Ssim - Xsim( 2,:) , 'Color',[0.6350 0.0780 0.1840], 'Linewidth', 2)
    axis("square")
    xlim([1 horizon])
    title('Ex-post real interest rate (p.p.)')
    hold off
    exportgraphics(gcf,'myplot.jpg','Resolution',300)

end
