%{

The Covid-19 Recession in Germany: A Macro-Epidemiological Analysis
Krause, Costa, and Costa-Filho (2025)

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

For Matlab R2021a.

%}


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
plot(time, 100*Reference_Data.Cases, 'k-' ,'LineWidth',1.5, 'Markersize', 2);
plot(time, 1.8*100*Reference_Data.Cases, 'r-' ,'LineWidth',1.0, 'Markersize', 2 ); hold off
box off;
legend("Weekly Model", "Weekly Data", "Weekly Data x 1.8", 'Location','northwest')
title("New Infections", 'FontSize', fsize);
set(gca, 'FontSize', fsize);

% Second tile (Deaths)
nexttile
plot(time, 100*dd(1:horz + 1),'b-','LineWidth',1.5, 'Markersize', 2); hold on
plot(time, 100*Reference_Data.Deaths, 'k-' ,'LineWidth',1.5, 'Markersize', 2); hold off
box off;
%legend("Weekly Model", "Weekly Data", 'Location','northwest')
title('Deaths','FontSize', fsize);
set(gca, 'FontSize', fsize);

% Common labels
xlabel(t, "Weeks from W1:2020", 'FontSize', fsize);
ylabel(t, '% of initial population', 'FontSize', fsize);




