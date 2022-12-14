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
    T = model_RBC.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(34, 1);
lhs = T(2);
rhs = y(16)*y(17);
residual(1) = lhs - rhs;
lhs = T(2)*T(3);
rhs = y(16)*y(18);
residual(2) = lhs - rhs;
lhs = y(42)*(1+y(37));
rhs = y(16)*(1+params(8));
residual(3) = lhs - rhs;
lhs = y(42)-y(8);
rhs = x(it_, 5);
residual(4) = lhs - rhs;
lhs = y(19);
rhs = (1+y(7))*y(1)+y(15)*y(18)+y(22)-y(34)-y(14)*y(17);
residual(5) = lhs - rhs;
lhs = y(14);
rhs = T(7)^T(8);
residual(6) = lhs - rhs;
lhs = y(28);
rhs = y(14)*T(9);
residual(7) = lhs - rhs;
lhs = y(29);
rhs = y(14)*T(11);
residual(8) = lhs - rhs;
lhs = y(17)*y(35);
rhs = y(34);
residual(9) = lhs - rhs;
lhs = log(y(35));
rhs = (1-params(10))*log((steady_state(22)))+params(10)*log(y(5))+x(it_, 2);
residual(10) = lhs - rhs;
lhs = y(35);
rhs = T(12)^T(8);
residual(11) = lhs - rhs;
lhs = y(32);
rhs = T(9)*y(35);
residual(12) = lhs - rhs;
lhs = y(33);
rhs = T(11)*y(35);
residual(13) = lhs - rhs;
lhs = y(37);
rhs = (1-params(11))*(steady_state(24))+y(7)*params(11)+params(13)*(T(13)-1)+x(it_, 3);
residual(14) = lhs - rhs;
lhs = log(y(31));
rhs = (1-params(12))*log((steady_state(18)))+params(12)*log(y(4))+x(it_, 4);
residual(15) = lhs - rhs;
lhs = y(39);
rhs = y(21)*y(17)*T(16);
residual(16) = lhs - rhs;
lhs = y(40);
rhs = T(9)*y(39);
residual(17) = lhs - rhs;
lhs = y(41);
rhs = T(11)*y(39);
residual(18) = lhs - rhs;
lhs = y(25)*params(4);
rhs = y(24)-y(23)*(params(2)-1)/params(2)-T(14)*T(19);
residual(19) = lhs - rhs;
lhs = (1+params(8))*y(25);
rhs = 1/params(2)*y(45)*y(44)/y(27)-T(22)/y(27)-(1-params(5))*y(43);
residual(20) = lhs - rhs;
lhs = y(45)-y(11);
rhs = x(it_, 6);
residual(21) = lhs - rhs;
lhs = y(43)-y(9);
rhs = x(it_, 7);
residual(22) = lhs - rhs;
lhs = y(44)-y(10);
rhs = x(it_, 8);
residual(23) = lhs - rhs;
lhs = y(46)-y(12);
rhs = x(it_, 9);
residual(24) = lhs - rhs;
lhs = y(47)-y(13);
rhs = x(it_, 10);
residual(25) = lhs - rhs;
lhs = y(24);
rhs = y(18)/T(23)*T(24);
residual(26) = lhs - rhs;
lhs = y(26);
rhs = y(23)/y(24);
residual(27) = lhs - rhs;
lhs = y(27);
rhs = params(4)*y(20)+(1-params(5))*y(3);
residual(28) = lhs - rhs;
lhs = log(y(36));
rhs = (1-params(9))*log((steady_state(23)))+params(9)*log(y(6))+x(it_, 1);
residual(29) = lhs - rhs;
lhs = y(30);
rhs = y(23)*T(25);
residual(30) = lhs - rhs;
lhs = y(21);
rhs = T(27)*T(28);
residual(31) = lhs - rhs;
lhs = y(21);
rhs = y(14)+y(35)+y(30)*y(38)/y(17)-T(10)*(y(41)+y(29)+y(33));
residual(32) = lhs - rhs;
lhs = y(22);
rhs = y(17)*y(21)-y(15)*y(18);
residual(33) = lhs - rhs;
lhs = y(20);
rhs = y(21)*T(25);
residual(34) = lhs - rhs;

end
