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

assert(length(T) >= 12);

T = rbc.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(7) = params(4)*getPowerDeriv(y(4),(-1),1);
T(8) = params(2)*params(4)*getPowerDeriv(y(11),(-1),1);
T(9) = getPowerDeriv(y(1),params(1),1);
T(10) = y(7)*T(9);
T(11) = (-((-params(5))*(-(getPowerDeriv(1-y(6),(-1),1)))));
T(12) = getPowerDeriv(y(6),1-params(1),1);

end
