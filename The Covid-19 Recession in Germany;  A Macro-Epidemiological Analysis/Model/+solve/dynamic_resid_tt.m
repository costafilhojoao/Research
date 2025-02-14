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

T(1) = y(1)^(1-params(14));
T(2) = y(53)^params(14);
T(3) = 1/(params(12)*params(14)^params(14)*(1-params(14))^(1-params(14)));
T(4) = T(3)*y(54)^params(14);
T(5) = y(55)^(1-params(14));
T(6) = y(53)^(params(14)-1);
T(7) = params(12)*params(14)*y(77)*T(6);
T(8) = params(13)/2;
T(9) = y(65)*y(59)*y(149)*y(64)*params(5)*y(151)+y(62)*y(59)*y(150)*y(61)*params(6)*y(152)+params(7)*y(59)*(1-y(167));
T(10) = params(4)/(params(4)-1);
T(11) = params(10)*params(1)*(y(76)*y(164))^T(10);
T(12) = 1/(params(4)-1);
T(13) = params(10)*params(1)*(y(76)*y(164))^T(12);
T(14) = (1-params(1)*y(76)^T(12))/(1-params(1));
T(15) = T(14)^(-(params(4)-1));
T(16) = params(1)*y(76)^T(10);
T(17) = y(28)^(1-params(14));
T(18) = y(104)^params(14);
T(19) = T(3)*y(105)^params(14);
T(20) = y(106)^(1-params(14));
T(21) = y(104)^(params(14)-1);
T(22) = params(12)*params(14)*y(128)*T(21);
T(23) = y(116)*y(110)*y(168)*params(5)*y(115)*y(170)+y(113)*y(110)*y(169)*params(6)*y(112)*y(171)+(1-y(167))*params(7)*y(110);
T(24) = params(10)*params(20)*(y(127)*y(183))^T(10);
T(25) = params(10)*params(20)*(y(127)*y(183))^T(12);
T(26) = (1-params(20)*y(127)^T(12))/(1-params(20));
T(27) = T(26)^(-(params(4)-1));
T(28) = params(20)*y(127)^T(10);

end
