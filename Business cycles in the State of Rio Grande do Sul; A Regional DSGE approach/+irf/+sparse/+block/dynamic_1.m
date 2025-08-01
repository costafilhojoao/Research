function [y, T] = dynamic_1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(84)=params(71)*y(33)+x(1);
  y(85)=params(72)*y(34)+x(2);
  y(87)=params(73)*y(36)+x(3);
  y(88)=params(74)*y(37)+x(4);
  y(89)=params(75)*y(38)+x(5);
  y(90)=params(76)*y(39)+x(6);
  y(98)=params(84)*y(47);
  y(92)=params(79)*y(41);
  y(93)=params(80)*y(42);
  y(94)=params(81)*y(43);
  y(91)=params(78)*y(40);
  y(97)=params(83)*y(46);
  y(86)=params(77)*y(35);
  y(99)=params(82)*y(48);
  y(82)=(1-params(29))*y(31)+params(40)/params(39)*y(89)+params(41)/params(39)*y(90);
end
