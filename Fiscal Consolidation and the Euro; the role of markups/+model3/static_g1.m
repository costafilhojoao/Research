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
    T = model3.static_g1_tt(T, y, x, params);
end
g1 = zeros(22, 22);
g1(1,1)=T(11);
g1(1,2)=T(12);
g1(1,3)=(-y(4));
g1(1,4)=(-y(3));
g1(2,1)=T(3)*T(11);
g1(2,2)=T(3)*T(12)+T(2)*getPowerDeriv(y(2),params(7)-1,1);
g1(2,4)=(-y(5));
g1(2,5)=(-y(4));
g1(3,4)=(-(1+params(8)));
g1(3,19)=y(20);
g1(3,20)=1+y(19);
g1(5,1)=y(3);
g1(5,2)=(-y(5));
g1(5,3)=y(1);
g1(5,5)=(-y(2));
g1(5,6)=1-(1+y(19));
g1(5,7)=(-1);
g1(5,8)=1;
g1(5,19)=(-y(6));
g1(6,3)=y(9);
g1(6,8)=(-1);
g1(6,9)=y(3);
g1(7,9)=1/y(9)-((1-params(10))*1/(y(9))+params(10)*1/y(9));
g1(8,18)=1;
g1(9,19)=1;
g1(10,10)=(params(2)-1)/params(2);
g1(10,11)=(-1);
g1(10,12)=params(4);
g1(11,10)=T(4)*y(22)/y(14);
g1(11,14)=T(4)*(-(y(10)*y(22)))/(y(14)*y(14));
g1(11,21)=(-(1-params(5)))-(1+params(8));
g1(11,22)=T(4)*y(10)/y(14);
g1(14,5)=(-(T(6)*1/T(5)));
g1(14,11)=1;
g1(14,13)=(-(y(5)/T(5)*getPowerDeriv(y(13),params(3)/(1-params(3)),1)));
g1(14,15)=(-(T(6)*(-(y(5)*(1-params(3))*getPowerDeriv(y(15),1/(1-params(3)),1)))/(T(5)*T(5))));
g1(15,10)=(-(1/y(11)));
g1(15,11)=(-((-y(10))/(y(11)*y(11))));
g1(15,16)=1;
g1(16,13)=(-params(4));
g1(16,14)=1-(1-params(5));
g1(17,15)=1/y(15)-((1-params(9))*1/(y(15))+params(9)*1/y(15));
g1(18,3)=1;
g1(18,10)=(-T(7));
g1(18,14)=(-(y(10)*T(13)));
g1(19,2)=(-(T(9)*getPowerDeriv(y(2),1-params(3),1)));
g1(19,14)=(-(T(10)*y(15)*params(1)*getPowerDeriv(y(14)*params(1),1/(params(2)-1),1)));
g1(19,15)=(-(T(8)*T(10)));
g1(19,17)=1;
g1(20,1)=(-1);
g1(20,9)=(-1);
g1(20,17)=1;
g1(20,18)=(-1);
g1(21,2)=y(5);
g1(21,3)=(-y(17));
g1(21,5)=y(2);
g1(21,7)=1;
g1(21,17)=(-y(3));
g1(22,13)=1;
g1(22,14)=(-(y(17)*T(13)));
g1(22,17)=(-T(7));
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
