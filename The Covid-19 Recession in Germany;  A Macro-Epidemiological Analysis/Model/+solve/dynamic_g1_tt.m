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

assert(length(T) >= 37);

T = solve.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(29) = getPowerDeriv(y(1),1-params(14),1);
T(30) = 1/params(10);
T(31) = getPowerDeriv(y(76)*y(164),T(10),1);
T(32) = getPowerDeriv(y(76)*y(164),T(12),1);
T(33) = (-(params(1)*getPowerDeriv(y(76),T(12),1)))/(1-params(1));
T(34) = getPowerDeriv(y(28),1-params(14),1);
T(35) = getPowerDeriv(y(127)*y(183),T(10),1);
T(36) = getPowerDeriv(y(127)*y(183),T(12),1);
T(37) = (-(params(20)*getPowerDeriv(y(127),T(12),1)))/(1-params(20));

end
