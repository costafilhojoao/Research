function data = USA()
% "Business Cycle Accounting: what have we learned so far?"
% Brinca, Pedro, Costa-Filho, João and Loria, Francesca

% Creates the USA.mat file

restoredefaultpath;
clear all;close all;clc;

%% pathing

% code assumes (and needs) current folder to be the root folder

%% Loading Data %%

% Data loading refers to 1960Q1-2014Q4. 

%   GDP: value, market prices 
%  PGDP: deflator, market prices
%    IT: Gross fixed capital formation, total, value
%   PIT: Gross total fixed capital formation, deflator
%    CG: Government final consumption expenditure, value, GDP expenditure approach
%   PCG: Government final consumption expenditure, deflator
%   XGS: Exports of goods and services, value, National Accounts basis 
%  PXGS: Exports of goods and services, deflator, National Accounts basis
%   MGS: Imports of goods and services, value, National Accounts basis
%  PMGS: Imports of goods and services, deflator, National Accounts basis
%   HRS: Hours worked per employee, total economy
%    ET: Total employment
%    CP: Private final consumption expenditure, value, GDP expenditure approach
%   PCP: Private final consumption expenditure, deflator

% Quarterly data

sobs  = '8'; midsep = ':'; eobs ='227';
 dval  = 189-str2num(sobs); % determines the row element to use as base year in delfators
startY = 1960.25;


  GDP  = xlsread('Survey - Application','USA',['E',sobs,midsep,'E',eobs]);
 PGDP  = xlsread('Survey - Application','USA',['O',sobs,midsep,'O',eobs]);
   IT  = xlsread('Survey - Application','USA',['F',sobs,midsep,'F',eobs]);
  PIT  = xlsread('Survey - Application','USA',['L',sobs,midsep,'L',eobs]); 
   CG  = xlsread('Survey - Application','USA',['C',sobs,midsep,'C',eobs]);
  PCG  = xlsread('Survey - Application','USA',['Q',sobs,midsep,'Q',eobs]);
  XGS  = xlsread('Survey - Application','USA',['I',sobs,midsep,'I',eobs]);
 PXGS  = xlsread('Survey - Application','USA',['K',sobs,midsep,'K',eobs]);
  MGS  = xlsread('Survey - Application','USA',['H',sobs,midsep,'H',eobs]);
 PMGS  = xlsread('Survey - Application','USA',['N',sobs,midsep,'N',eobs]); 
  HRS  = xlsread('Survey - Application','USA',['S',sobs,midsep,'S',eobs]);
   ET  = xlsread('Survey - Application','USA',['R',sobs,midsep,'R',eobs]);
   CP  = xlsread('Survey - Application','USA',['D',sobs,midsep,'D',eobs]);
  PCP  = xlsread('Survey - Application','USA',['J',sobs,midsep,'J',eobs]);

% Annual data
  
sobs2  = '20'; midsep = ':'; eobs2 ='74';

PoPm = xlsread('USA Population','USA',['C',sobs2,midsep,'U',eobs2]); % population matrix
TP   = PoPm(:,19); %total population
P    = TP-sum(PoPm(:,1:3),2)-sum(PoPm(:,14:18),2); % population net from 0-15 and 65+
iP   = (interp1(1:size(P,1),P,1:0.25:size(P,1)+0.75,'spline','extrap'))'; %interpolated to Q

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

t   = [startY:0.25:2015]';

mled  = [t,ypc,xpc,hpc/1300,gpc,iP];

save('USA.dat','mled','-ascii');