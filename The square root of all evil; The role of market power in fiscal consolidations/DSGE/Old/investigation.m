
horizon = size(sG,1)+1;
shocks = zeros(M_base.exo_nbr, horizon);

T = 3; E = 1 + T;

%shocks(2,2:E) = sG(1:T); % government spending shock
%shocks(3,2:E) = si(1:T);  % interest rate shock
%shocks(4,2:E) = sPF(1:T); % foreign prices shock

shocks(2,2:horizon) = sG; % government spending shock
si_a = si;
si_a(4) = 0;
shocks(3,2:horizon) = si_a;  % interest rate shock
shocks(4,2:horizon) = sPF; % foreign prices shock


%% Simulation 2:government spending shock + interest rate shock

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

bar( t(2:length(t)), si )
