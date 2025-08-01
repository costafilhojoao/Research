function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 31);

T(1) = (1-params(14))*(y(27)/y(13))^(-params(15));
T(2) = y(28)/y(13);
T(3) = params(14)*T(2)^(-params(15));
T(4) = y(10)-y(11)^params(7)/params(7);
T(5) = T(4)^(-params(6));
T(6) = y(11)^(params(7)-1);
T(7) = (1-params(14))*y(27)^(1-params(15))+params(14)*y(28)^(1-params(15));
T(8) = (1-params(14))^(1/params(15));
T(9) = (params(15)-1)/params(15);
T(10) = params(14)^(1/params(15));
T(11) = T(8)*y(29)^T(9)+T(10)*y(30)^T(9);
T(12) = exp((steady_state(6))/((steady_state(4))*(steady_state(8)))-y(15)/(y(13)*y(17)));
T(13) = y(26)/y(4)-1;
T(14) = params(16)/2*T(13)^2;
T(15) = (1-params(3))*y(36)^(1/(1-params(3)));
T(16) = y(16)^(params(3)/(1-params(3)));
T(17) = (-(y(13)*y(17)*params(4)))/(params(2)*y(16));
T(18) = y(13)*y(17)*params(4)/(params(2)*y(3));
T(19) = params(2)*y(51)/(1-params(3))*y(48);
T(20) = (y(52)/y(56))^(-1);
T(21) = params(16)*(y(55)/y(26)-1);
T(22) = y(26)^(-1);
T(23) = T(21)*T(22);
T(24) = (1+params(8))^(-1);
T(25) = 1/(1+params(8));
T(26) = 1/(1+params(8))^2;
T(27) = (y(3)*params(1))^((-1)/(params(2)-1));
T(28) = (y(3)*params(1))^(1/(params(2)-1));
T(29) = y(36)*T(28);
T(30) = y(11)^(1-params(3));
T(31) = y(55)^2;

end
