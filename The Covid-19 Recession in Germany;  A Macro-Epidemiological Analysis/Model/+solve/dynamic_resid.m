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
residual = zeros(99, 1);
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
    residual(24) = (y(68)) - (y(68)*params(10)*(1-params(17)+y(55)*y(162))*y(157));
    residual(25) = (y(70)) - (y(69)+y(71));
residual(26) = log(y(64)*y(150))-T(8)*(y(61)*y(151))^2+y(69)*y(156)*T(9)+y(68)*y(157)*(y(151)*y(61)*y(54)*y(154)*(1-y(167))-y(64)*y(150)*(1+y(166)))-y(71)/params(10)+y(71)*y(155);
residual(27) = log(y(65)*y(152))-T(8)*(y(62)*y(153))^2+y(68)*y(157)*((1-y(167))*y(153)*y(62)*y(54)*y(154)-(1+y(166))*y(65)*y(152))-y(70)/params(10)+y(70)*y(158)*(1-params(8)-params(9))+params(8)*y(72)*y(159);
residual(28) = y(72)*y(159)+log(y(66)*y(160))-T(8)*(y(63)*y(161))^2+y(68)*y(157)*((1-y(167))*y(161)*y(63)*y(54)*y(154)-(1+y(166))*y(66)*y(160))-y(72)/params(10);
    residual(29) = (y(68)) - (y(157)*y(68)*params(10)*y(75)/(y(76)*y(165)));
    residual(30) = (y(80)) - (y(75)/(y(76)*y(165)));
    residual(31) = (y(79)) - (y(51)*y(68)*y(77)*params(4)+y(79)*T(11)*y(164));
    residual(32) = (y(78)) - (y(51)*y(68)+y(78)*T(13)*y(163));
    residual(33) = (y(79)) - (y(78)*T(15));
    residual(34) = (y(96)^(-1)) - ((1-params(1))*T(14)^params(4)+T(16)/y(23));
    residual(35) = (y(75)) - ((steady_state(25))+params(2)*log(y(76)/(steady_state(26)))+params(3)*log(y(51)/y(103)));
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
    residual(52) = (y(102)) - (y(58)*T(17)+y(59)*T(18)+y(60)*T(19));
    residual(53) = (y(103)) - (params(12)*y(148)*T(20)*T(21));
    residual(54) = (y(129)) - (T(22)*T(23));
    residual(55) = (y(106)) - (T(20)*T(25));
    residual(56) = (y(104)) - (y(108)+(1-params(17))*y(28));
    residual(57) = (y(103)) - (params(18)+y(108)+y(109));
    residual(58) = (y(105)) - (y(31)*y(113)+y(32)*y(114)+y(33)*y(115));
    residual(59) = (y(109)) - (y(31)*y(116)+y(32)*y(117)+y(33)*y(118));
    residual(60) = (y(119)) - (y(117)*y(32)*y(116)*params(5)*y(31)+y(114)*y(32)*y(113)*params(6)*y(31)+(1-y(100))*y(32)*params(7)*y(31));
    residual(61) = (y(110)) - (y(31)-y(119));
    residual(62) = (y(111)) - (y(32)+y(119)-(params(8)+params(9))*y(32));
    residual(63) = (y(112)) - (y(33)+params(8)*y(32));
    residual(64) = (y(125)) - (y(45)+params(9)*y(32));
    residual(65) = (y(126)) - (y(46)-params(9)*y(32));
    residual(66) = (1/y(116)) - ((1+y(98))*y(120)-y(117)*y(32)*params(5)*y(121));
    residual(67) = (1/y(117)) - ((1+y(98))*y(120));
    residual(68) = (1/y(118)) - ((1+y(98))*y(120));
    residual(69) = (params(13)*y(113)) - ((1-y(99))*y(106)*y(120)+y(114)*y(32)*params(6)*y(121));
    residual(70) = (params(13)*y(114)) - ((1-y(99))*y(106)*y(120));
    residual(71) = (params(13)*y(115)) - ((1-y(99))*y(106)*y(120));
    residual(72) = (y(120)) - (y(120)*params(10)*(1-params(17)+y(107)*y(181))*y(176));
    residual(73) = (y(122)) - (y(121)+y(123));
residual(74) = log(y(116)*y(169))-T(8)*(y(113)*y(170))^2+y(121)*y(175)*T(26)+y(120)*y(176)*((1-y(167))*y(170)*y(113)*y(106)*y(173)-(1+y(166))*y(116)*y(169))-y(123)/params(10)+y(123)*y(174);
residual(75) = log(y(117)*y(171))-T(8)*(y(114)*y(172))^2+y(120)*y(176)*((1-y(167))*y(172)*y(114)*y(106)*y(173)-(1+y(166))*y(117)*y(171))-y(122)/params(10)+(1-params(8)-params(9))*y(122)*y(177)+params(8)*y(124)*y(178);
residual(76) = y(124)*y(178)+log(y(118)*y(179))-T(8)*(y(115)*y(180))^2+y(120)*y(176)*((1-y(167))*y(180)*y(115)*y(106)*y(173)-(1+y(166))*y(118)*y(179))-y(124)/params(10);
    residual(77) = (y(120)) - (y(176)*y(120)*params(10)*y(127)/(y(128)*y(184)));
    residual(78) = (y(132)) - (y(127)/(y(128)*y(184)));
    residual(79) = (y(131)) - (y(103)*y(120)*params(4)*y(129)+y(131)*T(27)*y(183));
    residual(80) = (y(130)) - (y(103)*y(120)+y(130)*T(28)*y(182));
    residual(81) = (y(131)) - (y(130)*T(30));
    residual(82) = (y(148)^(-1)) - ((1-params(20))*T(29)^params(4)+T(31)/y(50));
    residual(83) = (y(127)) - ((steady_state(25))+params(2)*log(y(128)/(steady_state(78))));
    residual(84) = (y(146)) - (y(130)/y(48));
    residual(85) = (y(147)) - (y(131)/y(49));
    residual(86) = (y(149)) - (y(128)/y(47));
    residual(87) = (y(133)) - (y(116)/y(37));
    residual(88) = (y(134)) - (y(113)/y(34));
    residual(89) = (y(135)) - (y(117)/y(38));
    residual(90) = (y(136)) - (y(114)/y(35));
    residual(91) = (y(137)) - (y(106)/y(29));
    residual(92) = (y(138)) - (y(123)/y(43));
    residual(93) = (y(139)) - (y(121)/y(41));
    residual(94) = (y(140)) - (y(120)/y(40));
    residual(95) = (y(141)) - (y(122)/y(42));
    residual(96) = (y(142)) - (y(124)/y(44));
    residual(97) = (y(143)) - (y(118)/y(39));
    residual(98) = (y(144)) - (y(115)/y(36));
    residual(99) = (y(145)) - (y(107)/y(30));

end
