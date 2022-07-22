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
    T = RBC.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(8, 13);
g1(1,5)=(-(T(2)*params(1)*exp(y(11))*exp(y(5))*getPowerDeriv(exp(y(5)),params(1)-1,1)));
g1(1,11)=(-(T(2)*T(3)));
g1(1,7)=T(9);
g1(1,12)=(-((T(3)+1-params(3))*T(10)));
g1(2,3)=exp(y(3));
g1(2,1)=(-T(8));
g1(2,6)=(-T(5));
g1(3,1)=(-((1-params(3))*exp(y(1))+T(8)));
g1(3,5)=exp(y(5));
g1(3,6)=(-T(5));
g1(3,7)=exp(y(7));
g1(4,2)=(-params(4));
g1(4,6)=1;
g1(4,13)=(-1);
g1(5,3)=exp(y(3));
g1(5,4)=(-exp(y(4)));
g1(5,7)=(-exp(y(7)));
g1(6,7)=T(9);
g1(6,12)=(-((1+y(10))*T(10)));
g1(6,10)=(-T(2));
g1(7,1)=(-(params(1)*exp(y(6))*exp(y(1))*getPowerDeriv(exp(y(1)),params(1)-1,1)));
g1(7,6)=(-T(6));
g1(7,9)=exp(y(9));
g1(8,1)=(-(exp(y(6))*(1-params(1))*T(7)));
g1(8,6)=(-(T(4)*exp(y(6))*(1-params(1))));
g1(8,8)=exp(y(8));

end
