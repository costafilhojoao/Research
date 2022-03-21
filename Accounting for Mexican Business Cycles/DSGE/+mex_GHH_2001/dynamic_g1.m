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
    T = mex_GHH_2001.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(11, 19);
g1(1,5)=params(16);
g1(1,1)=(-(params(11)*(1+params(10))));
g1(1,6)=params(11);
g1(1,7)=(-params(21));
g1(1,2)=(-params(10));
g1(1,10)=(-params(20));
g1(1,11)=(-1);
g1(1,12)=(-params(19));
g1(2,5)=1;
g1(2,3)=(-((1-params(6))*params(5)));
g1(2,11)=(-params(6));
g1(2,13)=(-((1-params(6))*(1-params(5))));
g1(3,4)=(-params(9));
g1(3,12)=1;
g1(3,19)=(-1);
g1(4,3)=(-(1-params(3)));
g1(4,9)=1;
g1(4,10)=(-params(3));
g1(5,8)=(-(params(10)*params(1)));
g1(5,15)=1;
g1(5,18)=(-1);
g1(6,7)=(-params(21));
g1(6,13)=T(2);
g1(6,15)=T(1);
g1(7,5)=params(16)*(1-params(6))*(1-params(5));
g1(7,13)=(-(params(7)*T(2)));
g1(8,16)=(-(params(1)*T(3)));
g1(8,9)=(-(params(1)*((-(params(23)*params(18)*params(4)))-T(3))));
g1(8,17)=(-(params(1)*params(23)*params(18)*params(4)));
g1(8,15)=params(23);
g1(8,18)=(-(params(1)*params(23)*(1-params(3)+(1-params(6))*params(5)*params(16)/params(18))));
g1(9,5)=params(6)*params(16)/params(19);
g1(9,11)=(-(params(6)*params(16)/params(19)));
g1(9,12)=(-1);
g1(10,5)=params(21)-params(20)-params(19);
g1(10,7)=params(21);
g1(10,10)=(-params(20));
g1(10,11)=(-params(19));
g1(10,12)=(-params(19));
g1(10,14)=params(16)*params(22);
g1(11,6)=(-(params(11)*params(8)));
g1(11,8)=params(10);

end
