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

assert(length(T) >= 31);

T = model12.static_resid_tt(T, y, x, params);

T(22) = getPowerDeriv(T(1),(-params(6)),1);
T(23) = T(22)*(-(getPowerDeriv(y(2),params(7),1)/params(7)));
T(24) = getPowerDeriv(y(17)/y(4),(-params(15)),1);
T(25) = (1-params(14))*(-y(17))/(y(4)*y(4))*T(24);
T(26) = getPowerDeriv(T(10),(-params(15)),1);
T(27) = params(14)*(-y(18))/(y(4)*y(4))*T(26);
T(28) = params(1)*getPowerDeriv(y(14)*params(1),(-1)/(params(2)-1),1);
T(29) = getPowerDeriv(T(7),T(8),1);
T(30) = (1-params(14))*T(24)*1/y(4);
T(31) = getPowerDeriv(T(12),T(8),1);

end
