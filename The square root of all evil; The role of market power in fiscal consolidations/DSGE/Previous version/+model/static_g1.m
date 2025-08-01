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
g1 = zeros(33, 33);
g1(1,1)=(-T(1));
g1(1,4)=(-(y(1)*T(26)));
g1(1,20)=1;
g1(1,22)=(-(y(1)*T(31)));
g1(2,1)=(-T(3));
g1(2,4)=(-(y(1)*T(28)));
g1(2,21)=1;
g1(2,23)=(-(y(1)*params(14)*T(27)*1/y(4)));
g1(3,1)=T(23);
g1(3,2)=T(24);
g1(3,3)=(-y(4));
g1(3,4)=(-y(3));
g1(4,1)=T(6)*T(23);
g1(4,2)=T(6)*T(24)+T(5)*getPowerDeriv(y(2),params(7)-1,1);
g1(4,3)=(-y(5));
g1(4,5)=(-y(3));
g1(5,3)=1+y(33)-(1+params(8));
g1(5,33)=y(3);
g1(6,1)=y(4);
g1(6,2)=(-y(5));
g1(6,4)=y(1);
g1(6,5)=(-y(2));
g1(6,6)=1-(1+y(33));
g1(6,9)=(-1);
g1(6,30)=1;
g1(6,33)=(-y(6));
g1(7,1)=1;
g1(7,20)=(-(T(7)*getPowerDeriv(y(20),T(8),1)*T(30)));
g1(7,21)=(-(T(30)*T(9)*getPowerDeriv(y(21),T(8),1)));
g1(8,4)=1;
g1(8,22)=(-((1-params(14))*getPowerDeriv(y(22),1-params(15),1)*T(32)));
g1(8,23)=(-(T(32)*params(14)*getPowerDeriv(y(23),1-params(15),1)));
g1(9,4)=y(29);
g1(9,29)=y(4);
g1(9,30)=(-1);
g1(10,29)=1/y(29)-((1-params(10))*1/(y(29))+params(10)*1/y(29));
g1(11,4)=(-(y(29)*T(26)));
g1(11,22)=(-(y(29)*T(31)));
g1(11,24)=1;
g1(11,29)=(-T(1));
g1(12,4)=(-(y(29)*T(28)));
g1(12,23)=(-(y(29)*params(14)*T(27)*1/y(4)));
g1(12,25)=1;
g1(12,29)=(-T(3));
g1(13,4)=(-(params(13)*T(12)*((-((y(6))*(y(8))))/((y(4))*(y(8))*(y(4))*(y(8)))-(-(y(6)*y(8)))/(y(4)*y(8)*y(4)*y(8)))));
g1(13,6)=(-(params(13)*T(12)*(1/((y(4))*(y(8)))-1/(y(4)*y(8)))));
g1(13,8)=(-(params(13)*T(12)*((-((y(6))*(y(4))))/((y(4))*(y(8))*(y(4))*(y(8)))-(-(y(4)*y(6)))/(y(4)*y(8)*y(4)*y(8)))));
g1(14,23)=1/y(23)-((1-params(12))*1/(y(23))+params(12)*1/y(23));
g1(15,26)=1;
g1(16,4)=(-(y(26)*T(26)));
g1(16,22)=(-(y(26)*T(31)));
g1(16,26)=(-T(1));
g1(16,27)=1;
g1(17,4)=(-(y(26)*T(28)));
g1(17,23)=(-(y(26)*params(14)*T(27)*1/y(4)));
g1(17,26)=(-T(3));
g1(17,28)=1;
g1(18,19)=1;
g1(18,20)=(-1);
g1(18,24)=(-1);
g1(18,27)=(-1);
g1(18,32)=(-1);
g1(19,18)=1;
g1(19,19)=(-(params(1)*T(13)));
g1(19,22)=(-(y(19)*params(1)*getPowerDeriv(y(22),params(2),1)));
g1(20,4)=(-(y(11)*(y(11)-1)*y(8)*params(16)));
g1(20,7)=y(10)-params(2)*y(17);
g1(20,8)=(-(y(11)*y(4)*params(16)*(y(11)-1)));
g1(20,10)=y(16)+y(7);
g1(20,11)=(-(y(8)*y(4)*params(16)*(y(11)-1)+y(11)*y(8)*y(4)*params(16)));
g1(20,16)=y(10);
g1(20,17)=(-(params(2)*y(7)));
g1(21,7)=(-(T(14)*(y(10)-params(2)*y(17))));
g1(21,10)=y(16)-(y(16)+y(7))*T(14);
g1(21,16)=y(10)-y(10)*T(14);
g1(21,17)=(-(T(14)*(-(params(2)*y(7)))));
g1(22,10)=(-(T(14)*y(17)*y(18)*getPowerDeriv(y(10),(-params(2)),1)));
g1(22,13)=1-T(14)*(1-params(5));
g1(22,17)=(-(T(14)*T(16)));
g1(22,18)=(-(T(14)*y(17)*T(15)));
g1(23,5)=(-(T(18)*1/T(17)));
g1(23,7)=(-(y(5)/T(17)*getPowerDeriv(y(7),params(3)/(1-params(3)),1)));
g1(23,12)=1;
g1(23,31)=(-(T(18)*(-(y(5)*(1-params(3))*getPowerDeriv(y(31),1/(1-params(3)),1)))/(T(17)*T(17))));
g1(24,10)=(-(1/y(12)));
g1(24,12)=(-((-y(10))/(y(12)*y(12))));
g1(24,14)=1;
g1(25,7)=(-params(4));
g1(25,15)=1-(1-params(5));
g1(26,31)=1/y(31)-((1-params(9))*1/(y(31))+params(9)*1/y(31));
g1(27,10)=(-1);
g1(27,12)=1;
g1(27,13)=(-params(4));
g1(27,17)=1;
g1(28,10)=1-y(11);
g1(28,11)=(-y(10));
g1(29,10)=(-T(19));
g1(29,15)=(-(y(10)*T(29)));
g1(29,22)=1;
g1(30,2)=(-(T(21)*getPowerDeriv(y(2),1-params(3),1)));
g1(30,8)=1;
g1(30,15)=(-(T(22)*y(31)*params(1)*getPowerDeriv(params(1)*y(15),1/(params(2)-1),1)));
g1(30,31)=(-(T(20)*T(22)));
g1(31,1)=(-1);
g1(31,4)=(-((-(y(22)*y(32)))/(y(4)*y(4))-(y(28)+y(21)+y(25))*(-y(23))/(y(4)*y(4))));
g1(31,8)=1;
g1(31,21)=T(2);
g1(31,22)=(-(y(32)/y(4)));
g1(31,23)=(y(28)+y(21)+y(25))*1/y(4);
g1(31,25)=T(2);
g1(31,28)=T(2);
g1(31,29)=(-1);
g1(31,32)=(-(y(22)/y(4)));
g1(32,2)=y(5);
g1(32,4)=(-y(8));
g1(32,5)=y(2);
g1(32,8)=(-y(4));
g1(32,9)=1;
g1(33,7)=1;
g1(33,8)=(-T(19));
g1(33,15)=(-(y(8)*T(29)));
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
