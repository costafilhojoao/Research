function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = solve.static_resid_tt(T, y, x, params);
end
residual = zeros(98, 1);
    residual(1) = (y(48)) - (y(48)*y(51)+x(1));
    residual(2) = (y(49)) - (y(51)*y(49)+x(2));
    residual(3) = (y(50)) - (y(51)*y(50)+x(3));
    residual(4) = (y(51)) - (y(51)+x(4));
    residual(5) = (y(1)) - (y(46)*params(12)*T(1)*T(2));
    residual(6) = (y(27)) - (T(4)*T(5));
    residual(7) = (y(4)) - (T(1)*T(7));
    residual(8) = (y(2)) - (y(6)+y(2)*(1-params(17)));
    residual(9) = (y(1)) - (y(6)+y(7)+params(18));
    residual(10) = (y(3)) - (y(8)*y(11)+y(9)*y(12)+y(10)*y(13));
    residual(11) = (y(7)) - (y(8)*y(14)+y(9)*y(15)+y(10)*y(16));
    residual(12) = (y(17)) - (y(15)*y(9)*y(14)*y(8)*params(5)+y(12)*y(9)*y(11)*y(8)*params(6)+y(9)*y(8)*params(7)*(1-y(50)));
    residual(13) = (y(8)) - (y(8)-y(17));
    residual(14) = (y(9)) - (y(9)+y(17)-y(9)*(params(8)+params(9)));
    residual(15) = (y(10)) - (y(10)+y(9)*params(8));
    residual(16) = (y(23)) - (y(23)+y(9)*params(9));
    residual(17) = (y(24)) - (y(24)-y(9)*params(9));
    residual(18) = (1/y(14)) - (y(18)*(1+y(48))-y(15)*y(9)*params(5)*y(19));
    residual(19) = (1/y(15)) - (y(18)*(1+y(48)));
    residual(20) = (1/y(16)) - (y(18)*(1+y(48)));
    residual(21) = (y(11)*params(13)) - (y(4)*y(18)*(1-y(49))+y(12)*y(9)*params(6)*y(19));
    residual(22) = (y(12)*params(13)) - (y(4)*y(18)*(1-y(49)));
    residual(23) = (y(13)*params(13)) - (y(4)*y(18)*(1-y(49)));
    residual(24) = (y(18)) - (y(18)*params(10)*(1-params(17)+y(5)*y(43))*y(38));
    residual(25) = (y(20)) - (y(19)+y(21));
residual(26) = log(y(14)*y(31))-T(8)*(y(11)*y(32))^2+y(19)*y(37)*T(9)+y(18)*y(38)*((1-y(49))*y(32)*y(11)*y(4)*y(35)-(1+y(48))*y(14)*y(31))-y(21)/params(10)+y(21)*y(36);
residual(27) = log(y(15)*y(33))-T(8)*(y(12)*y(34))^2+y(18)*y(38)*((1-y(49))*y(34)*y(12)*y(4)*y(35)-(1+y(48))*y(15)*y(33))-y(20)/params(10)+y(20)*y(39)*(1-params(8)-params(9))+params(8)*y(22)*y(40);
residual(28) = y(22)*y(40)+log(y(16)*y(41))-T(8)*(y(13)*y(42))^2+y(18)*y(38)*((1-y(49))*y(42)*y(13)*y(4)*y(35)-(1+y(48))*y(16)*y(41))-y(22)/params(10);
    residual(29) = (y(18)) - (y(38)*y(18)*params(10)*y(25)/(y(26)*y(47)));
    residual(30) = (y(30)) - (y(25)/(y(26)*y(47)));
    residual(31) = (y(29)) - (y(1)*y(18)*y(27)*params(4)+y(29)*T(11)*y(45));
    residual(32) = (y(28)) - (y(1)*y(18)+y(28)*T(13)*y(44));
    residual(33) = (y(29)) - (y(28)*T(15));
    residual(34) = (y(46)^(-1)) - ((1-params(1))*T(14)^params(4)+T(16)/y(46));
    residual(35) = (y(25)) - ((y(25))+params(2)*log(y(26)/(y(26)))+params(3)*log(y(1)/y(52)));
    residual(36) = (y(44)) - (1);
    residual(37) = (y(45)) - (1);
    residual(38) = (y(47)) - (1);
    residual(39) = (y(31)) - (1);
    residual(40) = (y(32)) - (1);
    residual(41) = (y(33)) - (1);
    residual(42) = (y(34)) - (1);
    residual(43) = (y(35)) - (1);
    residual(44) = (y(36)) - (1);
    residual(45) = (y(37)) - (1);
    residual(46) = (y(38)) - (1);
    residual(47) = (y(39)) - (1);
    residual(48) = (y(40)) - (1);
    residual(49) = (y(41)) - (1);
    residual(50) = (y(42)) - (1);
    residual(51) = (y(43)) - (1);
    residual(52) = (y(52)) - (params(12)*y(97)*T(17)*T(18));
    residual(53) = (y(78)) - (T(19)*T(20));
    residual(54) = (y(55)) - (T(17)*T(22));
    residual(55) = (y(53)) - (y(57)+(1-params(17))*y(53));
    residual(56) = (y(52)) - (params(18)+y(57)+y(58));
    residual(57) = (y(54)) - (y(59)*y(62)+y(60)*y(63)+y(61)*y(64));
    residual(58) = (y(58)) - (y(59)*y(65)+y(60)*y(66)+y(61)*y(67));
    residual(59) = (y(68)) - (y(66)*y(60)*y(65)*params(5)*y(59)+y(63)*y(60)*y(62)*params(6)*y(59)+(1-y(50))*y(60)*params(7)*y(59));
    residual(60) = (y(59)) - (y(59)-y(68));
    residual(61) = (y(60)) - (y(60)+y(68)-(params(8)+params(9))*y(60));
    residual(62) = (y(61)) - (y(61)+params(8)*y(60));
    residual(63) = (y(74)) - (y(74)+params(9)*y(60));
    residual(64) = (y(75)) - (y(75)-params(9)*y(60));
    residual(65) = (1/y(65)) - ((1+y(48))*y(69)-y(66)*y(60)*params(5)*y(70));
    residual(66) = (1/y(66)) - ((1+y(48))*y(69));
    residual(67) = (1/y(67)) - ((1+y(48))*y(69));
    residual(68) = (params(13)*y(62)) - ((1-y(49))*y(55)*y(69)+y(63)*y(60)*params(6)*y(70));
    residual(69) = (params(13)*y(63)) - ((1-y(49))*y(55)*y(69));
    residual(70) = (params(13)*y(64)) - ((1-y(49))*y(55)*y(69));
    residual(71) = (y(69)) - (y(69)*params(10)*(1-params(17)+y(56)*y(94))*y(89));
    residual(72) = (y(71)) - (y(70)+y(72));
residual(73) = log(y(65)*y(82))-T(8)*(y(62)*y(83))^2+y(70)*y(88)*T(23)+y(69)*y(89)*((1-y(49))*y(83)*y(62)*y(55)*y(86)-(1+y(48))*y(65)*y(82))-y(72)/params(10)+y(72)*y(87);
residual(74) = log(y(66)*y(84))-T(8)*(y(63)*y(85))^2+y(69)*y(89)*((1-y(49))*y(85)*y(63)*y(55)*y(86)-(1+y(48))*y(66)*y(84))-y(71)/params(10)+(1-params(8)-params(9))*y(71)*y(90)+params(8)*y(73)*y(91);
residual(75) = y(73)*y(91)+log(y(67)*y(92))-T(8)*(y(64)*y(93))^2+y(69)*y(89)*((1-y(49))*y(93)*y(64)*y(55)*y(86)-(1+y(48))*y(67)*y(92))-y(73)/params(10);
    residual(76) = (y(69)) - (y(89)*y(69)*params(10)*y(76)/(y(77)*y(98)));
    residual(77) = (y(81)) - (y(76)/(y(77)*y(98)));
    residual(78) = (y(80)) - (y(52)*y(69)*params(4)*y(78)+y(80)*T(24)*y(96));
    residual(79) = (y(79)) - (y(52)*y(69)+y(79)*T(25)*y(95));
    residual(80) = (y(80)) - (y(79)*T(27));
    residual(81) = (y(97)^(-1)) - ((1-params(20))*T(26)^params(4)+T(28)/y(97));
    residual(82) = (y(76)) - ((y(25))+params(2)*log(y(77)/(y(77))));
    residual(83) = (y(95)) - (1);
    residual(84) = (y(96)) - (1);
    residual(85) = (y(98)) - (1);
    residual(86) = (y(82)) - (1);
    residual(87) = (y(83)) - (1);
    residual(88) = (y(84)) - (1);
    residual(89) = (y(85)) - (1);
    residual(90) = (y(86)) - (1);
    residual(91) = (y(87)) - (1);
    residual(92) = (y(88)) - (1);
    residual(93) = (y(89)) - (1);
    residual(94) = (y(90)) - (1);
    residual(95) = (y(91)) - (1);
    residual(96) = (y(92)) - (1);
    residual(97) = (y(93)) - (1);
    residual(98) = (y(94)) - (1);

end
