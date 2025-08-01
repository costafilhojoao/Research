function T = static_g1_tt(T, y, x, params)
% function T = static_g1_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 13);

T = irf.static_resid_tt(T, y, x, params);

T(10) = (-((1-params(69))*params(90)*params(66)*params(92)/(params(36)+params(37))));
T(11) = (-(params(69)*params(90)*params(66)*params(92)/(params(35)+params(38))));
T(12) = (-((1-params(69))*params(89)*params(65)*params(91)/(params(36)+params(37))));
T(13) = (-(params(69)*params(89)*params(65)*params(91)/(params(35)+params(38))));

end
