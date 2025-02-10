%% reading in data

Reference_Data = readtable("Reference_Data_difference.txt");

Reference_Data_Q = Reference_Data([1 14 27 40 54 67 80],:);


%%
y_q4_2019 = y_ss*13;
c_q4_2019 = c_ss*13;  %model implied consumption, not true data point
x_q4_2019 = x_ss*13;  %has to do relative to model values, as x,c in model and data do not coincide
n_q4_2019 = n_ss*13;  %y(1) is steady-state

%gap between years
%%%accounting procedure for "seasonality because of additional week: take
%%%the mean of the last 14 weeks and multiply it by 13, to still get the
%%%influence of the extra week but adjust for the seasonality 
%%%note that the OECD data already accounts for this extra week effect, as
%%%it is seasonally adjusted, which also includes calendar effects

y_aggregate = [y(1)*13 ; sum(y(2:14)); sum(y(15:27)); sum(y(28:40)); mean(y(41:54))*13; sum(y(55:67)); sum(y(68:80))]; %y1 is the ss value, so correct. 53 is actually the 52nd week. Be very careful with quarterly aggregation here
c_aggregate = [c(1)*13; sum(c(2:14)); sum(c(15:27)); sum(c(28:40)); mean(c(41:54))*13; sum(c(55:67)); sum(c(68:80))];   %compute weigthed average 
x_aggregate = [x(1)*13; sum(x(2:14)); sum(x(15:27)); sum(x(28:40)); mean(x(41:54))*13; sum(x(55:67)); sum(x(68:80))];
n_aggregate = [n(1)*13; sum(n(2:14)); sum(n(15:27)); sum(n(28:40)); mean(n(41:54))*13; sum(n(55:67)); sum(n(68:80))];

y_aggregate_relative = transpose([(y_aggregate(1)- y_q4_2019)/y_q4_2019  , (y_aggregate(2) - y_q4_2019)/y_q4_2019,   (y_aggregate(3) - y_q4_2019)/y_q4_2019,  (y_aggregate(4)-y_q4_2019)/y_q4_2019, (y_aggregate(5) - y_q4_2019)/y_q4_2019, (y_aggregate(6) - y_q4_2019)/y_q4_2019, (y_aggregate(7) - y_q4_2019)/y_q4_2019]);
c_aggregate_relative = transpose([(c_aggregate(1)- c_q4_2019)/c_q4_2019, (c_aggregate(2) - c_q4_2019)/c_q4_2019,  (c_aggregate(3) - c_q4_2019)/c_q4_2019,  (c_aggregate(4)-c_q4_2019)/c_q4_2019,  (c_aggregate(5) - c_q4_2019)/c_q4_2019,  (c_aggregate(6) - c_q4_2019)/c_q4_2019, (c_aggregate(7) - c_q4_2019)/c_q4_2019]);
x_aggregate_relative = transpose([(x_aggregate(1)- x_q4_2019)/x_q4_2019,  (x_aggregate(2) - x_q4_2019)/x_q4_2019,  (x_aggregate(3) - x_q4_2019)/x_q4_2019, (x_aggregate(4)-x_q4_2019)/x_q4_2019,  (x_aggregate(5) - x_q4_2019)/x_q4_2019,  (x_aggregate(6) - x_q4_2019)/x_q4_2019, (x_aggregate(7) - x_q4_2019)/x_q4_2019]);
n_aggregate_relative = transpose([(n_aggregate(1)- n_q4_2019)/n_q4_2019,  (n_aggregate(2) - n_q4_2019)/n_q4_2019,   (n_aggregate(3) - n_q4_2019)/n_q4_2019, (n_aggregate(4)-n_q4_2019)/n_q4_2019,  (n_aggregate(5) - n_q4_2019)/n_q4_2019,  (n_aggregate(6) - n_q4_2019)/n_q4_2019, (n_aggregate(7) - n_q4_2019)/n_q4_2019]);


%%

fsize=10;
horz=6;

time=0:1:horz;

pl1 = 2;
pl2 = 2;



tiledlayout(2,2)


nexttile
plot(time,zeros(time(end)+1,1),'m:','LineWidth',1.5);hold on
plot(time, 100*Reference_Data_Q.Y, 'Color',	'#0072BD');
plot(time, 100*y_aggregate_relative, 'Color','#D95319');hold off
box off;
%legend("Quarterly Growth Data ", "Quarterly Growth Model", Location='southeast', FontSize = 8)
xticks([0 1 2 3 4 5 6]);
title('GDP, Y','FontSize',fsize);
ylabel("% deviations from Q4:2019",'FontSize',fsize);
set(gca,'FontSize',fsize);


nexttile
plot(time,zeros(time(end)+1,1),'m:','LineWidth',1.5);hold on
plot(time,100*Reference_Data_Q.C ,'Color',	'#0072BD');
plot(time,100*c_aggregate_relative, 'Color','#D95319');hold off
box off;
%legend("Quarterly Growth Data ", "Quarterly Growth Model", Location='southeast', FontSize = 8)
xticks([0 1 2 3 4 5 6]);
title('Consumption, C','FontSize',fsize);
ylabel("% deviations from Q4:2019",'FontSize',fsize);
set(gca,'FontSize',fsize);

nexttile
plot(time,zeros(time(end)+1,1),'m:','LineWidth',1.5);hold on
plot(time,100*Reference_Data_Q.I, 'Color',	'#0072BD');
plot(time,100*x_aggregate_relative, 'Color','#D95319');hold off
box off;
%legend("Quarterly Growth Model", "Quarterly Growth Data ", "Quarterly Growth Model", Location='southeast', FontSize = 8)
xticks([0 1 2 3 4 5 6]);
title('Investment, X','FontSize',fsize);
xlabel('Quarters from Q4:2019','FontSize',fsize);
ylabel("% deviations from Q4:2019",'FontSize',fsize);
set(gca,'FontSize',fsize);


nexttile
plot(time,zeros(time(end)+1,1),'m:','LineWidth',1.5);hold on
plot(time, 100*Reference_Data_Q.H, 'Color',	'#0072BD');
plot(time,100*n_aggregate_relative, 'Color','#D95319');hold off
box off;
%legend("Quarterly Growth Data ", "Quarterly Growth Model", Location='southeast', FontSize = 8)
xticks([0 1 2 3 4 5 6]);
title('Hours, N','FontSize',fsize);
xlabel('Quarters from Q4:2019','FontSize',fsize);
ylabel("% deviations from Q4:2019",'FontSize',fsize);
set(gca,'FontSize',fsize);



lgd = legend("","Data", "Model");
lgd.Layout.Tile = 'east';


%suptitle('Figure 3: Model implied values vs observed data');
%%orient landscape
%print -dpdf -fillpage fig1



