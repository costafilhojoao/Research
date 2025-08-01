function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 9
    T = [T; NaN(9 - size(T, 1), 1)];
end
T(1) = params(63)/(1+params(63));
T(2) = (1-params(2)*(1-params(3)))^(-1);
T(3) = params(89)/(params(89)+params(90))*y(62)+params(90)/(params(89)+params(90))*y(61);
T(4) = (params(5)-params(6))*T(3);
T(5) = params(6)^(-1);
T(6) = params(63)*params(34)/(params(36)+params(37));
T(7) = params(64)*params(32)/(params(36)+params(37));
T(8) = params(63)*params(34)/(params(35)+params(38));
T(9) = params(64)*params(32)/(params(35)+params(38));
end
