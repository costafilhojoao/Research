% Adaptado de https://github.com/JohannesPfeifer/DSGE_mod/blob/master/Gali_2008/Gali_2008_chapter_3.mod


%--------------------------------------------------------------------------------------------------------------------------------------
% 0. Condução da política monetária
%--------------------------------------------------------------------------------------------------------------------------------------

% Aqui deve ser definido se o banco central utiliza uma regra de crescimento da quantidade de moeda (1) ou 
% uma regra de política monetária (0). 

@#define money_growth_rule=0


%--------------------------------------------------------------------------------------------------------------------------------------
% 1. Definição das Variáveis
%--------------------------------------------------------------------------------------------------------------------------------------


var y        ${\tilde y}$ (long_name='output gap')
    pi       ${\pi}$      (long_name='inflation')
    i        ${i}$        (long_name='interest rate')
    ;     

varexo e_d ${\varepsilon_d}$   (long_name='demand shock')
       e_s ${\varepsilon_\nu}$ (long_name='supply shock')
       e_m ${\varepsilon_\m}$  (long_name='monetary shock')
       ;

%--------------------------------------------------------------------------------------------------------------------------------------
% 2. Calibração
%--------------------------------------------------------------------------------------------------------------------------------------

parameters sigma  ${\sigma}$ (long_name='log utility')
           kappa  ${\phi}$ (long_name='unitary Frisch elasticity')
           beta   ${\phi_{\pi}}$ (long_name='inflation feedback Taylor Rule')
           phi_pi ${\phi_{y}}$ (long_name='output feedback Taylor Rule')
           phi_y  ${\eta}$ (long_name='semi-elasticity of money demand')
   rho ;  

sigma = 2;
kappa  = 0.5;
phi_y  = .5/4;
phi_pi = 1.5;
beta   = 0.96;
rho = 0.9;


%--------------------------------------------------------------------------------------------------------------------------------------
% 3. Modelo
%--------------------------------------------------------------------------------------------------------------------------------------

model(linear);

//2. Dynamic IS Curve 
y = y(+1) -1 / sigma * ( i - pi(+1) ) + e_d;

//1. New Keynesian Phillips Curve
pi = kappa * y + beta * pi(+1) + e_s;

//3. Interest Rate Rule
i = rho * i(-1) + ( 1 - rho ) * phi_pi * pi + phi_y * y + e_m;
end;

%--------------------------------------------------------------------------------------------------------------------------------------
% 4. Equilíbrio
%--------------------------------------------------------------------------------------------------------------------------------------

resid(1)
steady;
check;
model_diagnostics;
model_info;

%--------------------------------------------------------------------------------------------------------------------------------------
% 5. Simulação
%--------------------------------------------------------------------------------------------------------------------------------------

shocks;
var e_d = 0.25^2; //1 standard deviation shock of 25 basis points, i.e. 1 percentage point annualized
var e_s = 0.25^2; //1 standard deviation shock of 25 basis points, i.e. 1 percentage point annualized
var e_m = 0.25^2; //1 standard deviation shock of 25 basis points, i.e. 1 percentage point annualized
end;

stoch_simul(order = 1,irf=15, nograph) y, pi, i;