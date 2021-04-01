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

assert(length(T) >= 12);

T(1) = params(5)/(params(4)*params(1));
T(2) = params(11)*T(1);
T(3) = 0.5764583341;
T(4) = y(1)-y(2)^params(7)/params(7);
T(5) = T(4)^(-params(6));
T(6) = y(2)^(params(7)-1);
T(7) = 1/params(2);
T(8) = (1-params(3))*y(15)^(1/(1-params(3)));
T(9) = y(13)^(params(3)/(1-params(3)));
T(10) = (params(1)*y(14))^((-1)/(params(2)-1));
T(11) = (params(1)*y(14))^(1/(params(2)-1));
T(12) = y(2)^(1-params(3));

end
