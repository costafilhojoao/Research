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
    T = NK_Course.static_g1_tt(T, y, x, params);
end
g1 = zeros(35, 35);
g1(1,1)=1;
g1(1,4)=(-(T(1)*(-(getPowerDeriv(1-y(4),params(2),1)))*T(16)/(1-params(8))));
g1(1,12)=(-(T(16)*T(2)*getPowerDeriv(y(12),1-params(2),1)/(1-params(8))));
g1(2,2)=1;
g1(2,4)=(-(T(4)*(-(getPowerDeriv(1-y(4),params(2)*(1-params(8)),1)))));
g1(2,12)=(-(T(5)*(1-params(2))*getPowerDeriv(y(12),(1-params(2))*(1-params(8))-1,1)));
g1(3,2)=1;
g1(3,17)=(-params(6));
g1(4,2)=(-(y(26)/y(25)));
g1(4,17)=1;
g1(4,25)=(-(y(2)*(-y(26))/(y(25)*y(25))));
g1(4,26)=(-(y(2)*1/y(25)));
g1(5,2)=(-T(8))/(y(2)*y(2));
g1(5,4)=T(6)*(-(getPowerDeriv(1-y(4),params(2)*(1-params(8))-1,1)))/y(2);
g1(5,5)=(-1);
g1(5,12)=T(7)*params(2)*getPowerDeriv(y(12),(1-params(2))*(1-params(8)),1)/y(2);
g1(6,6)=(-(1-params(4)));
g1(6,7)=1;
g1(7,4)=(-(T(10)*y(13)*T(17)));
g1(7,6)=1;
g1(7,9)=(-(T(9)*getPowerDeriv(y(9),1-params(3),1)));
g1(7,13)=(-(T(10)*y(4)*T(17)));
g1(8,4)=(-(y(8)*y(6)*params(3)))/(y(4)*y(4));
g1(8,5)=(-1);
g1(8,6)=params(3)*y(8)/y(4);
g1(8,8)=y(6)*params(3)/y(4);
g1(9,7)=1;
g1(9,10)=(-1);
g1(9,12)=(-1);
g1(9,14)=(-1);
g1(10,15)=1;
g1(11,9)=1-(1-params(7));
g1(11,10)=(-T(11));
g1(11,15)=(-(y(10)*(-(params(12)*(y(15)-1)*2.0))));
g1(12,3)=(-((-(y(15)*(y(15)-1)*params(12)*2.0*y(16)))/(y(3)*y(3))));
g1(12,15)=(-(y(16)*((y(15)-1)*params(12)*2.0+y(15)*params(12)*2.0)/y(3)));
g1(12,16)=(-(y(15)*(y(15)-1)*params(12)*2.0/y(3)));
g1(12,18)=1;
g1(13,15)=y(16)*((-(params(12)*(y(15)-1)*2.0))-((y(15)-1)*params(12)*2.0+params(12)*y(15)*2.0));
g1(13,16)=T(11)-(y(15)-1)*params(12)*y(15)*2.0;
g1(13,18)=1;
g1(14,25)=(-((-1)/(y(25)*y(25))));
g1(14,27)=1;
g1(15,3)=1;
g1(15,26)=(-y(27));
g1(15,27)=(-y(26));
g1(16,6)=(-((1-params(3))*y(8)/y(9)));
g1(16,8)=(-(y(6)*(1-params(3))/y(9)));
g1(16,9)=(-((-(y(6)*(1-params(3))*y(8)))/(y(9)*y(9))));
g1(16,16)=(-(1-params(7)));
g1(16,19)=1;
g1(17,16)=(-((-y(19))/(y(16)*y(16))));
g1(17,19)=(-(1/y(16)));
g1(17,26)=y(27);
g1(17,27)=y(26);
g1(18,4)=(-(y(5)*y(11)));
g1(18,5)=(-(y(4)*y(11)));
g1(18,11)=(-(y(4)*y(5)));
g1(18,14)=1;
g1(19,2)=(-y(7));
g1(19,7)=(-y(2));
g1(19,21)=1;
g1(19,22)=(-(params(6)*params(13)));
g1(20,2)=(-(T(13)*y(20)));
g1(20,7)=(-(y(20)*y(2)*T(12)));
g1(20,20)=(-(y(2)*T(13)));
g1(20,23)=1;
g1(20,24)=(-(params(6)*params(13)));
g1(21,21)=(-T(14));
g1(21,22)=1;
g1(21,25)=(-(y(21)*T(21)));
g1(22,23)=(-T(15));
g1(22,24)=1;
g1(22,25)=(-(y(23)*getPowerDeriv(y(25),params(5),1)));
g1(23,21)=(-((1-params(13))*(-y(23))/(y(21)*y(21))*T(20)));
g1(23,23)=(-((1-params(13))*T(20)*1/y(21)));
g1(23,25)=(-(params(13)*T(21)));
g1(24,8)=(-1);
g1(24,20)=1;
g1(25,25)=(-(1/y(25)*params(15)));
g1(25,26)=T(22)-params(14)*T(22);
g1(26,13)=T(18)-params(9)*T(18);
g1(27,14)=T(19)-params(10)*T(19);
g1(28,7)=(-(((y(7))-y(7))/((y(7))*(y(7)))));
g1(28,30)=1;
g1(29,9)=(-(((y(9))-y(9))/((y(9))*(y(9)))));
g1(29,35)=1;
g1(30,10)=(-(((y(10))-y(10))/((y(10))*(y(10)))));
g1(30,34)=1;
g1(31,12)=(-(((y(12))-y(12))/((y(12))*(y(12)))));
g1(31,31)=1;
g1(32,5)=(-(((y(5))-y(5))/((y(5))*(y(5)))));
g1(32,33)=1;
g1(33,4)=(-(((y(4))-y(4))/((y(4))*(y(4)))));
g1(33,32)=1;
g1(34,3)=(-(((y(3))-y(3))/((y(3))*(y(3)))));
g1(34,28)=1;
g1(35,26)=(-(((y(26))-y(26))/((y(26))*(y(26)))));
g1(35,29)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
