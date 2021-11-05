function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = model6a.static_resid_tt(T, y, x, params);
end
residual = zeros(34, 1);
lhs = T(2);
rhs = y(3)*y(4);
residual(1) = lhs - rhs;
lhs = T(2)*T(3);
rhs = y(3)*y(5);
residual(2) = lhs - rhs;
lhs = y(29)*(1+y(24));
rhs = y(3)*(1+params(8));
residual(3) = lhs - rhs;
lhs = 0;
rhs = x(4);
residual(4) = lhs - rhs;
lhs = y(6);
rhs = (1+y(24))*y(6)+y(2)*y(5)+y(9)-y(22)-y(1)*y(4);
residual(5) = lhs - rhs;
lhs = y(1);
rhs = T(7)^T(8);
residual(6) = lhs - rhs;
lhs = y(15);
rhs = y(1)*T(9);
residual(7) = lhs - rhs;
lhs = y(16);
rhs = y(1)*T(11);
residual(8) = lhs - rhs;
lhs = y(4);
rhs = T(12)^(1/(1-params(15)));
residual(9) = lhs - rhs;
lhs = y(4)*y(21);
rhs = y(22);
residual(10) = lhs - rhs;
lhs = log(y(21));
rhs = (1-params(10))*log((y(21)))+log(y(21))*params(10)+x(2);
residual(11) = lhs - rhs;
lhs = y(21);
rhs = T(13)^T(8);
residual(12) = lhs - rhs;
lhs = y(19);
rhs = T(9)*y(21);
residual(13) = lhs - rhs;
lhs = y(20);
rhs = T(11)*y(21);
residual(14) = lhs - rhs;
lhs = y(24);
rhs = (1-params(11))*(y(24))+y(24)*params(11)+params(13)*(exp((y(6))-y(6))-1)+x(3);
residual(15) = lhs - rhs;
residual(16) = y(26);
lhs = y(27);
rhs = T(9)*y(26);
residual(17) = lhs - rhs;
lhs = y(28);
rhs = T(11)*y(26);
residual(18) = lhs - rhs;
lhs = y(12)*params(4);
rhs = y(11)-y(10)*(params(2)-1)/params(2);
residual(19) = lhs - rhs;
lhs = (1+params(8))*y(12);
rhs = 1/params(2)*y(32)*y(31)/y(14)-T(15)/y(10)*y(34)*y(33)/y(14)-(1-params(5))*y(30);
residual(20) = lhs - rhs;
lhs = 0;
rhs = x(5);
residual(21) = lhs - rhs;
lhs = 0;
rhs = x(6);
residual(22) = lhs - rhs;
lhs = 0;
rhs = x(7);
residual(23) = lhs - rhs;
lhs = 0;
rhs = x(8);
residual(24) = lhs - rhs;
lhs = 0;
rhs = x(9);
residual(25) = lhs - rhs;
lhs = y(11);
rhs = y(5)/T(16)*T(17);
residual(26) = lhs - rhs;
lhs = y(13);
rhs = y(10)/y(11);
residual(27) = lhs - rhs;
lhs = y(14);
rhs = params(4)*y(7)+y(14)*(1-params(5));
residual(28) = lhs - rhs;
lhs = log(y(23));
rhs = (1-params(9))*log((y(23)))+log(y(23))*params(9)+x(1);
residual(29) = lhs - rhs;
lhs = y(17);
rhs = y(10)*T(18);
residual(30) = lhs - rhs;
lhs = y(8);
rhs = T(20)*T(21);
residual(31) = lhs - rhs;
lhs = y(8);
rhs = y(1)+y(21)+y(10)*y(25)/y(4)-T(10)*(y(28)+y(16)+y(20));
residual(32) = lhs - rhs;
lhs = y(9);
rhs = y(4)*y(8)-y(2)*y(5);
residual(33) = lhs - rhs;
lhs = y(7);
rhs = y(8)*T(18);
residual(34) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
