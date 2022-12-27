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
    T = mex.static_g1_tt(T, y, x, params);
end
g1 = zeros(12, 12);
g1(1,1)=T(5);
g1(1,3)=T(10)-T(10)*(1+T(9));
g1(1,4)=(-T(12));
g1(1,5)=(-T(9));
g1(1,7)=(-T(11));
g1(1,8)=(-1);
g1(1,9)=(-T(7));
g1(2,1)=1;
g1(2,6)=(-((1-params(6))*params(5)));
g1(2,8)=(-params(6));
g1(2,10)=(-((1-params(6))*(1-params(5))));
g1(3,9)=1-params(9);
g1(4,6)=1-(1-params(3));
g1(4,7)=(-T(11));
g1(5,5)=(-(params(1)*T(9)));
g1(6,4)=(-T(12));
g1(6,10)=T(16);
g1(6,12)=T(17);
g1(7,1)=(1-params(6))*(1-params(5))*T(5);
g1(7,10)=(-(params(7)*T(16)));
g1(8,1)=(-(params(1)*T(18)));
g1(8,6)=(-(params(1)*(-T(18))));
g1(8,12)=T(14)-params(1)*T(14)*(1-params(3)+(1-params(6))*params(5)*T(5)/T(6));
g1(9,1)=params(6)*T(5)/T(7);
g1(9,8)=(-(params(6)*T(5)/T(7)));
g1(9,9)=(-1);
g1(10,2)=(-(T(11)+T(12)));
g1(10,4)=T(12);
g1(10,7)=T(11);
g1(10,11)=T(8)*T(15);
g1(11,3)=(-(T(10)*params(8)));
g1(11,5)=T(9);
g1(12,1)=(-(T(5)-T(7)));
g1(12,2)=T(8);
g1(12,9)=T(7);
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
