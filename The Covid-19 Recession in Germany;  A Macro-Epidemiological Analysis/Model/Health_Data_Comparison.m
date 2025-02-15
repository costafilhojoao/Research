%% reading in data

Reference_Data = readtable("Reference_Data_difference.txt");

%% Plot Infections and Deaths from Model vs the data

fsize = 10;
horz = 79;
time = 0:1:horz;

% Create tiled layout with 2 rows and 1 column
t = tiledlayout(2,1);
t.TileSpacing = 'compact'; % Reduce spacing between tiles
t.Padding = 'compact'; % Reduce padding around the figure

% First tile (New Infections)
nexttile
plot(time, 100*tau(1:horz +1), 'b-','LineWidth',1.5, 'Markersize', 2); hold on  
plot(time, 100*Reference_Data.Cases, 'r-' ,'LineWidth',1.5, 'Markersize', 2);
plot(time, 1.8*100*Reference_Data.Cases, '-' ,'LineWidth',1.0, 'Markersize', 2, 'Color','#A9A9A9'); hold off
box off;
%legend("Weekly Model", "Weekly Data", 'Location','northwest')
title("New Infections", 'FontSize', fsize);
set(gca, 'FontSize', fsize);

% Second tile (Deaths)
nexttile
plot(time, 100*dd(1:horz + 1),'b-','LineWidth',1.5, 'Markersize', 2); hold on
plot(time, 100*Reference_Data.Deaths, 'r-' ,'LineWidth',1.5, 'Markersize', 2); hold off
box off;
legend("Weekly Model", "Weekly Data", 'Location','northwest')
title('Deaths','FontSize', fsize);
set(gca, 'FontSize', fsize);

% Common labels
xlabel(t, "Weeks from W1:2020", 'FontSize', fsize);
ylabel(t, '% of initial population', 'FontSize', fsize);




