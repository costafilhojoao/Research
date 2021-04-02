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
    T = model2.static_resid_tt(T, y, x, params);
end
residual = zeros(19, 1);
lhs = T(4);
rhs = y(4)*y(3);
residual(1) = lhs - rhs;
lhs = T(4)*T(5);
rhs = y(4)*y(5);
residual(2) = lhs - rhs;
lhs = y(4)*(1+y(19));
rhs = y(4)*(1+params(8));
residual(3) = lhs - rhs;
lhs = y(6);
rhs = (1+y(19))*y(6)+y(2)*y(5)+y(7)-y(8)-y(1)*y(3);
residual(4) = lhs - rhs;
lhs = y(3)*y(9);
rhs = y(8);
residual(5) = lhs - rhs;
lhs = log(y(9));
rhs = (1-params(10))*log(T(1))+log(y(9))*params(10)+x(2);
residual(6) = lhs - rhs;
lhs = y(18);
rhs = x(3);
residual(7) = lhs - rhs;
lhs = y(19);
rhs = params(8)+x(4);
residual(8) = lhs - rhs;
residual(9) = (params(2)-1)/params(2)*y(10)-y(11)+params(4)*y(12);
lhs = T(6)*y(10)*y(13)/y(14)-y(12)*(1-params(5));
rhs = (1+params(8))*y(12);
residual(10) = lhs - rhs;
lhs = y(11);
rhs = y(5)/T(7)*T(8);
residual(11) = lhs - rhs;
lhs = y(16);
rhs = y(10)/y(11);
residual(12) = lhs - rhs;
lhs = y(14);
rhs = params(4)*y(13)+y(14)*(1-params(5));
residual(13) = lhs - rhs;
lhs = log(y(15));
rhs = (1-params(9))*log(T(2))+log(y(15))*params(9)+x(1);
residual(14) = lhs - rhs;
lhs = y(3);
rhs = y(10)*T(9);
residual(15) = lhs - rhs;
lhs = y(17);
rhs = y(15)*T(10)*T(11);
residual(16) = lhs - rhs;
lhs = y(17);
rhs = y(18)+y(1)+y(9);
residual(17) = lhs - rhs;
lhs = y(7);
rhs = y(3)*y(17)-y(2)*y(5);
residual(18) = lhs - rhs;
lhs = y(13);
rhs = y(17)*T(10);
residual(19) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
