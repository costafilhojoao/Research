function data = MEX()

%%  Accounting for Mexican Business Cycles

% Brinca and Costa-Filho

%%
% This function prepares the data for the Business Cycle Accounting and creates the DATA_MBCA.mat file

restoredefaultpath;
clear all;close all;clc;

% Pathing: the code assumes (and needs) current folder to be the root folder

%% Loading Data %%

% WEO Data: October 2021 Edition
% https://www.imf.org/en/Publications/WEO/weo-database/2021/October

% Period: 1960Q1-2014Q1. 

% GDP: value, market prices 
%PGDP: deflator, market prices
% IT: Gross fixed capital formation, total, value
%PIT: Gross total fixed capital formation, deflator
% CG: Government final consumption expenditure, value, GDP expenditure approach
%PCG: Government final consumption expenditure, deflator
% XGS: Exports of goods and services, value, National Accounts basis 
%PXGS: Exports of goods and services, deflator, National Accounts basis
% MGS: Imports of goods and services, value, National Accounts basis
%PMGS: Imports of goods and services, deflator, National Accounts basis
% HRS: Hours worked per employee, total economy
%  ET: Total employment
%  CP: Private final consumption expenditure, value, GDP expenditure approach
% PCP: Private final consumption expenditure, deflator


sobs  = '88'; % initial observation
midsep = ':'; % separator
eobs ='224';  % final observation

dval  = 189-str2num(sobs); % determines the row element to use as base year in delfators
startY = 1980.25; %initial year

  GDP  = xlsread('OECDDATA','US',['E',sobs,midsep,'E',eobs]);
 PGDP  = xlsread('OECDDATA','US',['K',sobs,midsep,'K',eobs]);
   IT  = xlsread('OECDDATA','US',['F',sobs,midsep,'F',eobs]);
  PIT  = xlsread('OECDDATA','US',['L',sobs,midsep,'L',eobs]); 
   CG  = xlsread('OECDDATA','US',['C',sobs,midsep,'C',eobs]);
  PCG  = xlsread('OECDDATA','US',['I',sobs,midsep,'I',eobs]);
  XGS  = xlsread('OECDDATA','US',['H',sobs,midsep,'H',eobs]);
 PXGS  = xlsread('OECDDATA','US',['N',sobs,midsep,'N',eobs]);
  MGS  = xlsread('OECDDATA','US',['G',sobs,midsep,'G',eobs]);
 PMGS  = xlsread('OECDDATA','US',['M',sobs,midsep,'M',eobs]); 
  HRS  = xlsread('OECDDATA','US',['P',sobs,midsep,'P',eobs]);
   ET  = xlsread('OECDDATA','US',['O',sobs,midsep,'O',eobs]);
   CP  = xlsread('OECDDATA','US',['D',sobs,midsep,'D',eobs]);
  PCP  = xlsread('OECDDATA','US',['J',sobs,midsep,'J',eobs]);
  IRS  = xlsread('OECDDATA','US',['Q',sobs,midsep,'Q',eobs]);
% all variables above at quarterly frequency - OECD Outlook 95

sobs2  = '38'; midsep = ':'; eobs2 ='71';

PoPm = xlsread('OECDDATA','US',['S',sobs2,midsep,'AC',eobs2]); % population matrix
TP   = PoPm(:,9); %total population
P    = TP-PoPm(:,8)-sum(PoPm(:,1:8),2); % population net from 0-15 and 65+
iP   = (interp1(1:size(P,1),P,1:0.25:size(P,1)+1,'spline','extrap'))'; %interpolated to Q

% all variables above at yearly frequency - OECD Demography and Population

T = size(GDP,1); % number of observations



%% treating data %%

% turn deflators from their base years to Q1:2005
nPGDP  = PGDP./PGDP(dval);   nPIT = PIT./PIT(dval);
 nPCG  =   PCG./PCG(dval);  nPXGS = PXGS./PXGS(dval);
nPMGS  = PMGS./PMGS(dval);   nPCP = PCP./PCP(dval);

nPIT = nPGDP; nPCG = nPGDP; nPMGS = nPGDP;
nPXGS = nPGDP; nPCP = nPGDP;

% compute Y, H, X, G, 
Y = (GDP./nPGDP); %-STXQ./nPGDP);
H = HRS/4.*ET;
X = IT./nPIT;
G = CG./nPCG + XGS./nPXGS-MGS./nPMGS;
CG2 = CG./nPCG;
XGS2 = XGS./nPXGS-MGS./nPMGS;

% compute per capita values
ypc = Y./iP./4;
hpc = H./iP;
xpc = X./iP./4;
gpc = G./iP./4;
cpc = CP./nPCP./iP./4;
cgpc = CG2./iP./4;
xgspc = XGS2./iP./4;
pi = (log(PGDP(2:end))-log(PGDP(1:end-1)));
irs = IRS/400;
t   = (startY:0.25:2014.25)';

mled_bca  = [t,ypc,xpc,hpc/1300,gpc,iP]; % BCA
mled_mbca = [t,ypc,xpc,hpc/1300,gpc,PGDP,irs,iP]; % MBCA

save('USA_OECD_BCA.dat','mled_bca','-ascii');
save('USA_OECD_MBCA.dat','mled_mbca','-ascii');