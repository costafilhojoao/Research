function [y, T, residual, g1] = static_12(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(1, 1);
  residual(1)=((1-params(5))/(1+params(8))*y(13)+1/(1+params(8))*(y(31)-y(34))/y(4)+1/(1+params(8))^2*y(37)-y(13))-(0);
if nargout > 3
    g1_v = NaN(1, 1);
g1_v(1)=(1-params(5))/(1+params(8))-1;
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 1, 1);
end
end
