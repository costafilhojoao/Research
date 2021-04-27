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

assert(length(T) >= 13);

T = model3.static_resid_tt(T, y, x, params);

T(11) = getPowerDeriv(T(1),(-params(6)),1);
T(12) = T(11)*(-(getPowerDeriv(y(2),params(7),1)/params(7)));
T(13) = params(1)*getPowerDeriv(y(14)*params(1),(-1)/(params(2)-1),1);

end
