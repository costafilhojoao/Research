function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 25);

T(1) = y(13)-y(14)^params(7)/params(7);
T(2) = T(1)^(-params(6));
T(3) = y(14)^(params(7)-1);
T(4) = (1-params(14))^(1/params(15));
T(5) = (params(15)-1)/params(15);
T(6) = params(14)^(1/params(15));
T(7) = T(4)*y(27)^T(5)+T(6)*y(28)^T(5);
T(8) = params(15)/(params(15)-1);
T(9) = (1-params(14))*(y(29)/y(16))^(-params(15));
T(10) = y(30)/y(16);
T(11) = params(14)*T(10)^(-params(15));
T(12) = (1-params(14))*y(29)^(1-params(15))+params(14)*y(30)^(1-params(15));
T(13) = T(4)*y(31)^T(5)+T(6)*y(32)^T(5);
T(14) = params(16)/2*(y(22)/y(2)-1)^2;
T(15) = params(16)/params(2);
T(16) = (y(22)/y(2)-1)*T(15);
T(17) = y(44)*T(15)*(y(44)/y(22)-1)/y(22);
T(18) = T(17)*y(46);
T(19) = T(18)*y(45);
T(20) = (1-params(3))*y(35)^(1/(1-params(3)));
T(21) = y(19)^(params(3)/(1-params(3)));
T(22) = (y(3)*params(1))^((-1)/(params(2)-1));
T(23) = (y(3)*params(1))^(1/(params(2)-1));
T(24) = y(35)*T(23);
T(25) = y(14)^(1-params(3));

end
