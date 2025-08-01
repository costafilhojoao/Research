function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 31
    T = [T; NaN(31 - size(T, 1), 1)];
end
T(1) = (1-params(14))*(y(56)/y(42))^(-params(15));
T(2) = y(57)/y(42);
T(3) = params(14)*T(2)^(-params(15));
T(4) = y(39)-y(40)^params(7)/params(7);
T(5) = T(4)^(-params(6));
T(6) = y(40)^(params(7)-1);
T(7) = (1-params(14))*y(56)^(1-params(15))+params(14)*y(57)^(1-params(15));
T(8) = (1-params(14))^(1/params(15));
T(9) = (params(15)-1)/params(15);
T(10) = params(14)^(1/params(15));
T(11) = T(8)*y(58)^T(9)+T(10)*y(59)^T(9);
T(12) = exp((steady_state(6))/((steady_state(4))*(steady_state(8)))-y(44)/(y(42)*y(46)));
T(13) = y(55)/y(17)-1;
T(14) = params(16)/2*T(13)^2;
T(15) = (1-params(3))*y(65)^(1/(1-params(3)));
T(16) = y(45)^(params(3)/(1-params(3)));
T(17) = (-(y(42)*y(46)*params(4)))/(params(2)*y(45));
T(18) = y(42)*y(46)*params(4)/(params(2)*y(12));
T(19) = params(2)*y(81)/(1-params(3))*y(78);
T(20) = (y(83)/y(103))^(-1);
T(21) = params(16)*(y(93)/y(55)-1);
T(22) = y(55)^(-1);
T(23) = T(21)*T(22);
T(24) = (1+params(8))^(-1);
T(25) = 1/(1+params(8));
T(26) = 1/(1+params(8))^2;
T(27) = (y(12)*params(1))^((-1)/(params(2)-1));
T(28) = (y(12)*params(1))^(1/(params(2)-1));
T(29) = y(65)*T(28);
T(30) = y(40)^(1-params(3));
T(31) = y(93)^2;
end
