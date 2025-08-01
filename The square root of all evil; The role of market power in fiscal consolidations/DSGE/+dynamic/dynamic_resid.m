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
    T = dynamic.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(38, 1);
    residual(1) = (y(24)) - (T(1)*y(10));
    residual(2) = (y(25)) - (y(10)*T(3));
    residual(3) = (T(5)) - (y(13)*y(12));
    residual(4) = (T(5)*T(6)) - (y(12)*y(14));
    residual(5) = (y(49)*(1+y(57))) - (y(12)*(1+params(8)));
    residual(6) = (y(15)) - ((1+y(38))*y(1)+y(11)*y(14)+y(18)-y(35)-y(13)*y(10));
    residual(7) = (y(13)) - (T(7)^(1/(1-params(15))));
    residual(8) = (y(13)*y(34)) - (y(35));
    residual(9) = (log(y(34))) - ((1-params(10))*log((steady_state(25)))+params(10)*log(y(6))+x(it_, 2));
    residual(10) = (y(34)) - (T(11)^(params(15)/(params(15)-1)));
    residual(11) = (y(29)) - (T(1)*y(34));
    residual(12) = (y(30)) - (T(3)*y(34));
    residual(13) = (y(38)) - ((1-params(11))*(steady_state(29))+params(11)*y(8)+params(13)*(T(12)-1)+x(it_, 3));
    residual(14) = (log(y(28))) - ((1-params(12))*log((steady_state(19)))+params(12)*log(y(5))+x(it_, 4));
    residual(15) = (y(31)) - (y(17)*y(13)*T(14));
    residual(16) = (y(32)) - (T(1)*y(31));
    residual(17) = (y(33)) - (T(3)*y(31));
    residual(18) = (y(23)) - (y(32)+y(24)+y(29)+y(37));
    residual(19) = (y(39)) - (y(26)*(1-1/params(2)));
    residual(20) = (y(40)) - (y(26)*y(16)/(params(2)*y(3)));
    residual(21) = (y(19)) - (y(14)/T(15)*T(16));
    residual(22) = (y(41)) - (y(26)*T(13)*T(17)/y(4));
    residual(23) = (y(42)) - (y(16)*(-y(41))/y(2));
    residual(24) = (y(43)) - (y(26)*T(13)*T(18)/y(4));
    residual(25) = (y(44)) - (y(3)*(-y(43))/y(9));
    residual(26) = (y(21)) - (y(16)*params(4)+y(3)*(1-params(5)));
residual(27) = (1-params(2))*y(52)+T(19)*T(20)/y(55)-T(23)*y(50)*y(53)+T(24)*y(61);
residual(28) = (1-params(5))/(1+params(8))*y(54)+T(25)*(y(58)-y(59))/y(50)+T(26)*y(62)-y(22);
    residual(29) = (log(y(36))) - ((1-params(9))*log((steady_state(27)))+params(9)*log(y(7))+x(it_, 1));
    residual(30) = (y(20)) - (y(26)/y(19));
    residual(31) = (y(27)) - (y(26)*T(27));
    residual(32) = (y(17)) - (T(29)*T(30));
    residual(33) = (y(17)) - (y(10)+y(34)+y(27)*y(37)/y(13)-T(2)*(y(33)+y(25)+y(30)));
    residual(34) = (y(18)) - (y(13)*y(17)-y(11)*y(14));
    residual(35) = (y(16)) - (y(17)*T(27));
    residual(36) = (y(45)) - (y(55)*y(53)*T(21)*y(50)*T(31));
    residual(37) = (y(46)) - (y(60)/y(50));
    residual(38) = (y(47)) - (y(3));

end
