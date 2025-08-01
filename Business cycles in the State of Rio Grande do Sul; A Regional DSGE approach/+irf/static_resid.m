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
    T = irf.static_resid_tt(T, y, x, params);
end
residual = zeros(51, 1);
    residual(1) = (y(3)) - (y(3)-(y(19)-y(17)));
    residual(2) = (y(4)) - (T(2)*(params(2)*(1-params(3))*y(22)-y(22))+y(35));
    residual(3) = (y(3)+params(64)/(1+params(64))*y(40)+y(6)) - (y(22)+y(22));
    residual(4) = (T(4)+params(6)*y(11)) - (y(14)-params(65)/(1-params(65))*y(41)-T(1)*y(47)-y(1));
    residual(5) = (T(4)+params(6)*y(10)) - (y(15)-y(6)-params(66)/(1-params(66))*y(42)-T(1)*y(47)-y(1));
    residual(6) = (y(4)) - (y(4)*(1-params(3))+params(3)*y(5));
    residual(7) = (y(24)) - (params(2)*(params(14)*y(25)+y(24)*(1-params(28)))-(y(19)-y(17)));
    residual(8) = (y(26)) - (y(26)*1/(1+params(2))+y(26)*params(2)/(1+params(2))+y(24)*params(27)/(1+params(2)));
    residual(9) = (y(23)) - ((1-params(28))*y(23)+params(28)*y(26));
    residual(10) = (y(31)) - (y(31)*(1-params(29))+params(40)/params(39)*y(38)+params(41)/params(39)*y(39));
    residual(11) = (y(2)) - (params(85)*(y(11)+y(14)-params(65)/(1-params(65))*y(41))+params(86)*(y(10)+y(15)-params(66)/(1-params(66))*y(42))-T(1)*y(47));
    residual(12) = (y(17)) - (y(17)*params(23)+y(17)*params(24)+params(61)*y(20)+params(61)*params(67)/(1-params(67))*y(43));
    residual(13) = (y(18)) - (y(18)*params(59)+y(18)*params(60)+params(62)*y(21)+y(43)*params(67)*params(62)/(1-params(67)));
residual(14) = y(16);
    residual(15) = (y(9)) - (y(33)+y(23)*params(12)+y(11)*(1-params(13))+y(31)*params(30));
    residual(16) = (y(19)) - ((1-params(26)-params(1))*(y(16)*params(11)+params(25)*y(7))+y(19)*params(26)+params(1)*y(51));
    residual(17) = (y(27)) - (y(19)-y(16));
    residual(18) = (y(8)) - (y(10)+y(34));
    residual(19) = (y(20)) - (y(14)*(1-params(13))-y(33)+y(25)*params(12)-y(31)*params(30));
    residual(20) = (y(21)) - (y(15)-y(34)-y(6));
    residual(21) = (y(11)) - (y(25)+y(23)-y(14));
    residual(22) = (y(10)) - (y(11)+T(5)*(y(14)-y(15)-y(6))-T(5)*(y(41)*params(65)/(1+params(65))-params(66)/(1-params(66))*y(42)));
    residual(23) = (y(12)) - (y(9)+y(28)-y(49)-y(25)-y(23)-y(14)-y(11));
    residual(24) = (y(13)) - (y(8)+y(29)-y(49)-y(15)-y(10));
    residual(25) = (params(36)*y(36)/(params(36)+params(37))+y(38)*params(37)/(params(36)+params(37))) - ((1-params(68))*(T(6)*(y(1)+y(47)+y(28)-y(49))+T(7)*(y(1)+y(40)+y(29)-y(49)))+(1-params(69))*(params(89)*params(65)*params(91)/(params(36)+params(37))*(y(11)+y(14)+y(41))+params(90)*params(66)*params(92)/(params(36)+params(37))*(y(10)+y(15)+y(42)))+params(47)*y(44));
    residual(26) = (params(35)*y(37)/(params(35)+params(38))+y(39)*params(38)/(params(35)+params(38))) - (params(68)*((y(1)+y(47)+y(28)-y(49))*T(8)+(y(1)+y(40)+y(29)-y(49))*T(9))+params(69)*((y(11)+y(14)+y(41))*params(89)*params(65)*params(91)/(params(35)+params(38))+(y(10)+y(15)+y(42))*params(90)*params(66)*params(92)/(params(35)+params(38)))+params(67)*(params(87)/(params(35)+params(38))*(y(43)+y(12))+params(88)/(params(35)+params(38))*(y(43)+y(13)))-y(44)*params(54)+0.02*y(30)-params(55)*(y(19)+y(30))+y(45));
    residual(27) = (y(7)) - (y(39)*params(38)+y(38)*params(37)+params(35)*y(37)+params(36)*y(36)+y(1)*params(34)+y(5)*params(32)+y(26)*params(33));
    residual(28) = (y(7)) - (y(9)*(1-params(8))+y(8)*params(8));
    residual(29) = (y(32)) - (T(3));
    residual(30) = (y(50)) - ((y(11)+y(14))*params(89)*params(91)+(y(10)+y(15))*params(90)*params(92));
    residual(31) = (y(6)) - (y(6)+y(18)-y(17));
residual(32) = y(17);
residual(33) = y(18);
    residual(34) = (y(49)) - (y(28)*(1-params(7))+y(29)*params(7));
    residual(35) = (y(1)) - (y(3)*(1-params(16))+y(2)*params(16));
    residual(36) = (y(45)) - (y(30)*params(17)+y(48));
    residual(37) = (y(33)) - (y(33)*params(71)+x(1));
    residual(38) = (y(34)) - (y(34)*params(72)+x(2));
    residual(39) = (y(36)) - (y(36)*params(73)+x(3));
    residual(40) = (y(37)) - (y(37)*params(74)+x(4));
    residual(41) = (y(38)) - (y(38)*params(75)+x(5));
    residual(42) = (y(39)) - (y(39)*params(76)+x(6));
    residual(43) = (y(47)) - (y(47)*params(84));
    residual(44) = (y(41)) - (y(41)*params(79));
    residual(45) = (y(42)) - (y(42)*params(80));
    residual(46) = (y(43)) - (y(43)*params(81));
    residual(47) = (y(40)) - (y(40)*params(78));
    residual(48) = (y(46)) - (y(46)*params(83));
    residual(49) = (y(35)) - (y(35)*params(77));
    residual(50) = (y(48)) - (y(48)*params(82));
    residual(51) = (y(51)) - (y(19));

end
