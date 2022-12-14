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

assert(length(T) >= 23);

T(1) = (1-params(14))*(y(29)/y(11))^(-params(15));
T(2) = y(30)/y(11);
T(3) = params(14)*T(2)^(-params(15));
T(4) = y(8)-y(9)^params(7)/params(7);
T(5) = T(4)^(-params(6));
T(6) = y(9)^(params(7)-1);
T(7) = (1-params(14))^(1/params(15));
T(8) = (params(15)-1)/params(15);
T(9) = params(14)^(1/params(15));
T(10) = T(7)*y(27)^T(8)+T(9)*y(28)^T(8);
T(11) = (1-params(14))*y(29)^(1-params(15))+params(14)*y(30)^(1-params(15));
T(12) = exp((steady_state(6))/((steady_state(4))*(steady_state(8)))-y(13)/(y(11)*y(15)));
T(13) = params(16)/2*(y(17)/y(2)-1)^2;
T(14) = y(29)^params(2);
T(15) = (1+params(8))^(-1);
T(16) = y(43)^(-params(2));
T(17) = y(47)*T(16);
T(18) = (1-params(3))*y(38)^(1/(1-params(3)));
T(19) = y(14)^(params(3)/(1-params(3)));
T(20) = (params(1)*y(3))^((-1)/(params(2)-1));
T(21) = (params(1)*y(3))^(1/(params(2)-1));
T(22) = y(38)*T(21);
T(23) = y(9)^(1-params(3));

end
