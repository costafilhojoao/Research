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

assert(length(T) >= 11);

T(1) = 0.0700991824330554;
T(2) = 0.576556784777983;
T(3) = y(1)-y(2)^params(7)/params(7);
T(4) = T(3)^(-params(6));
T(5) = y(2)^(params(7)-1);
T(6) = 1/params(2);
T(7) = (1-params(3))*y(15)^(1/(1-params(3)));
T(8) = y(13)^(params(3)/(1-params(3)));
T(9) = (y(14)*params(1))^((-1)/(params(2)-1));
T(10) = (y(14)*params(1))^(1/(params(2)-1));
T(11) = y(2)^(1-params(3));

end
