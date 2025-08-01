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

assert(length(T) >= 35);

T = dynamic.static_resid_tt(T, y, x, params);

T(24) = getPowerDeriv(T(4),(-params(6)),1);
T(25) = T(24)*(-(getPowerDeriv(y(2),params(7),1)/params(7)));
T(26) = getPowerDeriv(y(18)/y(4),(-params(15)),1);
T(27) = (1-params(14))*(-y(18))/(y(4)*y(4))*T(26);
T(28) = getPowerDeriv(T(2),(-params(15)),1);
T(29) = params(14)*(-y(19))/(y(4)*y(4))*T(28);
T(30) = getPowerDeriv(y(7)/y(27),(-1),1);
T(31) = params(1)*getPowerDeriv(y(12)*params(1),(-1)/(params(2)-1),1);
T(32) = 1/y(4);
T(33) = (1-params(14))*T(26)*T(32);
T(34) = getPowerDeriv(T(7),1/(1-params(15)),1);
T(35) = getPowerDeriv(T(11),params(15)/(params(15)-1),1);

end
