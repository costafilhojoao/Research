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

assert(length(T) >= 37);

T = solve.static_resid_tt(T, y, x, params);

T(29) = getPowerDeriv(y(2),1-params(14),1);
T(30) = 1/params(10);
T(31) = getPowerDeriv(y(26)*y(47),T(10),1);
T(32) = getPowerDeriv(y(26)*y(47),T(12),1);
T(33) = (-(params(1)*getPowerDeriv(y(26),T(12),1)))/(1-params(1));
T(34) = getPowerDeriv(y(53),1-params(14),1);
T(35) = getPowerDeriv(y(77)*y(98),T(10),1);
T(36) = getPowerDeriv(y(77)*y(98),T(12),1);
T(37) = (-(params(20)*getPowerDeriv(y(77),T(12),1)))/(1-params(20));

end
