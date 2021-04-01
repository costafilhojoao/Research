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
M_.exo_names = cell(3,1);
M_.exo_names_tex = cell(3,1);
M_.exo_names_long = cell(3,1);
M_.exo_names(1) = {'sA'};
M_.exo_names_tex(1) = {'sA'};
M_.exo_names_long(1) = {'sA'};
M_.exo_names(2) = {'sG'};
M_.exo_names_tex(2) = {'sG'};
M_.exo_names_long(2) = {'sG'};
M_.exo_names(3) = {'sX'};
M_.exo_names_tex(3) = {'sX'};
M_.exo_names_long(3) = {'sX'};
M_.endo_names = cell(19,1);
M_.endo_names_tex = cell(19,1);
M_.endo_names_long = cell(19,1);
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
M_.endo_partitions = struct();
M_.param_names = cell(15,1);
M_.param_names_tex = cell(15,1);
M_.param_names_long = cell(15,1);
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
M_.param_names(11) = {'zetaX'};
M_.param_names_tex(11) = {'zetaX'};
M_.param_names_long(11) = {'zetaX'};
M_.param_names(12) = {'zetai'};
M_.param_names_tex(12) = {'zetai'};
M_.param_names_long(12) = {'zetai'};
M_.param_names(13) = {'gs'};
M_.param_names_tex(13) = {'gs'};
M_.param_names_long(13) = {'gs'};
M_.param_names(14) = {'hbar'};
M_.param_names_tex(14) = {'hbar'};
M_.param_names_long(14) = {'hbar'};
M_.param_names(15) = {'kappa'};
M_.param_names_tex(15) = {'kappa'};
M_.param_names_long(15) = {'kappa'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 3;
M_.endo_nbr = 19;
M_.param_nbr = 15;
M_.orig_endo_nbr = 19;
M_.aux_vars = [];
M_.Sigma_e = zeros(3, 3);
M_.Correlation_matrix = eye(3, 3);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.linear_decomposition = false;
M_.orig_eq_nbr = 19;
M_.eq_nbr = 19;
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
 0 6 0;
 0 7 0;
 0 8 0;
 0 9 25;
 0 10 0;
 1 11 0;
 0 12 0;
 0 13 0;
 2 14 0;
 0 15 26;
 0 16 0;
 0 17 27;
 0 18 28;
 3 19 0;
 4 20 0;
 0 21 0;
 0 22 0;
 0 23 0;
 5 24 0;]';
M_.nstatic = 10;
M_.nfwrd   = 4;
M_.npred   = 5;
M_.nboth   = 0;
M_.nsfwrd   = 4;
M_.nspred   = 5;
M_.ndynamic   = 9;
M_.dynamic_tmp_nbr = [12; 3; 0; 0; ];
M_.equations_tags = {
  1 , 'name' , '1' ;
  2 , 'name' , '2' ;
  3 , 'name' , '3' ;
  4 , 'name' , 'B' ;
  5 , 'name' , '5' ;
  6 , 'name' , '6' ;
  7 , 'name' , 'X' ;
  8 , 'name' , 'i' ;
  9 , 'name' , '9' ;
  10 , 'name' , '10' ;
  11 , 'name' , 'MC' ;
  12 , 'name' , 'mu' ;
  13 , 'name' , 'e' ;
  14 , 'name' , '14' ;
  15 , 'name' , 'P' ;
  16 , 'name' , 'Y' ;
  17 , 'name' , '17' ;
  18 , 'name' , 'PI' ;
  19 , 'name' , 'y' ;
};
M_.mapping.C.eqidx = [1 2 4 17 ];
M_.mapping.H.eqidx = [1 2 4 16 18 ];
M_.mapping.P.eqidx = [1 4 5 15 18 ];
M_.mapping.lambda.eqidx = [1 2 3 ];
M_.mapping.W.eqidx = [2 4 11 18 ];
M_.mapping.B.eqidx = [4 8 ];
M_.mapping.PI.eqidx = [4 18 ];
M_.mapping.T.eqidx = [4 5 ];
M_.mapping.G.eqidx = [5 6 17 ];
M_.mapping.p.eqidx = [9 10 12 15 ];
M_.mapping.MC.eqidx = [9 11 12 ];
M_.mapping.theta.eqidx = [9 10 ];
M_.mapping.y.eqidx = [10 11 13 19 ];
M_.mapping.e.eqidx = [10 13 15 16 19 ];
M_.mapping.A.eqidx = [11 14 16 ];
M_.mapping.mu.eqidx = [12 ];
M_.mapping.Y.eqidx = [16 17 18 19 ];
M_.mapping.X.eqidx = [7 17 ];
M_.mapping.i.eqidx = [3 4 8 ];
M_.mapping.sA.eqidx = [14 ];
M_.mapping.sG.eqidx = [6 ];
M_.mapping.sX.eqidx = [7 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [6 9 14 15 19 ];
M_.exo_names_orig_ord = [1:3];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(19, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(3, 1);
M_.params = NaN(15, 1);
M_.endo_trends = struct('deflator', cell(19, 1), 'log_deflator', cell(19, 1), 'growth_factor', cell(19, 1), 'log_growth_factor', cell(19, 1));
M_.NNZDerivatives = [70; -1; -1; ];
M_.static_tmp_nbr = [9; 3; 0; 0; ];
close all;
M_.params(2) = 2.9;
sigma = M_.params(2);
M_.params(3) = 0.3333333333333333;
alpha = M_.params(3);
M_.params(4) = 0.75;
phi = M_.params(4);
M_.params(5) = 0.5;
eta = M_.params(5);
M_.params(8) = 0.02;
rho = M_.params(8);
M_.params(6) = 2;
gamma = M_.params(6);
M_.params(7) = 1.455;
omega = M_.params(7);
M_.params(9) = 0.9;
zetaA = M_.params(9);
M_.params(10) = 0.8;
zetaG = M_.params(10);
M_.params(14) = 0.3649706457925636;
hbar = M_.params(14);
M_.params(13) = 0.341;
gs = M_.params(13);
mubar = 1.301062573789847;
M_.params(15) = 10;
kappa = M_.params(15);
M_.params(1) = M_.params(5)/(M_.params(4)*(mubar/(1-M_.params(3)))^((1-M_.params(3))/(1+M_.params(3)))*M_.params(14)^((1-M_.params(3))/(1+M_.params(3))));
psi = M_.params(1);
steady;
resid;
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(2, 2) = 0.011;
steady;
options_.hp_filter = 1600;
options_.irf = 20;
options_.order = 1;
var_list_ = {};
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
