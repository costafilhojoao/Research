clear;

%% Dynamic pricind with nominal rigidity model

dynare model6;

%% Steady State

C  = oo_.steady_state(1);
H  = oo_.steady_state(2);
W  = oo_.steady_state(5);
B  = oo_.steady_state(6);
Y  = oo_.steady_state(8);
PI = oo_.steady_state(9); 
MC = oo_.steady_state(11);
mu = oo_.steady_state(13);
e  = oo_.steady_state(14);
CD = oo_.steady_state(15);
CF = oo_.steady_state(16);
PD = oo_.steady_state(17);
PF = oo_.steady_state(18);
GD = oo_.steady_state(19);
GF = oo_.steady_state(20);
i  = oo_.steady_state(24);

%% Matrix with the IRFs

var    = 16;  % number of variables in the matrix
shocks = 2;  % number of shocks (two: sA and SG)
T      = 20; % number of simulated periods

irfs = zeros( var, T, shocks);

%Productivity shock
irfs(1,:,1) = ( oo_.irfs.C_sA' ./ C ) * 100;
irfs(2,:,1) = ( oo_.irfs.H_sA' ./ H ) * 100;
irfs(3,:,1) = ( oo_.irfs.W_sA' ./ W ) * 100 ;
irfs(4,:,1) = ( oo_.irfs.B_sA' ./ B ) * 100;
irfs(5,:,1) = ( oo_.irfs.Y_sA' ./ Y ) * 100;
irfs(6,:,1) = ( oo_.irfs.PI_sA' ./ PI ) * 100;
irfs(7,:,1) = ( oo_.irfs.MC_sA' ./ MC ) * 100;
irfs(8,:,1) = ( oo_.irfs.mu_sA' ./ mu ) * 100;
irfs(9,:,1) = ( oo_.irfs.e_sA' ./ e ) * 100;
irfs(10,:,1) = ( oo_.irfs.CD_sA' ./ CD ) * 100;
irfs(11,:,1) = ( oo_.irfs.CF_sA' ./ CF ) * 100;
irfs(12,:,1) = ( oo_.irfs.PD_sA' ./ PD ) * 100;
irfs(13,:,1) = ( oo_.irfs.PF_sA' ./ PF ) * 100;
irfs(14,:,1) = ( oo_.irfs.GD_sA' ./ GD ) * 100;
irfs(15,:,1) = ( oo_.irfs.GF_sA' ./ GF ) * 100;
irfs(16,:,1) = oo_.irfs.i_sA' - i;

%Government Spending shock shock

irfs(1,:,1) = ( oo_.irfs.C_sG' ./ C ) * 100;
irfs(2,:,1) = ( oo_.irfs.H_sG' ./ H ) * 100;
irfs(3,:,1) = ( oo_.irfs.W_sG' ./ W ) * 100 ;
irfs(4,:,1) = ( oo_.irfs.B_sG' ./ B ) * 100;
irfs(5,:,1) = ( oo_.irfs.Y_sG' ./ Y ) * 100;
irfs(6,:,1) = ( oo_.irfs.PI_sG' ./ PI ) * 100;
irfs(7,:,1) = ( oo_.irfs.MC_sG' ./ MC ) * 100;
irfs(8,:,1) = ( oo_.irfs.mu_sG' ./ mu ) * 100;
irfs(9,:,1) = ( oo_.irfs.e_sG' ./ e ) * 100;
irfs(10,:,1) = ( oo_.irfs.CD_sG' ./ CD ) * 100;
irfs(11,:,1) = ( oo_.irfs.CF_sG' ./ CF ) * 100;
irfs(12,:,1) = ( oo_.irfs.PD_sG' ./ PD ) * 100;
irfs(14,:,1) = ( oo_.irfs.GD_sG' ./ GD ) * 100;
irfs(15,:,1) = ( oo_.irfs.GF_sG' ./ GF ) * 100;
irfs(16,:,1) = oo_.irfs.i_sG' - i;

clearvars -except irfs T;

%% Graphs

X = 0:20;
Y = -1:2;
Z = 0:0;

names = {'Consumption', 'Hours', 'Wages', 'Bonds', 'Output', 'Profits', ...
    'Marginal Cost', ' Markup', 'Demand Shifter', 'Cons Domestic Goods', ...
    'Cons Imported Goods', 'Price Domestic Goods', 'Gov Domestic Goods', ...
    ' Gov Imported Goods', 'Interest rate'};


figure
subplot(2,2,1)
plot(1:T,irfs(1,:,1)) 
axis([1,20, -1, 1.5], "square")
title( names(  ) )
hold on
plot(X,Z)
   
hold on
subplot(2,2,2)
plot(1:T,irfs(1,:,2))
axis([1,20, -1, 1.5], "square")
title('Government spending shock')
hold on
plot(X,Z)


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

plot( oo_.endo_simul( 13, : )./ ( .9500000000 / .6440021245) * 100 );  







mu_data = mu; mu_model = mu0; y_data = y; y_model = Y0;

filename = 'dados.xls';
dados = [ mu_data mu_model' y_data y_model' ]; 
xlRange='A2';
sheet=1;
xlswrite(filename,dados,sheet,xlRange);
names = { "mu_data" "mu_model" "y_data" "y_model" };
xlRange='A1';
xlswrite(filename,names,sheet,xlRange);


%% Simulation (model vs data)

mu_sim = oo_.endo_simul(13,:) ./ oo_.steady_state(13) * 100;
plot(mu_sim)

filename = 'mu_sim.xlsx';
xlRange='A1:A17';
sheet=1;
xlswrite(filename, round(mu_sim*1e3)/1e3, sheet, xlRange);





