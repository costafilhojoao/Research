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
% 3. Model
%--------------------------------------------------------------------------------------------------------------------------------------

model(linear);

// Optimized households (10 eqs)

c_o = c_o(+1)-(r - pi_c(+1))+tau_C/(1+tau_C)*(tc(+1)-tc)-(pr(+1)-pr); // Euler equation for non-durable goods

d = (1-beta*(1-delta))^(-1)*((1-delta)*beta*mu(+1)-mu)+dd; // FOC for durable goods

tau_D/(1+tau_D)*td + q + c_o = mu + mu(+1) + beta*psi*(i(+1)-i); // FOC for residual investment

(phi-l_L)*((nc_ss/(nc_ss+nd_ss))*nc+(nd_ss/(nc_ss+nd_ss))*nd)+l_L*nc = wc - tau_WC/(1-tau_WC)*twc - tau_C/(1+tau_C)*tc-c; // Labor for non-durable

(phi-l_L)*((nc_ss/(nc_ss+nd_ss))*nc+(nd_ss/(nc_ss+nd_ss))*nd)+l_L*nd = wd - q- tau_WD/(1-tau_WD)*twd - tau_C/(1+tau_C)*tc-c; // Labor for durable

d = (1-delta)*d(-1)+delta*i; // LOM for durable

Q = -(r-pi_c(+1))+beta*(r_k*rk(+1)+(1-delta_k)*Q(+1));//Tobin's Q

IC = 1/(1+beta)*IC(-1)+beta/(1+beta)*IC(+1)+psi_C/(1+beta)*Q;//Investment for non durable

K = (1-delta_k)*K(-1)+delta_k*IC; //LOM of capital stock

kg = (1-delta_g)*kg(-1) + (IGL_ss/KG_ss)*IGL + (IGC_ss/KG_ss)*IGC; //

// HTM households (1 eqs)

c_r = ww1*(wc+nc-tau_WC/(1-tau_WC)*twc)+ww2*(wd+nd-tau_WD/(1-tau_WD)*twd)-tau_C/(1+tau_C)*tc;

// other equations (13 eqs)

pi_c = lambda_fc*pi_c(+1)+lambda_bc*pi_c(-1)+kappa_c*xc+kappa_c*tau_I/(1-tau_I)*ti; // Phillips Curve for non-durable with tax

pi_d = lambda_fd*pi_d(+1)+lambda_bd*pi_d(-1)+kappa_d*xd+kappa_d*tau_I/(1-tau_I)*ti; // Phillips Curve for durable with tax

pi = p - p(-1); // Inflation

yc = ac+omega*K(-1)+(1-omega2)*nc+nu*kg(-1); // Production function for non-durable

r = phi_r*r(-1)+phi_r2*r(-2)+(1-phi_r-phi_r2)*(phi_p*pi+phi_y*y); // Monetary policy rule

rr = r - pi(+1); // real interest rate

yd = ad+nd; // Production function for durable

xc = -ac+(1-omega2)*wc+omega*rk-nu*kg(-1); // Real marginal cost for non-durable

xd = -ad+wd-q; // Real marginal cost for durable

nc = K(-1) + rk -wc; // Labor demand for non-durable

nd = nc +l_L^(-1)*(wc-wd-q)-l_L^(-1)*(tau_WC/(1+tau_WC)*twc-tau_WD/(1-tau_WD)*twd); // relative labour demand

phi_c = p_c+yc-p-rk-K(-1)-wc-nc;

phi_d = p_d+yd-p-wd-nd;

c_gl*GL/(c_igl+c_gl) + c_igl*IGL/(c_igl+c_gl) = (1-tht_c)*((tau_C*c_y)/(c_igl+c_gl)*(tc+p_c+c-p)+(tau_D*c_i)/(c_igl+c_gl)*(td+p_d+c-p)) + (1-tht_w)*((tau_WC*wc_ss*nc_ss)/(c_igl+c_gl)*(twc+wc+nc)+(tau_WD*wd_ss*nd_ss)/(c_igl+c_gl)*(twd+wd+nd)) + w_ltr*tr; // local government budget constraint

c_gc*GC/(c_igc+c_gc) + c_igc*IGC/(c_igc+c_gc) = tht_c*((tau_C*c_y)/(c_igc+c_gc)*(tc+p_c+c-p)+(tau_D*c_i)/(c_igc+c_gc)*(td+p_d+c-p)) + tht_w*((tau_WC*wc_ss*nc_ss)/(c_igc+c_gc)*(twc+wc+nc)+(tau_WD*wd_ss*nd_ss)/(c_igc+c_gc)*(twd+wd+nd)) +tau_I*(phi_c_ss/(c_igc+c_gc)*(ti+phi_c) + phi_d_ss/(c_igc+c_gc)*(ti+phi_d)) - w_ctr*tr + 0.02*b - w_br*(b(-1)+r) + T ; // central government budget

// identities (6 eqs)

y = c_y*c + c_i*i + c_I*IC + c_gl*GL + c_gc*GC + c_igl*IGL + c_igc*IGC; // Market equilibrium condition

y = (1-alpha)*yc + alpha*yd;

n = (nc_ss/(nc_ss+nd_ss))*nc + (nd_ss/(nc_ss+nd_ss))*nd;

W = nc_ss*wc_ss*(nc + wc) + nd_ss*wd_ss*(nd + wd);

q = q(-1)+pi_d-pi_c; // LOM of Relative price (P_d/P_c)

pi_c = p_c-p_c(-1); //price level of non-durable goods

pi_d = p_d-p_d(-1); // Price level of durable goods (Housing price)

p = (1-gam)*p_c+gam*p_d; // Prices aggregation for governmemt equations

c = (1-zeta)*c_o + zeta*c_r; // aggregate consumption

T = phi_b*b(-1)+ tp; // Fiscal policy rule

// shocks

ac = rho_c * ac(-1) + eps_ac;      // Non-durable goods TFP

ad = rho_d * ad(-1) + eps_ad;      // Durable goods TFP

GL = rho_G * GL(-1) + eps_g;       // Local Government expediture

GC = rho_gc * GC(-1) + eps_gc;     // Central Government expediture

IGL = rho_IGL * IGL(-1) + eps_igl; // Local Government investiment

IGC = rho_IGC*IGC(-1) + eps_igc;   // Central Government investment

tc = rho_tc * tc(-1);              // non-durable consumption tax

twc = rho_wc * twc(-1);             // non-durable income tax

twd = rho_wd*twd(-1); // durable income tax shock

ti = rho_i*ti(-1); // cooperation tax shock

td = rho_td*td(-1);

pr = rho_pr*pr(-1); // preference shock

dd = rho_e*dd(-1); // Housing demand shock

tp = rho_t*tp(-1); //

end;
