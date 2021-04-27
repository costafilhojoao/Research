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
    T = model3.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(22, 38);
g1(1,9)=T(11);
g1(1,10)=T(12);
g1(1,11)=(-y(12));
g1(1,12)=(-y(11));
g1(2,9)=T(3)*T(11);
g1(2,10)=T(3)*T(12)+T(2)*getPowerDeriv(y(10),params(7)-1,1);
g1(2,12)=(-y(13));
g1(2,13)=(-y(12));
g1(3,12)=(-(1+params(8)));
g1(3,27)=y(28);
g1(3,28)=1+y(27);
g1(4,6)=(-1);
g1(4,28)=1;
g1(4,36)=(-1);
g1(5,9)=y(11);
g1(5,10)=(-y(13));
g1(5,11)=y(9);
g1(5,13)=(-y(10));
g1(5,1)=(-(1+y(5)));
g1(5,14)=1;
g1(5,15)=(-1);
g1(5,16)=1;
g1(5,5)=(-y(1));
g1(6,11)=y(17);
g1(6,16)=(-1);
g1(6,17)=y(11);
g1(7,2)=(-(params(10)*1/y(2)));
g1(7,17)=1/y(17);
g1(7,33)=(-1);
g1(8,26)=1;
g1(8,34)=(-1);
g1(9,27)=1;
g1(9,35)=(-1);
g1(10,18)=(params(2)-1)/params(2);
g1(10,19)=(-1);
g1(10,20)=params(4);
g1(11,31)=T(4)*y(30)/y(22);
g1(11,22)=T(4)*(-(y(31)*y(30)))/(y(22)*y(22));
g1(11,7)=(-(1+params(8)));
g1(11,29)=(-(1-params(5)));
g1(11,30)=T(4)*y(31)/y(22);
g1(12,7)=(-1);
g1(12,29)=1;
g1(12,37)=(-1);
g1(13,8)=(-1);
g1(13,30)=1;
g1(13,38)=(-1);
g1(14,13)=(-(T(6)*1/T(5)));
g1(14,19)=1;
g1(14,21)=(-(y(13)/T(5)*getPowerDeriv(y(21),params(3)/(1-params(3)),1)));
g1(14,23)=(-(T(6)*(-(y(13)*(1-params(3))*getPowerDeriv(y(23),1/(1-params(3)),1)))/(T(5)*T(5))));
g1(15,18)=(-(1/y(19)));
g1(15,19)=(-((-y(18))/(y(19)*y(19))));
g1(15,24)=1;
g1(16,21)=(-params(4));
g1(16,3)=(-(1-params(5)));
g1(16,22)=1;
g1(17,4)=(-(params(9)*1/y(4)));
g1(17,23)=1/y(23);
g1(17,32)=(-1);
g1(18,11)=1;
g1(18,18)=(-T(7));
g1(18,3)=(-(y(18)*T(13)));
g1(19,10)=(-(T(9)*getPowerDeriv(y(10),1-params(3),1)));
g1(19,3)=(-(T(10)*y(23)*params(1)*getPowerDeriv(y(3)*params(1),1/(params(2)-1),1)));
g1(19,23)=(-(T(8)*T(10)));
g1(19,25)=1;
g1(20,9)=(-1);
g1(20,17)=(-1);
g1(20,25)=1;
g1(20,26)=(-1);
g1(21,10)=y(13);
g1(21,11)=(-y(25));
g1(21,13)=y(10);
g1(21,15)=1;
g1(21,25)=(-y(11));
g1(22,21)=1;
g1(22,3)=(-(y(25)*T(13)));
g1(22,25)=(-T(7));

end
