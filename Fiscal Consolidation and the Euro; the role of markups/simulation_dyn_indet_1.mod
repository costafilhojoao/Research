var x; R; pi; g; z; xs;

varexo e_R; e_g; e_z; sunspot;

parameters tau; kappa; rho_R; rho_g; rho_z; psi1
psi2; sigmag; sigmaz; sigmaR;

Model equationsmodel(linear);

x = xs ;
pi ¼ 0:97npiðþ1ÞþkappanðxzÞ;
R ¼ rho_RnRð1Þþ1 ð rho_RÞn
ðpsi1npiþpsi2nðxzÞÞþe_R;
g ¼ rho_gngð1Þþe_g;
z ¼ rho_znzð1Þþe_z;
xxsð1Þ¼sunspot;
end;