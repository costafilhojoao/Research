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
    T = model6a.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(34, 55);
g1(1,13)=T(26);
g1(1,14)=T(27);
g1(1,15)=(-y(16));
g1(1,16)=(-y(15));
g1(2,13)=T(3)*T(26);
g1(2,14)=T(3)*T(27)+T(2)*getPowerDeriv(y(14),params(7)-1,1);
g1(2,15)=(-y(17));
g1(2,17)=(-y(15));
g1(3,15)=(-(1+params(8)));
g1(3,36)=y(41);
g1(3,41)=1+y(36);
g1(4,7)=(-1);
g1(4,41)=1;
g1(4,50)=(-1);
g1(5,13)=y(16);
g1(5,14)=(-y(17));
g1(5,16)=y(13);
g1(5,17)=(-y(14));
g1(5,1)=(-(1+y(6)));
g1(5,18)=1;
g1(5,21)=(-1);
g1(5,34)=1;
g1(5,6)=(-y(1));
g1(6,13)=1;
g1(6,27)=(-(T(4)*getPowerDeriv(y(27),T(5),1)*T(33)));
g1(6,28)=(-(T(33)*T(6)*getPowerDeriv(y(28),T(5),1)));
g1(7,13)=(-T(9));
g1(7,16)=(-(y(13)*T(29)));
g1(7,27)=1;
g1(7,29)=(-(y(13)*T(34)));
g1(8,13)=(-T(11));
g1(8,16)=(-(y(13)*T(31)));
g1(8,28)=1;
g1(8,30)=(-(y(13)*params(14)*T(30)*1/y(16)));
g1(9,16)=1;
g1(9,29)=(-((1-params(14))*getPowerDeriv(y(29),1-params(15),1)*T(35)));
g1(9,30)=(-(T(35)*params(14)*getPowerDeriv(y(30),1-params(15),1)));
g1(10,16)=y(33);
g1(10,33)=y(16);
g1(10,34)=(-1);
g1(11,4)=(-(params(10)*1/y(4)));
g1(11,33)=1/y(33);
g1(11,48)=(-1);
g1(12,31)=(-(T(4)*getPowerDeriv(y(31),T(5),1)*T(36)));
g1(12,32)=(-(T(36)*T(6)*getPowerDeriv(y(32),T(5),1)));
g1(12,33)=1;
g1(13,16)=(-(y(33)*T(29)));
g1(13,29)=(-(y(33)*T(34)));
g1(13,31)=1;
g1(13,33)=(-T(9));
g1(14,16)=(-(y(33)*T(31)));
g1(14,30)=(-(y(33)*params(14)*T(30)*1/y(16)));
g1(14,32)=1;
g1(14,33)=(-T(11));
g1(15,18)=(-(params(13)*(-exp((steady_state(6))-y(18)))));
g1(15,6)=(-params(11));
g1(15,36)=1;
g1(15,49)=(-1);
g1(16,16)=(-(T(14)*y(20)));
g1(16,20)=(-(y(16)*T(14)));
g1(16,2)=(-(y(20)*y(16)*params(16)/2*(-y(22))/(y(2)*y(2))*2*(y(22)/y(2)-1)));
g1(16,22)=(-(y(20)*y(16)*params(16)/2*2*(y(22)/y(2)-1)*1/y(2)));
g1(16,38)=1;
g1(17,16)=(-(y(38)*T(29)));
g1(17,29)=(-(y(38)*T(34)));
g1(17,38)=(-T(9));
g1(17,39)=1;
g1(18,16)=(-(y(38)*T(31)));
g1(18,30)=(-(y(38)*params(14)*T(30)*1/y(16)));
g1(18,38)=(-T(11));
g1(18,40)=1;
g1(19,16)=y(22)*y(20)*T(16)/y(2)/y(19);
g1(19,19)=(-(y(22)*y(20)*y(16)*T(16)/y(2)))/(y(19)*y(19));
g1(19,20)=y(22)*y(16)*T(16)/y(2)/y(19);
g1(19,2)=(y(2)*y(22)*y(20)*y(16)*T(15)*(-y(22))/(y(2)*y(2))-y(22)*y(20)*y(16)*T(16))/(y(2)*y(2))/y(19);
g1(19,22)=(-((-((params(2)-1)/params(2)))-(y(20)*y(16)*T(16)+y(22)*y(20)*y(16)*T(15)*1/y(2))/y(2)/y(19)));
g1(19,23)=(-1);
g1(19,24)=params(4);
g1(20,22)=y(45)*y(46)*(y(22)*y(44)*T(15)*(-y(44))/(y(22)*y(22))-y(44)*T(15)*(y(44)/y(22)-1))/(y(22)*y(22))/y(26);
g1(20,24)=1+params(8);
g1(20,26)=(-((-(1/params(2)*y(44)*y(43)))/(y(26)*y(26))-(-T(19))/(y(26)*y(26))));
g1(20,42)=1-params(5);
g1(20,43)=(-(1/params(2)*y(44)/y(26)));
g1(20,44)=(-(1/params(2)*y(43)/y(26)-y(45)*y(46)*(T(15)*(y(44)/y(22)-1)+y(44)*T(15)*1/y(22))/y(22)/y(26)));
g1(20,45)=T(18)/y(26);
g1(20,46)=T(17)*y(45)/y(26);
g1(21,10)=(-1);
g1(21,44)=1;
g1(21,51)=(-1);
g1(22,8)=(-1);
g1(22,42)=1;
g1(22,52)=(-1);
g1(23,9)=(-1);
g1(23,43)=1;
g1(23,53)=(-1);
g1(24,11)=(-1);
g1(24,45)=1;
g1(24,54)=(-1);
g1(25,12)=(-1);
g1(25,46)=1;
g1(25,55)=(-1);
g1(26,17)=(-(T(21)*1/T(20)));
g1(26,19)=(-(y(17)/T(20)*getPowerDeriv(y(19),params(3)/(1-params(3)),1)));
g1(26,23)=1;
g1(26,35)=(-(T(21)*(-(y(17)*(1-params(3))*getPowerDeriv(y(35),1/(1-params(3)),1)))/(T(20)*T(20))));
g1(27,22)=(-(1/y(23)));
g1(27,23)=(-((-y(22))/(y(23)*y(23))));
g1(27,25)=1;
g1(28,19)=(-params(4));
g1(28,3)=(-(1-params(5)));
g1(28,26)=1;
g1(29,5)=(-(params(9)*1/y(5)));
g1(29,35)=1/y(35);
g1(29,47)=(-1);
g1(30,22)=(-T(22));
g1(30,3)=(-(y(22)*T(32)));
g1(30,29)=1;
g1(31,14)=(-(T(24)*getPowerDeriv(y(14),1-params(3),1)));
g1(31,20)=1;
g1(31,3)=(-(T(25)*y(35)*params(1)*getPowerDeriv(y(3)*params(1),1/(params(2)-1),1)));
g1(31,35)=(-(T(23)*T(25)));
g1(32,13)=(-1);
g1(32,16)=(-((-(y(22)*y(37)))/(y(16)*y(16))-(y(40)+y(28)+y(32))*(-y(30))/(y(16)*y(16))));
g1(32,20)=1;
g1(32,22)=(-(y(37)/y(16)));
g1(32,28)=T(10);
g1(32,30)=(y(40)+y(28)+y(32))*1/y(16);
g1(32,32)=T(10);
g1(32,33)=(-1);
g1(32,37)=(-(y(22)/y(16)));
g1(32,40)=T(10);
g1(33,14)=y(17);
g1(33,16)=(-y(20));
g1(33,17)=y(14);
g1(33,20)=(-y(16));
g1(33,21)=1;
g1(34,19)=1;
g1(34,20)=(-T(22));
g1(34,3)=(-(y(20)*T(32)));

end
