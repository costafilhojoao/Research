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
    T = mex.static_resid_tt(T, y, x, params);
end
residual = zeros(12, 1);
lhs = T(10)*y(3);
rhs = y(3)*T(10)*(1+T(9))+T(9)*y(5)-T(5)*y(1)+T(12)*y(4)+T(11)*y(7)+T(7)*y(9)+y(8);
residual(1) = lhs - rhs;
lhs = y(1);
rhs = params(6)*y(8)+(1-params(6))*params(5)*y(6)+(1-params(6))*(1-params(5))*y(10);
residual(2) = lhs - rhs;
lhs = y(9);
rhs = y(9)*params(9)+x(1);
residual(3) = lhs - rhs;
lhs = y(6);
rhs = T(11)*y(7)+y(6)*(1-params(3));
residual(4) = lhs - rhs;
lhs = y(12);
rhs = y(12)+y(5)*params(1)*T(9);
residual(5) = lhs - rhs;
lhs = y(12)*T(17);
rhs = T(12)*y(4)-T(16)*y(10);
residual(6) = lhs - rhs;
lhs = (1-params(6))*(1-params(5))*T(5)*y(1);
rhs = y(10)*params(7)*T(16);
residual(7) = lhs - rhs;
lhs = y(12)*T(14);
rhs = params(1)*(y(12)*T(14)*(1-params(3)+(1-params(6))*params(5)*T(5)/T(6))+T(18)*(y(1)-y(6)));
residual(8) = lhs - rhs;
lhs = params(6)*T(5)/T(7)*(y(1)-y(8));
rhs = y(9);
residual(9) = lhs - rhs;
lhs = T(8)*T(15)*y(11);
rhs = (T(11)+T(12))*y(2)-T(12)*y(4)-T(11)*y(7);
residual(10) = lhs - rhs;
lhs = T(9)*y(5);
rhs = y(3)*T(10)*params(8);
residual(11) = lhs - rhs;
lhs = T(8)*y(2);
rhs = T(5)*y(1)-T(7)*(y(1)+y(9));
residual(12) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
