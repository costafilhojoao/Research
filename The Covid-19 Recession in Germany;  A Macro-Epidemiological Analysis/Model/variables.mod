/*

The Covid-19 Recession in Germany: A Macro-Epidemiological Analysis
Krause, Costa, and Costa-Filho (2025)

This is a free software: you can redistribute it and/or modify it under                                                                //
the terms of the GNU General Public License as published by the Free                                                                   //
Software Foundation, either version 3 of the License, or (at your option)                                                              //
any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //

* set the path to Dynare via Home -> Set Path -> Add Folder -> chose the matlab-subfolder of Dynare
* set the folder where the .mod-file is saved to yout Matlab-path
* type "dynare name" (where name stands for how you named your mod-file; in our case, 'mex') into the command window

This code was originally written by Eichenbaum, Rebelo and Trabandt (2020),'Epidemics in the New Keynesian Model' and adpted by Willi Krause.

For Matlab R2021a and DYNARE 4.6.1.

*/


%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Defining variables
%--------------------------------------------------------------------------------------------------------------------------------------

% Endogenous variables of the actual (sticky price) economy

var y k n w rk x c s i r ns ni nr cs ci cr tau 
lambtilde lamtau lami lams lamr dd pop Rb pie mc F Kf rr 
dcs dns dci dni dw dlams dlamtau dlambtilde dlami dlamr 
dcr dnr drk dF dKf pbreve dpie muc mun mul ro; 
   

% Endogenous variables of the flexible price economy

var yF kF nF wF rkF xF cF sF iF rF nsF niF nrF csF ciF crF 
tauF lambtildeF lamtauF lamiF lamsF lamrF ddF popF RbF pieF 
mcF FF KfF rrF dcsF dnsF dciF dniF dwF dlamsF dlamtauF 
dlambtildeF dlamiF dlamrF dcrF dnrF drkF dFF dKfF pbreveF dpieF;   

% variables in both economies are the same

varexo muc_innov, mun_innov, mul_innov, ro_innov; //innovations in the Lockdown AR processes