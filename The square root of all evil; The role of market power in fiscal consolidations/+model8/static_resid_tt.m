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

assert(length(T) >= 21);

T(1) = y(1)-y(2)^params(7)/params(7);
T(2) = T(1)^(-params(6));
T(3) = y(2)^(params(7)-1);
T(4) = (1-params(14))^(1/params(15));
T(5) = (params(15)-1)/params(15);
T(6) = params(14)^(1/params(15));
T(7) = T(4)*y(15)^T(5)+T(6)*y(16)^T(5);
T(8) = params(15)/(params(15)-1);
T(9) = (1-params(14))*(y(17)/y(4))^(-params(15));
T(10) = y(18)/y(4);
T(11) = params(14)*T(10)^(-params(15));
T(12) = T(4)*y(19)^T(5)+T(6)*y(20)^T(5);
T(13) = exp((y(6))/((y(4))*(y(8)))-y(6)/(y(4)*y(8)));
T(14) = params(16)/params(2)*(y(32)/y(10)-1);
T(15) = y(32)*T(14);
T(16) = (1-params(3))*y(23)^(1/(1-params(3)));
T(17) = y(7)^(params(3)/(1-params(3)));
T(18) = (y(14)*params(1))^((-1)/(params(2)-1));
T(19) = (y(14)*params(1))^(1/(params(2)-1));
T(20) = y(23)*T(19);
T(21) = y(2)^(1-params(3));

end
