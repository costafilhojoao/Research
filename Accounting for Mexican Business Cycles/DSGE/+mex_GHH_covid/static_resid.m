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
    T = mex_GHH_covid.static_resid_tt(T, y, x, params);
end
residual = zeros(11, 1);
lhs = params(11)*y(2);
rhs = y(2)*params(11)*(1+params(10))+params(10)*y(4)-params(16)*y(1)+params(21)*y(3)+params(20)*y(6)+params(19)*y(8)+y(7);
residual(1) = lhs - rhs;
lhs = y(1);
rhs = y(7)*params(6)+(1-params(6))*params(5)*y(5)+(1-params(6))*(1-params(5))*y(9);
residual(2) = lhs - rhs;
lhs = y(8);
rhs = y(8)*params(9)+x(1);
residual(3) = lhs - rhs;
lhs = y(5);
rhs = y(6)*params(3)+y(5)*(1-params(3));
residual(4) = lhs - rhs;
lhs = y(11);
rhs = y(11)+y(4)*params(10)*params(1);
residual(5) = lhs - rhs;
lhs = y(11)*T(1);
rhs = params(21)*y(3)-y(9)*T(2);
residual(6) = lhs - rhs;
lhs = y(1)*params(16)*(1-params(6))*(1-params(5));
rhs = y(9)*params(7)*T(2);
residual(7) = lhs - rhs;
lhs = y(11)*params(23);
rhs = params(1)*(y(11)*params(23)*(1-params(3)+(1-params(6))*params(5)*params(16)/params(18))+T(3)*(y(1)-y(5)));
residual(8) = lhs - rhs;
lhs = params(6)*params(16)/params(19)*(y(1)-y(7));
rhs = y(8);
residual(9) = lhs - rhs;
lhs = params(16)*params(22)*y(10);
rhs = params(19)*y(8)+params(20)*y(6)-params(21)*y(3)+params(19)*y(7)-y(1)*(params(21)-params(20)-params(19));
residual(10) = lhs - rhs;
lhs = params(10)*y(4);
rhs = y(2)*params(11)*params(8);
residual(11) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
