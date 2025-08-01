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

@#include "irf.mod"

%--------------------------------------------------------------------------------------------------------------------------------------
% 6. Decomposition
%--------------------------------------------------------------------------------------------------------------------------------------

varobs y ac ad GL IGL GC IGC;
options_.diffuse_filter=1;
shock_decomposition(parameter_set=calibration,datafile='data.xlsx') y;

shocks_sequence = zeros(10, M_.exo_nbr);
shocks_sequence(1, strmatch('eps_ac',M_.exo_names,'exact')) = -0.01705975490872472; %2012
shocks_sequence(1, strmatch('eps_ad',M_.exo_names,'exact')) = 0.001550379989629987; %2012
shocks_sequence(1, strmatch('eps_g',M_.exo_names,'exact')) = 0.02171074048448909; %2012
shocks_sequence(1, strmatch('eps_igl',M_.exo_names,'exact')) = 0.1306769400372893; %2012
shocks_sequence(1, strmatch('eps_gc',M_.exo_names,'exact')) = -0.0261711560524772; %2012
shocks_sequence(1, strmatch('eps_igc',M_.exo_names,'exact')) = -0.06645770510926448; %2012

shocks_sequence(2, strmatch('eps_ac',M_.exo_names,'exact')) = 0.02544120779411117; %2013
shocks_sequence(2, strmatch('eps_ad',M_.exo_names,'exact')) = 0.06216426213942115; %2013
shocks_sequence(2, strmatch('eps_g',M_.exo_names,'exact')) = 0.03097442117742822; %2013
shocks_sequence(2, strmatch('eps_igl',M_.exo_names,'exact')) = -0.05772984093651459; %2013
shocks_sequence(2, strmatch('eps_gc',M_.exo_names,'exact')) = 0.02411627614978016; %2013
shocks_sequence(2, strmatch('eps_igc',M_.exo_names,'exact')) = 0.1474284674844898; %2013

shocks_sequence(3, strmatch('eps_ac',M_.exo_names,'exact')) = 0.005358939666522266; %2014
shocks_sequence(3, strmatch('eps_ad',M_.exo_names,'exact')) = 0.041489952015686; %2014
shocks_sequence(3, strmatch('eps_g',M_.exo_names,'exact')) = 0.03471539481743821; %2014
shocks_sequence(3, strmatch('eps_igl',M_.exo_names,'exact')) = 0.1386351706115867; %2014
shocks_sequence(3, strmatch('eps_gc',M_.exo_names,'exact')) = 0.04234465981216511; %2014
shocks_sequence(3, strmatch('eps_igc',M_.exo_names,'exact')) = 0.3287591844776029; %2014

shocks_sequence(4, strmatch('eps_ac',M_.exo_names,'exact')) = -0.03143798074161005; %2015
shocks_sequence(4, strmatch('eps_ad',M_.exo_names,'exact')) = -0.01065386460472011; %2015
shocks_sequence(4, strmatch('eps_g',M_.exo_names,'exact')) = 0.001632502183520814; %2015
shocks_sequence(4, strmatch('eps_igl',M_.exo_names,'exact')) = -0.25075678055595; %2015
shocks_sequence(4, strmatch('eps_gc',M_.exo_names,'exact')) = 0.00652464652236222; %2015
shocks_sequence(4, strmatch('eps_igc',M_.exo_names,'exact')) = -0.05552662867606521; %2015

shocks_sequence(5, strmatch('eps_ac',M_.exo_names,'exact')) = -0.03450058171804366; %2016
shocks_sequence(5, strmatch('eps_ad',M_.exo_names,'exact')) = -0.02489555105405343; %2016
shocks_sequence(5, strmatch('eps_g',M_.exo_names,'exact')) = -0.03499518063205938; %2016
shocks_sequence(5, strmatch('eps_igl',M_.exo_names,'exact')) = -0.1326128705939315; %2016
shocks_sequence(5, strmatch('eps_gc',M_.exo_names,'exact')) = -0.02790570654028174; %2016
shocks_sequence(5, strmatch('eps_igc',M_.exo_names,'exact')) = 0.04112288579695766; %2016

shocks_sequence(6, strmatch('eps_ac',M_.exo_names,'exact')) = 0.004031229545217486; %2017
shocks_sequence(6, strmatch('eps_ad',M_.exo_names,'exact')) = -0.04847198387384286; %2017
shocks_sequence(6, strmatch('eps_g',M_.exo_names,'exact')) = 0.004082299219190419; %2017
shocks_sequence(6, strmatch('eps_igl',M_.exo_names,'exact')) = -0.2439025747872802; %2017
shocks_sequence(6, strmatch('eps_gc',M_.exo_names,'exact')) = 0.00667183290091585; %2017
shocks_sequence(6, strmatch('eps_igc',M_.exo_names,'exact')) = -0.2292722177791354; %2017

shocks_sequence(7, strmatch('eps_ac',M_.exo_names,'exact')) = 0.03585422393154063; %2018
shocks_sequence(7, strmatch('eps_ad',M_.exo_names,'exact')) = -0.03554124750818318; %2018
shocks_sequence(7, strmatch('eps_g',M_.exo_names,'exact')) = 0.01360725515171144; %2018
shocks_sequence(7, strmatch('eps_igl',M_.exo_names,'exact')) = 0.112874594282675; %2018
shocks_sequence(7, strmatch('eps_gc',M_.exo_names,'exact')) = 0.006779324717219024; %2018
shocks_sequence(7, strmatch('eps_igc',M_.exo_names,'exact')) = -0.2205236619715751; %2018

shocks_sequence(8, strmatch('eps_ac',M_.exo_names,'exact')) = 0.01562722847499207; %2019
shocks_sequence(8, strmatch('eps_ad',M_.exo_names,'exact')) = -0.01428033857246151; %2019
shocks_sequence(8, strmatch('eps_g',M_.exo_names,'exact')) = -0.004242805345791618; %2019
shocks_sequence(8, strmatch('eps_igl',M_.exo_names,'exact')) = -0.1033395459187607; %2019
shocks_sequence(8, strmatch('eps_gc',M_.exo_names,'exact')) = -0.05032409839734402; %2019
shocks_sequence(8, strmatch('eps_igc',M_.exo_names,'exact')) = -0.1465960583935117; %2019

shocks_sequence(9, strmatch('eps_ac',M_.exo_names,'exact')) = -0.02146625288628368; %2020
shocks_sequence(9, strmatch('eps_ad',M_.exo_names,'exact')) = -0.0478992193146519; %2020
shocks_sequence(9, strmatch('eps_g',M_.exo_names,'exact')) = -0.01296410441542629; %2020
shocks_sequence(9, strmatch('eps_igl',M_.exo_names,'exact')) = 0.1698590282740009; %2020
shocks_sequence(9, strmatch('eps_gc',M_.exo_names,'exact')) = 0.08179942343391636; %2020
shocks_sequence(9, strmatch('eps_igc',M_.exo_names,'exact')) = 0.4560292809791568; %2020

shocks_sequence(10, strmatch('eps_ac',M_.exo_names,'exact')) = 0.01815174084227845; %2021
shocks_sequence(10, strmatch('eps_ad',M_.exo_names,'exact')) = 0.07653761078317585; %2021
shocks_sequence(10, strmatch('eps_g',M_.exo_names,'exact')) = -0.0612271036573273; %2021
shocks_sequence(10, strmatch('eps_igl',M_.exo_names,'exact')) = 0.334056990197168; %2021
shocks_sequence(10, strmatch('eps_gc',M_.exo_names,'exact')) = -0.01015965496669864; %2021
shocks_sequence(10, strmatch('eps_igc',M_.exo_names,'exact')) = -0.1069469224910851; %2021

simulated_sequence = simult_(M_,options_,oo_.steady_state, oo_.dr, shocks_sequence, 1);