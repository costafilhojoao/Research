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

assert(length(T) >= 42);

T = dynamic.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(32) = getPowerDeriv(T(4),(-params(6)),1);
T(33) = T(32)*(-(getPowerDeriv(y(11),params(7),1)/params(7)));
T(34) = getPowerDeriv(y(27)/y(13),(-params(15)),1);
T(35) = (1-params(14))*(-y(27))/(y(13)*y(13))*T(34);
T(36) = getPowerDeriv(T(2),(-params(15)),1);
T(37) = params(14)*(-y(28))/(y(13)*y(13))*T(36);
T(38) = getPowerDeriv(y(52)/y(56),(-1),1);
T(39) = params(1)*getPowerDeriv(y(3)*params(1),(-1)/(params(2)-1),1);
T(40) = (1-params(14))*T(34)*1/y(13);
T(41) = getPowerDeriv(T(7),1/(1-params(15)),1);
T(42) = getPowerDeriv(T(11),params(15)/(params(15)-1),1);

end
