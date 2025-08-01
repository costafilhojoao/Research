function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 31
    T = [T; NaN(31 - size(T, 1), 1)];
end
T(1) = y(2)^(1-params(14));
T(2) = y(102)^params(14);
T(3) = 1/(params(12)*params(14)^params(14)*(1-params(14))^(1-params(14)));
T(4) = T(3)*y(103)^params(14);
T(5) = y(104)^(1-params(14));
T(6) = y(102)^(params(14)-1);
T(7) = params(12)*params(14)*y(126)*T(6);
T(8) = params(13)/2;
T(9) = y(114)*y(108)*y(229)*y(113)*params(5)*y(231)+y(111)*y(108)*y(230)*y(110)*params(6)*y(232)+params(7)*y(108)*(1-y(248));
T(10) = params(4)/(params(4)-1);
T(11) = params(10)*params(1)*(y(125)*y(245))^T(10);
T(12) = 1/(params(4)-1);
T(13) = params(10)*params(1)*(y(125)*y(245))^T(12);
T(14) = (1-params(1)*y(125)^T(12))/(1-params(1));
T(15) = T(14)^(-(params(4)-1));
T(16) = params(1)*y(125)^T(10);
T(17) = log(y(113))-T(8)*y(110)^2;
T(18) = log(y(114))-T(8)*y(111)^2;
T(19) = log(y(115))-T(8)*y(112)^2;
T(20) = y(54)^(1-params(14));
T(21) = y(154)^params(14);
T(22) = T(3)*y(155)^params(14);
T(23) = y(156)^(1-params(14));
T(24) = y(154)^(params(14)-1);
T(25) = params(12)*params(14)*y(178)*T(24);
T(26) = y(166)*y(160)*y(281)*params(5)*y(165)*y(283)+y(163)*y(160)*y(282)*params(6)*y(162)*y(284)+(1-y(248))*params(7)*y(160);
T(27) = params(10)*params(20)*(y(177)*y(297))^T(10);
T(28) = params(10)*params(20)*(y(177)*y(297))^T(12);
T(29) = (1-params(20)*y(177)^T(12))/(1-params(20));
T(30) = T(29)^(-(params(4)-1));
T(31) = params(20)*y(177)^T(10);
end
