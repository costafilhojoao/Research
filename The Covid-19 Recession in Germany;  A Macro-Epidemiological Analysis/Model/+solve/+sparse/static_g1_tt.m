function [T_order, T] = static_g1_tt(y, x, params, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = solve.sparse.static_resid_tt(y, x, params, T_order, T);
T_order = 1;
if size(T, 1) < 40
    T = [T; NaN(40 - size(T, 1), 1)];
end
T(32) = getPowerDeriv(y(2),1-params(14),1);
T(33) = 1/params(10);
T(34) = getPowerDeriv(y(26)*y(47),T(10),1);
T(35) = getPowerDeriv(y(26)*y(47),T(12),1);
T(36) = (-(params(1)*getPowerDeriv(y(26),T(12),1)))/(1-params(1));
T(37) = getPowerDeriv(y(54),1-params(14),1);
T(38) = getPowerDeriv(y(78)*y(99),T(10),1);
T(39) = getPowerDeriv(y(78)*y(99),T(12),1);
T(40) = (-(params(20)*getPowerDeriv(y(78),T(12),1)))/(1-params(20));
end
