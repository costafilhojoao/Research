function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
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

assert(length(T) >= 9);

T(1) = params(63)/(1+params(63));
T(2) = (1-params(2)*(1-params(3)))^(-1);
T(3) = params(89)/(params(89)+params(90))*y(11)+params(90)/(params(89)+params(90))*y(10);
T(4) = (params(5)-params(6))*T(3);
T(5) = params(6)^(-1);
T(6) = params(63)*params(34)/(params(36)+params(37));
T(7) = params(64)*params(32)/(params(36)+params(37));
T(8) = params(63)*params(34)/(params(35)+params(38));
T(9) = params(64)*params(32)/(params(35)+params(38));

end
