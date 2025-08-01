function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = solve.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 40
    T = [T; NaN(40 - size(T, 1), 1)];
end
T(32) = getPowerDeriv(y(2),1-params(14),1);
T(33) = 1/params(10);
T(34) = getPowerDeriv(y(125)*y(245),T(10),1);
T(35) = getPowerDeriv(y(125)*y(245),T(12),1);
T(36) = (-(params(1)*getPowerDeriv(y(125),T(12),1)))/(1-params(1));
T(37) = getPowerDeriv(y(54),1-params(14),1);
T(38) = getPowerDeriv(y(177)*y(297),T(10),1);
T(39) = getPowerDeriv(y(177)*y(297),T(12),1);
T(40) = (-(params(20)*getPowerDeriv(y(177),T(12),1)))/(1-params(20));
end
