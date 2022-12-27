function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = mex.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(12, 1);
lhs = T(10)*y(7);
rhs = T(10)*(1+T(9))*y(1)+T(9)*y(2)-T(5)*y(5)+T(12)*y(8)+T(11)*y(11)+T(7)*y(13)+y(12);
residual(1) = lhs - rhs;
lhs = y(5);
rhs = params(6)*y(12)+(1-params(6))*params(5)*y(3)+(1-params(6))*(1-params(5))*y(14);
residual(2) = lhs - rhs;
lhs = y(13);
rhs = params(9)*y(4)+x(it_, 1);
residual(3) = lhs - rhs;
lhs = y(10);
rhs = T(11)*y(11)+y(3)*(1-params(3));
residual(4) = lhs - rhs;
lhs = y(16);
rhs = y(19)+params(1)*T(9)*y(9);
residual(5) = lhs - rhs;
lhs = y(16)*T(17);
rhs = T(12)*y(8)-T(16)*y(14);
residual(6) = lhs - rhs;
lhs = (1-params(6))*(1-params(5))*T(5)*y(5);
rhs = y(14)*params(7)*T(16);
residual(7) = lhs - rhs;
lhs = y(16)*T(14);
rhs = params(1)*(y(19)*T(14)*(1-params(3)+(1-params(6))*params(5)*T(5)/T(6))+T(6)*T(14)*params(4)*(y(18)-y(10))+T(18)*(y(17)-y(10)));
residual(8) = lhs - rhs;
lhs = params(6)*T(5)/T(7)*(y(5)-y(12));
rhs = y(13);
residual(9) = lhs - rhs;
lhs = T(8)*T(15)*y(15);
rhs = (T(11)+T(12))*y(6)-T(12)*y(8)-T(11)*y(11);
residual(10) = lhs - rhs;
lhs = T(9)*y(9);
rhs = y(7)*T(10)*params(8);
residual(11) = lhs - rhs;
lhs = T(8)*y(6);
rhs = T(5)*y(5)-T(7)*(y(5)+y(13));
residual(12) = lhs - rhs;

end
