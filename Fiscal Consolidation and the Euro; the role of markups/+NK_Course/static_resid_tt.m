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

assert(length(T) >= 15);

T(1) = y(12)^(1-params(2));
T(2) = (1-y(4))^params(2);
T(3) = T(1)*T(2);
T(4) = (1-params(2))*y(12)^((1-params(2))*(1-params(8))-1);
T(5) = (1-y(4))^(params(2)*(1-params(8)));
T(6) = params(2)*y(12)^((1-params(2))*(1-params(8)));
T(7) = (1-y(4))^(params(2)*(1-params(8))-1);
T(8) = T(6)*T(7);
T(9) = (y(4)*y(13))^params(3);
T(10) = y(9)^(1-params(3));
T(11) = 1-params(12)*(y(15)-1)^2.0;
T(12) = 1/(1-1/params(5));
T(13) = y(7)*T(12);
T(14) = y(25)^(params(5)-1);
T(15) = y(25)^params(5);

end
