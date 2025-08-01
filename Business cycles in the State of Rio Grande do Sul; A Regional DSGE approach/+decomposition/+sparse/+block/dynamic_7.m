function [y, T] = dynamic_7(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(101)=(y(62)+y(65))*params(89)*params(91)+(y(61)+y(66))*params(90)*params(92);
  y(83)=params(89)/(params(89)+params(90))*y(62)+params(90)/(params(89)+params(90))*y(61);
  y(78)=y(70)-y(118);
end
