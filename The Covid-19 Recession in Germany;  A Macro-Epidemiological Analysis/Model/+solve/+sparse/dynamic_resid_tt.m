function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 28
    T = [T; NaN(28 - size(T, 1), 1)];
end
T(1) = y(2)^(1-params(14));
T(2) = y(101)^params(14);
T(3) = 1/(params(12)*params(14)^params(14)*(1-params(14))^(1-params(14)));
T(4) = T(3)*y(102)^params(14);
T(5) = y(103)^(1-params(14));
T(6) = y(101)^(params(14)-1);
T(7) = params(12)*params(14)*y(125)*T(6);
T(8) = params(13)/2;
T(9) = y(113)*y(107)*y(227)*y(112)*params(5)*y(229)+y(110)*y(107)*y(228)*y(109)*params(6)*y(230)+params(7)*y(107)*(1-y(246));
T(10) = params(4)/(params(4)-1);
T(11) = params(10)*params(1)*(y(124)*y(243))^T(10);
T(12) = 1/(params(4)-1);
T(13) = params(10)*params(1)*(y(124)*y(243))^T(12);
T(14) = (1-params(1)*y(124)^T(12))/(1-params(1));
T(15) = T(14)^(-(params(4)-1));
T(16) = params(1)*y(124)^T(10);
T(17) = y(53)^(1-params(14));
T(18) = y(152)^params(14);
T(19) = T(3)*y(153)^params(14);
T(20) = y(154)^(1-params(14));
T(21) = y(152)^(params(14)-1);
T(22) = params(12)*params(14)*y(176)*T(21);
T(23) = y(164)*y(158)*y(278)*params(5)*y(163)*y(280)+y(161)*y(158)*y(279)*params(6)*y(160)*y(281)+(1-y(246))*params(7)*y(158);
T(24) = params(10)*params(20)*(y(175)*y(294))^T(10);
T(25) = params(10)*params(20)*(y(175)*y(294))^T(12);
T(26) = (1-params(20)*y(175)^T(12))/(1-params(20));
T(27) = T(26)^(-(params(4)-1));
T(28) = params(20)*y(175)^T(10);
end
