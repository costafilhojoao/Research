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

assert(length(T) >= 13);

T = irf.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(10) = (-((1-params(69))*params(90)*params(66)*params(92)/(params(36)+params(37))));
T(11) = (-(params(69)*params(90)*params(66)*params(92)/(params(35)+params(38))));
T(12) = (-((1-params(69))*params(89)*params(65)*params(91)/(params(36)+params(37))));
T(13) = (-(params(69)*params(89)*params(65)*params(91)/(params(35)+params(38))));

end
