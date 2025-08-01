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

assert(length(T) >= 33);

T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(24) = getPowerDeriv(T(4),(-params(6)),1);
T(25) = T(24)*(-(getPowerDeriv(y(9),params(7),1)/params(7)));
T(26) = getPowerDeriv(y(29)/y(11),(-params(15)),1);
T(27) = (1-params(14))*(-y(29))/(y(11)*y(11))*T(26);
T(28) = getPowerDeriv(T(2),(-params(15)),1);
T(29) = params(14)*(-y(30))/(y(11)*y(11))*T(28);
T(30) = params(1)*getPowerDeriv(params(1)*y(3),(-1)/(params(2)-1),1);
T(31) = getPowerDeriv(T(10),params(15)/(params(15)-1),1);
T(32) = (1-params(14))*T(26)*1/y(11);
T(33) = getPowerDeriv(T(11),1/(1-params(15)),1);

end
