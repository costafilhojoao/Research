function [nzij_pred, nzij_current, nzij_fwrd] = dynamic_g1_nz()
% Returns the coordinates of non-zero elements in the Jacobian, in column-major order, for each lead/lag (only for endogenous)
  nzij_pred = zeros(4, 2, 'int32');
  nzij_pred(1,1)=3; nzij_pred(1,2)=3;
  nzij_pred(2,1)=5; nzij_pred(2,2)=3;
  nzij_pred(3,1)=7; nzij_pred(3,2)=3;
  nzij_pred(4,1)=8; nzij_pred(4,2)=5;
  nzij_current = zeros(19, 2, 'int32');
  nzij_current(1,1)=4; nzij_current(1,2)=1;
  nzij_current(2,1)=5; nzij_current(2,2)=1;
  nzij_current(3,1)=6; nzij_current(3,2)=1;
  nzij_current(4,1)=7; nzij_current(4,2)=1;
  nzij_current(5,1)=1; nzij_current(5,2)=2;
  nzij_current(6,1)=2; nzij_current(6,2)=2;
  nzij_current(7,1)=4; nzij_current(7,2)=2;
  nzij_current(8,1)=3; nzij_current(8,2)=3;
  nzij_current(9,1)=2; nzij_current(9,2)=4;
  nzij_current(10,1)=5; nzij_current(10,2)=4;
  nzij_current(11,1)=6; nzij_current(11,2)=4;
  nzij_current(12,1)=5; nzij_current(12,2)=5;
  nzij_current(13,1)=8; nzij_current(13,2)=5;
  nzij_current(14,1)=1; nzij_current(14,2)=6;
  nzij_current(15,1)=7; nzij_current(15,2)=6;
  nzij_current(16,1)=2; nzij_current(16,2)=7;
  nzij_current(17,1)=6; nzij_current(17,2)=7;
  nzij_current(18,1)=3; nzij_current(18,2)=8;
  nzij_current(19,1)=4; nzij_current(19,2)=8;
  nzij_fwrd = zeros(1, 2, 'int32');
  nzij_fwrd(1,1)=1; nzij_fwrd(1,2)=2;
end
