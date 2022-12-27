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
    T = mex.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(12, 20);
g1(1,5)=T(5);
g1(1,1)=(-(T(10)*(1+T(9))));
g1(1,7)=T(10);
g1(1,8)=(-T(12));
g1(1,2)=(-T(9));
g1(1,11)=(-T(11));
g1(1,12)=(-1);
g1(1,13)=(-T(7));
g1(2,5)=1;
g1(2,3)=(-((1-params(6))*params(5)));
g1(2,12)=(-params(6));
g1(2,14)=(-((1-params(6))*(1-params(5))));
g1(3,4)=(-params(9));
g1(3,13)=1;
g1(3,20)=(-1);
g1(4,3)=(-(1-params(3)));
g1(4,10)=1;
g1(4,11)=(-T(11));
g1(5,9)=(-(params(1)*T(9)));
g1(5,16)=1;
g1(5,19)=(-1);
g1(6,8)=(-T(12));
g1(6,14)=T(16);
g1(6,16)=T(17);
g1(7,5)=(1-params(6))*(1-params(5))*T(5);
g1(7,14)=(-(params(7)*T(16)));
g1(8,17)=(-(params(1)*T(18)));
g1(8,10)=(-(params(1)*((-(T(6)*T(14)*params(4)))-T(18))));
g1(8,18)=(-(params(1)*T(6)*T(14)*params(4)));
g1(8,16)=T(14);
g1(8,19)=(-(params(1)*T(14)*(1-params(3)+(1-params(6))*params(5)*T(5)/T(6))));
g1(9,5)=params(6)*T(5)/T(7);
g1(9,12)=(-(params(6)*T(5)/T(7)));
g1(9,13)=(-1);
g1(10,6)=(-(T(11)+T(12)));
g1(10,8)=T(12);
g1(10,11)=T(11);
g1(10,15)=T(8)*T(15);
g1(11,7)=(-(T(10)*params(8)));
g1(11,9)=T(9);
g1(12,5)=(-(T(5)-T(7)));
g1(12,6)=T(8);
g1(12,13)=T(7);

end
