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

assert(length(T) >= 22);

T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(13) = getPowerDeriv(T(3),(-params(6)),1);
T(14) = (-(getPowerDeriv(y(7),params(7),1)/params(7)));
T(15) = T(13)*T(14);
T(16) = getPowerDeriv(y(7),params(7)-1,1);
T(17) = getPowerDeriv(y(7),1-params(3),1);
T(18) = getPowerDeriv(y(18),params(3)/(1-params(3)),1);
T(19) = params(1)*getPowerDeriv(y(3)*params(1),(-1)/(params(2)-1),1);
T(20) = params(1)*getPowerDeriv(y(3)*params(1),1/(params(2)-1),1);
T(21) = y(20)*T(20);
T(22) = (1-params(3))*getPowerDeriv(y(20),1/(1-params(3)),1);

end
