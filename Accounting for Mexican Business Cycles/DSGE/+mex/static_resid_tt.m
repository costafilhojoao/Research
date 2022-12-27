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

assert(length(T) >= 18);

T(1) = params(6)^params(6);
T(2) = ((1/params(1)-1+params(3))^(-1)*(1-params(6))*params(5))^((1-params(6))*params(5));
T(3) = ((1-params(6))*(1-params(5)))^((1-params(6))*(1-params(5))/params(7));
T(4) = 1/(1-((1-params(6))*(1-params(5))/params(7)+params(6)+(1-params(6))*params(5)));
T(5) = (T(1)*T(2)*T(3))^T(4);
T(6) = (1-params(6))*params(5)*T(5)*(1/params(1)+params(3)-1)^(-1);
T(7) = params(6)*T(5);
T(8) = T(5)-T(7);
T(9) = 1/params(1)-1;
T(10) = 0.02*T(8);
T(11) = params(3)*T(6);
T(12) = T(8)-T(9)*T(10)-T(11)-T(7);
T(13) = ((1-params(6))*(1-params(5))*T(5))^(1/params(7));
T(14) = (T(12)-params(7)^(-1)*T(13)^params(7))^(-params(2));
T(15) = 1-(T(7)+T(11)+T(12))/T(8);
T(16) = T(13)^params(7);
T(17) = (-(1/params(2)))*T(14)^(-(1/params(2)));
T(18) = params(5)*(1-params(6))*T(5)/T(6);

end
