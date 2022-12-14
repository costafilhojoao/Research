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
    T = model.static_resid_tt(T, y, x, params);
end
residual = zeros(33, 1);
lhs = y(20);
rhs = T(1)*y(1);
residual(1) = lhs - rhs;
lhs = y(21);
rhs = y(1)*T(3);
residual(2) = lhs - rhs;
lhs = T(5);
rhs = y(4)*y(3);
residual(3) = lhs - rhs;
lhs = T(5)*T(6);
rhs = y(3)*y(5);
residual(4) = lhs - rhs;
lhs = y(3)*(1+y(33));
rhs = y(3)*(1+params(8));
residual(5) = lhs - rhs;
lhs = y(6);
rhs = (1+y(33))*y(6)+y(2)*y(5)+y(9)-y(30)-y(4)*y(1);
residual(6) = lhs - rhs;
lhs = y(1);
rhs = T(10)^(params(15)/(params(15)-1));
residual(7) = lhs - rhs;
lhs = y(4);
rhs = T(11)^(1/(1-params(15)));
residual(8) = lhs - rhs;
lhs = y(4)*y(29);
rhs = y(30);
residual(9) = lhs - rhs;
lhs = log(y(29));
rhs = (1-params(10))*log((y(29)))+log(y(29))*params(10)+x(2);
residual(10) = lhs - rhs;
lhs = y(24);
rhs = T(1)*y(29);
residual(11) = lhs - rhs;
lhs = y(25);
rhs = T(3)*y(29);
residual(12) = lhs - rhs;
lhs = y(33);
rhs = (1-params(11))*(y(33))+y(33)*params(11)+params(13)*(T(12)-1)+x(3);
residual(13) = lhs - rhs;
lhs = log(y(23));
rhs = (1-params(12))*log((y(23)))+log(y(23))*params(12)+x(4);
residual(14) = lhs - rhs;
residual(15) = y(26);
lhs = y(27);
rhs = T(1)*y(26);
residual(16) = lhs - rhs;
lhs = y(28);
rhs = T(3)*y(26);
residual(17) = lhs - rhs;
lhs = y(19);
rhs = y(27)+y(20)+y(24)+y(32);
residual(18) = lhs - rhs;
lhs = y(18);
rhs = y(19)*params(1)*T(13);
residual(19) = lhs - rhs;
residual(20) = y(10)*(y(16)+y(7))-y(11)*y(8)*y(4)*params(16)*(y(11)-1)-params(2)*y(7)*y(17);
residual(21) = y(10)*y(16)-T(14)*(y(10)*(y(16)+y(7))-params(2)*y(7)*y(17));
residual(22) = y(13)-T(14)*(y(13)*(1-params(5))+y(17)*T(16));
lhs = y(12);
rhs = y(5)/T(17)*T(18);
residual(23) = lhs - rhs;
lhs = y(14);
rhs = y(10)/y(12);
residual(24) = lhs - rhs;
lhs = y(15);
rhs = y(7)*params(4)+(1-params(5))*y(15);
residual(25) = lhs - rhs;
lhs = log(y(31));
rhs = (1-params(9))*log((y(31)))+log(y(31))*params(9)+x(1);
residual(26) = lhs - rhs;
lhs = y(17);
rhs = y(10)-y(12)+y(13)*params(4);
residual(27) = lhs - rhs;
lhs = y(10);
rhs = y(10)*y(11);
residual(28) = lhs - rhs;
lhs = y(22);
rhs = y(10)*T(19);
residual(29) = lhs - rhs;
lhs = y(8);
rhs = T(21)*T(22);
residual(30) = lhs - rhs;
lhs = y(8);
rhs = y(1)+y(29)+y(22)*y(32)/y(4)-T(2)*(y(28)+y(21)+y(25));
residual(31) = lhs - rhs;
lhs = y(9);
rhs = y(4)*y(8)-y(2)*y(5);
residual(32) = lhs - rhs;
lhs = y(7);
rhs = y(8)*T(19);
residual(33) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
