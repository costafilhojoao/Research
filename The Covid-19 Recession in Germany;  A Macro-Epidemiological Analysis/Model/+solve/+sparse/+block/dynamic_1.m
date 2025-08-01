function [y, T] = dynamic_1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(150)=y(51)+x(4);
  y(148)=y(150)*y(49)+x(2);
  y(149)=y(150)*y(50)+x(3);
  y(147)=y(150)*y(48)+x(1);
end
