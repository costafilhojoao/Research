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

T = NK_Course.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(19) = (-(getPowerDeriv(1-y(10),params(2),1)));
T(20) = T(1)*T(19);
T(21) = getPowerDeriv(T(3),1-params(8),1);
T(22) = (-(getPowerDeriv(1-y(10),params(2)*(1-params(8)),1)));
T(23) = (-(getPowerDeriv(1-y(10),params(2)*(1-params(8))-1,1)));
T(24) = T(6)*T(23);
T(25) = getPowerDeriv(y(10)*y(19),params(3),1);
T(26) = getPowerDeriv(y(2),1-params(3),1);
T(27) = getPowerDeriv(y(18),1-params(2),1);
T(28) = (1-params(2))*getPowerDeriv(y(18),(1-params(2))*(1-params(8))-1,1);
T(29) = params(2)*getPowerDeriv(y(18),(1-params(2))*(1-params(8)),1);
T(30) = T(7)*T(29);
T(31) = (-y(29))/(y(27)*y(27));
T(32) = getPowerDeriv(y(29)/y(27),1-params(5),1);
T(33) = getPowerDeriv(y(31),params(5)-1,1);
T(34) = getPowerDeriv(y(31),params(5),1);
T(35) = 1/(steady_state(26));

end
