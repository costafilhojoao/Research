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
    T = model.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(19, 30);
g1(1,5)=T(13);
g1(1,6)=T(14);
g1(1,7)=(-y(8));
g1(1,8)=(-y(7));
g1(2,5)=T(6)*T(13);
g1(2,6)=T(6)*T(14)+T(5)*getPowerDeriv(y(6),params(7)-1,1);
g1(2,8)=(-y(9));
g1(2,9)=(-y(8));
g1(3,8)=(-(1+params(8)));
g1(3,24)=1+y(23);
g1(3,23)=y(24);
g1(4,5)=y(7);
g1(4,6)=(-y(9));
g1(4,7)=y(5);
g1(4,9)=(-y(6));
g1(4,1)=(-(1+y(23)));
g1(4,10)=1;
g1(4,11)=(-1);
g1(4,12)=1;
g1(4,23)=(-y(1));
g1(5,7)=y(13);
g1(5,12)=(-1);
g1(5,13)=y(7);
g1(6,2)=(-(params(10)*1/y(2)));
g1(6,13)=1/y(13);
g1(6,29)=(-1);
g1(7,22)=1;
g1(7,30)=(-1);
g1(8,10)=(-(params(12)*(-exp((-y(10))))));
g1(8,23)=1;
g1(9,14)=(params(2)-1)/params(2);
g1(9,15)=(-1);
g1(9,16)=params(4);
g1(10,25)=T(7)*y(27)/y(18);
g1(10,16)=(-(1+params(8)));
g1(10,26)=(-(1-params(5)));
g1(10,27)=T(7)*y(25)/y(18);
g1(10,18)=T(7)*(-(y(25)*y(27)))/(y(18)*y(18));
g1(11,9)=(-(T(9)*1/T(8)));
g1(11,15)=1;
g1(11,17)=(-(y(9)/T(8)*getPowerDeriv(y(17),params(3)/(1-params(3)),1)));
g1(11,19)=(-(T(9)*(-(y(9)*(1-params(3))*getPowerDeriv(y(19),1/(1-params(3)),1)))/(T(8)*T(8))));
g1(12,14)=(-(1/y(15)));
g1(12,15)=(-((-y(14))/(y(15)*y(15))));
g1(12,20)=1;
g1(13,17)=(-params(4));
g1(13,3)=(-(1-params(5)));
g1(13,18)=1;
g1(14,4)=(-(params(9)*1/y(4)));
g1(14,19)=1/y(19);
g1(14,28)=(-1);
g1(15,7)=1;
g1(15,14)=(-T(10));
g1(15,3)=(-(y(14)*params(1)*getPowerDeriv(params(1)*y(3),(-1)/(params(2)-1),1)));
g1(16,6)=(-(y(19)*T(11)*getPowerDeriv(y(6),1-params(3),1)));
g1(16,3)=(-(T(12)*y(19)*T(15)));
g1(16,19)=(-(T(11)*T(12)));
g1(16,21)=1;
g1(17,5)=(-1);
g1(17,13)=(-1);
g1(17,21)=1;
g1(17,22)=(-1);
g1(18,6)=y(9);
g1(18,7)=(-y(21));
g1(18,9)=y(6);
g1(18,11)=1;
g1(18,21)=(-y(7));
g1(19,17)=1;
g1(19,3)=(-(y(21)*T(15)));
g1(19,21)=(-T(11));

end
