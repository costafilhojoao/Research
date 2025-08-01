function [T_order, T] = static_g1_tt(y, x, params, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = dynamic.sparse.static_resid_tt(y, x, params, T_order, T);
T_order = 1;
if size(T, 1) < 35
    T = [T; NaN(35 - size(T, 1), 1)];
end
T(24) = getPowerDeriv(T(4),(-params(6)),1);
T(25) = T(24)*(-(getPowerDeriv(y(2),params(7),1)/params(7)));
T(26) = getPowerDeriv(y(18)/y(4),(-params(15)),1);
T(27) = (1-params(14))*(-y(18))/(y(4)*y(4))*T(26);
T(28) = getPowerDeriv(T(2),(-params(15)),1);
T(29) = params(14)*(-y(19))/(y(4)*y(4))*T(28);
T(30) = getPowerDeriv(y(7)/y(27),(-1),1);
T(31) = params(1)*getPowerDeriv(y(12)*params(1),(-1)/(params(2)-1),1);
T(32) = 1/y(4);
T(33) = (1-params(14))*T(26)*T(32);
T(34) = getPowerDeriv(T(7),1/(1-params(15)),1);
T(35) = getPowerDeriv(T(11),params(15)/(params(15)-1),1);
end
