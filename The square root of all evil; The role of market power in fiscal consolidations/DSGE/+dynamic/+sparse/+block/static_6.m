function [y, T, residual, g1] = static_6(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(4, 1);
  T(4)=(1-params(14))^(1/params(15));
  T(5)=params(14)^(1/params(15));
  T(6)=T(4)*y(20)^((params(15)-1)/params(15))+T(5)*y(21)^((params(15)-1)/params(15));
  residual(1)=(y(25))-(T(6)^(params(15)/(params(15)-1)));
  T(7)=(1-params(14))*(y(18)/y(4))^(-params(15));
  residual(2)=(y(20))-(T(7)*y(25));
  T(8)=params(14)*(y(19)/y(4))^(-params(15));
  residual(3)=(y(21))-(T(8)*y(25));
  T(9)=(1-params(14))*y(18)^(1-params(15))+params(14)*y(19)^(1-params(15));
  residual(4)=(y(4))-(T(9)^(1/(1-params(15))));
  T(10)=getPowerDeriv(y(18)/y(4),(-params(15)),1);
  T(11)=getPowerDeriv(T(6),params(15)/(params(15)-1),1);
if nargout > 3
    g1_v = NaN(9, 1);
g1_v(1)=(-(T(4)*getPowerDeriv(y(20),(params(15)-1)/params(15),1)*T(11)));
g1_v(2)=1;
g1_v(3)=(-(y(25)*(1-params(14))*(-y(18))/(y(4)*y(4))*T(10)));
g1_v(4)=(-(y(25)*params(14)*(-y(19))/(y(4)*y(4))*getPowerDeriv(y(19)/y(4),(-params(15)),1)));
g1_v(5)=1;
g1_v(6)=(-(T(11)*T(5)*getPowerDeriv(y(21),(params(15)-1)/params(15),1)));
g1_v(7)=1;
g1_v(8)=(-(y(25)*(1-params(14))*T(10)*1/y(4)));
g1_v(9)=(-((1-params(14))*getPowerDeriv(y(18),1-params(15),1)*getPowerDeriv(T(9),1/(1-params(15)),1)));
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 4, 4);
end
end
