function T = static_g1_tt(T, y, x, params)
% function T = static_g1_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 40);

T = solve.static_resid_tt(T, y, x, params);

T(32) = getPowerDeriv(y(2),1-params(14),1);
T(33) = 1/params(10);
T(34) = getPowerDeriv(y(26)*y(47),T(10),1);
T(35) = getPowerDeriv(y(26)*y(47),T(12),1);
T(36) = (-(params(1)*getPowerDeriv(y(26),T(12),1)))/(1-params(1));
T(37) = getPowerDeriv(y(54),1-params(14),1);
T(38) = getPowerDeriv(y(78)*y(99),T(10),1);
T(39) = getPowerDeriv(y(78)*y(99),T(12),1);
T(40) = (-(params(20)*getPowerDeriv(y(78),T(12),1)))/(1-params(20));

end
