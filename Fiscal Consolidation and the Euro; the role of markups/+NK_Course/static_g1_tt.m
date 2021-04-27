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

assert(length(T) >= 22);

T = NK_Course.static_resid_tt(T, y, x, params);

T(16) = getPowerDeriv(T(3),1-params(8),1);
T(17) = getPowerDeriv(y(4)*y(13),params(3),1);
T(18) = 1/y(13)-1/(y(13));
T(19) = 1/y(14)-1/(y(14));
T(20) = getPowerDeriv(y(23)/y(21),1-params(5),1);
T(21) = getPowerDeriv(y(25),params(5)-1,1);
T(22) = ((y(26))-y(26))/((y(26))*(y(26)))/(y(26)/(y(26)));

end
