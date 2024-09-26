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
M_.fname = 'mex';
M_.dynare_version = '4.6.0';
oo_.dynare_version = '4.6.0';
options_.dynare_version = '4.6.0';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('mex.log');
M_.exo_names = cell(1,1);
M_.exo_names_tex = cell(1,1);
M_.exo_names_long = cell(1,1);
M_.exo_names(1) = {'ee'};
M_.exo_names_tex(1) = {'ee'};
M_.exo_names_long(1) = {'real exchange rate shock'};
M_.endo_names = cell(12,1);
M_.endo_names_tex = cell(12,1);
M_.endo_names_long = cell(12,1);
M_.endo_names(1) = {'q'};
M_.endo_names_tex(1) = {'{\hat q}'};
M_.endo_names_long(1) = {'gross output'};
M_.endo_names(2) = {'y'};
M_.endo_names_tex(2) = {'{\hat y}'};
M_.endo_names_long(2) = {'value-added output'};
M_.endo_names(3) = {'d'};
M_.endo_names_tex(3) = {'{\hat d}'};
M_.endo_names_long(3) = {'foreign debt'};
M_.endo_names(4) = {'c'};
M_.endo_names_tex(4) = {'{\hat c}'};
M_.endo_names_long(4) = {'consumption'};
M_.endo_names(5) = {'r'};
M_.endo_names_tex(5) = {'{\hat r}'};
M_.endo_names_long(5) = {'real interest rate'};
M_.endo_names(6) = {'k'};
M_.endo_names_tex(6) = {'{\hat k}'};
M_.endo_names_long(6) = {'capital'};
M_.endo_names(7) = {'x'};
M_.endo_names_tex(7) = {'{\hat x}'};
M_.endo_names_long(7) = {'investment'};
M_.endo_names(8) = {'m'};
M_.endo_names_tex(8) = {'{\hat m}'};
M_.endo_names_long(8) = {'intermediates goods imports'};
M_.endo_names(9) = {'e'};
M_.endo_names_tex(9) = {'{\hat e}'};
M_.endo_names_long(9) = {'real exchange rate'};
M_.endo_names(10) = {'l'};
M_.endo_names_tex(10) = {'{\hat l}'};
M_.endo_names_long(10) = {'hours of work'};
M_.endo_names(11) = {'tby'};
M_.endo_names_tex(11) = {'{\hat tby}'};
M_.endo_names_long(11) = {'trade balance / GDP'};
M_.endo_names(12) = {'lambda'};
M_.endo_names_tex(12) = {'{\lambda}'};
M_.endo_names_long(12) = {'Lagrange multiplier'};
M_.endo_partitions = struct();
M_.param_names = cell(9,1);
M_.param_names_tex = cell(9,1);
M_.param_names_long = cell(9,1);
M_.param_names(1) = {'beta'};
M_.param_names_tex(1) = {'beta'};
M_.param_names_long(1) = {'beta'};
M_.param_names(2) = {'gamma'};
M_.param_names_tex(2) = {'gamma'};
M_.param_names_long(2) = {'gamma'};
M_.param_names(3) = {'delta'};
M_.param_names_tex(3) = {'delta'};
M_.param_names_long(3) = {'delta'};
M_.param_names(4) = {'phi'};
M_.param_names_tex(4) = {'phi'};
M_.param_names_long(4) = {'phi'};
M_.param_names(5) = {'alpha'};
M_.param_names_tex(5) = {'alpha'};
M_.param_names_long(5) = {'alpha'};
M_.param_names(6) = {'mu'};
M_.param_names_tex(6) = {'mu'};
M_.param_names_long(6) = {'mu'};
M_.param_names(7) = {'omega'};
M_.param_names_tex(7) = {'omega'};
M_.param_names_long(7) = {'omega'};
M_.param_names(8) = {'psi'};
M_.param_names_tex(8) = {'psi'};
M_.param_names_long(8) = {'psi'};
M_.param_names(9) = {'rhoe'};
M_.param_names_tex(9) = {'rhoe'};
M_.param_names_long(9) = {'rhoe'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 12;
M_.param_nbr = 9;
M_.orig_endo_nbr = 12;
M_.aux_vars = [];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
options_.linear = true;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.linear_decomposition = false;
M_.orig_eq_nbr = 12;
M_.eq_nbr = 12;
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
 0 5 17;
 0 6 0;
 1 7 0;
 0 8 0;
 2 9 0;
 3 10 18;
 0 11 0;
 0 12 0;
 4 13 0;
 0 14 0;
 0 15 0;
 0 16 19;]';
M_.nstatic = 6;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 1;
M_.nsfwrd   = 3;
M_.nspred   = 4;
M_.ndynamic   = 6;
M_.dynamic_tmp_nbr = [18; 0; 0; 0; ];
M_.equations_tags = {
  1 , 'name' , 'foreign debt dynamics' ;
  2 , 'name' , 'gross output' ;
  3 , 'name' , 'real exchange rate dynamics' ;
  4 , 'name' , 'capital acumulation' ;
  5 , 'name' , 'FOC debt' ;
  6 , 'name' , 'FOC consumption' ;
  7 , 'name' , 'FOC hours of work' ;
  8 , 'name' , 'FOC capital' ;
  9 , 'name' , 'FOC intermediates goods' ;
  10 , 'name' , 'trade balance' ;
  11 , 'name' , 'Real interest rate' ;
  12 , 'name' , 'Value-added output' ;
};
M_.mapping.q.eqidx = [1 2 7 8 9 12 ];
M_.mapping.y.eqidx = [10 12 ];
M_.mapping.d.eqidx = [1 11 ];
M_.mapping.c.eqidx = [1 6 10 ];
M_.mapping.r.eqidx = [1 5 11 ];
M_.mapping.k.eqidx = [2 4 8 ];
M_.mapping.x.eqidx = [1 4 10 ];
M_.mapping.m.eqidx = [1 2 9 ];
M_.mapping.e.eqidx = [1 3 9 12 ];
M_.mapping.l.eqidx = [2 6 7 ];
M_.mapping.tby.eqidx = [10 ];
M_.mapping.lambda.eqidx = [5 6 8 ];
M_.mapping.ee.eqidx = [3 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [3 5 6 9 ];
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(12, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(9, 1);
M_.endo_trends = struct('deflator', cell(12, 1), 'log_deflator', cell(12, 1), 'growth_factor', cell(12, 1), 'log_growth_factor', cell(12, 1));
M_.NNZDerivatives = [43; -1; -1; ];
M_.static_tmp_nbr = [3; 0; 0; 0; ];
close all;
M_.params(1) = 0.9665;
beta = M_.params(1);
M_.params(2) = 2;
gamma = M_.params(2);
M_.params(3) = 0.0075;
delta = M_.params(3);
M_.params(4) = 0.028;
phi = M_.params(4);
M_.params(5) = 0.61;
alpha = M_.params(5);
M_.params(6) = 0.0667;
mu = M_.params(6);
M_.params(7) = 2.1765;
omega = M_.params(7);
M_.params(7) = 1.5;
omega = M_.params(7);
M_.params(9) = 0.9967;
rhoe = M_.params(9);
M_.params(9) = 0.956;
rhoe = M_.params(9);
M_.params(9) = 0.5;
rhoe = M_.params(9);
M_.params(8) = 0.000742;
psi = M_.params(8);
steady;
de = xlsread('data','Sheet1',['D','2',':','D','15']);   
dy = xlsread('data','Sheet1',['C','2',':','C','15']);   
%
% SHOCKS instructions
%
M_.det_shocks = [ M_.det_shocks;
struct('exo_det',0,'exo_id',1,'multiplicative',0,'periods',1:14,'value',de) ];
M_.exo_det_length = 0;
options_.periods = 100;
perfect_foresight_setup;
perfect_foresight_solver;
t = [1994:0.25:1997.25]';
figure
plot(t,oo_.endo_simul(2,1:length(de)),'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
xlabel('1995 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
hold off;
de = xlsread('data','Sheet1',['D','60',':','D','86']);   
dy = xlsread('data','Sheet1',['C','60',':','C','86']);   
%
% SHOCKS instructions
%
M_.det_shocks = [ M_.det_shocks;
struct('exo_det',0,'exo_id',1,'multiplicative',0,'periods',1:27,'value',de) ];
M_.exo_det_length = 0;
options_.periods = 100;
perfect_foresight_setup;
perfect_foresight_solver;
t = [2008.5:0.25:2015]';
figure 
plot(t,oo_.endo_simul(2,1:length(de)),'k--','Linewidth',3); hold on;
plot(t, dy, 'k-', 'Linewidth', 3 ); 
axis("square")
xlim([min( t ) max( t )])
xlabel('2008 crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
hold off;
de = xlsread('data','Sheet1',['D','104',':','D','109']);   
dy = xlsread('data','Sheet1',['C','104',':','C','109']);   
%
% SHOCKS instructions
%
M_.det_shocks = [ M_.det_shocks;
struct('exo_det',0,'exo_id',1,'multiplicative',0,'periods',1:6,'value',de) ];
M_.exo_det_length = 0;
options_.periods = 100;
perfect_foresight_setup;
perfect_foresight_solver;
t = [2019.75:0.25:2021]'; 
figure
plot(t,oo_.endo_simul(2,1:length(de)),'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
xlim([min( t ) max( t )])
ylim([min( dy )*1.2 max( dy )*1.1])
xlabel('Covid crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthWest')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\2nd Round\figure11', 'jpg');
hold off;
save('mex_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('mex_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('mex_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('mex_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('mex_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('mex_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('mex_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
disp('Note: 3 warning(s) encountered in the preprocessor')
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
