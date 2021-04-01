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
g1 = zeros(19, 31);
g1(1,6)=T(13);
g1(1,7)=T(14);
g1(1,8)=(-y(9));
g1(1,9)=(-y(8));
g1(2,6)=T(6)*T(13);
g1(2,7)=T(6)*T(14)+T(5)*getPowerDeriv(y(7),params(7)-1,1);
g1(2,9)=(-y(10));
g1(2,10)=(-y(9));
g1(3,9)=(-(1+params(8)));
g1(3,25)=1+y(24);
g1(3,24)=y(25);
g1(4,6)=y(8);
g1(4,7)=(-y(10));
g1(4,8)=y(6);
g1(4,10)=(-y(7));
g1(4,1)=(-(1+y(5)));
g1(4,11)=1;
g1(4,12)=(-1);
g1(4,13)=1;
g1(4,5)=(-y(1));
g1(5,8)=y(14);
g1(5,13)=(-1);
g1(5,14)=y(8);
g1(6,2)=(-(params(10)*1/y(2)));
g1(6,14)=1/y(14);
g1(6,30)=(-1);
g1(7,23)=1;
g1(7,31)=(-1);
g1(8,11)=(-(params(15)*(-exp((-y(11))))));
g1(8,24)=1;
g1(9,15)=(params(2)-1)/params(2);
g1(9,16)=(-1);
g1(9,17)=params(4);
g1(10,26)=T(7)*y(28)/y(19);
g1(10,17)=(-(1+params(8)));
g1(10,27)=(-(1-params(5)));
g1(10,28)=T(7)*y(26)/y(19);
g1(10,19)=T(7)*(-(y(26)*y(28)))/(y(19)*y(19));
g1(11,10)=(-(T(9)*1/T(8)));
g1(11,16)=1;
g1(11,18)=(-(y(10)/T(8)*getPowerDeriv(y(18),params(3)/(1-params(3)),1)));
g1(11,20)=(-(T(9)*(-(y(10)*(1-params(3))*getPowerDeriv(y(20),1/(1-params(3)),1)))/(T(8)*T(8))));
g1(12,15)=(-(1/y(16)));
g1(12,16)=(-((-y(15))/(y(16)*y(16))));
g1(12,21)=1;
g1(13,18)=(-params(4));
g1(13,3)=(-(1-params(5)));
g1(13,19)=1;
g1(14,4)=(-(params(9)*1/y(4)));
g1(14,20)=1/y(20);
g1(14,29)=(-1);
g1(15,8)=1;
g1(15,15)=(-T(10));
g1(15,3)=(-(y(15)*params(1)*getPowerDeriv(params(1)*y(3),(-1)/(params(2)-1),1)));
g1(16,7)=(-(y(20)*T(11)*getPowerDeriv(y(7),1-params(3),1)));
g1(16,3)=(-(T(12)*y(20)*T(15)));
g1(16,20)=(-(T(11)*T(12)));
g1(16,22)=1;
g1(17,6)=(-1);
g1(17,14)=(-1);
g1(17,22)=1;
g1(17,23)=(-1);
g1(18,7)=y(10);
g1(18,8)=(-y(22));
g1(18,10)=y(7);
g1(18,12)=1;
g1(18,22)=(-y(8));
g1(19,18)=1;
g1(19,3)=(-(y(22)*T(15)));
g1(19,22)=(-T(11));

end
