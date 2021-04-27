%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'model3';
M_.dynare_version = '4.6.0';
oo_.dynare_version = '4.6.0';
options_.dynare_version = '4.6.0';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('model3.log');
M_.exo_names = cell(7,1);
M_.exo_names_tex = cell(7,1);
M_.exo_names_long = cell(7,1);
M_.exo_names(1) = {'sA'};
M_.exo_names_tex(1) = {'sA'};
M_.exo_names_long(1) = {'sA'};
M_.exo_names(2) = {'sG'};
M_.exo_names_tex(2) = {'sG'};
M_.exo_names_long(2) = {'sG'};
M_.exo_names(3) = {'sX'};
M_.exo_names_tex(3) = {'sX'};
M_.exo_names_long(3) = {'sX'};
M_.exo_names(4) = {'si'};
M_.exo_names_tex(4) = {'si'};
M_.exo_names_long(4) = {'si'};
M_.exo_names(5) = {'sunspot'};
M_.exo_names_tex(5) = {'sunspot'};
M_.exo_names_long(5) = {'sunspot'};
M_.exo_names(6) = {'sunspot2'};
M_.exo_names_tex(6) = {'sunspot2'};
M_.exo_names_long(6) = {'sunspot2'};
M_.exo_names(7) = {'sunspot3'};
M_.exo_names_tex(7) = {'sunspot3'};
M_.exo_names_long(7) = {'sunspot3'};
M_.endo_names = cell(22,1);
M_.endo_names_tex = cell(22,1);
M_.endo_names_long = cell(22,1);
M_.endo_names(1) = {'C'};
M_.endo_names_tex(1) = {'C'};
M_.endo_names_long(1) = {'C'};
M_.endo_names(2) = {'H'};
M_.endo_names_tex(2) = {'H'};
M_.endo_names_long(2) = {'H'};
M_.endo_names(3) = {'P'};
M_.endo_names_tex(3) = {'P'};
M_.endo_names_long(3) = {'P'};
M_.endo_names(4) = {'lambda'};
M_.endo_names_tex(4) = {'lambda'};
M_.endo_names_long(4) = {'lambda'};
M_.endo_names(5) = {'W'};
M_.endo_names_tex(5) = {'W'};
M_.endo_names_long(5) = {'W'};
M_.endo_names(6) = {'B'};
M_.endo_names_tex(6) = {'B'};
M_.endo_names_long(6) = {'B'};
M_.endo_names(7) = {'PI'};
M_.endo_names_tex(7) = {'PI'};
M_.endo_names_long(7) = {'PI'};
M_.endo_names(8) = {'T'};
M_.endo_names_tex(8) = {'T'};
M_.endo_names_long(8) = {'T'};
M_.endo_names(9) = {'G'};
M_.endo_names_tex(9) = {'G'};
M_.endo_names_long(9) = {'G'};
M_.endo_names(10) = {'p'};
M_.endo_names_tex(10) = {'p'};
M_.endo_names_long(10) = {'p'};
M_.endo_names(11) = {'MC'};
M_.endo_names_tex(11) = {'MC'};
M_.endo_names_long(11) = {'MC'};
M_.endo_names(12) = {'theta'};
M_.endo_names_tex(12) = {'theta'};
M_.endo_names_long(12) = {'theta'};
M_.endo_names(13) = {'y'};
M_.endo_names_tex(13) = {'y'};
M_.endo_names_long(13) = {'y'};
M_.endo_names(14) = {'e'};
M_.endo_names_tex(14) = {'e'};
M_.endo_names_long(14) = {'e'};
M_.endo_names(15) = {'A'};
M_.endo_names_tex(15) = {'A'};
M_.endo_names_long(15) = {'A'};
M_.endo_names(16) = {'mu'};
M_.endo_names_tex(16) = {'mu'};
M_.endo_names_long(16) = {'mu'};
M_.endo_names(17) = {'Y'};
M_.endo_names_tex(17) = {'Y'};
M_.endo_names_long(17) = {'Y'};
M_.endo_names(18) = {'X'};
M_.endo_names_tex(18) = {'X'};
M_.endo_names_long(18) = {'X'};
M_.endo_names(19) = {'i'};
M_.endo_names_tex(19) = {'i'};
M_.endo_names_long(19) = {'i'};
M_.endo_names(20) = {'lambdas'};
M_.endo_names_tex(20) = {'lambdas'};
M_.endo_names_long(20) = {'lambdas'};
M_.endo_names(21) = {'thetas'};
M_.endo_names_tex(21) = {'thetas'};
M_.endo_names_long(21) = {'thetas'};
M_.endo_names(22) = {'ys'};
M_.endo_names_tex(22) = {'ys'};
M_.endo_names_long(22) = {'ys'};
M_.endo_partitions = struct();
M_.param_names = cell(12,1);
M_.param_names_tex = cell(12,1);
M_.param_names_long = cell(12,1);
M_.param_names(1) = {'psi'};
M_.param_names_tex(1) = {'psi'};
M_.param_names_long(1) = {'psi'};
M_.param_names(2) = {'sigma'};
M_.param_names_tex(2) = {'sigma'};
M_.param_names_long(2) = {'sigma'};
M_.param_names(3) = {'alpha'};
M_.param_names_tex(3) = {'alpha'};
M_.param_names_long(3) = {'alpha'};
M_.param_names(4) = {'phi'};
M_.param_names_tex(4) = {'phi'};
M_.param_names_long(4) = {'phi'};
M_.param_names(5) = {'eta'};
M_.param_names_tex(5) = {'eta'};
M_.param_names_long(5) = {'eta'};
M_.param_names(6) = {'gamma'};
M_.param_names_tex(6) = {'gamma'};
M_.param_names_long(6) = {'gamma'};
M_.param_names(7) = {'omega'};
M_.param_names_tex(7) = {'omega'};
M_.param_names_long(7) = {'omega'};
M_.param_names(8) = {'rho'};
M_.param_names_tex(8) = {'rho'};
M_.param_names_long(8) = {'rho'};
M_.param_names(9) = {'zetaA'};
M_.param_names_tex(9) = {'zetaA'};
M_.param_names_long(9) = {'zetaA'};
M_.param_names(10) = {'zetaG'};
M_.param_names_tex(10) = {'zetaG'};
M_.param_names_long(10) = {'zetaG'};
M_.param_names(11) = {'zetai'};
M_.param_names_tex(11) = {'zetai'};
M_.param_names_long(11) = {'zetai'};
M_.param_names(12) = {'kappa'};
M_.param_names_tex(12) = {'kappa'};
M_.param_names_long(12) = {'kappa'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 7;
M_.endo_nbr = 22;
M_.param_nbr = 12;
M_.orig_endo_nbr = 22;
M_.aux_vars = [];
M_.Sigma_e = zeros(7, 7);
M_.Correlation_matrix = eye(7, 7);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.linear_decomposition = false;
M_.orig_eq_nbr = 22;
M_.eq_nbr = 22;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 0 9 0;
 0 10 0;
 0 11 0;
 0 12 0;
 0 13 0;
 1 14 0;
 0 15 0;
 0 16 0;
 2 17 0;
 0 18 31;
 0 19 0;
 0 20 0;
 0 21 0;
 3 22 0;
 4 23 0;
 0 24 0;
 0 25 0;
 0 26 0;
 5 27 0;
 6 28 0;
 7 29 0;
 8 30 0;]';
M_.nstatic = 13;
M_.nfwrd   = 1;
M_.npred   = 8;
M_.nboth   = 0;
M_.nsfwrd   = 1;
M_.nspred   = 8;
M_.ndynamic   = 9;
M_.dynamic_tmp_nbr = [10; 3; 0; 0; ];
M_.equations_tags = {
  1 , 'name' , '1' ;
  2 , 'name' , '2' ;
  3 , 'name' , '3' ;
  4 , 'name' , '4' ;
  5 , 'name' , 'B' ;
  6 , 'name' , '6' ;
  7 , 'name' , '7' ;
  8 , 'name' , 'X' ;
  9 , 'name' , 'i' ;
  10 , 'name' , '10' ;
  11 , 'name' , '11' ;
  12 , 'name' , '12' ;
  13 , 'name' , '13' ;
  14 , 'name' , 'MC' ;
  15 , 'name' , 'mu' ;
  16 , 'name' , 'e' ;
  17 , 'name' , '17' ;
  18 , 'name' , 'P' ;
  19 , 'name' , 'Y' ;
  20 , 'name' , '20' ;
  21 , 'name' , 'PI' ;
  22 , 'name' , 'y' ;
};
M_.mapping.C.eqidx = [1 2 5 20 ];
M_.mapping.H.eqidx = [1 2 5 19 21 ];
M_.mapping.P.eqidx = [1 5 6 18 21 ];
M_.mapping.lambda.eqidx = [1 2 3 ];
M_.mapping.W.eqidx = [2 5 14 21 ];
M_.mapping.B.eqidx = [5 ];
M_.mapping.PI.eqidx = [5 21 ];
M_.mapping.T.eqidx = [5 6 ];
M_.mapping.G.eqidx = [6 7 20 ];
M_.mapping.p.eqidx = [10 11 15 18 ];
M_.mapping.MC.eqidx = [10 14 15 ];
M_.mapping.theta.eqidx = [10 ];
M_.mapping.y.eqidx = [14 16 22 ];
M_.mapping.e.eqidx = [11 16 18 19 22 ];
M_.mapping.A.eqidx = [14 17 19 ];
M_.mapping.mu.eqidx = [15 ];
M_.mapping.Y.eqidx = [19 20 21 22 ];
M_.mapping.X.eqidx = [8 20 ];
M_.mapping.i.eqidx = [3 5 9 ];
M_.mapping.lambdas.eqidx = [3 4 ];
M_.mapping.thetas.eqidx = [11 12 ];
M_.mapping.ys.eqidx = [11 13 ];
M_.mapping.sA.eqidx = [17 ];
M_.mapping.sG.eqidx = [7 ];
M_.mapping.sX.eqidx = [8 ];
M_.mapping.si.eqidx = [9 ];
M_.mapping.sunspot.eqidx = [4 ];
M_.mapping.sunspot2.eqidx = [12 ];
M_.mapping.sunspot3.eqidx = [13 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [6 9 14 15 19 20 21 22 ];
M_.exo_names_orig_ord = [1:7];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(22, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(7, 1);
M_.params = NaN(12, 1);
M_.endo_trends = struct('deflator', cell(22, 1), 'log_deflator', cell(22, 1), 'growth_factor', cell(22, 1), 'log_growth_factor', cell(22, 1));
M_.NNZDerivatives = [79; -1; -1; ];
M_.static_tmp_nbr = [10; 3; 0; 0; ];
close all;
dgov   = xlsread('data','Sheet1',['B','2',':','B','26']);   
M_.params(2) = 2.9;
sigma = M_.params(2);
M_.params(3) = 0.3333333333333333;
alpha = M_.params(3);
M_.params(4) = 0.75;
phi = M_.params(4);
M_.params(5) = 0.125;
eta = M_.params(5);
M_.params(8) = 0.02177818086464089;
rho = M_.params(8);
M_.params(6) = 2;
gamma = M_.params(6);
M_.params(7) = 1.455;
omega = M_.params(7);
M_.params(9) = 0.9;
zetaA = M_.params(9);
M_.params(10) = 0.9;
zetaG = M_.params(10);
M_.params(11) = 0.9;
zetai = M_.params(11);
M_.params(12) = 0.07;
kappa = M_.params(12);
M_.params(1) = .3264644442;
psi = M_.params(1);
steady;
shockA = oo_.steady_state(15) * 0.01;
shockG = oo_.steady_state(8) * 0.03;
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = shockA;
M_.Sigma_e(2, 2) = shockG;
options_.ar = 1;
options_.irf = 10;
options_.order = 1;
var_list_ = {'y';'P';'MC';'mu';'W';'C';'H';'A'};
[info, oo_, options_] = stoch_simul(M_, options_, oo_, var_list_);
save('model3_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('model3_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('model3_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('model3_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('model3_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('model3_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('model3_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
