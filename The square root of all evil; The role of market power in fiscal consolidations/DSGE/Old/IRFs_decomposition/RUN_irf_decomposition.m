%% Paper:  Labus, M. & Labus, M.(2017: “Monetary Transmission Channels in DSGE Models: Decomposition of Impulse Response Functions Approach”, 
%% Computation Economics, Volume 50, Number 1, pp.1-24. https://doi.org/10.1007/s10614-017-9717-1
%% Reproduction of Fig.1 from the paper
load('QUEST_III_results.mat')
irf_decomposition('E_GY','E_EPS_M',0.01,6,20,1,1)
%% Reproduction of Fig.3b from the paper
load('SW_NOFA_results.mat')
irf_decomposition('y','em',0.01,6,20,0,1)