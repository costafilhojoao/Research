function [T_order, T] = static_resid_tt(y, x, params, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 23
    T = [T; NaN(23 - size(T, 1), 1)];
end
T(1) = (1-params(14))*(y(18)/y(4))^(-params(15));
T(2) = y(19)/y(4);
T(3) = params(14)*T(2)^(-params(15));
T(4) = y(1)-y(2)^params(7)/params(7);
T(5) = T(4)^(-params(6));
T(6) = y(2)^(params(7)-1);
T(7) = (1-params(14))*y(18)^(1-params(15))+params(14)*y(19)^(1-params(15));
T(8) = (1-params(14))^(1/params(15));
T(9) = (params(15)-1)/params(15);
T(10) = params(14)^(1/params(15));
T(11) = T(8)*y(20)^T(9)+T(10)*y(21)^T(9);
T(12) = exp((y(6))/((y(4))*(y(8)))-y(6)/(y(4)*y(8)));
T(13) = (1-params(3))*y(27)^(1/(1-params(3)));
T(14) = y(7)^(params(3)/(1-params(3)));
T(15) = y(2)*y(5)*params(2)/(1-params(3));
T(16) = (y(7)/y(27))^(-1);
T(17) = (1+params(8))^(-1);
T(18) = 1/(1+params(8));
T(19) = 1/(1+params(8))^2;
T(20) = (y(12)*params(1))^((-1)/(params(2)-1));
T(21) = (y(12)*params(1))^(1/(params(2)-1));
T(22) = y(27)*T(21);
T(23) = y(2)^(1-params(3));
end
