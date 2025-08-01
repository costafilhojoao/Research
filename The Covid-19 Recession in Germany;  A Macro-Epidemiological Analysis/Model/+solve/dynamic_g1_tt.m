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

assert(length(T) >= 40);

T = solve.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(32) = getPowerDeriv(y(1),1-params(14),1);
T(33) = 1/params(10);
T(34) = getPowerDeriv(y(76)*y(165),T(10),1);
T(35) = getPowerDeriv(y(76)*y(165),T(12),1);
T(36) = (-(params(1)*getPowerDeriv(y(76),T(12),1)))/(1-params(1));
T(37) = getPowerDeriv(y(28),1-params(14),1);
T(38) = getPowerDeriv(y(128)*y(184),T(10),1);
T(39) = getPowerDeriv(y(128)*y(184),T(12),1);
T(40) = (-(params(20)*getPowerDeriv(y(128),T(12),1)))/(1-params(20));

end
