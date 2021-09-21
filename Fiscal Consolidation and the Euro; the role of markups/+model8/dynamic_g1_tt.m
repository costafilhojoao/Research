function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 35);

T = model8.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(26) = getPowerDeriv(T(1),(-params(6)),1);
T(27) = T(26)*(-(getPowerDeriv(y(15),params(7),1)/params(7)));
T(28) = getPowerDeriv(y(30)/y(17),(-params(15)),1);
T(29) = (1-params(14))*(-y(30))/(y(17)*y(17))*T(28);
T(30) = getPowerDeriv(T(10),(-params(15)),1);
T(31) = params(14)*(-y(31))/(y(17)*y(17))*T(30);
T(32) = params(1)*getPowerDeriv(y(3)*params(1),(-1)/(params(2)-1),1);
T(33) = getPowerDeriv(T(7),T(8),1);
T(34) = (1-params(14))*T(28)*1/y(17);
T(35) = getPowerDeriv(T(12),T(8),1);

end
