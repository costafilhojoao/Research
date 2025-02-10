%% reading in data

Reference_Data = readtable("Reference_Data_difference.txt");

%% Plot Infections and Deaths from Model vs the data

fsize=10;
horz=79;

time=0:1:horz;


figure;

subplot(2,1,1)
plot(time, 100*tau(1:horz +1), '--ob','LineWidth',0.5, 'Markersize', 2,'Color','#D95319');hold on  
plot(time, 100*Reference_Data.Cases, '--or' ,'LineWidth',0.5, 'Markersize', 2, 'Color',	'#0072BD');
plot(time, 1.8*100*Reference_Data.Cases, '--or' ,'LineWidth',0.5, 'Markersize', 2, 'Color',	'green');hold off
box off;
legend("Weekly Model", "Weekly Data", 'Location','northwest')
title("New Infections", 'FontSize',fsize);
xlabel("Weeks from W1:2020");
ylabel('% of initial population');
set(gca,'FontSize',fsize);


subplot(2,1,2)
plot(time, 100*dd(1:horz + 1),'--ob','LineWidth',0.5, 'Markersize', 2,'Color','#D95319');hold on
plot(time, 100*Reference_Data.Deaths, '--or' ,'LineWidth',0.5, 'Markersize', 2,'Color',	'#0072BD');hold off
box off;
legend("Weekly Model", "Weekly Data", 'Location','northwest')
title('Deaths','FontSize',fsize);
xlabel("Weeks from W1:2020")
ylabel('% of initial population');
set(gca,'FontSize',fsize);




