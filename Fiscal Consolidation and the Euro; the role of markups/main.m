clear;

%Dynamic pricing model

dynare model3;

%% Steady State

y = oo_.steady_state(13);
P = oo_.steady_state(3);
MC = oo_.steady_state(11);
mu = oo_.steady_state(16);
W = oo_.steady_state(5); 
C = oo_.steady_state(1);
H = oo_.steady_state(2);


%% Vector with the IRFs

irfs = nan(7,10,2);

%Productivity shock
irfs(1,:,1) = ( oo_.irfs.y_sA' ./ y ) * 100;
irfs(2,:,1) = oo_.irfs.P_sA';
irfs(3,:,1) = oo_.irfs.MC_sA';
irfs(4,:,1) = oo_.irfs.mu_sA';
irfs(5,:,1) = oo_.irfs.W_sA';
irfs(6,:,1) = oo_.irfs.C_sA';
irfs(7,:,1) = oo_.irfs.H_sA';

%Government Spending shock shock

irfs(1,:,2) = oo_.irfs.y_sG';
irfs(2,:,2) = oo_.irfs.P_sG';
irfs(3,:,2) = oo_.irfs.MC_sG';
irfs(4,:,2) = oo_.irfs.mu_sG';
irfs(5,:,2) = oo_.irfs.W_sG';
irfs(6,:,2) = oo_.irfs.C_sG';
irfs(7,:,2) = oo_.irfs.H_sG';

clearvars -except irfs;

%Graph parameters

T = 10;
X = 0:20;
Y = -1:2;
Z = 0:0;

figure

for i = 1:5 
  subplot(1,2,1)
   plot(1:T,irfs(1,:,1)) 
   axis([1,20, -1, 1.5], "square")
   title('Spending (1957-1979)')
   hold on
   plot(X,Z)
   
   hold on
   subplot(1,2,2)
   plot(1:T,irfs(1,:,2))
   axis([1,20, -1, 1.5], "square")
   title('Spending (1983-2004)')
   hold on
   plot(X,Z)
   
   end



%Endogenous markup

mu_level = oo_.endo_simul(16,1:9);
mu_ss    = oo_.steady_state(16);
dmu = diff( mu_level );
Y0  = ( log( oo_.endo_simul(17,1:9) ) - log( oo_.steady_state(17) ) ) * 100; % output log-deviations from steady state
mu0  = ( log( oo_.endo_simul(16,1:9) ) - log( oo_.steady_state(16) ) ) * 100; % output log-deviations from steady state
clearvars -except mu_level mu_ss dmu mu0 Y0;

mu = rdivide(dmu , mu_level(1:8) ) * 100;

clc;

mus = [   
0 
0.00287 
 0.00763 
 0.04427 
 0.03033 
-0.01156 
 0.01435 
 0.00904 
-0.00873 
 ];

mus = mus * 100;

% Observed data

y   = xlsread('data','Sheet1',['B','2',':','B','10']);   %observed Log-detrended output 
c   = xlsread('data','Sheet1',['C','2',':','C','15']);   %observed Log-detrended consumption 
g   = xlsread('data','Sheet1',['D','2',':','D','15']);   %observed Log-detrended government spending 



%% Figures

t = [2007:1:2014]'; %years

%Figure 1

plot( t, mus(2:9), 'k', t, mu0(2:9), 'b--');
xticks(2007:1:2014);
grid on
yyaxis right
ylim([-.9 -0.8])

plot( t, y(2:9)*100, 'k', t, Y0(2:9), 'b--');




%%%%%%%%%%%%%%%%%%%%%%%%










mu_data = mu; mu_model = mu0; y_data = y; y_model = Y0;

filename = 'dados.xls';
dados = [ mu_data mu_model' y_data y_model' ]; 
xlRange='A2';
sheet=1;
xlswrite(filename,dados,sheet,xlRange);
names = { "mu_data" "mu_model" "y_data" "y_model" };
xlRange='A1';
xlswrite(filename,names,sheet,xlRange);



