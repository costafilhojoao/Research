%% Data - Raw and detrended

%%% IMPORTANT!!!!!! First, open the Workspace; then, thw worktemp.
%%% (Path: Desktop > Workspace > Worktemp
%%% Then, run this script!
load worktemp.mat;
l=220;

%Output
SUBPLOT(1,2,1)
plot(t,worktemp.mled(1:l,2),'DisplayName','worktemp.mled(1:l,2)','YDataSource','worktemp.mled(1:l,2)');figure(gcf)
axis([min(t) max(t) min(worktemp.mled(1:l,2))*0.97 inf])
SUBPLOT(1,2,2)
plot(t,worktemp.lnY(1:l,1),'DisplayName','worktemp.lnY(1:l,1)','YDataSource','worktemp.lnY(1:l,1)');figure(gcf)
axis([min(t) max(t) min(worktemp.lnY(1:l,1))*1.03 inf])
saveas(gcf, 'H:\Google Drive\Documents\FEP\Thesis\1. Survey - Business Cycles Accounting\figure1', 'jpg')

%Hours
SUBPLOT(1,2,1)
plot(t,worktemp.mled(1:l,3),'DisplayName','worktemp.mled(1:l,3)','YDataSource','worktemp.mled(1:l,3)');figure(gcf)
axis([min(t) max(t) min(worktemp.mled(1:l,3))*0.97 inf])
SUBPLOT(1,2,2)
plot(t,worktemp.lnY(1:l,2),'DisplayName','worktemp.lnY(1:l,2)','YDataSource','worktemp.lnY(1:l,2)');figure(gcf)
axis([min(t) max(t) min(worktemp.lnY(1:l,2))*01.03 inf])
saveas(gcf, 'H:\Google Drive\Documents\FEP\Thesis\1. Survey - Business Cycles Accounting\figure2', 'jpg')

%Investment
SUBPLOT(1,2,1)
plot(t,worktemp.mled(1:l,4),'DisplayName','worktemp.mled(1:l,4)','YDataSource','worktemp.mled(1:l,4)');figure(gcf)
axis([min(t) max(t) min(worktemp.mled(1:l,4))*0.97 inf])
SUBPLOT(1,2,2)
plot(t,worktemp.lnY(1:l,3),'DisplayName','worktemp.lnY(1:l,3)','YDataSource','worktemp.lnY(1:l,3)');figure(gcf)
axis([min(t) max(t) min(worktemp.lnY(1:l,3))*01.03 inf])
saveas(gcf, 'H:\Google Drive\Documents\FEP\Thesis\1. Survey - Business Cycles Accounting\figure3', 'jpg')

%government consumption + net exports
SUBPLOT(1,2,1)
plot(t,worktemp.mled(1:l,5),'DisplayName','worktemp.mled(1:l,5)','YDataSource','worktemp.mled(1:l,5)');figure(gcf)
axis([min(t) max(t) min(worktemp.mled(1:l,5))*0.97 inf])
SUBPLOT(1,2,2)
plot(t, worktemp.lnY(1:l,4),'DisplayName','worktemp.lnY(1:l,4)','YDataSource','worktemp.lnY(1:l,4)');figure(gcf)
axis([min(t) max(t) min(worktemp.lnY(1:l,4))*01.03 inf])
saveas(gcf, 'H:\Google Drive\Documents\FEP\Thesis\1. Survey - Business Cycles Accounting\figure4', 'jpg')

%% Wedges

SUBPLOT(2,2,1)
plot(t, worktemp.hpw(1:l,1),'DisplayName','worktemp.hpw(1:l,1)','YDataSource','worktemp.hpw(1:l,1)');figure(gcf)
axis([min(t) max(t) -0.2 0.2])
XLABEL('Efficiency')
SUBPLOT(2,2,2)
plot(t, worktemp.hpw(1:l,2),'DisplayName','worktemp.hpw(1:l,2)','YDataSource','worktemp.hpw(1:l,2)');figure(gcf)
axis([min(t) max(t) -0.2 0.2])
XLABEL('Labor')
SUBPLOT(2,2,3)
plot(t, worktemp.hpw(1:l,3),'DisplayName','worktemp.hpw(1:l,3)','YDataSource','worktemp.hpw(1:l,3)');figure(gcf)
axis([min(t) max(t) -0.2 0.2])
XLABEL('Investment')
SUBPLOT(2,2,4)
plot(t, worktemp.hpw(1:l,1),'DisplayName','worktemp.hpw(1:l,4)','YDataSource','worktemp.hpw(1:l,4)');figure(gcf)
axis([min(t) max(t) -0.2 0.2])
XLABEL('Government Consumption')
saveas(gcf, 'H:\Google Drive\Documents\FEP\Thesis\1. Survey - Business Cycles Accounting\figure5', 'jpg')

%% Simulation

%One wedge economies
SUBPLOT(2,1,1)
plot(t, worktemp.w.Y(1:l,2),'k', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
plot(t, worktemp.w.mzy,'r', 'LineWidth',2,'DisplayName','\omega_A');hold on; %efficiency wedge
plot(t, worktemp.w.mly,'g', 'LineWidth',2,'DisplayName','\omega_l');hold on; %labor wedge
plot(t, worktemp.w.mxy,'b', 'LineWidth',2,'DisplayName','\omega_x');hold on; %investment wedge
plot(t, worktemp.w.mgy,'m', 'LineWidth',2,'DisplayName','\omega_g');hold on; %gov cons wedge
xlim([min(t) max(t)])
XLABEL('One wedge economies')

%One wedge off economies
SUBPLOT(2,1,2)
plot(t, worktemp.w.Y(1:l,2),'k', 'Linewidth',2,'DisplayName','Output'); hold on;  %output data
plot(t, worktemp.w.mnozy,'r', 'LineWidth',2,'DisplayName','\omega_A');hold on; %efficiency wedge off
plot(t, worktemp.w.mnoly,'g', 'LineWidth',2,'DisplayName','\omega_l');hold on; %labor wedge off
plot(t, worktemp.w.mnoxy,'b', 'LineWidth',2,'DisplayName','\omega_x');hold on; %investment wedge off
plot(t, worktemp.w.mnogy,'m', 'LineWidth',2,'DisplayName','\omega_g');hold on; %gov cons wedge off
XLABEL('One wedge off economies')
xlim([min(t) max(t)])
ylim([75 120])
saveas(gcf, 'H:\Google Drive\Documents\FEP\Thesis\1. Survey - Business Cycles Accounting\figure6', 'jpg')






