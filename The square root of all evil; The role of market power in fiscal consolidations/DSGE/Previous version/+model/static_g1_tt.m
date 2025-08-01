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

assert(length(T) >= 32);

T = model.static_resid_tt(T, y, x, params);

T(23) = getPowerDeriv(T(4),(-params(6)),1);
T(24) = T(23)*(-(getPowerDeriv(y(2),params(7),1)/params(7)));
T(25) = getPowerDeriv(y(22)/y(4),(-params(15)),1);
T(26) = (1-params(14))*(-y(22))/(y(4)*y(4))*T(25);
T(27) = getPowerDeriv(T(2),(-params(15)),1);
T(28) = params(14)*(-y(23))/(y(4)*y(4))*T(27);
T(29) = params(1)*getPowerDeriv(params(1)*y(15),(-1)/(params(2)-1),1);
T(30) = getPowerDeriv(T(10),params(15)/(params(15)-1),1);
T(31) = (1-params(14))*T(25)*1/y(4);
T(32) = getPowerDeriv(T(11),1/(1-params(15)),1);

end
