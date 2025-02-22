function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(28, 1);
end
[T_order, T] = solve.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(98, 1);
    residual(1) = (y(146)) - (y(149)*y(48)+x(1));
    residual(2) = (y(147)) - (y(149)*y(49)+x(2));
    residual(3) = (y(148)) - (y(149)*y(50)+x(3));
    residual(4) = (y(149)) - (y(51)+x(4));
    residual(5) = (y(99)) - (y(144)*params(12)*T(1)*T(2));
    residual(6) = (y(125)) - (T(4)*T(5));
    residual(7) = (y(102)) - (T(1)*T(7));
    residual(8) = (y(100)) - (y(104)+y(2)*(1-params(17)));
    residual(9) = (y(99)) - (y(104)+y(105)+params(18));
    residual(10) = (y(101)) - (y(8)*y(109)+y(9)*y(110)+y(10)*y(111));
    residual(11) = (y(105)) - (y(8)*y(112)+y(9)*y(113)+y(10)*y(114));
    residual(12) = (y(115)) - (y(113)*y(9)*y(112)*y(8)*params(5)+y(110)*y(9)*y(109)*y(8)*params(6)+y(9)*y(8)*params(7)*(1-y(148)));
    residual(13) = (y(106)) - (y(8)-y(115));
    residual(14) = (y(107)) - (y(9)+y(115)-y(9)*(params(8)+params(9)));
    residual(15) = (y(108)) - (y(10)+y(9)*params(8));
    residual(16) = (y(121)) - (y(23)+y(9)*params(9));
    residual(17) = (y(122)) - (y(24)-y(9)*params(9));
    residual(18) = (1/y(112)) - (y(116)*(1+y(146))-y(113)*y(9)*params(5)*y(117));
    residual(19) = (1/y(113)) - (y(116)*(1+y(146)));
    residual(20) = (1/y(114)) - (y(116)*(1+y(146)));
    residual(21) = (y(109)*params(13)) - (y(102)*y(116)*(1-y(147))+y(110)*y(9)*params(6)*y(117));
    residual(22) = (y(110)*params(13)) - (y(102)*y(116)*(1-y(147)));
    residual(23) = (y(111)*params(13)) - (y(102)*y(116)*(1-y(147)));
    residual(24) = (y(116)) - (y(116)*params(10)*(1-params(17)+y(103)*y(239))*y(234));
    residual(25) = (y(118)) - (y(117)+y(119));
residual(26) = log(y(112)*y(227))-T(8)*(y(109)*y(228))^2+y(117)*y(233)*T(9)+y(116)*y(234)*(y(228)*y(109)*y(102)*y(231)*(1-y(245))-y(112)*y(227)*(1+y(244)))-y(119)/params(10)+y(119)*y(232);
residual(27) = log(y(113)*y(229))-T(8)*(y(110)*y(230))^2+y(116)*y(234)*((1-y(245))*y(230)*y(110)*y(102)*y(231)-(1+y(244))*y(113)*y(229))-y(118)/params(10)+y(118)*y(235)*(1-params(8)-params(9))+params(8)*y(120)*y(236);
residual(28) = y(120)*y(236)+log(y(114)*y(237))-T(8)*(y(111)*y(238))^2+y(116)*y(234)*((1-y(245))*y(238)*y(111)*y(102)*y(231)-(1+y(244))*y(114)*y(237))-y(120)/params(10);
    residual(29) = (y(116)) - (y(234)*y(116)*params(10)*y(123)/(y(124)*y(243)));
    residual(30) = (y(128)) - (y(123)/(y(124)*y(243)));
    residual(31) = (y(127)) - (y(99)*y(116)*y(125)*params(4)+y(127)*T(11)*y(241));
    residual(32) = (y(126)) - (y(99)*y(116)+y(126)*T(13)*y(240));
    residual(33) = (y(127)) - (y(126)*T(15));
    residual(34) = (y(144)^(-1)) - ((1-params(1))*T(14)^params(4)+T(16)/y(46));
    residual(35) = (y(123)) - ((steady_state(25))+params(2)*log(y(124)/(steady_state(26)))+params(3)*log(y(99)/y(150)));
    residual(36) = (y(142)) - (y(126)/y(28));
    residual(37) = (y(143)) - (y(127)/y(29));
    residual(38) = (y(145)) - (y(124)/y(26));
    residual(39) = (y(129)) - (y(112)/y(14));
    residual(40) = (y(130)) - (y(109)/y(11));
    residual(41) = (y(131)) - (y(113)/y(15));
    residual(42) = (y(132)) - (y(110)/y(12));
    residual(43) = (y(133)) - (y(102)/y(4));
    residual(44) = (y(134)) - (y(119)/y(21));
    residual(45) = (y(135)) - (y(117)/y(19));
    residual(46) = (y(136)) - (y(116)/y(18));
    residual(47) = (y(137)) - (y(118)/y(20));
    residual(48) = (y(138)) - (y(120)/y(22));
    residual(49) = (y(139)) - (y(114)/y(16));
    residual(50) = (y(140)) - (y(111)/y(13));
    residual(51) = (y(141)) - (y(103)/y(5));
    residual(52) = (y(150)) - (params(12)*y(195)*T(17)*T(18));
    residual(53) = (y(176)) - (T(19)*T(20));
    residual(54) = (y(153)) - (T(17)*T(22));
    residual(55) = (y(151)) - (y(155)+(1-params(17))*y(53));
    residual(56) = (y(150)) - (params(18)+y(155)+y(156));
    residual(57) = (y(152)) - (y(59)*y(160)+y(60)*y(161)+y(61)*y(162));
    residual(58) = (y(156)) - (y(59)*y(163)+y(60)*y(164)+y(61)*y(165));
    residual(59) = (y(166)) - (y(164)*y(60)*y(163)*params(5)*y(59)+y(161)*y(60)*y(160)*params(6)*y(59)+(1-y(148))*y(60)*params(7)*y(59));
    residual(60) = (y(157)) - (y(59)-y(166));
    residual(61) = (y(158)) - (y(60)+y(166)-(params(8)+params(9))*y(60));
    residual(62) = (y(159)) - (y(61)+params(8)*y(60));
    residual(63) = (y(172)) - (y(74)+params(9)*y(60));
    residual(64) = (y(173)) - (y(75)-params(9)*y(60));
    residual(65) = (1/y(163)) - ((1+y(146))*y(167)-y(164)*y(60)*params(5)*y(168));
    residual(66) = (1/y(164)) - ((1+y(146))*y(167));
    residual(67) = (1/y(165)) - ((1+y(146))*y(167));
    residual(68) = (params(13)*y(160)) - ((1-y(147))*y(153)*y(167)+y(161)*y(60)*params(6)*y(168));
    residual(69) = (params(13)*y(161)) - ((1-y(147))*y(153)*y(167));
    residual(70) = (params(13)*y(162)) - ((1-y(147))*y(153)*y(167));
    residual(71) = (y(167)) - (y(167)*params(10)*(1-params(17)+y(154)*y(290))*y(285));
    residual(72) = (y(169)) - (y(168)+y(170));
residual(73) = log(y(163)*y(278))-T(8)*(y(160)*y(279))^2+y(168)*y(284)*T(23)+y(167)*y(285)*((1-y(245))*y(279)*y(160)*y(153)*y(282)-(1+y(244))*y(163)*y(278))-y(170)/params(10)+y(170)*y(283);
residual(74) = log(y(164)*y(280))-T(8)*(y(161)*y(281))^2+y(167)*y(285)*((1-y(245))*y(281)*y(161)*y(153)*y(282)-(1+y(244))*y(164)*y(280))-y(169)/params(10)+(1-params(8)-params(9))*y(169)*y(286)+params(8)*y(171)*y(287);
residual(75) = y(171)*y(287)+log(y(165)*y(288))-T(8)*(y(162)*y(289))^2+y(167)*y(285)*((1-y(245))*y(289)*y(162)*y(153)*y(282)-(1+y(244))*y(165)*y(288))-y(171)/params(10);
    residual(76) = (y(167)) - (y(285)*y(167)*params(10)*y(174)/(y(175)*y(294)));
    residual(77) = (y(179)) - (y(174)/(y(175)*y(294)));
    residual(78) = (y(178)) - (y(150)*y(167)*params(4)*y(176)+y(178)*T(24)*y(292));
    residual(79) = (y(177)) - (y(150)*y(167)+y(177)*T(25)*y(291));
    residual(80) = (y(178)) - (y(177)*T(27));
    residual(81) = (y(195)^(-1)) - ((1-params(20))*T(26)^params(4)+T(28)/y(97));
    residual(82) = (y(174)) - ((steady_state(25))+params(2)*log(y(175)/(steady_state(77))));
    residual(83) = (y(193)) - (y(177)/y(79));
    residual(84) = (y(194)) - (y(178)/y(80));
    residual(85) = (y(196)) - (y(175)/y(77));
    residual(86) = (y(180)) - (y(163)/y(65));
    residual(87) = (y(181)) - (y(160)/y(62));
    residual(88) = (y(182)) - (y(164)/y(66));
    residual(89) = (y(183)) - (y(161)/y(63));
    residual(90) = (y(184)) - (y(153)/y(55));
    residual(91) = (y(185)) - (y(170)/y(72));
    residual(92) = (y(186)) - (y(168)/y(70));
    residual(93) = (y(187)) - (y(167)/y(69));
    residual(94) = (y(188)) - (y(169)/y(71));
    residual(95) = (y(189)) - (y(171)/y(73));
    residual(96) = (y(190)) - (y(165)/y(67));
    residual(97) = (y(191)) - (y(162)/y(64));
    residual(98) = (y(192)) - (y(154)/y(56));
end
