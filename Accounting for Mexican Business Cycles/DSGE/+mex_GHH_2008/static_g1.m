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
    T = mex_GHH_2008.static_g1_tt(T, y, x, params);
end
g1 = zeros(11, 11);
g1(1,1)=params(16);
g1(1,2)=params(11)-params(11)*(1+params(10));
g1(1,3)=(-params(21));
g1(1,4)=(-params(10));
g1(1,6)=(-params(20));
g1(1,7)=(-1);
g1(1,8)=(-params(19));
g1(2,1)=1;
g1(2,5)=(-((1-params(6))*params(5)));
g1(2,7)=(-params(6));
g1(2,9)=(-((1-params(6))*(1-params(5))));
g1(3,8)=1-params(9);
g1(4,5)=1-(1-params(3));
g1(4,6)=(-params(3));
g1(5,4)=(-(params(10)*params(1)));
g1(6,3)=(-params(21));
g1(6,9)=T(2);
g1(6,11)=T(1);
g1(7,1)=params(16)*(1-params(6))*(1-params(5));
g1(7,9)=(-(params(7)*T(2)));
g1(8,1)=(-(params(1)*T(3)));
g1(8,5)=(-(params(1)*(-T(3))));
g1(8,11)=params(23)-params(1)*params(23)*(1-params(3)+(1-params(6))*params(5)*params(16)/params(18));
g1(9,1)=params(6)*params(16)/params(19);
g1(9,7)=(-(params(6)*params(16)/params(19)));
g1(9,8)=(-1);
g1(10,1)=params(21)-params(20)-params(19);
g1(10,3)=params(21);
g1(10,6)=(-params(20));
g1(10,7)=(-params(19));
g1(10,8)=(-params(19));
g1(10,10)=params(16)*params(22);
g1(11,2)=(-(params(11)*params(8)));
g1(11,4)=params(10);
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
