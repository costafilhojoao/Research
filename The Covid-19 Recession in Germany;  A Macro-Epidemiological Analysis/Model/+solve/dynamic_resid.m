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
    T = solve.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(98, 1);
    residual(1) = (y(98)) - (y(101)*y(24)+x(it_, 1));
    residual(2) = (y(99)) - (y(101)*y(25)+x(it_, 2));
    residual(3) = (y(100)) - (y(101)*y(26)+x(it_, 3));
    residual(4) = (y(101)) - (y(27)+x(it_, 4));
    residual(5) = (y(51)) - (y(96)*params(12)*T(1)*T(2));
    residual(6) = (y(77)) - (T(4)*T(5));
    residual(7) = (y(54)) - (T(1)*T(7));
    residual(8) = (y(52)) - (y(56)+y(1)*(1-params(17)));
    residual(9) = (y(51)) - (y(56)+y(57)+params(18));
    residual(10) = (y(53)) - (y(4)*y(61)+y(5)*y(62)+y(6)*y(63));
    residual(11) = (y(57)) - (y(4)*y(64)+y(5)*y(65)+y(6)*y(66));
    residual(12) = (y(67)) - (y(65)*y(5)*y(64)*y(4)*params(5)+y(62)*y(5)*y(61)*y(4)*params(6)+y(5)*y(4)*params(7)*(1-y(100)));
    residual(13) = (y(58)) - (y(4)-y(67));
    residual(14) = (y(59)) - (y(5)+y(67)-y(5)*(params(8)+params(9)));
    residual(15) = (y(60)) - (y(6)+y(5)*params(8));
    residual(16) = (y(73)) - (y(18)+y(5)*params(9));
    residual(17) = (y(74)) - (y(19)-y(5)*params(9));
    residual(18) = (1/y(64)) - (y(68)*(1+y(98))-y(65)*y(5)*params(5)*y(69));
    residual(19) = (1/y(65)) - (y(68)*(1+y(98)));
    residual(20) = (1/y(66)) - (y(68)*(1+y(98)));
    residual(21) = (y(61)*params(13)) - (y(54)*y(68)*(1-y(99))+y(62)*y(5)*params(6)*y(69));
    residual(22) = (y(62)*params(13)) - (y(54)*y(68)*(1-y(99)));
    residual(23) = (y(63)*params(13)) - (y(54)*y(68)*(1-y(99)));
    residual(24) = (y(68)) - (y(68)*params(10)*(1-params(17)+y(55)*y(161))*y(156));
    residual(25) = (y(70)) - (y(69)+y(71));
residual(26) = log(y(64)*y(149))-T(8)*(y(61)*y(150))^2+y(69)*y(155)*T(9)+y(68)*y(156)*(y(150)*y(61)*y(54)*y(153)*(1-y(166))-y(64)*y(149)*(1+y(165)))-y(71)/params(10)+y(71)*y(154);
residual(27) = log(y(65)*y(151))-T(8)*(y(62)*y(152))^2+y(68)*y(156)*((1-y(166))*y(152)*y(62)*y(54)*y(153)-(1+y(165))*y(65)*y(151))-y(70)/params(10)+y(70)*y(157)*(1-params(8)-params(9))+params(8)*y(72)*y(158);
residual(28) = y(72)*y(158)+log(y(66)*y(159))-T(8)*(y(63)*y(160))^2+y(68)*y(156)*((1-y(166))*y(160)*y(63)*y(54)*y(153)-(1+y(165))*y(66)*y(159))-y(72)/params(10);
    residual(29) = (y(68)) - (y(156)*y(68)*params(10)*y(75)/(y(76)*y(164)));
    residual(30) = (y(80)) - (y(75)/(y(76)*y(164)));
    residual(31) = (y(79)) - (y(51)*y(68)*y(77)*params(4)+y(79)*T(11)*y(163));
    residual(32) = (y(78)) - (y(51)*y(68)+y(78)*T(13)*y(162));
    residual(33) = (y(79)) - (y(78)*T(15));
    residual(34) = (y(96)^(-1)) - ((1-params(1))*T(14)^params(4)+T(16)/y(23));
    residual(35) = (y(75)) - ((steady_state(25))+params(2)*log(y(76)/(steady_state(26)))+params(3)*log(y(51)/y(102)));
    residual(36) = (y(94)) - (y(78)/y(21));
    residual(37) = (y(95)) - (y(79)/y(22));
    residual(38) = (y(97)) - (y(76)/y(20));
    residual(39) = (y(81)) - (y(64)/y(10));
    residual(40) = (y(82)) - (y(61)/y(7));
    residual(41) = (y(83)) - (y(65)/y(11));
    residual(42) = (y(84)) - (y(62)/y(8));
    residual(43) = (y(85)) - (y(54)/y(2));
    residual(44) = (y(86)) - (y(71)/y(16));
    residual(45) = (y(87)) - (y(69)/y(14));
    residual(46) = (y(88)) - (y(68)/y(13));
    residual(47) = (y(89)) - (y(70)/y(15));
    residual(48) = (y(90)) - (y(72)/y(17));
    residual(49) = (y(91)) - (y(66)/y(12));
    residual(50) = (y(92)) - (y(63)/y(9));
    residual(51) = (y(93)) - (y(55)/y(3));
    residual(52) = (y(102)) - (params(12)*y(147)*T(17)*T(18));
    residual(53) = (y(128)) - (T(19)*T(20));
    residual(54) = (y(105)) - (T(17)*T(22));
    residual(55) = (y(103)) - (y(107)+(1-params(17))*y(28));
    residual(56) = (y(102)) - (params(18)+y(107)+y(108));
    residual(57) = (y(104)) - (y(31)*y(112)+y(32)*y(113)+y(33)*y(114));
    residual(58) = (y(108)) - (y(31)*y(115)+y(32)*y(116)+y(33)*y(117));
    residual(59) = (y(118)) - (y(116)*y(32)*y(115)*params(5)*y(31)+y(113)*y(32)*y(112)*params(6)*y(31)+(1-y(100))*y(32)*params(7)*y(31));
    residual(60) = (y(109)) - (y(31)-y(118));
    residual(61) = (y(110)) - (y(32)+y(118)-(params(8)+params(9))*y(32));
    residual(62) = (y(111)) - (y(33)+params(8)*y(32));
    residual(63) = (y(124)) - (y(45)+params(9)*y(32));
    residual(64) = (y(125)) - (y(46)-params(9)*y(32));
    residual(65) = (1/y(115)) - ((1+y(98))*y(119)-y(116)*y(32)*params(5)*y(120));
    residual(66) = (1/y(116)) - ((1+y(98))*y(119));
    residual(67) = (1/y(117)) - ((1+y(98))*y(119));
    residual(68) = (params(13)*y(112)) - ((1-y(99))*y(105)*y(119)+y(113)*y(32)*params(6)*y(120));
    residual(69) = (params(13)*y(113)) - ((1-y(99))*y(105)*y(119));
    residual(70) = (params(13)*y(114)) - ((1-y(99))*y(105)*y(119));
    residual(71) = (y(119)) - (y(119)*params(10)*(1-params(17)+y(106)*y(180))*y(175));
    residual(72) = (y(121)) - (y(120)+y(122));
residual(73) = log(y(115)*y(168))-T(8)*(y(112)*y(169))^2+y(120)*y(174)*T(23)+y(119)*y(175)*((1-y(166))*y(169)*y(112)*y(105)*y(172)-(1+y(165))*y(115)*y(168))-y(122)/params(10)+y(122)*y(173);
residual(74) = log(y(116)*y(170))-T(8)*(y(113)*y(171))^2+y(119)*y(175)*((1-y(166))*y(171)*y(113)*y(105)*y(172)-(1+y(165))*y(116)*y(170))-y(121)/params(10)+(1-params(8)-params(9))*y(121)*y(176)+params(8)*y(123)*y(177);
residual(75) = y(123)*y(177)+log(y(117)*y(178))-T(8)*(y(114)*y(179))^2+y(119)*y(175)*((1-y(166))*y(179)*y(114)*y(105)*y(172)-(1+y(165))*y(117)*y(178))-y(123)/params(10);
    residual(76) = (y(119)) - (y(175)*y(119)*params(10)*y(126)/(y(127)*y(183)));
    residual(77) = (y(131)) - (y(126)/(y(127)*y(183)));
    residual(78) = (y(130)) - (y(102)*y(119)*params(4)*y(128)+y(130)*T(24)*y(182));
    residual(79) = (y(129)) - (y(102)*y(119)+y(129)*T(25)*y(181));
    residual(80) = (y(130)) - (y(129)*T(27));
    residual(81) = (y(147)^(-1)) - ((1-params(20))*T(26)^params(4)+T(28)/y(50));
    residual(82) = (y(126)) - ((steady_state(25))+params(2)*log(y(127)/(steady_state(77))));
    residual(83) = (y(145)) - (y(129)/y(48));
    residual(84) = (y(146)) - (y(130)/y(49));
    residual(85) = (y(148)) - (y(127)/y(47));
    residual(86) = (y(132)) - (y(115)/y(37));
    residual(87) = (y(133)) - (y(112)/y(34));
    residual(88) = (y(134)) - (y(116)/y(38));
    residual(89) = (y(135)) - (y(113)/y(35));
    residual(90) = (y(136)) - (y(105)/y(29));
    residual(91) = (y(137)) - (y(122)/y(43));
    residual(92) = (y(138)) - (y(120)/y(41));
    residual(93) = (y(139)) - (y(119)/y(40));
    residual(94) = (y(140)) - (y(121)/y(42));
    residual(95) = (y(141)) - (y(123)/y(44));
    residual(96) = (y(142)) - (y(117)/y(39));
    residual(97) = (y(143)) - (y(114)/y(36));
    residual(98) = (y(144)) - (y(106)/y(30));

end
