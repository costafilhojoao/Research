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
    T = rbc.static_g1_tt(T, y, x, params);
end
g1 = zeros(8, 8);
g1(1,2)=T(7)-(1-params(3)+y(6))*params(2)*T(7);
g1(1,6)=(-(params(2)*T(2)));
g1(2,2)=(-((-((-T(3))*T(7)))/(T(1)*T(1))));
g1(2,4)=(-((-((-params(5))*(-(getPowerDeriv(1-y(4),(-1),1)))))/T(1)));
g1(2,7)=1;
g1(3,3)=1-(1-params(3));
g1(3,8)=(-1);
g1(4,1)=1;
g1(4,2)=(-1);
g1(4,8)=(-1);
g1(5,1)=1;
g1(5,3)=(-(T(6)*y(5)*getPowerDeriv(y(3),params(1),1)));
g1(5,4)=(-(T(5)*getPowerDeriv(y(4),1-params(1),1)));
g1(5,5)=(-(T(4)*T(6)));
g1(6,1)=(-((1-params(1))/y(4)));
g1(6,4)=(-((-(y(1)*(1-params(1))))/(y(4)*y(4))));
g1(6,7)=1;
g1(7,1)=(-(params(1)/y(3)));
g1(7,3)=(-((-(y(1)*params(1)))/(y(3)*y(3))));
g1(7,6)=1;
g1(8,5)=1/y(5)-params(6)*1/y(5);
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
