
sigma = 2.5;
omega = 1.5;
alpha = 1/3;
psi = .55;
eta = 0.5 / 4;
phi   = 0.5;
rho   = ( ( 1 + 0.09 )^( 1 / 4 ) ) - 1;
n     = 0.5;
s     = 2.9;

PD  = 0.95;
PF  = 1;
H   = 1865 /( 365 * 14 );

e      = 1 / psi;
y       = eta * e / phi;
Y       = y;
A       = Y / H ^ ( 1 - alpha );

P   = (  ( 1 - n ) * PD ^ ( 1 - s ) + n * PF ^( 1 - s ) ) ^ ( 1 / ( 1 - s ) );
pD  = PD;
MR  = ( 1 - 1 / sigma ) * pD;
W   = H ^ ( omega - 1 ) * P;
MLC = W / ( ( 1 - alpha ) * A ^ ( 1 / ( 1 - alpha ) ) ) * y ^( alpha / ( 1 - alpha ) );
METR    = ( pD * y ) / ( sigma * e );


steadystate = @(x)[

    % lambdaf: x(1); 
    %  varphi: x(2);

    % Pricing equation
    MR + x(2) * P * x(1) - MLC;

    % Optimal demand shifter
    1 / ( 1 + rho ) * METR / P - x(1) + ( 1 - eta ) / ( 1 + rho ) * x(1);

];

%% Teste

%beta = 0.9; delta = 0.05; psi = 1; alpha= 1/3; omega=0.4; phi=1; sigma=2; xi = 2;
%steadystate( ones(12, 1) )

%%

x = fsolve( steadystate, ones(2, 1) );

x

clearvars -except x;
