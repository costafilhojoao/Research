%%BCA

%Data from BCKM
%workspace_MEX.mat -> worktemp -> w

t     = xlsread('BCA graphs and tables','Plan1',['A','2',':','A','97']);   %quarters
ypc   = xlsread('BCA graphs and tables','Plan1',['B','2',':','B','97']);   %per capita output
xpc   = xlsread('BCA graphs and tables','Plan1',['C','2',':','C','97']);   %per capita investment
hpc   = xlsread('BCA graphs and tables','Plan1',['D','2',':','D','97']);   %per capita hours of work
gpc   = xlsread('BCA graphs and tables','Plan1',['E','2',':','E','97']);  %per capita gov spending + net exports
Y     = xlsread('BCA graphs and tables','Plan1',['F','2',':','F','97']);   %output level
X     = xlsread('BCA graphs and tables','Plan1',['G','2',':','G','97']);   %investment level
H     = xlsread('BCA graphs and tables','Plan1',['H','2',':','H','97']);   %hours of work level
G     = xlsread('BCA graphs and tables','Plan1',['I','2',':','I','97']);   %gov spending + net exports level
mzy   = xlsread('BCA graphs and tables','Plan1',['J','2',':','J','97']);   %simulated output with only the efficiency wedge
%mzh   = xlsread('BCA graphs and tables','Plan1',['K','2',':','K','97']);  %simulated hours of work with only the efficiency wedge
%mzx   = xlsread('BCA graphs and tables','Plan1',['L','2',':','L','97']);  %simulated investment with only the efficiency wedge
mly   = xlsread('BCA graphs and tables','Plan1',['M','2',':','M','97']);   %simulated output with only the labor wedge
%mlh   = xlsread('BCA graphs and tables','Plan1',['N','2',':','N','97']);  %simulated hours of work with only the labor wedge
%mlx   = xlsread('BCA graphs and tables','Plan1',['O','2',':','O','97']);  %simulated investment with only the labor wedge
mxy   = xlsread('BCA graphs and tables','Plan1',['P','2',':','P','97']);   %simulated output with only the investment wedge
%mxh   = xlsread('BCA graphs and tables','Plan1',['Q','2',':','Q','97']);  %simulated hours of work with only the investment wedge
%mxx   = xlsread('BCA graphs and tables','Plan1',['R','2',':','R','97']);  %simulated investment with only the investment wedge
mgy   = xlsread('BCA graphs and tables','Plan1',['S','2',':','S','97']);   %simulated output with only the gov cons wedge
%mgh   = xlsread('BCA graphs and tables','Plan1',['T','2',':','T','97']);  %simulated hours of work with only the gov cons wedge
%mgx   = xlsread('BCA graphs and tables','Plan1',['U','2',':','U','97']);  %simulated %investment with only the gov cons wedge wedge
mnozy = xlsread('BCA graphs and tables','Plan1',['V','2',':','V','97']);   %simulated output without the efficiency wedge
%mnozh = xlsread('BCA graphs and tables','Plan1',['W','2',':','W','97']);  %simulated hours of work without the efficiency wedge
%mnozx = xlsread('BCA graphs and tables','Plan1',['X','2',':','X','97']);  %simulated investment without the efficiency wedge
mnoly = xlsread('BCA graphs and tables','Plan1',['Y','2',':','Y','97']);   %simulated output without the labor wedge
%mnolh = xlsread('BCA graphs and tables','Plan1',['Z','2',':','Z','97']);  %simulated hours of work without the labor wedge
%mnolx = xlsread('BCA graphs and tables','Plan1',['AA','2',':','AA','97']);%simulated investment without the labor wedge
mnoxy = xlsread('BCA graphs and tables','Plan1',['AB','2',':','AB','97']); %simulated output without the investment wedge
%mnoxh = xlsread('BCA graphs and tables','Plan1',['AC','2',':','AC','97']);%simulated hours of work without the investment wedge
%mnoxx = xlsread('BCA graphs and tables','Plan1',['AD','2',':','AD','97']);%simulated investment without the investment wedge
mnogy = xlsread('BCA graphs and tables','Plan1',['S','2',':','S','97']);   %simulated output without the gov cons wedge wedge
%mnogh = xlsread('BCA graphs and tables','Plan1',['T','2',':','T','97']);  %simulated hours of work without the gov cons wedge 
%mnogx = xlsread('BCA graphs and tables','Plan1',['U','2',':','U','97']);  %simulated investment without the gov cons wedge
yt = xlsread('BCA graphs and tables','Plan1',['AH','2',':','AH','97']);    %normalized output
%ht = xlsread('BCA graphs and tables','Plan1',['AI','2',':','AI','97']);   %normalized hours of work
xt = xlsread('BCA graphs and tables','Plan1',['AJ','2',':','AJ','97']);    %normalized investment
gt = xlsread('BCA graphs and tables','Plan1',['AK','2',':','AK','97']);    %normalized gov consumption + next exports
wa = xlsread('BCA graphs and tables','Plan1',['AL','2',':','AL','97']);    %efficiency wedge
wl = xlsread('BCA graphs and tables','Plan1',['AM','2',':','AM','97']);    %labor wedge
wx = xlsread('BCA graphs and tables','Plan1',['AN','2',':','AN','97']);    %investment wedge
wg = xlsread('BCA graphs and tables','Plan1',['AO','2',':','AO','97']);    %gov consumption wedge
yt100=yt*100.;

%% BCA exercises

%Only one graph - (black and white version)

%1995 crisis

base1 = 16; %determines the row element to use as base year (1 for the 1995 crisis and 2 for the 2008 crisis)

%turn variables from their base years to 1Q1994
ypc95 = (ypc./ypc(base1))*100; %output
hpc95 = (hpc./hpc(base1))*100;%hours
xpc95 = (xpc./xpc(base1))*100;%investment
gpc95 = (gpc./gpc(base1))*100;%gov+net exports

handle=plot(t(base1:32), ypc95(base1:32),'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output
set(handle,'LineWidth',[5])
plot(t(base1:32), hpc95(base1:32),'k:', 'LineWidth',2,'DisplayName','\omega_A');hold on; %hours
plot(t(base1:32), xpc95(base1:32),'k--', 'LineWidth',2,'DisplayName','\omega_l');hold on; %investment
plot(t(base1:32), gpc95(base1:32),'k-.', 'LineWidth',2,'DisplayName','\omega_l');hold on; %gov+net exports
xlim([min(t(base1:32)) max(t(base1:32))])
%XLABEL('One wedge economies')
legend('Output','Hours', 'Investment', 'Government', 'Location', 'NorthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure1', 'jpg')
hold off;

%2008 crisis
base2 = 71; %determines the row element to use as base year (1 for the 1995 crisis and 2 for the 2008 crisis)

%turn variables from their base years to 1Q2007

ypc08 = (ypc./ypc(base2))*100; %output
hpc08 = (hpc./hpc(base2))*100;%hours
xpc08 = (xpc./xpc(base2))*100;%investment
gpc08 = (gpc./gpc(base2))*100;%gov+net exports

handle=plot(t(base2:96), ypc08(base2:96),'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output
set(handle,'LineWidth',[5])
plot(t(base2:96), hpc08(base2:96),'k:', 'LineWidth',2,'DisplayName','\omega_A');hold on; %hours
plot(t(base2:96), xpc08(base2:96),'k--', 'LineWidth',2,'DisplayName','\omega_l');hold on; %investment
plot(t(base2:96), gpc08(base2:96),'k-.', 'LineWidth',2,'DisplayName','\omega_l');hold on; %gov+net exports
xlim([min(t(base2:96)) max(t(base2:96))])
%XLABEL('One wedge economies')
legend('Output','Hours', 'Investment', 'Government', 'Location', 'NorthWest')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure2', 'jpg')
hold off;

%Output
%subplot(1,2,1)
%plot(t,Y);figure(gcf)
%xlim([min(t) max(t)])
%subplot(1,2,2)
%plot(t,ypc);figure(gcf)
%xlim([min(t) max(t)])
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure1', 'jpg')

%Hours
%subplot(1,2,1)
%plot(t,H);figure(gcf)
%xlim([min(t) max(t)])
%subplot(1,2,2)
%plot(t,hpc);figure(gcf)
%xlim([min(t) max(t)])
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure2', 'jpg')

%Investment
%subplot(1,2,1)
%plot(t,X);figure(gcf)
%xlim([min(t) max(t)])
%subplot(1,2,2)
%plot(t,xpc);figure(gcf)
%xlim([min(t) max(t)])
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure3', 'jpg')

%government consumption + net exports
%subplot(1,2,1)
%plot(t,G);figure(gcf)
%xlim([min(t) max(t)])
%subplot(1,2,2)
%plot(t, gpc);figure(gcf)
%xlim([min(t) max(t)])
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure4', 'jpg')

%% Wedges

subplot(2,2,1)
plot(t, wa,'k-','Linewidth',2.5);figure(gcf)
xlim([min(t) max(t)])
xlabel('Efficiency')
subplot(2,2,2)
plot(t, wl,'k-','Linewidth',2.5);figure(gcf)
xlim([min(t) max(t)])
xlabel('Labor')
subplot(2,2,3)
plot(t, wx,'k-','Linewidth',2.5);figure(gcf)
xlim([min(t) max(t)])
xlabel('Investment')
subplot(2,2,4)
plot(t, wg,'k-','Linewidth',2.5);figure(gcf)
xlim([min(t) max(t)])
xlabel('Government Consumption')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure5', 'jpg')

%% Simulation

%1995 crisis

y95 = (yt100./yt100(base1))*100; %output
mzy95 = (mzy./mzy(base1))*100;%efficiency wedge
mly95 = (mly./mly(base1))*100;%labor wedge
mxy95 = (mxy./mxy(base1))*100;%investment wedge
mgy95 = (mgy./mgy(base1))*100;%gov cons wedge
mnozy95 = (mnozy./mnozy(base1))*100;%efficiency wedge
mnoly95 = (mnoly./mnoly(base1))*100;%labor wedge
mnoxy95 = (mnoxy./mnoxy(base1))*100;%investment wedge
mnogy95 = (mnogy./mnogy(base1))*100;%gov cons wedge

%One wedge economies 
handle=plot(t(base1:32), y95(base1:32), 'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
set(handle,'LineWidth',[5])
plot(t(base1:32), mzy95(base1:32),'k:', 'LineWidth',2,'DisplayName','\omega_A');hold on;    %efficiency wedge
plot(t(base1:32), mly95(base1:32),'k--', 'LineWidth',2,'DisplayName','\omega_l');hold on;    %labor wedge
XLABEL('One wedge economies')
legend('Data','Efficiency', 'Labor', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure4', 'jpg')
hold off;
handle=plot(t(base1:32), y95(base1:32), 'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
set(handle,'LineWidth',[5])
plot(t(base1:32), mxy95(base1:32),'k-.', 'LineWidth',2,'DisplayName','\omega_x');hold on;    %investment wedge
plot(t(base1:32), mgy95(base1:32),'k.', 'LineWidth',2,'DisplayName','\omega_g');hold on;    %gov cons wedge
xlim([min(t(base1:32)) max(t(base1:32))])
%ylim([85 115])
xlabel('One wedge economies')
legend('Data','Investment', 'Government', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure5', 'jpg')
hold off;

%One wedge off economies
handle=plot(t(base1:32), y95(base1:32), 'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
set(handle,'LineWidth',[5])
plot(t(base1:32), mnozy95(base1:32),'k:', 'LineWidth',2,'DisplayName','\omega_A');hold on;    %efficiency wedge
plot(t(base1:32), mnoly95(base1:32),'k--', 'LineWidth',2,'DisplayName','\omega_l');hold on;    %labor wedge
xlim([min(t(base1:32)) max(t(base1:32))])
XLABEL('One wedge off economies')
legend('Data','No Efficiency', 'No Labor', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure6', 'jpg')
hold off;
handle=plot(t(base1:32), y95(base1:32), 'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
set(handle,'LineWidth',[5])
plot(t(base1:32), mnoxy95(base1:32),'k-.', 'LineWidth',2,'DisplayName','\omega_x');hold on;    %investment wedge
plot(t(base1:32), mnogy95(base1:32),'k.', 'LineWidth',2,'DisplayName','\omega_g');hold on;    %gov cons wedge
xlim([min(t(base1:32)) max(t(base1:32))])
%ylim([85 115])
xlabel('One wedge off economies')
legend('Data','No Investment', 'No Government', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure7', 'jpg')
hold off;

%2008 crisis

y08 = (yt100./yt100(base2))*100; %output
mzy08 = (mzy./mzy(base2))*100;%efficiency wedge
mly08 = (mly./mly(base2))*100;%labor wedge
mxy08 = (mxy./mxy(base2))*100;%investment wedge
mgy08 = (mgy./mgy(base2))*100;%gov cons wedge
mnozy08 = (mnozy./mnozy(base2))*100;%efficiency wedge
mnoly08 = (mnoly./mnoly(base2))*100;%labor wedge
mnoxy08 = (mnoxy./mnoxy(base2))*100;%investment wedge
mnogy08 = (mnogy./mnogy(base2))*100;%gov cons wedge

%One wedge economies 
handle=plot(t(base2:96), y08(base2:96), 'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
set(handle,'LineWidth',[5])
plot(t(base2:96), mzy08(base2:96),'k:', 'LineWidth',2,'DisplayName','\omega_A');hold on;    %efficiency wedge
plot(t(base2:96), mly08(base2:96),'k--', 'LineWidth',2,'DisplayName','\omega_l');hold on;    %labor wedge
xlim([min(t(base2:96)) max(t(base2:96))])
XLABEL('One wedge economies')
legend('Data','Efficiency', 'Labor', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure8', 'jpg')
hold off;
handle=plot(t(base2:96), y08(base2:96), 'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
set(handle,'LineWidth',[5])
plot(t(base2:96), mxy08(base2:96),'k-.', 'LineWidth',2,'DisplayName','\omega_x');hold on;    %investment wedge
plot(t(base2:96), mgy08(base2:96),'k.', 'LineWidth',2,'DisplayName','\omega_g');hold on;    %gov cons wedge
xlim([min(t(base2:96)) max(t(base2:96))])
%ylim([85 115])
xlabel('One wedge economies')
legend('Data','Investment', 'Government', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure9', 'jpg')
hold off;

%One wedge off economies
handle=plot(t(base2:96), y08(base2:96), 'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
set(handle,'LineWidth',[5])
plot(t(base2:96), mnozy08(base2:96),'k:', 'LineWidth',2,'DisplayName','\omega_A');hold on;    %efficiency wedge
plot(t(base2:96), mnoly08(base2:96),'k--', 'LineWidth',2,'DisplayName','\omega_l');hold on;    %labor wedge
xlim([min(t(base2:96)) max(t(base2:96))])
XLABEL('One wedge off economies')
legend('Data','No Efficiency', 'No Labor', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure10', 'jpg')
hold off;
handle=plot(t(base2:96), y08(base2:96), 'k-', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
set(handle,'LineWidth',[5])
plot(t(base2:96), mnoxy08(base2:96),'k-.', 'LineWidth',2,'DisplayName','\omega_x');hold on;    %investment wedge
plot(t(base2:96), mnogy08(base2:96),'k.', 'LineWidth',2,'DisplayName','\omega_g');hold on;    %gov cons wedge
xlim([min(t(base2:96)) max(t(base2:96))])
%ylim([85 115])
xlabel('One wedge off economies')
legend('Data','No Investment', 'No Government', 'Location', 'SouthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure11', 'jpg')
hold off;


%% REER and Intermediate goods

reer     = xlsread('reer BIS','Real',['AM','6',':','AM','275']);         %Real Effective Exchange Rate
n        = length(reer);
t1       = (1:n);                                                        %Number of months;
t2       = xlsread('intermediate goods','Plan1',['A','8',':','A','31']); %years
mexint   = xlsread('intermediate goods','Plan1',['B','7',':','B','31']); %Intermediate goods imports (USD thousands) for Mexico
mexshare = xlsread('intermediate goods','Plan1',['F','8',':','F','31']); %Intermediate goods imports (%GDP) for Mexico
usashare = xlsread('intermediate goods','Plan1',['G','8',':','G','31']); %Intermediate goods imports (%GDP) for USA

%Intermediate goods imports (%GDP) 
plot(t2, mexshare*100, 'k-', 'Linewidth',3); figure(gcf); hold on;  %output data
plot(t2, usashare*100,'k--', 'LineWidth',3);
legend('Mexican share','US share', 'Location', 'NorthWest')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure14', 'jpg')
hold off;

%plot(t2, mexint, 'k');figure(gcf)
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure8', 'jpg')

%plot(t1, reer, 'k');figure(gcf)
%dateaxis('x', 12, 'Jan94')
%saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure7', 'jpg')


%%

t4  = xlsread('data','Plan1',['A','13',':','A','97']);   %quarters
de  = xlsread('data','Plan1',['F','13',':','F','97']);   %observed real exchange rate shocks
%dy  = xlsread('data','Plan1',['E','13',':','E','97']);   %observed HP filtered per capita output cycle
dy2 = xlsread('data','Plan1',['G','13',':','G','97']);   %observed Log linear filtered per capita output cycle
 
plot(t4, de, 'k-.', 'Linewidth',2.5); figure(gcf); hold on;
plot(t4, dy2, 'k-', 'Linewidth',3); 
xlim([min(t4) max(t4)])
legend('Exchange rate','Output', 'Location', 'NorthEast')
saveas(gcf, 'F:\Google Drive\Documents\FEP\Thesis\2. México\figure18', 'jpg')

