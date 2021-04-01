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
residual = zeros(19, 1);
lhs = T(5);
rhs = y(9)*y(8);
residual(1) = lhs - rhs;
lhs = T(5)*T(6);
rhs = y(9)*y(10);
residual(2) = lhs - rhs;
lhs = y(25)*(1+y(24));
rhs = y(9)*(1+params(8));
residual(3) = lhs - rhs;
lhs = y(11);
rhs = (1+y(5))*y(1)+y(7)*y(10)+y(12)-y(13)-y(6)*y(8);
residual(4) = lhs - rhs;
lhs = y(8)*y(14);
rhs = y(13);
residual(5) = lhs - rhs;
lhs = log(y(14));
rhs = (1-params(10))*log(T(2))+params(10)*log(y(2))+x(it_, 2);
residual(6) = lhs - rhs;
lhs = y(23);
rhs = x(it_, 3);
residual(7) = lhs - rhs;
lhs = y(24);
rhs = params(8)+params(15)*(exp((-y(11)))-1);
residual(8) = lhs - rhs;
residual(9) = (params(2)-1)/params(2)*y(15)-y(16)+params(4)*y(17);
lhs = T(7)*y(26)*y(28)/y(19)-(1-params(5))*y(27);
rhs = (1+params(8))*y(17);
residual(10) = lhs - rhs;
lhs = y(16);
rhs = y(10)/T(8)*T(9);
residual(11) = lhs - rhs;
lhs = y(21);
rhs = y(15)/y(16);
residual(12) = lhs - rhs;
lhs = y(19);
rhs = params(4)*y(18)+(1-params(5))*y(3);
residual(13) = lhs - rhs;
lhs = log(y(20));
rhs = (1-params(9))*log(T(3))+params(9)*log(y(4))+x(it_, 1);
residual(14) = lhs - rhs;
lhs = y(8);
rhs = y(15)*T(10);
residual(15) = lhs - rhs;
lhs = y(22);
rhs = y(20)*T(11)*T(12);
residual(16) = lhs - rhs;
lhs = y(22);
rhs = y(23)+y(6)+y(14);
residual(17) = lhs - rhs;
lhs = y(12);
rhs = y(8)*y(22)-y(7)*y(10);
residual(18) = lhs - rhs;
lhs = y(18);
rhs = y(22)*T(11);
residual(19) = lhs - rhs;

end
