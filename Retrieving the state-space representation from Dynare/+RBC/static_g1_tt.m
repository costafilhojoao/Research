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

assert(length(T) >= 8);

T = RBC.static_resid_tt(T, y, x, params);

T(5) = params(1)*exp(y(4))*exp(y(3))*getPowerDeriv(exp(y(3)),params(1)-1,1);
T(6) = exp(y(3))*getPowerDeriv(exp(y(3)),params(1),1);
T(7) = exp(y(4))*T(6);
T(8) = exp(y(5))*getPowerDeriv(exp(y(5)),(-params(5)),1);

end
