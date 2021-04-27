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
    T = model3.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(22, 1);
lhs = T(2);
rhs = y(12)*y(11);
residual(1) = lhs - rhs;
lhs = T(2)*T(3);
rhs = y(12)*y(13);
residual(2) = lhs - rhs;
lhs = y(28)*(1+y(27));
rhs = y(12)*(1+params(8));
residual(3) = lhs - rhs;
lhs = y(28)-y(6);
rhs = x(it_, 5);
residual(4) = lhs - rhs;
lhs = y(14);
rhs = (1+y(5))*y(1)+y(10)*y(13)+y(15)-y(16)-y(9)*y(11);
residual(5) = lhs - rhs;
lhs = y(11)*y(17);
rhs = y(16);
residual(6) = lhs - rhs;
lhs = log(y(17));
rhs = (1-params(10))*log((steady_state(9)))+params(10)*log(y(2))+x(it_, 2);
residual(7) = lhs - rhs;
lhs = y(26);
rhs = x(it_, 3);
residual(8) = lhs - rhs;
lhs = y(27);
rhs = params(8)+x(it_, 4);
residual(9) = lhs - rhs;
residual(10) = (params(2)-1)/params(2)*y(18)-y(19)+params(4)*y(20);
lhs = T(4)*y(31)*y(30)/y(22)-(1-params(5))*y(29);
rhs = (1+params(8))*y(7);
residual(11) = lhs - rhs;
lhs = y(29)-y(7);
rhs = x(it_, 6);
residual(12) = lhs - rhs;
lhs = y(30)-y(8);
rhs = x(it_, 7);
residual(13) = lhs - rhs;
lhs = y(19);
rhs = y(13)/T(5)*T(6);
residual(14) = lhs - rhs;
lhs = y(24);
rhs = y(18)/y(19);
residual(15) = lhs - rhs;
lhs = y(22);
rhs = params(4)*y(21)+(1-params(5))*y(3);
residual(16) = lhs - rhs;
lhs = log(y(23));
rhs = (1-params(9))*log((steady_state(15)))+params(9)*log(y(4))+x(it_, 1);
residual(17) = lhs - rhs;
lhs = y(11);
rhs = y(18)*T(7);
residual(18) = lhs - rhs;
lhs = y(25);
rhs = T(9)*T(10);
residual(19) = lhs - rhs;
lhs = y(25);
rhs = y(26)+y(9)+y(17);
residual(20) = lhs - rhs;
lhs = y(15);
rhs = y(11)*y(25)-y(10)*y(13);
residual(21) = lhs - rhs;
lhs = y(21);
rhs = T(7)*y(25);
residual(22) = lhs - rhs;

end
