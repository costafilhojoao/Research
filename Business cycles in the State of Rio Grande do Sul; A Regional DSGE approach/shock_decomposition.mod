### .mod to perform shock decomposition.

#Here is the Dynare Code of Kansai-RS DSGE Model.

//
//
//       Kansai-RS macroeconomic model for Rio Grande do Sul --- Based on Okano's et al (2015) mark II model
//        --- Inclusion of Public investment, social transfers and HTM households ---
//        -- Annual Frequency for parameters --
//                           
//
// 
// Modified version of Kanan, Rabanal and Scott (2012, BEJM)
// Inclusion of hand to mouth (HTM) consumer (Gali, Lopez-Salido, and Valley, 2007 JEEA) 

var c,c_r,c_o,d,i,q,y ${{Y}}$(long_name='Output'),yd,yc,nd,nc, phi_c, phi_d;
var wc,wd,pi ${{\pi_{POA}}}$,pi_c,pi_d,r,xc,xd,mu,K,Q,rk,IC,rr,p_c,p_d,b,kg,n;
var ac,ad,dd,GL ${{G^L}}$(long_name='Local Government'),GC ${{G^C}}$(long_name='Central Government'),IGL ${{IG^L}}$(long_name='Local Investment'),IGC ${{IG^C}}$(long_name='Central Investment'),td,twc,twd,ti,tr,T,pr,tc,tp,p,W ${{W}}$    (long_name='Wages');
varexo eps_ac eps_ad eps_g eps_gc eps_igl eps_igc;
// varexo eps_e eps_tc eps_td eps_wc eps_wd eps_ti eps_t eps_pr;

// oo endogenous variables, xx exogeneous shocks

parameters phi_r2 beta delta psi phi l_L gam alpha theta_c theta_d phi_p omega omega2 r_k theta_el zeta phi_b phi_g;
parameters  lam_c lam_d chi_c chi_d lambda_fc lambda_bc phi_y phi_r psi_C delta_k delta_g nu gybar ;
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

tau_C = 0.75*(c_gl+c_igl)/((1-tht_c)*(c_y+c_i)); //  consumption tax of non-durable goods
tau_D = tau_C; //  consumption tax of durable investment
tau_WC = 0.10*(c_gl+c_igl)/((1-tht_w)*(wc_ss*nc_ss+nd_ss*wd_ss)); // income tax for worker in non-durable goods firms
tau_WD = tau_WC; // income tax for worker in Brazil is the same for every sector
tau_I = 0.225 ; //  cooperate tax

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

chi_c = theta_c+(1-lam_c)*(1-theta_c*(1-beta));
lambda_fc = theta_c*beta/chi_c;
lambda_bc = (1-lam_c)/chi_c;
kappa_c = lam_c*(1-theta_c)*(1-theta_c*beta)/chi_c;

chi_d = theta_d+(1-lam_d)*(1-theta_d*(1-beta));
lambda_fd = theta_d*beta/chi_d;
lambda_bd = (1-lam_d)/chi_d;
kappa_d = lam_d*(1-theta_d)*(1-theta_d*beta)/chi_d;

rho_c = -0.010294; // * TFP shock for non-durable sector;
rho_d = 0.373946; // * TFP shock for durable sector;
rho_e = 0.13^4; // housing demand shock;
rho_G = 0.433644; // Government expenditure shock
rho_tc = 0;
rho_td = 0;
rho_wc = 0;
rho_wd = 0;
rho_i = 0;
rho_t = 0;
rho_gc = -0.832495;
rho_IGL = 0.340844;
rho_IGC = -0.235596;
rho_pr = 0.13^4; // preference shock
rho_tc = 0.8^4;

SIGMAC= 0.024680;
SIGMAD= 0.045081;
SIGMAE= 1;
SIGMAG= 0.028364;
SIGMATC= 1;
SIGMATD = 1;
SIGMAWC = 1;
SIGMAWD = 1;
SIGMAI = 1;
SIGMAT = 1;
SIGMAGC = 0.040224;
SIGMAPR = 1;
SIGMAIGL = 0.187884;
SIGMAIGC = 0.224278;

// The following is model proc. Total 31 endogenous variables and 31 corresponding equations

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
ac = rho_c*ac(-1) + eps_ac; // TFP shock in non-durable goods sector (negative shock!!)
ad = rho_d*ad(-1) + eps_ad; // TFP shock in durable goods sector
GL = rho_G*GL(-1)+eps_g; // Local Government expediture shock (nao inclui transferencias para familias)
GC = rho_gc*GC(-1)+eps_gc; // Central Government expediture shock (nao inclui transferencias para familias)
IGL = rho_IGL*IGL(-1)+eps_igl; // Local Government investiment shock
IGC = rho_IGC*IGC(-1)+eps_igc; // Central Government investment shock

tc = rho_tc*tc(-1); // non-durable consumption tax shock with news shock
twc = rho_wc*twc(-1); // non-durable income tax shock 
twd = rho_wd*twd(-1); // durable income tax shock
ti = rho_i*ti(-1); // cooperation tax shock 
td = rho_td*td(-1);
pr = rho_pr*pr(-1); // preference shock
dd = rho_e*dd(-1); // Housing demand shock
tp = rho_t*tp(-1); //
end;

initval;
c = 0;
c_o = 0;
c_r = 0;
d = 0;
q = 0;
y = 0;
K = 0;
kg = 0;
rk = 0;
Q = 0;
IC = 0;
yd = 0;
yc = 0;
nd = 0;
nc = 0;
wc = 0;
wd = 0;
W = 0;
n = 0;
pi = 0;
pi_c = 0;
pi_d = 0;
p_d = 0;
p_c = 0;
p = 0;
b = 0;
r = 0;
xc = 0;
xd = 0;
mu = 0;
tc = 0;
ac = 0;
ad = 0;
dd = 0;
GL = 0;
td = 0;
twc = 0;
twd = 0;
ti = 0;
tr = 0;
tc = 0;
T = 0;
GC = 0;
pr = 0;
tp = 0;
IGL = 0;
IGC = 0;
end;

//steady(solve_algo=3);
//resid(1);
steady;
check;

shocks;
var eps_ac; stderr SIGMAC;
var eps_ad; stderr SIGMAD;
var eps_e; stderr SIGMAE;
var eps_g; stderr SIGMAG;
//var eps_tc; stderr SIGMATC;
//var eps_td; stderr SIGMATD;
//var eps_wc; stderr SIGMAWC;
//var eps_wd; stderr SIGMAWD;
//var eps_tc_news = 1; // news shock for non-durable com tax
var eps_pr; stderr SIGMAPR;
//var eps_ti; stderr SIGMAI; // the effect of coorporation tax
//var eps_t; stderr SIGMAT;
var eps_gc; stderr SIGMAGC;
var eps_igl; stderr SIGMAIGL;
var eps_igc; stderr SIGMAIGC;
end;

stoch_simul(order=1,drop=0,periods=100,nograph,irf=15,tex) y W pi GL IGL GC IGC;

varobs y ac ad GL IGL GC IGC;
options_.diffuse_filter=1;
shock_decomposition(parameter_set=calibration,datafile='data.xlsx') y;
