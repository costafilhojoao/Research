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

@#include "ss.mod"

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Impulse Response Functions
%--------------------------------------------------------------------------------------------------------------------------------------

shocks;
var eps_ac;  stderr SIGMAC;
var eps_ad;  stderr SIGMAD;
var eps_g;   stderr SIGMAG;
var eps_gc;  stderr SIGMAGC;
var eps_igl; stderr SIGMAIGL;
var eps_igc; stderr SIGMAIGC;
end;


stoch_simul( irf=10, nograph );
