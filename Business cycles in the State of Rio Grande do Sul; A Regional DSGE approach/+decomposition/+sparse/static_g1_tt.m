function [T_order, T] = static_g1_tt(y, x, params, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = decomposition.sparse.static_resid_tt(y, x, params, T_order, T);
T_order = 1;
if size(T, 1) < 13
    T = [T; NaN(13 - size(T, 1), 1)];
end
T(10) = (-((1-params(69))*params(90)*params(66)*params(92)/(params(36)+params(37))));
T(11) = (-(params(69)*params(90)*params(66)*params(92)/(params(35)+params(38))));
T(12) = (-((1-params(69))*params(89)*params(65)*params(91)/(params(36)+params(37))));
T(13) = (-(params(69)*params(89)*params(65)*params(91)/(params(35)+params(38))));
end
