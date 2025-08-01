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
    T = irf.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(51, 1);
    residual(1) = (y(30)) - (y(79)-(y(46)-y(82))+T(1)*(y(89)-y(74))-(y(88)-y(73)));
    residual(2) = (y(31)) - (T(2)*(params(2)*(1-params(3))*y(84)-y(49))+y(62));
    residual(3) = (y(30)+params(64)/(1+params(64))*y(67)+y(33)) - (y(84)+y(49)+params(2)*params(4)*(y(80)-y(32)));
    residual(4) = (T(4)+params(6)*y(38)) - (y(41)-params(65)/(1-params(65))*y(68)-T(1)*y(74)-y(28));
    residual(5) = (T(4)+params(6)*y(37)) - (y(42)-y(33)-params(66)/(1-params(66))*y(69)-T(1)*y(74)-y(28));
    residual(6) = (y(31)) - ((1-params(3))*y(1)+params(3)*y(32));
    residual(7) = (y(51)) - (params(2)*(params(14)*y(86)+(1-params(28))*y(85))-(y(46)-y(82)));
    residual(8) = (y(53)) - (1/(1+params(2))*y(7)+params(2)/(1+params(2))*y(87)+y(51)*params(27)/(1+params(2)));
    residual(9) = (y(50)) - ((1-params(28))*y(6)+params(28)*y(53));
    residual(10) = (y(58)) - ((1-params(29))*y(11)+params(40)/params(39)*y(65)+params(41)/params(39)*y(66));
    residual(11) = (y(29)) - (params(85)*(y(38)+y(41)-params(65)/(1-params(65))*y(68))+params(86)*(y(37)+y(42)-params(66)/(1-params(66))*y(69))-T(1)*y(74));
    residual(12) = (y(44)) - (y(82)*params(23)+params(24)*y(3)+params(61)*y(47)+params(61)*params(67)/(1-params(67))*y(70));
    residual(13) = (y(45)) - (params(59)*y(83)+params(60)*y(4)+params(62)*y(48)+y(70)*params(67)*params(62)/(1-params(67)));
    residual(14) = (y(43)) - (y(76)-y(26));
    residual(15) = (y(36)) - (y(60)+y(6)*params(12)+y(38)*(1-params(13))+y(11)*params(30));
    residual(16) = (y(46)) - ((1-params(26)-params(1))*(y(43)*params(11)+params(25)*y(34))+params(26)*y(5)+params(1)*y(27));
    residual(17) = (y(54)) - (y(46)-y(81));
    residual(18) = (y(35)) - (y(37)+y(61));
    residual(19) = (y(47)) - (y(41)*(1-params(13))-y(60)+params(12)*y(52)-y(11)*params(30));
    residual(20) = (y(48)) - (y(42)-y(61)-y(33));
    residual(21) = (y(38)) - (y(6)+y(52)-y(41));
    residual(22) = (y(37)) - (y(38)+T(5)*(y(41)-y(42)-y(33))-T(5)*(y(68)*params(65)/(1+params(65))-params(66)/(1-params(66))*y(69)));
    residual(23) = (y(39)) - (y(36)+y(55)-y(76)-y(52)-y(6)-y(41)-y(38));
    residual(24) = (y(40)) - (y(35)+y(56)-y(76)-y(42)-y(37));
    residual(25) = (params(36)*y(63)/(params(36)+params(37))+y(65)*params(37)/(params(36)+params(37))) - ((1-params(68))*(T(6)*(y(28)+y(74)+y(55)-y(76))+T(7)*(y(28)+y(67)+y(56)-y(76)))+(1-params(69))*(params(89)*params(65)*params(91)/(params(36)+params(37))*(y(38)+y(41)+y(68))+params(90)*params(66)*params(92)/(params(36)+params(37))*(y(37)+y(42)+y(69)))+params(47)*y(71));
    residual(26) = (params(35)*y(64)/(params(35)+params(38))+y(66)*params(38)/(params(35)+params(38))) - (params(68)*((y(28)+y(74)+y(55)-y(76))*T(8)+(y(28)+y(67)+y(56)-y(76))*T(9))+params(69)*((y(38)+y(41)+y(68))*params(89)*params(65)*params(91)/(params(35)+params(38))+(y(37)+y(42)+y(69))*params(90)*params(66)*params(92)/(params(35)+params(38)))+params(67)*(params(87)/(params(35)+params(38))*(y(70)+y(39))+params(88)/(params(35)+params(38))*(y(70)+y(40)))-y(71)*params(54)+0.02*y(57)-params(55)*(y(46)+y(10))+y(72));
    residual(27) = (y(34)) - (y(66)*params(38)+y(65)*params(37)+params(35)*y(64)+params(36)*y(63)+y(28)*params(34)+y(32)*params(32)+y(53)*params(33));
    residual(28) = (y(34)) - (y(36)*(1-params(8))+y(35)*params(8));
    residual(29) = (y(59)) - (T(3));
    residual(30) = (y(77)) - ((y(38)+y(41))*params(89)*params(91)+(y(37)+y(42))*params(90)*params(92));
    residual(31) = (y(33)) - (y(45)+y(2)-y(44));
    residual(32) = (y(44)) - (y(55)-y(8));
    residual(33) = (y(45)) - (y(56)-y(9));
    residual(34) = (y(76)) - (y(55)*(1-params(7))+y(56)*params(7));
    residual(35) = (y(28)) - (y(30)*(1-params(16))+y(29)*params(16));
    residual(36) = (y(72)) - (y(10)*params(17)+y(75));
    residual(37) = (y(60)) - (params(71)*y(12)+x(it_, 1));
    residual(38) = (y(61)) - (params(72)*y(13)+x(it_, 2));
    residual(39) = (y(63)) - (params(73)*y(15)+x(it_, 3));
    residual(40) = (y(64)) - (params(74)*y(16)+x(it_, 4));
    residual(41) = (y(65)) - (params(75)*y(17)+x(it_, 5));
    residual(42) = (y(66)) - (params(76)*y(18)+x(it_, 6));
    residual(43) = (y(74)) - (params(84)*y(24));
    residual(44) = (y(68)) - (params(79)*y(20));
    residual(45) = (y(69)) - (params(80)*y(21));
    residual(46) = (y(70)) - (params(81)*y(22));
    residual(47) = (y(67)) - (params(78)*y(19));
    residual(48) = (y(73)) - (params(83)*y(23));
    residual(49) = (y(62)) - (params(77)*y(14));
    residual(50) = (y(75)) - (params(82)*y(25));
    residual(51) = (y(78)) - (y(5));

end
