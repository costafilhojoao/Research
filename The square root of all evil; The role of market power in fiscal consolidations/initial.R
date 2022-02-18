###



#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("initial.RData")


#### Packages ####

library(eurostat)
library(tempdisagg)
library(dplyr)
library(nicethings)
library(xlsx)

#load("initial.RData")

#### National Accounts ####
 
# Economy and Finance > National accounts (ESA 2010) > Quarterly National accounts > Main GDP aggregates

dat <- get_eurostat( "namq_10_gdp", time_format = "num" ) #quarterly


countries <- c("PT")

countries_names <- c( "Portugal" )

#Portuguese quarterly expenditure-side data
base <- subset( dat,  geo == countries[ 1 ] & 
                      s_adj == "SCA" & 
                      unit == "CP_MEUR")
base   <- base[ order( base$time ), ]

Y  <- subset( base,  na_item == "B1GQ" )        # Gross domestic product at market prices
C  <- subset( base,  na_item == "P31_S14_S15" ) # Household and NPISH final consumption expenditure
I  <- subset( base,  na_item == "P5G" )         # Gross capital formation
G  <- subset( base,  na_item == "P3_S13" )      # Final consumption expenditure of general government
X  <- subset( base,  na_item == "P6" )          # Exports of goods and services
M  <- subset( base,  na_item == "P7" )          # Imports of goods and services


# Portuguese quarterly price deflators of expenditure-side data
base <- subset( dat,  geo == countries[ 1 ] & 
                  s_adj == "SCA" & 
                  unit == "PD10_NAC")
base   <- base[ order( base$time ), ]

PY  <- subset( base,  na_item == "B1GQ" )        # Gross domestic product at market prices
PC  <- subset( base,  na_item == "P31_S14_S15" ) # Household and NPISH final consumption expenditure
PI  <- subset( base,  na_item == "P5G" )         # Gross capital formation
PG  <- subset( base,  na_item == "P3_S13" )      # Final consumption expenditure of general government
PX  <- subset( base,  na_item == "P6" )          # Exports of goods and services
PM  <- subset( base,  na_item == "P7" )          # Imports of goods and services

# Deflating
Y   <- ts( Y$values / PY$values, start=c(1995,1), frequency = 4) 
C   <- ts( C$values / PY$values, start=c(1995,1), frequency = 4)
I   <- ts( I$values / PY$values, start=c(1995,1), frequency = 4)
G   <- ts( G$values / PY$values, start=c(1995,1), frequency = 4)
X   <- ts( X$values / PY$values, start=c(1995,1), frequency = 4)
M   <- ts( M$values / PY$values, start=c(1995,1), frequency = 4)


#### Population #### 

# Population and social conditions > Labour market (labour) > Population LFS series > Population by sex, age, citizenship and labour status 

dat2 <- get_eurostat( "lfsq_pganws", time_format = "num" )


# Total population from 15 to 64 years
pop <- subset( dat2,  geo == countries[ 1 ] &
                      age == "Y15-64" &
                      wstatus == "POP" & 
                      citizen == "TOTAL" & 
                      sex == "T")

pop   <- pop[ order( pop$time ), ]
pop   <- ts( pop$values, start=c(1998,1), frequency = 4) * 1000

# Per capita figures

y = Y[ time(Y) > 1997.99] * 10000 / pop
c = C[ time(Y) > 1997.99] * 10000 / pop
g = ( G[ time(Y) > 1997.99] + I[ time(Y) > 1997.99] ) * 10000 / pop
x = X[ time(Y) > 1997.99] * 10000 / pop

#### Labour market ####

# Population and social conditions > Labour market > Employment and unemployment (Labour force survey) > LFS series - detailed quarterly survey results (from 1998 onwards) > Working time - LFS series 

dat3 <- get_eurostat( "lfsq_ewhun2", time_format = "num" ) #quarterly

base <- subset( dat3,  geo == countries[ 1 ] & 
                  sex == "T" & 
                  worktime == "TOTAL" &
                  nace_r2 == "TOTAL" & 
                  wstatus == "EMP")
base   <- base[ order( base$time ), ]

H <- ts( base$values, start=c(2008,1), frequency = 4) 

h <- H / ( 14 * 7 )


# Population and social conditions > Labour market > Earnings > Net earnings and tax rates

dat4 <- get_eurostat( "earn_nt_net", time_format = "num" ) #annual

base <- subset( dat4,  geo == countries[ 1 ] & 
                  estruct == "NET" & 
                  currency == "EUR" &
                  ecase == "P1_NCH_AW100")  #Single person without children earning 100% of the average earning
base   <- base[ order( base$time ), ]

W  <- ts( base$values, start = 2000, frequency = 1) 

w <- td( W ~ 0 + H, 
         to = "quarterly", 
         conversion = "sum", 
         method = "denton-cholette" )

w <- predict( w ) / H / 100


#### Nominal interest rate ####

#Economy and finance > Interest rates > Long-term interest rates > Maastricht criterion interest rates

dat5 <- get_eurostat( "irt_lt_mcby_q", time_format = "num" ) #quarterly, EMU convergence criterion series 

base <- subset( dat5,  geo == countries[ 1 ]  )  
base   <- base[ order( base$time ), ]

i <- window( ts( base$values, start = c( 1986, 1), frequency = 4 ), start = c( 1995 , 1 ) ) 

#### Price levels ####

# Price index (implicit deflator), 2010=100, national currency

ger <- subset( dat,  geo == "DE" & 
                 s_adj == "SCA" & 
                 unit == "PD10_NAC")
ger   <- ger[ order( ger$time ), ]
PCger  <- subset( ger,  na_item == "P31_S14_S15" ) # Household and NPISH final consumption expenditure

PF <- window( ts( PCger$values, start = c( 1991, 1), frequency = 4 ), start = c( 1995 , 1 ) ) 

mean( PC$values[ time(PF) < 2010 & time(PF) > 2000] / PF[ time(PF) < 2010 & time(PF) > 2000] )


P <- PDbar * PC$values / mean( 
                          window( 
                                  ts( PC$values, start = c( 1995, 1), frequency = 4 ), 
                          start = c( 2004 , 1 ) , end = c( 2004, 4 ) )
                        )

P <- window( ts( P, start = c( 1995, 1 ), frequency = 4), start = c( 1998, 1 ) )


PF <- PFbar * PCger$values / mean( 
                          window( 
                                  ts( PCger$values, start = c( 1995, 1), frequency = 4 ), 
                          start = c( 2004 , 1 ) , end = c( 2004, 4 ) )
                        )

PF <- window( ts( PF, start = c( 1991, 1 ), frequency = 4), start = c( 1998, 1 ) )


#### Parameters ####

rho   = ( ( 1 + 0.09 )^( 1 / 4 ) ) - 1 ;  # discount rate 
gamma = 2;                                # elasticity of intertemporal substitution
omega = 1.455;                            # exponent of labor in utility function 
Hbar = 373 / 1022;
n     = 0.5;                              # share of imported goods into total consumption
s     = 2.9;                              # elasticity of substitution between domestic and imported goods

gshare = 0.3372392;

nx = -0.08;

PFbar     = 1;

sigma = s;                                # price-elasticity of demand 
phi   = 0.5;                              # firm's future demand sensitivity to current sales
eta = 0.5 / 4;                            # Firm's demand "depreciation"
Pbar      = 0.95;
pDbar     = ( ( Pbar ^( 1 - s) - n * PFbar ^( 1 - s ) ) / ( 1 - n) ) ^ ( 1 / ( 1 - s ) );
Wbar      = Hbar ^ ( omega - 1 ) * Pbar;
thetabar = 1 / ( sigma * ( 2 + rho - eta ) ) * pDbar * eta / phi;
alpha = 1/3;                              # 1 - alpha: labor exponent in the production function

varphi = 0.2;

# Demand scaling factor consistent with steady state value for hours of work
psi = eta /  phi * ( 1 - alpha ) / ( Hbar * Wbar ) * ( thetabar * phi + (sigma - 1 ) / sigma * pDbar );





#### Steady State ####

Hbar = 373 / 1022;
Pbar      = 0.95;
PFbar     = 1;
pDbar     = ( ( Pbar ^( 1 - s) - n * PFbar ^( 1 - s ) ) / ( 1 - n) ) ^ ( 1 / ( 1 - s ) );
PDbar     = pDbar;
Wbar      = Hbar ^ ( omega - 1 ) * Pbar;
thetabar  = 1 / ( sigma * ( 2 + rho - eta ) ) * pDbar * eta / phi;
MCbar     = ( sigma - 1 ) / sigma * pDbar + thetabar * phi;
mubar     = pDbar / MCbar;
ebar      = 1 / psi;
ybar      = eta * ebar / phi  ;
Ybar      = ybar;
Gbar      = gshare * Ybar;
Tbar      = Pbar * Gbar;
GDbar     = ( 1 - n ) * ( PDbar / Pbar ) ^ ( - s ) * Gbar;
GFbar     = n * ( PFbar / Pbar ) ^ ( - s ) * Gbar;
Cbar      = Ybar - Gbar - nx * Ybar;
CDbar     = ( 1 - n ) * ( PDbar / Pbar ) ^ ( - s ) * Cbar;
CFbar     = n * ( PFbar / Pbar ) ^ ( - s ) * Cbar;
lambdabar = ( ( Cbar - Hbar ^omega / omega )^-gamma ) / Pbar;
ibar      = rho;
PIbar     = Pbar * Ybar - Wbar * Hbar;
Xbar      = Pbar / PDbar * ( nx * Ybar + PFbar / Pbar * ( CFbar + GFbar ) );
Bbar      = ( Tbar + Pbar * Cbar - Wbar * Hbar - PIbar ) / ibar;
Abar      = eta / ( phi * psi ) * Hbar ^ ( alpha - 1 );
ACbar     = 0;
ACDbar    = 0;
ACFbar    = 0;


lambdaSbar = lambdabar;
thetaSbar  = thetabar;
ySbar      = ybar;
YSbar      = Ybar;
PSbar      = Pbar; 
pDSbar     = pDbar;  



#### Calculated variables ####

lambda = ( ( c - h ^ omega / omega  )^-gamma ) / P

PD     = ( P ^ ( 1 - s  ) - n * PF ^ ( 1 - s )  ) / ( 1 - n )

#demand shifter from its law of motion

e[1] = ebar

for ( j in 2:length(B)) {
  
  e[ j ] = phi * y[ j ] + ( 1 - eta ) * e[ j - 1 ]
  
}

e <- ts( e, start = c( 1995, 1), frequency = 4 )

pD     = PD * ( e * psi ) ^ ( 1 / ( sigma - 1 ) )  * PD

y_ind  = ( e * psi )^ ( - 1 / ( sigma - 1 ) )   * y

PI     = P * y - h * w

A      = y / ( ( e * psi ) ^ ( 1 / ( sigma - 1  ) ) * h ^( 1 - alpha )  )

MC     = w / ( ( 1 - alpha ) *  A ^( 1 / ( 1 - alpha ) ) ) * y_ind ^ ( alpha / ( 1 - alpha ) )

theta  = 1 / phi * ( MC - ( sigma - 1 ) / sigma * pD - varphi / sigma * ( pD / lag(as.vector(pD), n = 1 ) - 1 ) * P * y * pD / lag(as.vector(pD), n = 1 ) * 1 / y_ind  )

# average price markup (mu)
nice_load(file = "markupsdata.RData", object = c("mu"), rename = NULL)

mu = mu / 100 * 1.47515

CD = ( 1 - n ) * ( PD / P ) ^ - s * c

CF = n  * ( PF / P ) ^ - s * c

GD = ( 1 - n ) * ( PD / P ) ^ - s * g

GF = n  * ( PF / P ) ^ - s * g

T = P * g

AC = varphi / 2 * ( pD / lag(as.vector(pD), n = 1 ) - 1 )^ 2 * P * y 

ACD = ( 1 - n ) * ( PD / P ) ^ - s * AC

ACF = n * ( PF / P ) ^ - s * AC

lambdaS = 0;

thetaS  = 0;

yS      = 0;

PS      = 0;

#debt dynamics from the budget constraint

B = matrix( NA, nrow = length( y ), ncol = 1)

B[1] = Bbar

for ( j in 2:length(B)) {
  
  B[ j ] = ( 1 + i[ j - 1 ] / 400 ) * B [ j - 1 ] + w * h  + PI - T - P * c
  
}

B <- ts( B, start = c( 1998, 1), frequency = 4 )


#### Deviations from the Steady State ####

dC      <- c - Cbar
dH      <- h - Hbar
dlambda <- lambda - lambdabar
dP      <- P - Pbar
dW      <- w - Wbar
dB      <- B - Bbar
dy      <- y_ind - ybar
dY      <- y - Ybar
dPI     <- PI - PIbar
dpD     <- pD - pDbar
dMC     <- MC - MCbar
dtheta  <- theta - thetabar
dmu     <- mu - mubar
de      <- e - ebar
dCD     <- CD - CDbar
dCF     <- CF - CFbar
dPD     <- PD - PDbar
dGD     <- GD - GDbar
dGF     <- GF - GFbar 
dT      <- T - Tbar
dG      <- g - Gbar
dA      <- A - Abar
di      <- ( 1 +  i / 100 ) ^( 1 / 4 ) - 1 - ibar
dX      <- x - Xbar
dAC     <- AC - ACbar
dACD    <- ACD - ACDbar
dACF    <- ACF - ACFbar
dlambdaS <- ts( rep( 0, length( y ) ), start = c( 1995, 1), frequency = 4 ) 
dthetaS  <- ts( rep( 0, length( y ) ), start = c( 1995, 1), frequency = 4 )
dyS      <- ts( rep( 0, length( y ) ), start = c( 1995, 1), frequency = 4 )
dpDS     <- ts( rep( 0, length( y ) ), start = c( 1995, 1), frequency = 4 )
dYS      <- ts( rep( 0, length( y ) ), start = c( 1995, 1), frequency = 4 )
dPS      <- ts( rep( 0, length( y ) ), start = c( 1995, 1), frequency = 4 )

detach("package:dplyr", unload = TRUE)

#### Shocks ####

library(neverhpfilter) # Hamilton (2018)
library(xts)

series <- as.xts( ts( PM$values / 100 , start = c( 1995, 1), frequency = 4 )  )
dimnames(series) <- list(NULL, "PF")
hh <- 8 # h
pp <- 4 # p
hamilton <- yth_filter( series, h = hh, p = pp); rm(hh, pp, series)
dPF = ts( as.numeric(hamilton$PF.cycle ), start = c( 1995, 1), frequency = 4 )


#### Initial conditions for the quantitative exercise ####

quarter <- 2010.5


X_initial = matrix( data = c( 
                              dC [ time ( dC ) == quarter], 
                              dH[ time ( dH ) == quarter],
                              dlambda[ time ( dlambda ) == quarter], 
                              dP[ time ( dP ) == quarter],
                              dW[ time ( dW ) == quarter],
                              dy[ time ( dy ) == quarter], 
                              dY[ time ( dY ) == quarter],
                              dPI[ time ( dPI ) == quarter], 
                              dMC[ time ( dMC ) == quarter], 
                              dtheta[ time ( dtheta ) == quarter], 
                              dmu[ time ( dmu ) == quarter],
                              dCD[ time ( dCD ) == quarter], 
                              dCF[ time ( dCF ) == quarter],
                              dPD[ time ( dPD ) == quarter],
                              dGD[ time ( dGD ) == quarter],
                              dGF[ time ( dGF ) == quarter], 
                              dT[ time ( dT ) == quarter],
                              dX[ time ( dX ) == quarter], 
                              dAC[ time ( dAC ) == quarter],
                              dACD[ time ( dACD ) == quarter],
                              dACF[ time ( dACF ) == quarter]
                              ),
                    nrow = 21,
                    ncol = 1 )

S_initial = matrix( data = c( 
                              dB[ time ( dB ) == quarter], 
                              dpD[ time ( dpD ) == quarter],
                              de[ time ( de ) == quarter],
                              dPF[ time ( dPF ) == quarter],
                              dG[ time ( dG ) == quarter],
                              dA[ time ( dA ) == quarter],
                              di[ time ( di ) == quarter],
                              dlambdaS[ time ( dlambdaS ) == quarter], 
                              dthetaS[ time ( dthetaS ) == quarter],
                              dyS[ time ( dyS ) == quarter], 
                              dpDS[ time ( dpDS ) == quarter],
                              dYS[ time ( dYS ) == quarter], 
                              dPS[ time ( dPS ) == quarter]
                              ),
                    nrow = 13,
                    ncol = 1 )



#### Save files that will be used in the simulations ####

write.xlsx( X_initial, file="X_initial.xlsx")

write.xlsx( S_initial, file="S_initial.xlsx")

write.xlsx( dA[ time( dA ) > quarter & time( dA ) < 2015], file="sA.xlsx")

write.xlsx( dPF[ time( dPF ) > quarter & time( dPF ) < 2015], file="sPF.xlsx")



library(mFilter)

dPF <- mFilter( ts( PM$values / 100 , start = c( 1995, 1), frequency = 4 ),
                filter="BK", pl = 6, pu = 32, nfix = 12)
dPF <- dPF$cycle         


dPF <- mFilter( ts( PM$values / 100 , start = c( 1995, 1), frequency = 4 ),
                filter="CF", pl = 8, pu = 40, drift = FALSE)
dPF <- dPF$cycle / dPF$trend         




