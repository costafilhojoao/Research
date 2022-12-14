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
    T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(33, 1);
lhs = y(27);
rhs = T(1)*y(8);
residual(1) = lhs - rhs;
lhs = y(28);
rhs = y(8)*T(3);
residual(2) = lhs - rhs;
lhs = T(5);
rhs = y(11)*y(10);
residual(3) = lhs - rhs;
lhs = T(5)*T(6);
rhs = y(10)*y(12);
residual(4) = lhs - rhs;
lhs = y(41)*(1+y(40));
rhs = y(10)*(1+params(8));
residual(5) = lhs - rhs;
lhs = y(13);
rhs = (1+y(7))*y(1)+y(9)*y(12)+y(16)-y(37)-y(11)*y(8);
residual(6) = lhs - rhs;
lhs = y(8);
rhs = T(10)^(params(15)/(params(15)-1));
residual(7) = lhs - rhs;
lhs = y(11);
rhs = T(11)^(1/(1-params(15)));
residual(8) = lhs - rhs;
lhs = y(11)*y(36);
rhs = y(37);
residual(9) = lhs - rhs;
lhs = log(y(36));
rhs = (1-params(10))*log((steady_state(29)))+params(10)*log(y(5))+x(it_, 2);
residual(10) = lhs - rhs;
lhs = y(31);
rhs = T(1)*y(36);
residual(11) = lhs - rhs;
lhs = y(32);
rhs = T(3)*y(36);
residual(12) = lhs - rhs;
lhs = y(40);
rhs = (1-params(11))*(steady_state(33))+y(7)*params(11)+params(13)*(T(12)-1)+x(it_, 3);
residual(13) = lhs - rhs;
lhs = log(y(30));
rhs = (1-params(12))*log((steady_state(23)))+params(12)*log(y(4))+x(it_, 4);
residual(14) = lhs - rhs;
lhs = y(33);
rhs = y(15)*y(11)*T(13);
residual(15) = lhs - rhs;
lhs = y(34);
rhs = T(1)*y(33);
residual(16) = lhs - rhs;
lhs = y(35);
rhs = T(3)*y(33);
residual(17) = lhs - rhs;
lhs = y(26);
rhs = y(34)+y(27)+y(31)+y(39);
residual(18) = lhs - rhs;
lhs = y(25);
rhs = y(26)*params(1)*T(14);
residual(19) = lhs - rhs;
residual(20) = y(17)*(y(23)+y(14))-y(18)*y(15)*y(11)*params(16)*(y(18)-1)-params(2)*y(14)*y(24);
residual(21) = y(17)*y(23)-T(15)*(y(43)*(y(42)+y(45))-params(2)*y(42)*y(46));
residual(22) = y(20)-T(15)*((1-params(5))*y(44)+y(46)*T(17));
lhs = y(19);
rhs = y(12)/T(18)*T(19);
residual(23) = lhs - rhs;
lhs = y(21);
rhs = y(17)/y(19);
residual(24) = lhs - rhs;
lhs = y(22);
rhs = y(14)*params(4)+(1-params(5))*y(3);
residual(25) = lhs - rhs;
lhs = log(y(38));
rhs = (1-params(9))*log((steady_state(31)))+params(9)*log(y(6))+x(it_, 1);
residual(26) = lhs - rhs;
lhs = y(24);
rhs = y(17)-y(19)+y(20)*params(4);
residual(27) = lhs - rhs;
lhs = y(17);
rhs = y(2)*y(18);
residual(28) = lhs - rhs;
lhs = y(29);
rhs = y(17)*T(20);
residual(29) = lhs - rhs;
lhs = y(15);
rhs = T(22)*T(23);
residual(30) = lhs - rhs;
lhs = y(15);
rhs = y(8)+y(36)+y(29)*y(39)/y(11)-T(2)*(y(35)+y(28)+y(32));
residual(31) = lhs - rhs;
lhs = y(16);
rhs = y(11)*y(15)-y(9)*y(12);
residual(32) = lhs - rhs;
lhs = y(14);
rhs = y(15)*T(20);
residual(33) = lhs - rhs;

end
