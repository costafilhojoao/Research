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

assert(length(T) >= 28);

T(1) = y(14)-y(15)^params(7)/params(7);
T(2) = T(1)^(-params(6));
T(3) = y(15)^(params(7)-1);
T(4) = (1-params(14))^(1/params(15));
T(5) = (params(15)-1)/params(15);
T(6) = params(14)^(1/params(15));
T(7) = T(4)*y(28)^T(5)+T(6)*y(29)^T(5);
T(8) = params(15)/(params(15)-1);
T(9) = (1-params(14))*(y(30)/y(17))^(-params(15));
T(10) = y(31)/y(17);
T(11) = params(14)*T(10)^(-params(15));
T(12) = T(4)*y(32)^T(5)+T(6)*y(33)^T(5);
T(13) = exp((steady_state(6))/((steady_state(4))*(steady_state(8)))-y(19)/(y(17)*y(21)));
T(14) = y(23)/y(2);
T(15) = T(14)-1;
T(16) = params(16)/2*T(15)^2;
T(17) = params(16)/params(2);
T(18) = y(21)*y(17)*T(17)/y(20);
T(19) = T(15)*T(18);
T(20) = y(45)*T(17)*(y(45)/y(23)-1)/y(23);
T(21) = T(20)*y(47);
T(22) = T(21)*y(46);
T(23) = (1-params(3))*y(36)^(1/(1-params(3)));
T(24) = y(20)^(params(3)/(1-params(3)));
T(25) = (y(3)*params(1))^((-1)/(params(2)-1));
T(26) = (y(3)*params(1))^(1/(params(2)-1));
T(27) = y(36)*T(26);
T(28) = y(15)^(1-params(3));

end
