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
    T = NK_Course.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(35, 1);
lhs = y(7);
rhs = (T(3)^(1-params(8))-1)/(1-params(8));
residual(1) = lhs - rhs;
lhs = y(8);
rhs = T(4)*T(5);
residual(2) = lhs - rhs;
lhs = y(8);
rhs = params(6)*y(42);
residual(3) = lhs - rhs;
lhs = y(23);
rhs = y(8)*y(6)/y(31);
residual(4) = lhs - rhs;
lhs = T(8)/y(8);
rhs = y(11);
residual(5) = lhs - rhs;
lhs = y(13);
rhs = (1-params(4))*y(12);
residual(6) = lhs - rhs;
lhs = y(12);
rhs = T(9)*T(10);
residual(7) = lhs - rhs;
lhs = y(14)*y(12)*params(3)/y(10);
rhs = y(11);
residual(8) = lhs - rhs;
lhs = y(13);
rhs = y(18)+y(20)+y(16);
residual(9) = lhs - rhs;
lhs = y(21);
rhs = y(16)/y(3);
residual(10) = lhs - rhs;
lhs = y(15);
rhs = y(16)*T(11)+y(2)*(1-params(7));
residual(11) = lhs - rhs;
lhs = y(24);
rhs = y(21)*(y(21)-1)*params(12)*2.0*y(22)/y(1);
residual(12) = lhs - rhs;
lhs = y(22)*(T(11)-(y(21)-1)*params(12)*y(21)*2.0)+y(43);
rhs = 1;
residual(13) = lhs - rhs;
lhs = y(33);
rhs = T(12);
residual(14) = lhs - rhs;
lhs = y(9);
rhs = y(6)*y(33);
residual(15) = lhs - rhs;
lhs = y(25);
rhs = y(12)*(1-params(3))*y(14)/y(2)+(1-params(7))*y(22);
residual(16) = lhs - rhs;
lhs = y(32)*y(47);
rhs = y(44)/y(22);
residual(17) = lhs - rhs;
lhs = y(20);
rhs = y(10)*y(11)*y(17);
residual(18) = lhs - rhs;
lhs = y(27)-params(6)*params(13)*y(45);
rhs = y(8)*y(13);
residual(19) = lhs - rhs;
lhs = y(29)-params(6)*params(13)*y(46);
rhs = y(8)*T(14)*y(26);
residual(20) = lhs - rhs;
lhs = y(28);
rhs = y(27)*T(15);
residual(21) = lhs - rhs;
lhs = y(30);
rhs = y(29)*T(16);
residual(22) = lhs - rhs;
lhs = 1;
rhs = params(13)*T(15)+(1-params(13))*(y(29)/y(27))^(1-params(5));
residual(23) = lhs - rhs;
lhs = y(26);
rhs = y(14);
residual(24) = lhs - rhs;
lhs = log(T(17));
rhs = params(14)*log(T(18))+params(15)*log(y(31))+x(it_, 3);
residual(25) = lhs - rhs;
lhs = log(y(19))-log((steady_state(13)));
rhs = params(9)*(log(y(4))-log((steady_state(13))))+x(it_, 1);
residual(26) = lhs - rhs;
lhs = log(y(20))-log((steady_state(14)));
rhs = params(10)*(log(y(5))-log((steady_state(14))))+x(it_, 2);
residual(27) = lhs - rhs;
lhs = y(36);
rhs = y(13)/(steady_state(7));
residual(28) = lhs - rhs;
lhs = y(41);
rhs = y(15)/(steady_state(9));
residual(29) = lhs - rhs;
lhs = y(40);
rhs = y(16)/(steady_state(10));
residual(30) = lhs - rhs;
lhs = y(37);
rhs = y(18)/(steady_state(12));
residual(31) = lhs - rhs;
lhs = y(39);
rhs = y(11)/(steady_state(5));
residual(32) = lhs - rhs;
lhs = y(38);
rhs = y(10)/(steady_state(4));
residual(33) = lhs - rhs;
lhs = y(34);
rhs = y(9)/(steady_state(3));
residual(34) = lhs - rhs;
lhs = y(35);
rhs = T(17);
residual(35) = lhs - rhs;

end
