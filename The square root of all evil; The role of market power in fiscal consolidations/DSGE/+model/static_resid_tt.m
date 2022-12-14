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

assert(length(T) >= 22);

T(1) = (1-params(14))*(y(22)/y(4))^(-params(15));
T(2) = y(23)/y(4);
T(3) = params(14)*T(2)^(-params(15));
T(4) = y(1)-y(2)^params(7)/params(7);
T(5) = T(4)^(-params(6));
T(6) = y(2)^(params(7)-1);
T(7) = (1-params(14))^(1/params(15));
T(8) = (params(15)-1)/params(15);
T(9) = params(14)^(1/params(15));
T(10) = T(7)*y(20)^T(8)+T(9)*y(21)^T(8);
T(11) = (1-params(14))*y(22)^(1-params(15))+params(14)*y(23)^(1-params(15));
T(12) = exp((y(6))/((y(4))*(y(8)))-y(6)/(y(4)*y(8)));
T(13) = y(22)^params(2);
T(14) = (1+params(8))^(-1);
T(15) = y(10)^(-params(2));
T(16) = y(18)*T(15);
T(17) = (1-params(3))*y(31)^(1/(1-params(3)));
T(18) = y(7)^(params(3)/(1-params(3)));
T(19) = (params(1)*y(15))^((-1)/(params(2)-1));
T(20) = (params(1)*y(15))^(1/(params(2)-1));
T(21) = y(31)*T(20);
T(22) = y(2)^(1-params(3));

end
