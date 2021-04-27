function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
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
%   g1
%

if T_flag
    T = NK_Course.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(35, 50);
g1(1,7)=1;
g1(1,10)=(-(T(20)*T(21)/(1-params(8))));
g1(1,18)=(-(T(21)*T(2)*T(27)/(1-params(8))));
g1(2,8)=1;
g1(2,10)=(-(T(4)*T(22)));
g1(2,18)=(-(T(5)*T(28)));
g1(3,8)=1;
g1(3,42)=(-params(6));
g1(4,8)=(-(y(6)/y(31)));
g1(4,23)=1;
g1(4,31)=(-(y(8)*(-y(6))/(y(31)*y(31))));
g1(4,6)=(-(y(8)*T(12)));
g1(5,8)=(-T(8))/(y(8)*y(8));
g1(5,10)=T(24)/y(8);
g1(5,11)=(-1);
g1(5,18)=T(30)/y(8);
g1(6,12)=(-(1-params(4)));
g1(6,13)=1;
g1(7,10)=(-(T(10)*y(19)*T(25)));
g1(7,12)=1;
g1(7,2)=(-(T(9)*T(26)));
g1(7,19)=(-(T(10)*y(10)*T(25)));
g1(8,10)=(-(y(14)*y(12)*params(3)))/(y(10)*y(10));
g1(8,11)=(-1);
g1(8,12)=params(3)*y(14)/y(10);
g1(8,14)=y(12)*params(3)/y(10);
g1(9,13)=1;
g1(9,16)=(-1);
g1(9,18)=(-1);
g1(9,20)=(-1);
g1(10,3)=(-((-y(16))/(y(3)*y(3))));
g1(10,16)=(-(1/y(3)));
g1(10,21)=1;
g1(11,2)=(-(1-params(7)));
g1(11,15)=1;
g1(11,16)=(-T(11));
g1(11,21)=(-(y(16)*(-(params(12)*(y(21)-1)*2.0))));
g1(12,1)=(-((-(y(21)*(y(21)-1)*params(12)*2.0*y(22)))/(y(1)*y(1))));
g1(12,21)=(-(y(22)*((y(21)-1)*params(12)*2.0+y(21)*params(12)*2.0)/y(1)));
g1(12,22)=(-(y(21)*(y(21)-1)*params(12)*2.0/y(1)));
g1(12,24)=1;
g1(13,21)=y(22)*((-(params(12)*(y(21)-1)*2.0))-((y(21)-1)*params(12)*2.0+params(12)*y(21)*2.0));
g1(13,22)=T(11)-(y(21)-1)*params(12)*y(21)*2.0;
g1(13,43)=1;
g1(14,31)=(-((-1)/(y(31)*y(31))));
g1(14,33)=1;
g1(15,9)=1;
g1(15,6)=(-y(33));
g1(15,33)=(-y(6));
g1(16,12)=(-((1-params(3))*y(14)/y(2)));
g1(16,14)=(-(y(12)*(1-params(3))/y(2)));
g1(16,2)=(-((-(y(12)*(1-params(3))*y(14)))/(y(2)*y(2))));
g1(16,22)=(-(1-params(7)));
g1(16,25)=1;
g1(17,22)=(-((-y(44))/(y(22)*y(22))));
g1(17,44)=(-(1/y(22)));
g1(17,32)=y(47);
g1(17,47)=y(32);
g1(18,10)=(-(y(11)*y(17)));
g1(18,11)=(-(y(10)*y(17)));
g1(18,17)=(-(y(10)*y(11)));
g1(18,20)=1;
g1(19,8)=(-y(13));
g1(19,13)=(-y(8));
g1(19,27)=1;
g1(19,45)=(-(params(6)*params(13)));
g1(20,8)=(-(T(14)*y(26)));
g1(20,13)=(-(y(26)*y(8)*T(13)));
g1(20,26)=(-(y(8)*T(14)));
g1(20,29)=1;
g1(20,46)=(-(params(6)*params(13)));
g1(21,27)=(-T(15));
g1(21,28)=1;
g1(21,31)=(-(y(27)*T(33)));
g1(22,29)=(-T(16));
g1(22,30)=1;
g1(22,31)=(-(y(29)*T(34)));
g1(23,27)=(-((1-params(13))*T(31)*T(32)));
g1(23,29)=(-((1-params(13))*T(32)*1/y(27)));
g1(23,31)=(-(params(13)*T(33)));
g1(24,14)=(-1);
g1(24,26)=1;
g1(25,31)=(-(T(12)*params(15)));
g1(25,6)=(-(params(14)*T(35)/T(18)));
g1(25,32)=T(35)/T(17);
g1(25,50)=(-1);
g1(26,4)=(-(params(9)*1/y(4)));
g1(26,19)=1/y(19);
g1(26,48)=(-1);
g1(27,5)=(-(params(10)*1/y(5)));
g1(27,20)=1/y(20);
g1(27,49)=(-1);
g1(28,13)=(-(1/(steady_state(7))));
g1(28,36)=1;
g1(29,15)=(-(1/(steady_state(9))));
g1(29,41)=1;
g1(30,16)=(-(1/(steady_state(10))));
g1(30,40)=1;
g1(31,18)=(-(1/(steady_state(12))));
g1(31,37)=1;
g1(32,11)=(-(1/(steady_state(5))));
g1(32,39)=1;
g1(33,10)=(-(1/(steady_state(4))));
g1(33,38)=1;
g1(34,9)=(-(1/(steady_state(3))));
g1(34,34)=1;
g1(35,32)=(-T(35));
g1(35,35)=1;

end
