/*

Business cycles in the State of Rio Grande do Sul: A Regional DSGE approach (2025)

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
* type "dynare name" (where name stands for how you named your mod-file) into the command window

This code was originally written by Eichenbaum, Rebelo and Trabandt (2020),'Epidemics in the New Keynesian Model' and adpted by Carlos Marchionatti.

For Matlab R2020a and DYNARE 4.6.1.

*/


%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

% Endogenous variables

var c,
    c_r,
    c_o,
    d,
    i,
    q,
    y ${{Y}}$ (long_name='Output'),
    yd,
    yc,
    nd,
    nc,
    phi_c,
    phi_d,
    wc,
    wd,
    pi ${{\pi_{POA}}}$,
    pi_c,
    pi_d,
    r,
    xc,
    xd,
    mu,
    K,
    Q,
    rk,
    IC,
    rr,
    p_c,
    p_d,
    b,
    kg,
    n,
    ac,
    ad,
    dd,
    GL  ${{G^L}}$   (long_name='Local Government'),
    GC  ${{G^C}}$   (long_name='Central Government'),
    IGL ${{IG^L}}$  (long_name='Local Investment'),
    IGC ${{IG^C}}$  (long_name='Central Investment'),
    td,
    twc,
    twd,
    ti,
    tr,
    T,
    pr,
    tc,
    tp,
    p,
    W ${{W}}$    (long_name='Wages')
  ;

% Exogenous variables

varexo eps_ac
       eps_ad
       eps_g
       eps_gc
       eps_igl
       eps_igc
;
