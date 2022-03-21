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
M_.fname = 'mex_GHH_covid';
M_.dynare_version = '4.6.0';
oo_.dynare_version = '4.6.0';
options_.dynare_version = '4.6.0';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('mex_GHH_covid.log');
M_.exo_names = cell(1,1);
M_.exo_names_tex = cell(1,1);
M_.exo_names_long = cell(1,1);
M_.exo_names(1) = {'ee'};
M_.exo_names_tex(1) = {'ee'};
M_.exo_names_long(1) = {'real exchange rate shock'};
M_.endo_names = cell(11,1);
M_.endo_names_tex = cell(11,1);
M_.endo_names_long = cell(11,1);
M_.endo_names(1) = {'y'};
M_.endo_names_tex(1) = {'{\hat y}'};
M_.endo_names_long(1) = {'output deviation from steady state'};
M_.endo_names(2) = {'d'};
M_.endo_names_tex(2) = {'{\hat d}'};
M_.endo_names_long(2) = {'foreign debt deviation from steady state'};
M_.endo_names(3) = {'c'};
M_.endo_names_tex(3) = {'{\hat c}'};
M_.endo_names_long(3) = {'conusmption deviation from steady state'};
M_.endo_names(4) = {'r'};
M_.endo_names_tex(4) = {'{\hat r}'};
M_.endo_names_long(4) = {'real interest rate deviation from steady state'};
M_.endo_names(5) = {'k'};
M_.endo_names_tex(5) = {'{\hat k}'};
M_.endo_names_long(5) = {'capital deviation from steady state'};
M_.endo_names(6) = {'x'};
M_.endo_names_tex(6) = {'{\hat x}'};
M_.endo_names_long(6) = {'investment deviation from steady state'};
M_.endo_names(7) = {'m'};
M_.endo_names_tex(7) = {'{\hat m}'};
M_.endo_names_long(7) = {'intermediates goods imports deviation from steady state'};
M_.endo_names(8) = {'e'};
M_.endo_names_tex(8) = {'{\hat e}'};
M_.endo_names_long(8) = {'real exchange rate deviation from steady state'};
M_.endo_names(9) = {'l'};
M_.endo_names_tex(9) = {'{\hat l}'};
M_.endo_names_long(9) = {'hours of work deviation from steady state'};
M_.endo_names(10) = {'tby'};
M_.endo_names_tex(10) = {'{\hat tby}'};
M_.endo_names_long(10) = {'trade balance / GDP deviation from steady state'};
M_.endo_names(11) = {'lambda'};
M_.endo_names_tex(11) = {'{\lambda}'};
M_.endo_names_long(11) = {'Lagrange multiplier deviation from steady state'};
M_.endo_partitions = struct();
M_.param_names = cell(23,1);
M_.param_names_tex = cell(23,1);
M_.param_names_long = cell(23,1);
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
M_.param_names(10) = {'rbar'};
M_.param_names_tex(10) = {'rbar'};
M_.param_names_long(10) = {'rbar'};
M_.param_names(11) = {'dbar'};
M_.param_names_tex(11) = {'dbar'};
M_.param_names_long(11) = {'dbar'};
M_.param_names(12) = {'cons1'};
M_.param_names_tex(12) = {'cons1'};
M_.param_names_long(12) = {'cons1'};
M_.param_names(13) = {'cons2'};
M_.param_names_tex(13) = {'cons2'};
M_.param_names_long(13) = {'cons2'};
M_.param_names(14) = {'cons3'};
M_.param_names_tex(14) = {'cons3'};
M_.param_names_long(14) = {'cons3'};
M_.param_names(15) = {'cons4'};
M_.param_names_tex(15) = {'cons4'};
M_.param_names_long(15) = {'cons4'};
M_.param_names(16) = {'ybar'};
M_.param_names_tex(16) = {'ybar'};
M_.param_names_long(16) = {'ybar'};
M_.param_names(17) = {'lbar'};
M_.param_names_tex(17) = {'lbar'};
M_.param_names_long(17) = {'lbar'};
M_.param_names(18) = {'kbar'};
M_.param_names_tex(18) = {'kbar'};
M_.param_names_long(18) = {'kbar'};
M_.param_names(19) = {'mbar'};
M_.param_names_tex(19) = {'mbar'};
M_.param_names_long(19) = {'mbar'};
M_.param_names(20) = {'xbar'};
M_.param_names_tex(20) = {'xbar'};
M_.param_names_long(20) = {'xbar'};
M_.param_names(21) = {'cbar'};
M_.param_names_tex(21) = {'cbar'};
M_.param_names_long(21) = {'cbar'};
M_.param_names(22) = {'tbybar'};
M_.param_names_tex(22) = {'tbybar'};
M_.param_names_long(22) = {'tbybar'};
M_.param_names(23) = {'lambdabar'};
M_.param_names_tex(23) = {'lambdabar'};
M_.param_names_long(23) = {'lambdabar'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 11;
M_.param_nbr = 23;
M_.orig_endo_nbr = 11;
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
M_.orig_eq_nbr = 11;
M_.eq_nbr = 11;
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
 0 5 16;
 1 6 0;
 0 7 0;
 2 8 0;
 3 9 17;
 0 10 0;
 0 11 0;
 4 12 0;
 0 13 0;
 0 14 0;
 0 15 18;]';
M_.nstatic = 5;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 1;
M_.nsfwrd   = 3;
M_.nspred   = 4;
M_.ndynamic   = 6;
M_.dynamic_tmp_nbr = [3; 0; 0; 0; ];
M_.equations_tags = {
  1 , 'name' , '1' ;
  2 , 'name' , 'y' ;
  3 , 'name' , 'e' ;
  4 , 'name' , 'k' ;
  5 , 'name' , 'lambda' ;
  6 , 'name' , '6' ;
  7 , 'name' , '7' ;
  8 , 'name' , '8' ;
  9 , 'name' , '9' ;
  10 , 'name' , '10' ;
  11 , 'name' , '11' ;
};
M_.mapping.y.eqidx = [1 2 7 8 9 10 ];
M_.mapping.d.eqidx = [1 11 ];
M_.mapping.c.eqidx = [1 6 10 ];
M_.mapping.r.eqidx = [1 5 11 ];
M_.mapping.k.eqidx = [2 4 8 ];
M_.mapping.x.eqidx = [1 4 10 ];
M_.mapping.m.eqidx = [1 2 9 10 ];
M_.mapping.e.eqidx = [1 3 9 10 ];
M_.mapping.l.eqidx = [2 6 7 ];
M_.mapping.tby.eqidx = [10 ];
M_.mapping.lambda.eqidx = [5 6 8 ];
M_.mapping.ee.eqidx = [3 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [2 4 5 8 ];
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(11, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(23, 1);
M_.endo_trends = struct('deflator', cell(11, 1), 'log_deflator', cell(11, 1), 'growth_factor', cell(11, 1), 'log_growth_factor', cell(11, 1));
M_.NNZDerivatives = [42; -1; -1; ];
M_.static_tmp_nbr = [3; 0; 0; 0; ];
close all;
de = xlsread('data','Sheet1',['C','104',':','C','109']);   
dy = xlsread('data','Sheet1',['D','104',':','D','109']);   
M_.params(1) = 0.98;
beta = M_.params(1);
M_.params(2) = 2;
gamma = M_.params(2);
M_.params(3) = 0.1;
delta = M_.params(3);
M_.params(4) = 0.028;
phi = M_.params(4);
M_.params(5) = 0.4;
alpha = M_.params(5);
M_.params(6) = 0.1;
mu = M_.params(6);
M_.params(7) = 1.455;
omega = M_.params(7);
M_.params(9) = 0.73;
rhoe = M_.params(9);
M_.params(8) = 0.000742;
psi = M_.params(8);
M_.params(11) = 0.7442;
dbar = M_.params(11);
M_.params(10) = 1/M_.params(1)-1;
rbar = M_.params(10);
M_.params(12) = M_.params(6)^M_.params(6);
cons1 = M_.params(12);
M_.params(13) = ((1/M_.params(1)-1+M_.params(3))^(-1)*(1-M_.params(6))*M_.params(5))^M_.params(5);
cons2 = M_.params(13);
M_.params(14) = ((((1-M_.params(6))*(1-M_.params(5)))^(1/M_.params(7)))^(1-M_.params(5)))^(1-M_.params(6));
cons3 = M_.params(14);
M_.params(15) = 1/(1-M_.params(6)-(1-M_.params(6))*M_.params(5)-(1-M_.params(6))*(1-M_.params(5))/M_.params(7));
cons4 = M_.params(15);
M_.params(16) = (M_.params(12)*M_.params(13)*M_.params(14))^(1/M_.params(15));
ybar = M_.params(16);
M_.params(17) = ((1-M_.params(6))*(1-M_.params(5))*M_.params(16))^(1/M_.params(7));
lbar = M_.params(17);
M_.params(18) = (1-M_.params(6))*M_.params(5)*M_.params(16)*(1/M_.params(1)+M_.params(3)-1)^(-1);
kbar = M_.params(18);
M_.params(19) = M_.params(6)*M_.params(16);
mbar = M_.params(19);
M_.params(20) = M_.params(3)*M_.params(18);
xbar = M_.params(20);
M_.params(21) = M_.params(16)-M_.params(10)*M_.params(11)-M_.params(20)+M_.params(19);
cbar = M_.params(21);
M_.params(22) = 1-(M_.params(19)+M_.params(20)+M_.params(21))/M_.params(16);
tbybar = M_.params(22);
M_.params(23) = (M_.params(21)-M_.params(7)^(-1)*M_.params(17)^M_.params(7))^(-M_.params(2));
lambdabar = M_.params(23);
%
% SHOCKS instructions
%
M_.det_shocks = [ M_.det_shocks;
struct('exo_det',0,'exo_id',1,'multiplicative',0,'periods',1:6,'value',de) ];
M_.exo_det_length = 0;
steady;
options_.periods = 6;
perfect_foresight_setup;
perfect_foresight_solver;
t = [2019.75:0.25:2021]'; 
plot(t,oo_.endo_simul(1,1:6)*100,'k--','Linewidth',3); hold on;
plot(t,dy,'k-','Linewidth',3); 
axis("square")
xlabel('Covid crisis')
ylabel('%')
legend('Model','Data', 'Location', 'SouthEast')
saveas(gcf, 'G:\Meu Drive\Documents\Papers\Acadêmicos\Working Papers\Accounting for Mexican Business Cycles\Submissions\2021 1 Macroeconomic Dynamics\2. R & R\1st Round\figure20', 'jpg');
hold off;
save('mex_GHH_covid_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('mex_GHH_covid_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('mex_GHH_covid_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('mex_GHH_covid_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('mex_GHH_covid_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('mex_GHH_covid_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('mex_GHH_covid_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
disp('Note: 1 warning(s) encountered in the preprocessor')
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
