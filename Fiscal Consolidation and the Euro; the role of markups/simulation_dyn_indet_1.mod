var x; R; pi; g; z; xs;

varexo e_R; e_g; e_z; sunspot;

parameters tau; kappa; rho_R; rho_g; rho_z; psi1
psi2; sigmag; sigmaz; sigmaR;

Model equationsmodel(linear);

x = xs ;
pi � 0:97npi��1��kappan�xz�;
R � rho_RnR�1��1 � rho_R�n
�psi1npi�psi2n�xz���e_R;
g � rho_gng�1��e_g;
z � rho_znz�1��e_z;
xxs�1޼sunspot;
end;