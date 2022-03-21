function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = model.static_g1_tt(T, y, x, params);
end
g1 = zeros(34, 34);
g1(1,1)=T(22);
g1(1,2)=T(23);
g1(1,3)=(-y(4));
g1(1,4)=(-y(3));
g1(2,1)=T(3)*T(22);
g1(2,2)=T(3)*T(23)+T(2)*getPowerDeriv(y(2),params(7)-1,1);
g1(2,3)=(-y(5));
g1(2,5)=(-y(3));
g1(3,3)=(-(1+params(8)));
g1(3,24)=y(29);
g1(3,29)=1+y(24);
g1(5,1)=y(4);
g1(5,2)=(-y(5));
g1(5,4)=y(1);
g1(5,5)=(-y(2));
g1(5,6)=1-(1+y(24));
g1(5,9)=(-1);
g1(5,21)=1;
g1(5,24)=(-y(6));
g1(6,1)=1;
g1(6,15)=(-(T(4)*getPowerDeriv(y(15),T(5),1)*T(29)));
g1(6,16)=(-(T(29)*T(6)*getPowerDeriv(y(16),T(5),1)));
g1(7,1)=(-T(9));
g1(7,4)=(-(y(1)*T(25)));
g1(7,15)=1;
g1(7,17)=(-(y(1)*T(30)));
g1(8,1)=(-T(11));
g1(8,4)=(-(y(1)*T(27)));
g1(8,16)=1;
g1(8,18)=(-(y(1)*params(14)*T(26)*1/y(4)));
g1(9,4)=y(22);
g1(9,21)=(-1);
g1(9,22)=y(4);
g1(10,22)=1/y(22)-((1-params(10))*1/(y(22))+params(10)*1/y(22));
g1(11,19)=(-(T(4)*getPowerDeriv(y(19),T(5),1)*T(31)));
g1(11,20)=(-(T(31)*T(6)*getPowerDeriv(y(20),T(5),1)));
g1(11,22)=1;
g1(12,4)=(-(y(22)*T(25)));
g1(12,17)=(-(y(22)*T(30)));
g1(12,19)=1;
g1(12,22)=(-T(9));
g1(13,4)=(-(y(22)*T(27)));
g1(13,18)=(-(y(22)*params(14)*T(26)*1/y(4)));
g1(13,20)=1;
g1(13,22)=(-T(11));
g1(14,4)=(-(params(13)*T(13)*((-((y(6))*(y(8))))/((y(4))*(y(8))*(y(4))*(y(8)))-(-(y(6)*y(8)))/(y(4)*y(8)*y(4)*y(8)))));
g1(14,6)=(-(params(13)*T(13)*(1/((y(4))*(y(8)))-1/(y(4)*y(8)))));
g1(14,8)=(-(params(13)*T(13)*((-((y(6))*(y(4))))/((y(4))*(y(8))*(y(4))*(y(8)))-(-(y(4)*y(6)))/(y(4)*y(8)*y(4)*y(8)))));
g1(15,18)=1/y(18)-((1-params(12))*1/(y(18))+params(12)*1/y(18));
g1(16,26)=1;
g1(17,4)=(-(y(26)*T(25)));
g1(17,17)=(-(y(26)*T(30)));
g1(17,26)=(-T(9));
g1(17,27)=1;
g1(18,4)=(-(y(26)*T(27)));
g1(18,18)=(-(y(26)*params(14)*T(26)*1/y(4)));
g1(18,26)=(-T(11));
g1(18,28)=1;
g1(19,10)=(params(2)-1)/params(2);
g1(19,11)=(-1);
g1(19,12)=params(4);
g1(20,10)=y(33)*y(34)*(y(10)*y(32)*params(16)/params(2)*(-y(32))/(y(10)*y(10))-T(15))/(y(10)*y(10))/y(14);
g1(20,12)=1+params(8);
g1(20,14)=(-((-(1/params(2)*y(32)*y(31)))/(y(14)*y(14))-(-(T(15)/y(10)*y(34)*y(33)))/(y(14)*y(14))));
g1(20,30)=1-params(5);
g1(20,31)=(-(1/params(2)*y(32)/y(14)));
g1(20,32)=(-(1/params(2)*y(31)/y(14)-y(33)*y(34)*(T(14)+y(32)*params(16)/params(2)*1/y(10))/y(10)/y(14)));
g1(20,33)=T(15)/y(10)*y(34)/y(14);
g1(20,34)=T(15)/y(10)*y(33)/y(14);
g1(26,5)=(-(T(17)*1/T(16)));
g1(26,7)=(-(y(5)/T(16)*getPowerDeriv(y(7),params(3)/(1-params(3)),1)));
g1(26,11)=1;
g1(26,23)=(-(T(17)*(-(y(5)*(1-params(3))*getPowerDeriv(y(23),1/(1-params(3)),1)))/(T(16)*T(16))));
g1(27,10)=(-(1/y(11)));
g1(27,11)=(-((-y(10))/(y(11)*y(11))));
g1(27,13)=1;
g1(28,7)=(-params(4));
g1(28,14)=1-(1-params(5));
g1(29,23)=1/y(23)-((1-params(9))*1/(y(23))+params(9)*1/y(23));
g1(30,10)=(-T(18));
g1(30,14)=(-(y(10)*T(28)));
g1(30,17)=1;
g1(31,2)=(-(T(20)*getPowerDeriv(y(2),1-params(3),1)));
g1(31,8)=1;
g1(31,14)=(-(T(21)*y(23)*params(1)*getPowerDeriv(y(14)*params(1),1/(params(2)-1),1)));
g1(31,23)=(-(T(19)*T(21)));
g1(32,1)=(-1);
g1(32,4)=(-((-(y(17)*y(25)))/(y(4)*y(4))-(y(28)+y(16)+y(20))*(-y(18))/(y(4)*y(4))));
g1(32,8)=1;
g1(32,16)=T(10);
g1(32,17)=(-(y(25)/y(4)));
g1(32,18)=(y(28)+y(16)+y(20))*1/y(4);
g1(32,20)=T(10);
g1(32,22)=(-1);
g1(32,25)=(-(y(17)/y(4)));
g1(32,28)=T(10);
g1(33,2)=y(5);
g1(33,4)=(-y(8));
g1(33,5)=y(2);
g1(33,8)=(-y(4));
g1(33,9)=1;
g1(34,7)=1;
g1(34,8)=(-T(18));
g1(34,14)=(-(y(8)*T(28)));
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
