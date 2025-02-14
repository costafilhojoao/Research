%{

The Covid-19 Recession in Germany: A Macro-Epidemiological Analysis
Krause, Costa, and Costa-Filho (2025)

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

For Matlab R2021a.

%}

%% Run the model with both shocks. Then, store the value of output:

dynare solve;

ybase    = y;
ybase_ss = y_ss;

%% Run the model with only the consumption restrictions shock. Then, store the value of output:

% First, change the values of the shocks in the 'simulations.mod' file.

dynare solve;

ycons    = y;
ycons_ss = y_ss;

%% Run the model with only the labor restrictions shock. Then, store the value of output:

% First, change the values of the shocks in the 'simulations.mod' file.

dynare solve;

ylab    = y;
ylab_ss = y_ss;

%% Run the model with only the social restrictions shock. Then, store the value of output:

% First, change the values of the shocks in the 'simulations.mod' file.

dynare solve;

ysocial    = y;
ysocial_ss = y_ss;

%% The code for figure

horz=79;        %first 53 weeks of 2020, and first 26 of 2021
                
time=1:1:horz;

figure;
hold on

% Ensure column vectors for fill()
time = time(:);
YOY_Tracker_lower = YOY_Tracker_lower(:);
YOY_Tracker_upper = YOY_Tracker_upper(:);

% Fill the area between YOY_Tracker_lower and YOY_Tracker_upper
fill([time; flipud(time)], [YOY_Tracker_lower; flipud(YOY_Tracker_upper)], ...
    [0.8 0.8 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.3);

plot(time, 100*(ybase(2:horz+1)-ybase_ss)/ybase_ss, 'k-', 'LineWidth', 1.5);
plot(time, 100*(ycons(2:horz+1)-ycons_ss)/ycons_ss, 'b--', 'LineWidth', 1.5);
plot(time, 100*(ylab(2:horz+1)-ylab_ss)/ylab_ss, 'r-.', 'LineWidth', 1.5);
plot(time, 100*(ysocial(2:horz+1)-ysocial_ss)/ysocial_ss, 'm:', 'LineWidth', 1.5);
hold off
legend("95% CI Tracker", "Baseline", "Consumption only", "Labor only", "Social only", 'Location', 'best')
xlabel("Weeks from W1:2020")
ylabel("% deviations from pre-Covid trend")
