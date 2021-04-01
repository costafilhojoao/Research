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
M_.fname = 'rbc';
M_.dynare_version = '4.6.0';
oo_.dynare_version = '4.6.0';
options_.dynare_version = '4.6.0';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('rbc.log');
M_.exo_names = cell(1,1);
M_.exo_names_tex = cell(1,1);
M_.exo_names_long = cell(1,1);
M_.exo_names(1) = {'eps_A'};
M_.exo_names_tex(1) = {'eps\_A'};
M_.exo_names_long(1) = {'eps_A'};
M_.endo_names = cell(8,1);
M_.endo_names_tex = cell(8,1);
M_.endo_names_long = cell(8,1);
M_.endo_names(1) = {'Y'};
M_.endo_names_tex(1) = {'Y'};
M_.endo_names_long(1) = {'Y'};
M_.endo_names(2) = {'C'};
M_.endo_names_tex(2) = {'C'};
M_.endo_names_long(2) = {'C'};
M_.endo_names(3) = {'K'};
M_.endo_names_tex(3) = {'K'};
M_.endo_names_long(3) = {'K'};
M_.endo_names(4) = {'L'};
M_.endo_names_tex(4) = {'L'};
M_.endo_names_long(4) = {'L'};
M_.endo_names(5) = {'A'};
M_.endo_names_tex(5) = {'A'};
M_.endo_names_long(5) = {'A'};
M_.endo_names(6) = {'R'};
M_.endo_names_tex(6) = {'R'};
M_.endo_names_long(6) = {'R'};
M_.endo_names(7) = {'W'};
M_.endo_names_tex(7) = {'W'};
M_.endo_names_long(7) = {'W'};
M_.endo_names(8) = {'I'};
M_.endo_names_tex(8) = {'I'};
M_.endo_names_long(8) = {'I'};
M_.endo_partitions = struct();
M_.param_names = cell(6,1);
M_.param_names_tex = cell(6,1);
M_.param_names_long = cell(6,1);
M_.param_names(1) = {'alph'};
M_.param_names_tex(1) = {'alph'};
M_.param_names_long(1) = {'alph'};
M_.param_names(2) = {'betta'};
M_.param_names_tex(2) = {'betta'};
M_.param_names_long(2) = {'betta'};
M_.param_names(3) = {'delt'};
M_.param_names_tex(3) = {'delt'};
M_.param_names_long(3) = {'delt'};
M_.param_names(4) = {'gam'};
M_.param_names_tex(4) = {'gam'};
M_.param_names_long(4) = {'gam'};
M_.param_names(5) = {'pssi'};
M_.param_names_tex(5) = {'pssi'};
M_.param_names_long(5) = {'pssi'};
M_.param_names(6) = {'rhoA'};
M_.param_names_tex(6) = {'rhoA'};
M_.param_names_long(6) = {'rhoA'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 8;
M_.param_nbr = 6;
M_.orig_endo_nbr = 8;
M_.aux_vars = [];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.linear_decomposition = false;
M_.nonzero_hessian_eqs = [1 2 5 6 7 8];
M_.hessian_eq_zero = isempty(M_.nonzero_hessian_eqs);
M_.orig_eq_nbr = 8;
M_.eq_nbr = 8;
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
 0 3 0;
 0 4 11;
 1 5 0;
 0 6 0;
 2 7 0;
 0 8 0;
 0 9 0;
 0 10 0;]';
M_.nstatic = 5;
M_.nfwrd   = 1;
M_.npred   = 2;
M_.nboth   = 0;
M_.nsfwrd   = 1;
M_.nspred   = 2;
M_.ndynamic   = 3;
M_.dynamic_tmp_nbr = [6; 6; 1; 0; ];
M_.equations_tags = {
  1 , 'name' , 'UC' ;
  2 , 'name' , 'W' ;
  3 , 'name' , 'K' ;
  4 , 'name' , 'Y' ;
  5 , 'name' , '5' ;
  6 , 'name' , '6' ;
  7 , 'name' , 'R' ;
  8 , 'name' , '8' ;
};
M_.mapping.Y.eqidx = [4 5 6 7 ];
M_.mapping.C.eqidx = [1 2 4 ];
M_.mapping.K.eqidx = [3 5 7 ];
M_.mapping.L.eqidx = [2 5 6 ];
M_.mapping.A.eqidx = [5 8 ];
M_.mapping.R.eqidx = [1 7 ];
M_.mapping.W.eqidx = [2 6 ];
M_.mapping.I.eqidx = [3 4 ];
M_.mapping.eps_A.eqidx = [8 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [3 5 ];
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(8, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(6, 1);
M_.endo_trends = struct('deflator', cell(8, 1), 'log_deflator', cell(8, 1), 'growth_factor', cell(8, 1), 'log_growth_factor', cell(8, 1));
M_.NNZDerivatives = [25; 24; -1; ];
M_.static_tmp_nbr = [3; 1; 0; 0; ];
M_.params(1) = 0.35;
alph = M_.params(1);
M_.params(2) = 0.99;
betta = M_.params(2);
M_.params(3) = 0.025;
delt = M_.params(3);
M_.params(4) = 1;
gam = M_.params(4);
M_.params(5) = 1.6;
pssi = M_.params(5);
M_.params(6) = 0.9;
rhoA = M_.params(6);
steady;
resid;
save('rbc_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('rbc_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('rbc_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('rbc_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('rbc_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('rbc_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('rbc_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
