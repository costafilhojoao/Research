%{

The Covid-19 Recession in Germany: A Macro-Epidemiological Analysis
Krause, Costa, and Costa-Filho (2025)

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

For Matlab R2021a.

%}

%% Evaluating the lockdowns

%% Data

Reference_Data = readtable("Reference_Data_difference.txt");

fsize = 10;
horz = 79;

deaths_data = Reference_Data.Deaths;

%% Run the model with no restrictions shock.

% First, change the values of the shocks in the 'simulations.mod' file.
% They within lines 149 to 183.

dynare solve;

deaths_nolockdowns = dd(1:horz +1);

saved  = deaths_nolockdowns(end) - deaths_data(end);

pop = 53764817; % Working age population in 2019; Source: OECD.

saved_pop = round( pop * saved, 0 );

VOL = 1.9 * 1000000;

%  the monetary benefit of containment policies:

benefit = round( saved_pop * VOL / 1000000000, 2 );

fprintf('Benefit: %.2f\n', benefit);

fprintf('Saved: %.2f\n', saved_pop);

% with a different (updated) VOL:

VOL2 = 2.7 * 1000000 / 1.142;

benefit2 = round( saved_pop * VOL2 / 1000000000, 2 );

fprintf('Benefit: %.2f\n', benefit2);

fprintf('Saved: %.2f\n', saved_pop);


