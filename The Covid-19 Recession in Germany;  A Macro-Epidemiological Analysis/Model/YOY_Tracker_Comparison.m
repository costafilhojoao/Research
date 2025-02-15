%% reading in data

YOY_Tracker_point = xlsread("Weekly_Tracker_Excel.xlsx", "Germany", "H88:H166"); %"H97:H175"
YOY_Tracker_lower = xlsread("Weekly_Tracker_Excel.xlsx", "Germany", "I88:I166"); %"I97:I175"
YOY_Tracker_upper = xlsread("Weekly_Tracker_Excel.xlsx", "Germany", "J88:J166"); %"J97:J175"


%tracker STARTS at the deviation in the first week of 2020
%have to run it from the first observation to the 26th week of 2021 , which
%79 weeks in total as 2020 has 53 weeks
%have to start model comparison at first deviation (index (2)) therefore
%% plot comparison between data and model implied gdp growth
horz=79;        %first 53 weeks of 2020, and first 26 of 2021
                
time=1:1:horz;


figure;
hold on

time = time(:);
YOY_Tracker_lower = YOY_Tracker_lower(:);
YOY_Tracker_upper = YOY_Tracker_upper(:);

% Fill the area between YOY_Tracker_lower and YOY_Tracker_upper
fill([time; flipud(time)], [YOY_Tracker_lower; flipud(YOY_Tracker_upper)], ...
    [0.8 0.8 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.3);

plot(time,100*(y(2:horz+1)-y_ss)/y_ss,'b-','LineWidth',1.5);
plot(time,zeros(horz,1),'--','LineWidth',1.5, 'Color','black', 'HandleVisibility', 'off');
plot(time, YOY_Tracker_point,'LineWidth',1.5, 'Color','red');
hold off
legend("95% CI","Model", "Tracker Mean")
xlabel("Weeks from W1:2020")
ylabel("% deviations from pre-Covid trend")



