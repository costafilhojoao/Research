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

assert(length(T) >= 31);

T(1) = y(2)^(1-params(14));
T(2) = y(3)^params(14);
T(3) = 1/(params(12)*params(14)^params(14)*(1-params(14))^(1-params(14)));
T(4) = T(3)*y(4)^params(14);
T(5) = y(5)^(1-params(14));
T(6) = y(3)^(params(14)-1);
T(7) = params(12)*params(14)*y(27)*T(6);
T(8) = params(13)/2;
T(9) = y(15)*y(9)*y(31)*y(14)*params(5)*y(33)+y(12)*y(9)*y(32)*y(11)*params(6)*y(34)+(1-y(50))*y(9)*params(7);
T(10) = params(4)/(params(4)-1);
T(11) = params(10)*params(1)*(y(26)*y(47))^T(10);
T(12) = 1/(params(4)-1);
T(13) = params(10)*params(1)*(y(26)*y(47))^T(12);
T(14) = (1-params(1)*y(26)^T(12))/(1-params(1));
T(15) = T(14)^(-(params(4)-1));
T(16) = params(1)*y(26)^T(10);
T(17) = log(y(14))-T(8)*y(11)^2;
T(18) = log(y(15))-T(8)*y(12)^2;
T(19) = log(y(16))-T(8)*y(13)^2;
T(20) = y(54)^(1-params(14));
T(21) = y(55)^params(14);
T(22) = T(3)*y(56)^params(14);
T(23) = y(57)^(1-params(14));
T(24) = y(55)^(params(14)-1);
T(25) = params(12)*params(14)*y(79)*T(24);
T(26) = y(67)*y(61)*y(83)*params(5)*y(66)*y(85)+y(64)*y(61)*y(84)*params(6)*y(63)*y(86)+(1-y(50))*params(7)*y(61);
T(27) = params(10)*params(20)*(y(78)*y(99))^T(10);
T(28) = params(10)*params(20)*(y(78)*y(99))^T(12);
T(29) = (1-params(20)*y(78)^T(12))/(1-params(20));
T(30) = T(29)^(-(params(4)-1));
T(31) = params(20)*y(78)^T(10);

end
