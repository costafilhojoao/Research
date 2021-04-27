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

assert(length(T) >= 18);

T(1) = y(18)^(1-params(2));
T(2) = (1-y(10))^params(2);
T(3) = T(1)*T(2);
T(4) = (1-params(2))*y(18)^((1-params(2))*(1-params(8))-1);
T(5) = (1-y(10))^(params(2)*(1-params(8)));
T(6) = params(2)*y(18)^((1-params(2))*(1-params(8)));
T(7) = (1-y(10))^(params(2)*(1-params(8))-1);
T(8) = T(6)*T(7);
T(9) = (y(10)*y(19))^params(3);
T(10) = y(2)^(1-params(3));
T(11) = 1-params(12)*(y(21)-1)^2.0;
T(12) = 1/y(31);
T(13) = 1/(1-1/params(5));
T(14) = y(13)*T(13);
T(15) = y(31)^(params(5)-1);
T(16) = y(31)^params(5);
T(17) = y(32)/(steady_state(26));
T(18) = y(6)/(steady_state(26));

end
