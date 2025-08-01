/*
The square root of all evil: the role of market power in Fiscal consolidations
Brito, P., Costa, L., Costa Filho, J.R., and Santos, C.

Correspondence: 

João Ricardo Costa Filho: joaocostafilho.com

This is a free software: you can redistribute it and/or modify it under                                                                
the terms of the GNU General Public License as published by the Free                                                                  
Software Foundation, either version 3 of the License, or (at your option)                                                              
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                          

*/

@#include "variables.mod"

@#include "parameters.mod"

@#include "model.mod"

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Steady State
%--------------------------------------------------------------------------------------------------------------------------------------

@#include "ss.mod"

%--------------------------------------------------------------------------------------------------------------------------------------
% Impulse-response functions
%--------------------------------------------------------------------------------------------------------------------------------------

@#include "shocks.mod"

stoch_simul(ar=5, order=1, irf=16);

%store the results into the following matlab objects:

oo_dynamic = oo_;
M_dynamic  = M_;

%write_latex_dynamic_model;
%write_latex_parameter_table;
%write_latex_definitions;

%stoch_simul(TeX, ar=5, irf=16, nograph, noprint);

%stoch_simul(TeX, ar=5, irf=16);

%collect_latex_files;


