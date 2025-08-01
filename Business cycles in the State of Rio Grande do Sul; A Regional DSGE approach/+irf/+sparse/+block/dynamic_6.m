function [y, T, residual, g1] = dynamic_6(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(2, 1);
  residual(1)=(y(96))-(y(30)*params(17)+y(99));
  residual(2)=(params(35)*y(88)/(params(35)+params(38))+y(90)*params(38)/(params(35)+params(38)))-(params(68)*((y(52)+y(98)+y(79)-y(100))*params(63)*params(34)/(params(35)+params(38))+(y(52)+y(91)+y(80)-y(100))*params(64)*params(32)/(params(35)+params(38)))+params(69)*((y(62)+y(65)+y(92))*params(89)*params(65)*params(91)/(params(35)+params(38))+(y(61)+y(66)+y(93))*params(90)*params(66)*params(92)/(params(35)+params(38)))+params(67)*(params(87)/(params(35)+params(38))*(y(94)+y(63))+params(88)/(params(35)+params(38))*(y(94)+y(64)))-y(95)*params(54)+0.02*y(81)-params(55)*(y(70)+y(30))+y(96));
if nargout > 3
    g1_v = NaN(3, 1);
g1_v(1)=1;
g1_v(2)=(-1);
g1_v(3)=(-0.02);
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 2, 2);
end
end
