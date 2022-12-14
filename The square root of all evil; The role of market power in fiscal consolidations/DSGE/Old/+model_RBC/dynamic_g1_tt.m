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

assert(length(T) >= 38);

T = model_RBC.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(29) = getPowerDeriv(T(1),(-params(6)),1);
T(30) = T(29)*(-(getPowerDeriv(y(15),params(7),1)/params(7)));
T(31) = getPowerDeriv(y(30)/y(17),(-params(15)),1);
T(32) = (1-params(14))*(-y(30))/(y(17)*y(17))*T(31);
T(33) = getPowerDeriv(T(10),(-params(15)),1);
T(34) = params(14)*(-y(31))/(y(17)*y(17))*T(33);
T(35) = params(1)*getPowerDeriv(y(3)*params(1),(-1)/(params(2)-1),1);
T(36) = getPowerDeriv(T(7),T(8),1);
T(37) = (1-params(14))*T(31)*1/y(17);
T(38) = getPowerDeriv(T(12),T(8),1);

end
