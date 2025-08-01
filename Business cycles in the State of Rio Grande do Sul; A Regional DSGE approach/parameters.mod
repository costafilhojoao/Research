
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
% 2. Parameters and Calibration
%--------------------------------------------------------------------------------------------------------------------------------------

parameters phi_r2 beta delta psi phi l_L gam alpha theta_c theta_d phi_p omega omega2 r_k theta_el zeta phi_b phi_g;
parameters lam_c lam_d chi_c chi_d lambda_fc lambda_bc phi_y phi_r psi_C delta_k delta_g nu gybar ;
parameters c_i c_I c_y c_gc c_gl c_igl c_igc KG_ss IGL_ss IGC_ss T_ss;
parameters w_glc w_gld w_glwc w_glwd w_ltr trans phi_gy;
parameters w_gcc w_gcd w_gcwc w_gcwd w_ctr w_br w_gf c_gl2 c_gc2;
parameters lambda_fd lambda_bd kappa_c kappa_d tau_C tau_D tau_WC tau_WD tau_I,tht_c,tht_w,tht_i;
parameters rho_c rho_d rho_G rho_gc rho_IGL rho_IGC ;
parameters rho_e rho_td rho_wc rho_wd rho_i rho_t rho_pr rho_tc;
parameters ww1 ww2 phi_c_ss phi_d_ss nc_ss nd_ss wc_ss wd_ss;
parameters SIGMAC SIGMAD SIGMAG SIGMAGC SIGMAIGL SIGMAIGC;
parameters SIGMAE SIGMATC SIGMATD SIGMAWC SIGMAWD SIGMAI SIGMAT SIGMAPR;

beta = 0.9585; // Discount factor
delta = .05; // Depriciation rate of durable goods
delta_k = .05;
delta_g = .05; // depriciation rate of public capital stock
nu = 0.05; //productivity effect of social capital
omega = .35; // production function
omega2 = omega + nu;
psi = 1.25; // Elasticity of durable investestment
psi_C = 1.25; // The model is robust to any change of this parameter
phi = 2.5; // Inverse Frisch elasticity of labor supply
l_L = 0.85; //Labor disutility of switching sectors
gam = .15; // Share of durable goods inflation in Price index
alpha = .05; // Share of durables in GDP
theta_c = .05; // Calvo lottery for non-durable
theta_d = .05; // Calvo lottery for durable
lam_c = 0.85; // Share of rule-of-thumb firms in non-durable sector
lam_d = 0.85; // Share of rule-of-thumb firms in durable sector
phi_p = 1.75; //Coefficient for inflation response in monetary policy rule
phi_y = 0.65; // Coefficient for output response in monetary policy rule
phi_r = 0.95; // Interest rate smoothing
phi_r2 = -0.4;
r_k = 1/beta - (1-delta_k); // Steady state value of rk

zeta = 0.4; // Share of HT households*

c_i = alpha; //  Share of housing investment
c_I = 0.1285; //  Share of investment
c_igl = 0.0137;
c_igc = 0.0140;
c_gl2 = 0.153; //  Share of government expediture
c_gc2 = 0.167;
trans_l = 0.04;
trans_c = 0.08;
c_gl = c_gl2 - trans_l;
c_gc = c_gc2 - trans_c;
c_y = 1 - c_i - c_I - c_gl2 - c_gc2 - c_igl - c_igc + trans_l + trans_c; //  Share of consumption

IGL_ss = c_igl;
IGC_ss = c_igc;
KG_ss = (c_igl + c_igc)/delta_g;
T_ss = 0.012;
phi_b = T_ss/(c_gc+c_igc);

nc_ss = ((1-alpha)/((c_I/delta_k)^omega*KG_ss^nu))^(1/(1-omega2));
wc_ss = ((1-omega2)*r_k*c_I/delta_k)/(omega*nc_ss);

nd_ss = alpha; // equal to yd as well
wd_ss = wc_ss*(nd_ss/nc_ss)^l_L;

phi_c_ss = (1-alpha) - r_k*(c_I/delta_k) - nc_ss*wc_ss;
phi_d_ss = alpha - nd_ss*wd_ss;

trans = 0.025;
tht_c = 0.075; //
tht_w = 0.85; //
tht_i = 1; //


w_ltr = trans/(c_gl+c_igl); //
w_ctr = trans/(c_gc+c_igc); //

tau_C  = 0.75*(c_gl+c_igl)/((1-tht_c)*(c_y+c_i)); //  consumption tax of non-durable goods
tau_D  = tau_C; //  consumption tax of durable investment
tau_WC = 0.10*(c_gl+c_igl)/((1-tht_w)*(wc_ss*nc_ss+nd_ss*wd_ss)); // income tax for worker in non-durable goods firms
tau_WD = tau_WC; // income tax for worker in Brazil is the same for every sector
tau_I  = 0.225 ; //  cooperate tax

local_receitas = (1-tht_c)*(tau_C*c_y)/(c_gl+c_igl)+(1-tht_c)*(tau_D*c_i)/(c_gl+c_igl)+(1-tht_w)*(tau_WC*nc_ss*wc_ss)/(c_gl+c_igl)+(1-tht_w)*(tau_WD*nd_ss*wd_ss)/(c_gl+c_igl)+w_ltr;
central_receitas = tht_c*(tau_C*c_y)/(c_gl+c_igc)+tht_c*(tau_D*c_i)/(c_gl+c_igc)+tht_w*(tau_WC*nc_ss*wc_ss)/(c_gl+c_igc)+tht_w*(tau_WD*nd_ss*wd_ss)/(c_gl+c_igc)-w_ctr+phi_b+tau_I*(phi_c_ss + phi_d_ss)/(c_gl+c_igc);

gl_c = (1-tht_c)*(tau_C*c_y)/(c_gl+c_igl)+(1-tht_c)*(tau_D*c_i)/(c_gl+c_igl);
gl_w = (1-tht_w)*(tau_WC*nc_ss*wc_ss)/(c_gl+c_igl)+(1-tht_w)*(tau_WD*nd_ss*wd_ss)/(c_gl+c_igl);

gc_c = tht_c*(tau_C*c_y)/(c_gl+c_igc)+tht_c*(tau_D*c_i)/(c_gl+c_igc);
gc_w = tht_w*(tau_WC*nc_ss*wc_ss)/(c_gl+c_igc)+tht_w*(tau_WD*nd_ss*wd_ss)/(c_gl+c_igc);
gc_i = tau_I*(phi_c_ss + phi_d_ss)/(c_gl+c_igc);

w_br = central_receitas - 1;

remuneracao_ss = (wc_ss*nc_ss)^(1-alpha)*(wd_ss*nd_ss)^(alpha);

remuneracao_ss2 = wc_ss*nc_ss + wd_ss*nd_ss;

yc_ss = nc_ss^(1-omega2)*(c_I/delta_k)^(omega)*KG_ss^(nu);
yd_ss = nd_ss;

ww1 = (wc_ss*nc_ss)*(1-tau_WC)/zeta*(1+tau_C);//
ww2 = (wd_ss*alpha)*(1-tau_WD)/zeta*(1+tau_D);

// Parameters for NK Philips Curves (Durable and non-durable)

chi_c     = theta_c+(1-lam_c)*(1-theta_c*(1-beta));
lambda_fc = theta_c*beta/chi_c;
lambda_bc = (1-lam_c)/chi_c;
kappa_c   = lam_c*(1-theta_c)*(1-theta_c*beta)/chi_c;

chi_d     = theta_d+(1-lam_d)*(1-theta_d*(1-beta));
lambda_fd = theta_d*beta/chi_d;
lambda_bd = (1-lam_d)/chi_d;
kappa_d   = lam_d*(1-theta_d)*(1-theta_d*beta)/chi_d;

rho_c   = -0.010294; // * TFP shock for non-durable sector;
rho_d   = 0.373946; // * TFP shock for durable sector;
rho_e   = 0.13^4; // housing demand shock;
rho_G   = 0.433644; // Government expenditure shock
rho_tc  = 0;
rho_td  = 0;
rho_wc  = 0;
rho_wd  = 0;
rho_i   = 0;
rho_t   = 0;
rho_gc  = -0.832495;
rho_IGL = 0.340844;
rho_IGC = -0.235596;
rho_pr  = 0.13^4; // preference shock
rho_tc  = 0.8^4;

SIGMAC   = 0.024680;
SIGMAD   = 0.045081;
SIGMAE   = 1;
SIGMAG   = 0.028364;
SIGMATC  = 1;
SIGMATD  = 1;
SIGMAWC  = 1;
SIGMAWD  = 1;
SIGMAI   = 1;
SIGMAT   = 1;
SIGMAGC  = 0.040224;
SIGMAPR  = 1;
SIGMAIGL = 0.187884;
SIGMAIGC = 0.224278;
