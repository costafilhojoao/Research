%% reading in data

YOY_Tracker_point = xlsread("Weekly_Tracker_Excel.xlsx", "Germany", "H88:H166"); %"H97:H175"
YOY_Tracker_lower = xlsread("Weekly_Tracker_Excel.xlsx", "Germany", "I88:I166"); %"I97:I175"
YOY_Tracker_upper = xlsread("Weekly_Tracker_Excel.xlsx", "Germany", "J88:J166"); %"J97:J175"


%tracker STARTS at the deviation in the first week of 2020 ! h
%have to run it from the first observation to the 26th week of 2021 , which
%79 weeks in total as 2020 has 53 weeks
%have to start model comparison at first deviation (index (2)) therefore
%% plot comparison between data and model implied gdp growth
horz=79;        %first 53 weeks of 2020, and first 26 of 2021
                
time=1:1:horz;


plot(time,100*(y(2:horz+1)-y_ss)/y_ss,'b-','LineWidth',1.5);hold on
plot(time,zeros(horz,1),'--','LineWidth',1.5, 'Color','black');
plot(time, YOY_Tracker_point,'LineWidth',1.5, 'Color','red');
plot(time,YOY_Tracker_lower,'m:', 'LineWidth',1.5);
plot(time,YOY_Tracker_upper,'m:', 'LineWidth',1.5); hold off
legend("Model", "", "Tracker Mean", "95% CI", "")
xlabel("Weeks from W1:2020")
ylabel("% deviations from pre-Covid trend")
%title("Model Implied vs Nowcasted weekly GDP Growth")



