function [y, T] = static_3(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(22)=0;
  y(32)=0;
  y(33)=(-y(32));
  y(34)=0;
end
