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
    T = mex_GHH.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(11, 1);
lhs = params(11)*y(6);
rhs = params(11)*(1+params(10))*y(1)+params(10)*y(2)-params(16)*y(5)+params(21)*y(7)+params(20)*y(10)+params(19)*y(12)+y(11);
residual(1) = lhs - rhs;
lhs = y(5);
rhs = y(11)*params(6)+(1-params(6))*params(5)*y(3)+(1-params(6))*(1-params(5))*y(13);
residual(2) = lhs - rhs;
lhs = y(12);
rhs = params(9)*y(4)+x(it_, 1);
residual(3) = lhs - rhs;
lhs = y(9);
rhs = y(10)*params(3)+y(3)*(1-params(3));
residual(4) = lhs - rhs;
lhs = y(15);
rhs = y(18)+params(10)*params(1)*y(8);
residual(5) = lhs - rhs;
lhs = y(15)*T(1);
rhs = params(21)*y(7)-y(13)*T(2);
residual(6) = lhs - rhs;
lhs = y(5)*params(16)*(1-params(6))*(1-params(5));
rhs = y(13)*params(7)*T(2);
residual(7) = lhs - rhs;
lhs = y(15)*params(23);
rhs = params(1)*(y(18)*params(23)*(1-params(3)+(1-params(6))*params(5)*params(16)/params(18))+params(23)*params(18)*params(4)*(y(17)-y(9))+T(3)*(y(16)-y(9)));
residual(8) = lhs - rhs;
lhs = params(6)*params(16)/params(19)*(y(5)-y(11));
rhs = y(12);
residual(9) = lhs - rhs;
lhs = params(16)*params(22)*y(14);
rhs = params(19)*y(12)+params(20)*y(10)-params(21)*y(7)+params(19)*y(11)-y(5)*(params(21)-params(20)-params(19));
residual(10) = lhs - rhs;
lhs = params(10)*y(8);
rhs = y(6)*params(11)*params(8);
residual(11) = lhs - rhs;

end
