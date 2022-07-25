%% Retrieving the state-space representation from Dynare
%  João Ricardo Costa Filho, 2022

%{
Correspondence: 

joao.filho@novasbe.pt
joaocostafilho.com

This is a free software: you can redistribute it and/or modify it under                                                                
the terms of the GNU General Public License as published by the Free                                                                   
Software Foundation, either version 3 of the License, or (at your option)                                                              
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
*/
%}

%% Housekeeping

close all;
clear;

%% solve the model

dynare RBC;

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
shocks = [ 1 ];      % TFP shock;

Sirf(:,1) = B * shocks;  % The initial value (at the time of the shocks) for the state variables
Xirf(:,1) = D * shocks;  % The initial value (at the time of the shocks) for the control variables

for j = 2:horizon
    Sirf(:,j) = A * Sirf(:,j-1);
    Xirf(:,j) = C * Sirf(:,j-1);
end

%% Graphs

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
exportgraphics(gcf,'figure1.jpg','Resolution',300)

%% Simulations - Sequence of random shocks

e = [ 1 0.5 -0.25 -0.75 0.25 0.17 -0.1 0 ]'; %TFP shock;

horizon = size(e,1)+1;

shocks_names = M_.exo_names;

shocks = zeros(M_.exo_nbr, horizon);

shocks( find( shocks_names == "e"),2:horizon) = e;
    
Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end


%% Graphs


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
exportgraphics(gcf,'figure2.jpg','Resolution',300)
