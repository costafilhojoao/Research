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

assert(length(T) >= 17);

T(1) = params(6)^params(6);
T(2) = ((1/params(1)-1+params(3))^(-1)*(1-params(6))*params(5))^((1-params(6))*params(5));
T(3) = ((1-params(6))*(1-params(5)))^((1-params(6))*(1-params(5))/params(7));
T(4) = 1/(1-((1-params(6))*(1-params(5))/params(7)+params(6)+(1-params(6))*params(5)));
T(5) = (T(1)*T(2)*T(3))^T(4);
T(6) = (1-params(6))*params(5)*T(5)*(1/params(1)+params(3)-1)^(-1);
T(7) = params(6)*T(5);
T(8) = T(5)-T(7);
T(9) = 1/params(1)-1;
T(10) = params(3)*T(6);
T(11) = T(8)-T(9)*params(10)-T(10)-T(7);
T(12) = ((1-params(6))*(1-params(5))*T(5))^(1/params(7));
T(13) = (T(11)-params(7)^(-1)*T(12)^params(7))^(-params(2));
T(14) = 1-(T(7)+T(10)+T(11))/T(8);
T(15) = T(12)^params(7);
T(16) = (-(1/params(2)))*T(13)^(-(1/params(2)));
T(17) = params(5)*(1-params(6))*T(5)/T(6);

end
