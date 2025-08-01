function [y, T, residual, g1] = dynamic_4(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(1, 1);
  residual(1)=(params(36)*y(87)/(params(36)+params(37))+y(89)*params(37)/(params(36)+params(37)))-((1-params(68))*(params(63)*params(34)/(params(36)+params(37))*(y(52)+y(98)+y(79)-y(100))+params(64)*params(32)/(params(36)+params(37))*(y(52)+y(91)+y(80)-y(100)))+(1-params(69))*(params(89)*params(65)*params(91)/(params(36)+params(37))*(y(62)+y(65)+y(92))+params(90)*params(66)*params(92)/(params(36)+params(37))*(y(61)+y(66)+y(93)))+params(47)*y(95));
if nargout > 3
    g1_v = NaN(1, 1);
g1_v(1)=(-params(47));
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 1, 1);
end
end
