function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = dynamic.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 42
    T = [T; NaN(42 - size(T, 1), 1)];
end
T(32) = getPowerDeriv(T(4),(-params(6)),1);
T(33) = T(32)*(-(getPowerDeriv(y(40),params(7),1)/params(7)));
T(34) = getPowerDeriv(y(56)/y(42),(-params(15)),1);
T(35) = (1-params(14))*(-y(56))/(y(42)*y(42))*T(34);
T(36) = getPowerDeriv(T(2),(-params(15)),1);
T(37) = params(14)*(-y(57))/(y(42)*y(42))*T(36);
T(38) = getPowerDeriv(y(83)/y(103),(-1),1);
T(39) = params(1)*getPowerDeriv(y(12)*params(1),(-1)/(params(2)-1),1);
T(40) = (1-params(14))*T(34)*1/y(42);
T(41) = getPowerDeriv(T(7),1/(1-params(15)),1);
T(42) = getPowerDeriv(T(11),params(15)/(params(15)-1),1);
end
