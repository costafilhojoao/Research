function g2 = dynamic_g2(T, y, x, params, steady_state, it_, T_flag)
% function g2 = dynamic_g2(T, y, x, params, steady_state, it_, T_flag)
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
%   g2
%

if T_flag
    T = rbc.dynamic_g2_tt(T, y, x, params, steady_state, it_);
end
v2 = zeros(24,3);
v2(1,1)=1;
v2(2,1)=1;
v2(3,1)=1;
v2(4,1)=1;
v2(5,1)=2;
v2(6,1)=2;
v2(7,1)=2;
v2(8,1)=2;
v2(9,1)=5;
v2(10,1)=5;
v2(11,1)=5;
v2(12,1)=5;
v2(13,1)=5;
v2(14,1)=5;
v2(15,1)=5;
v2(16,1)=5;
v2(17,1)=6;
v2(18,1)=6;
v2(19,1)=6;
v2(20,1)=7;
v2(21,1)=7;
v2(22,1)=7;
v2(23,1)=8;
v2(24,1)=8;
v2(1,2)=40;
v2(2,2)=131;
v2(3,2)=128;
v2(4,2)=95;
v2(5,2)=40;
v2(6,2)=42;
v2(7,2)=64;
v2(8,2)=66;
v2(9,2)=1;
v2(10,2)=6;
v2(11,2)=61;
v2(12,2)=7;
v2(13,2)=73;
v2(14,2)=66;
v2(15,2)=67;
v2(16,2)=78;
v2(17,2)=30;
v2(18,2)=63;
v2(19,2)=66;
v2(20,2)=25;
v2(21,2)=3;
v2(22,2)=1;
v2(23,2)=14;
v2(24,2)=79;
v2(1,3)=T(13);
v2(2,3)=(-((1-params(3)+y(8))*params(2)*params(4)*getPowerDeriv(y(11),(-1),2)));
v2(3,3)=(-T(8));
v2(4,3)=v2(3,3);
v2(5,3)=(-((T(1)*T(1)*(-((-T(3))*T(13)))-(-((-T(3))*T(7)))*(T(1)*T(7)+T(1)*T(7)))/(T(1)*T(1)*T(1)*T(1))));
v2(6,3)=(-((-(T(7)*T(11)))/(T(1)*T(1))));
v2(7,3)=v2(6,3);
v2(8,3)=(-((-((-params(5))*getPowerDeriv(1-y(6),(-1),2)))/T(1)));
v2(9,3)=(-(T(6)*y(7)*getPowerDeriv(y(1),params(1),2)));
v2(10,3)=(-(T(10)*T(12)));
v2(11,3)=v2(10,3);
v2(12,3)=(-(T(6)*T(9)));
v2(13,3)=v2(12,3);
v2(14,3)=(-(T(5)*getPowerDeriv(y(6),1-params(1),2)));
v2(15,3)=(-(T(4)*T(12)));
v2(16,3)=v2(15,3);
v2(17,3)=(-((-(1-params(1)))/(y(6)*y(6))));
v2(18,3)=v2(17,3);
v2(19,3)=(-((-((-(y(3)*(1-params(1))))*(y(6)+y(6))))/(y(6)*y(6)*y(6)*y(6))));
v2(20,3)=(-((-params(1))/(y(1)*y(1))));
v2(21,3)=v2(20,3);
v2(22,3)=(-((-((-(y(3)*params(1)))*(y(1)+y(1))))/(y(1)*y(1)*y(1)*y(1))));
v2(23,3)=(-(params(6)*(-1)/(y(2)*y(2))));
v2(24,3)=(-1)/(y(7)*y(7));
g2 = sparse(v2(:,1),v2(:,2),v2(:,3),8,144);
end
