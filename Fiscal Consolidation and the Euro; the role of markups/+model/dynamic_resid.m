function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(19, 1);
lhs = T(5);
rhs = y(8)*y(7);
residual(1) = lhs - rhs;
lhs = T(5)*T(6);
rhs = y(8)*y(9);
residual(2) = lhs - rhs;
lhs = y(24)*(1+y(23));
rhs = y(8)*(1+params(8));
residual(3) = lhs - rhs;
lhs = y(10);
rhs = (1+y(23))*y(1)+y(6)*y(9)+y(11)-y(12)-y(5)*y(7);
residual(4) = lhs - rhs;
lhs = y(7)*y(13);
rhs = y(12);
residual(5) = lhs - rhs;
lhs = log(y(13));
rhs = (1-params(10))*log(T(2))+params(10)*log(y(2))+x(it_, 2);
residual(6) = lhs - rhs;
lhs = y(22);
rhs = x(it_, 3);
residual(7) = lhs - rhs;
lhs = y(23);
rhs = params(8)+params(12)*(exp((-y(10)))-1);
residual(8) = lhs - rhs;
residual(9) = (params(2)-1)/params(2)*y(14)-y(15)+params(4)*y(16);
lhs = T(7)*y(25)*y(27)/y(18)-(1-params(5))*y(26);
rhs = (1+params(8))*y(16);
residual(10) = lhs - rhs;
lhs = y(15);
rhs = y(9)/T(8)*T(9);
residual(11) = lhs - rhs;
lhs = y(20);
rhs = y(14)/y(15);
residual(12) = lhs - rhs;
lhs = y(18);
rhs = params(4)*y(17)+(1-params(5))*y(3);
residual(13) = lhs - rhs;
lhs = log(y(19));
rhs = (1-params(9))*log(T(3))+params(9)*log(y(4))+x(it_, 1);
residual(14) = lhs - rhs;
lhs = y(7);
rhs = y(14)*T(10);
residual(15) = lhs - rhs;
lhs = y(21);
rhs = y(19)*T(11)*T(12);
residual(16) = lhs - rhs;
lhs = y(21);
rhs = y(22)+y(5)+y(13);
residual(17) = lhs - rhs;
lhs = y(11);
rhs = y(7)*y(21)-y(6)*y(9);
residual(18) = lhs - rhs;
lhs = y(17);
rhs = y(21)*T(11);
residual(19) = lhs - rhs;

end
