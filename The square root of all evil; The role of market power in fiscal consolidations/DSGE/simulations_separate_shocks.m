%% shocks

t = 2010.75:0.25:2013.75;

figure('Position', get(0, 'Screensize'))
subplot(1,3,1)
bar( t, sG ); hold on;    % Simulation 2s (government spending shock + interest rate shock)
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal', 'NumColumns',2)
title('Government spending shock');

subplot(1,3,2)
bar( t, si ); hold on;    % Simulation 2s (government spending shock + interest rate shock)
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal', 'NumColumns',2)
title('Interest rate shock'); hold off;

subplot(1,3,3)
bar( t, sPF ); hold on;    % Simulation 2s (government spending shock + interest rate shock)
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal', 'NumColumns',2)
title('Foreing prices shock'); hold off;


%% Simulation 1: government spending shock

horizon = size(sG,1)+1;

shocks = zeros(M_base.exo_nbr, horizon);

shocks(2,2:horizon) = sG; % government spending shock

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end

musim2 = oo_base.steady_state( find( endogenous == "mu") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "mu") ),:);
musim2 = musim2 / musim2(1) * 100;

ysim2 = oo_base.steady_state( find( endogenous == "Y") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim2 = ysim2 / ysim2(1) * 100;

%Graph

t = 2010.5:0.25:2013.75;

figure('Position', get(0, 'Screensize'))
subplot(1,2,1)
plot( t, musim2, 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;    % Simulation 2s (government spending shock + interest rate shock)
plot( t, mu,     'k-', 'Linewidth',3.5,'DisplayName','Data')                       % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal', 'NumColumns',2)
title('Markup'); hold off;

subplot(1,2,2)
plot( t, ysim2, 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;     % Simulation 2s (government spending shock + interest rate shock)
plot( t, y,     'k-', 'Linewidth',3.5,'DisplayName','Data')                        % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southwest','Orientation','horizontal', 'NumColumns',2)
title('Output'); hold off;
exportgraphics(gcf,'myplot.jpg','Resolution',300)
%saveas(gcf, 'output and markup', 'jpg')
%% Simulation 2: interest rate shock

horizon = size(sG,1)+1;

shocks = zeros(M_base.exo_nbr, horizon);

shocks(3,2:horizon) = si;  % interest rate shock

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);

for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end


musim2 = oo_base.steady_state( find( endogenous == "mu") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "mu") ),:);
musim2 = musim2 / musim2(1) * 100;

ysim2 = oo_base.steady_state( find( endogenous == "Y") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim2 = ysim2 / ysim2(1) * 100;

%Graph

t = 2010.5:0.25:2013.75;

figure('Position', get(0, 'Screensize'))
subplot(1,2,1)
plot( t, musim2, 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;    % Simulation 2s (government spending shock + interest rate shock)
plot( t, mu,     'k-', 'Linewidth',3.5,'DisplayName','Data')                       % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal', 'NumColumns',2)
title('Markup'); hold off;

subplot(1,2,2)
plot( t, ysim2, 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;     % Simulation 2s (government spending shock + interest rate shock)
plot( t, y,     'k-', 'Linewidth',3.5,'DisplayName','Data')                        % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southwest','Orientation','horizontal', 'NumColumns',2)
title('Output'); hold off;
exportgraphics(gcf,'myplot.jpg','Resolution',300)
%saveas(gcf, 'output and markup', 'jpg')

%% Simulation 3: foreign prices shock

horizon = size(sPF,1)+1;

shocks(4,2:horizon) = sPF;               % foreign prices shock

Ssim = zeros( size(state,1), horizon);
Xsim = zeros( size(control,1), horizon);


for j = 2:horizon
    
    Ssim(:,j) = A * Ssim(:,j-1) + B * shocks(:,j);
    Xsim(:,j) = C * Ssim(:,j-1) + D * shocks(:,j);
    
end


musim2 = oo_base.steady_state( find( endogenous == "mu") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "mu") ),:);
musim2 = musim2 / musim2(1) * 100;

ysim2 = oo_base.steady_state( find( endogenous == "Y") ) + Xsim( oo_base.dr.inv_order_var( find( endogenous == "Y") ),:);
ysim2 = ysim2 / ysim2(1) * 100;

%Graph

t = 2010.5:0.25:2013.75;

figure('Position', get(0, 'Screensize'))
subplot(1,2,1)
plot( t, musim2, 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;    % Simulation 2s (government spending shock + interest rate shock)
plot( t, mu,     'k-', 'Linewidth',3.5,'DisplayName','Data')                       % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southeast','Orientation','horizontal', 'NumColumns',2)
title('Markup'); hold off;

subplot(1,2,2)
plot( t, ysim2, 'r--','Linewidth',2,'DisplayName','Simulation 2s'); hold on;     % Simulation 2s (government spending shock + interest rate shock)
plot( t, y,     'k-', 'Linewidth',3.5,'DisplayName','Data')                        % Data
xlim([min( t ) max( t )])
axis("square")
legend( 'Location','southwest','Orientation','horizontal', 'NumColumns',2)
title('Output'); hold off;
exportgraphics(gcf,'myplot.jpg','Resolution',300)
%saveas(gcf, 'output and markup', 'jpg')