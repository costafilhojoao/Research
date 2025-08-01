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
    T = model.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(33, 51);
g1(1,8)=(-T(1));
g1(1,11)=(-(y(8)*T(27)));
g1(1,27)=1;
g1(1,29)=(-(y(8)*T(32)));
g1(2,8)=(-T(3));
g1(2,11)=(-(y(8)*T(29)));
g1(2,28)=1;
g1(2,30)=(-(y(8)*params(14)*T(28)*1/y(11)));
g1(3,8)=T(24);
g1(3,9)=T(25);
g1(3,10)=(-y(11));
g1(3,11)=(-y(10));
g1(4,8)=T(6)*T(24);
g1(4,9)=T(6)*T(25)+T(5)*getPowerDeriv(y(9),params(7)-1,1);
g1(4,10)=(-y(12));
g1(4,12)=(-y(10));
g1(5,10)=(-(1+params(8)));
g1(5,41)=1+y(40);
g1(5,40)=y(41);
g1(6,8)=y(11);
g1(6,9)=(-y(12));
g1(6,11)=y(8);
g1(6,12)=(-y(9));
g1(6,1)=(-(1+y(7)));
g1(6,13)=1;
g1(6,16)=(-1);
g1(6,37)=1;
g1(6,7)=(-y(1));
g1(7,8)=1;
g1(7,27)=(-(T(7)*getPowerDeriv(y(27),T(8),1)*T(31)));
g1(7,28)=(-(T(31)*T(9)*getPowerDeriv(y(28),T(8),1)));
g1(8,11)=1;
g1(8,29)=(-((1-params(14))*getPowerDeriv(y(29),1-params(15),1)*T(33)));
g1(8,30)=(-(T(33)*params(14)*getPowerDeriv(y(30),1-params(15),1)));
g1(9,11)=y(36);
g1(9,36)=y(11);
g1(9,37)=(-1);
g1(10,5)=(-(params(10)*1/y(5)));
g1(10,36)=1/y(36);
g1(10,49)=(-1);
g1(11,11)=(-(y(36)*T(27)));
g1(11,29)=(-(y(36)*T(32)));
g1(11,31)=1;
g1(11,36)=(-T(1));
g1(12,11)=(-(y(36)*T(29)));
g1(12,30)=(-(y(36)*params(14)*T(28)*1/y(11)));
g1(12,32)=1;
g1(12,36)=(-T(3));
g1(13,11)=(-(params(13)*T(12)*(-((-(y(13)*y(15)))/(y(11)*y(15)*y(11)*y(15))))));
g1(13,13)=(-(params(13)*T(12)*(-(1/(y(11)*y(15))))));
g1(13,15)=(-(params(13)*T(12)*(-((-(y(11)*y(13)))/(y(11)*y(15)*y(11)*y(15))))));
g1(13,7)=(-params(11));
g1(13,40)=1;
g1(13,50)=(-1);
g1(14,4)=(-(params(12)*1/y(4)));
g1(14,30)=1/y(30);
g1(14,51)=(-1);
g1(15,11)=(-(y(15)*T(13)));
g1(15,15)=(-(y(11)*T(13)));
g1(15,2)=(-(y(15)*y(11)*params(16)/2*(-y(17))/(y(2)*y(2))*2*(y(17)/y(2)-1)));
g1(15,17)=(-(y(15)*y(11)*params(16)/2*2*(y(17)/y(2)-1)*1/y(2)));
g1(15,33)=1;
g1(16,11)=(-(y(33)*T(27)));
g1(16,29)=(-(y(33)*T(32)));
g1(16,33)=(-T(1));
g1(16,34)=1;
g1(17,11)=(-(y(33)*T(29)));
g1(17,30)=(-(y(33)*params(14)*T(28)*1/y(11)));
g1(17,33)=(-T(3));
g1(17,35)=1;
g1(18,26)=1;
g1(18,27)=(-1);
g1(18,31)=(-1);
g1(18,34)=(-1);
g1(18,39)=(-1);
g1(19,25)=1;
g1(19,26)=(-(params(1)*T(14)));
g1(19,29)=(-(y(26)*params(1)*getPowerDeriv(y(29),params(2),1)));
g1(20,11)=(-(y(18)*(y(18)-1)*y(15)*params(16)));
g1(20,14)=y(17)-params(2)*y(24);
g1(20,15)=(-(y(18)*y(11)*params(16)*(y(18)-1)));
g1(20,17)=y(23)+y(14);
g1(20,18)=(-(y(15)*y(11)*params(16)*(y(18)-1)+y(15)*y(11)*params(16)*y(18)));
g1(20,23)=y(17);
g1(20,24)=(-(params(2)*y(14)));
g1(21,42)=(-(T(15)*(y(43)-params(2)*y(46))));
g1(21,17)=y(23);
g1(21,43)=(-(T(15)*(y(42)+y(45))));
g1(21,23)=y(17);
g1(21,45)=(-(T(15)*y(43)));
g1(21,46)=(-(T(15)*(-(params(2)*y(42)))));
g1(22,43)=(-(T(15)*y(46)*y(47)*getPowerDeriv(y(43),(-params(2)),1)));
g1(22,20)=1;
g1(22,44)=(-(T(15)*(1-params(5))));
g1(22,46)=(-(T(15)*T(17)));
g1(22,47)=(-(T(15)*y(46)*T(16)));
g1(23,12)=(-(T(19)*1/T(18)));
g1(23,14)=(-(y(12)/T(18)*getPowerDeriv(y(14),params(3)/(1-params(3)),1)));
g1(23,19)=1;
g1(23,38)=(-(T(19)*(-(y(12)*(1-params(3))*getPowerDeriv(y(38),1/(1-params(3)),1)))/(T(18)*T(18))));
g1(24,17)=(-(1/y(19)));
g1(24,19)=(-((-y(17))/(y(19)*y(19))));
g1(24,21)=1;
g1(25,14)=(-params(4));
g1(25,3)=(-(1-params(5)));
g1(25,22)=1;
g1(26,6)=(-(params(9)*1/y(6)));
g1(26,38)=1/y(38);
g1(26,48)=(-1);
g1(27,17)=(-1);
g1(27,19)=1;
g1(27,20)=(-params(4));
g1(27,24)=1;
g1(28,2)=(-y(18));
g1(28,17)=1;
g1(28,18)=(-y(2));
g1(29,17)=(-T(20));
g1(29,3)=(-(y(17)*T(30)));
g1(29,29)=1;
g1(30,9)=(-(T(22)*getPowerDeriv(y(9),1-params(3),1)));
g1(30,15)=1;
g1(30,3)=(-(T(23)*y(38)*params(1)*getPowerDeriv(params(1)*y(3),1/(params(2)-1),1)));
g1(30,38)=(-(T(21)*T(23)));
g1(31,8)=(-1);
g1(31,11)=(-((-(y(29)*y(39)))/(y(11)*y(11))-(y(35)+y(28)+y(32))*(-y(30))/(y(11)*y(11))));
g1(31,15)=1;
g1(31,28)=T(2);
g1(31,29)=(-(y(39)/y(11)));
g1(31,30)=(y(35)+y(28)+y(32))*1/y(11);
g1(31,32)=T(2);
g1(31,35)=T(2);
g1(31,36)=(-1);
g1(31,39)=(-(y(29)/y(11)));
g1(32,9)=y(12);
g1(32,11)=(-y(15));
g1(32,12)=y(9);
g1(32,15)=(-y(11));
g1(32,16)=1;
g1(33,14)=1;
g1(33,15)=(-T(20));
g1(33,3)=(-(y(15)*T(30)));

end
