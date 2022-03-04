#### The square root of all evil: the role of market power in fiscal consolidations
####  Brito, P., Costa, L., Costa Filho, J., and Santos, C.
####  Correspondence: João Ricardo Costa Filho
#### E-mail: joao.costa@fgv.br; Twitter: @costafilhojoao

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations")
#load("svardata.RData")


#### Packages ####

library(eurostat)
library(nicethings)
library(vars)
library(ggplot2)

#### Eurostat Data ####

# Countries in the sample

countries <- c("PT", "DE")

# Economy and Finance > National accounts (ESA 2010) > Quarterly National accounts > Main GDP aggregates
# Database for national accounts

dat <- get_eurostat( "namq_10_gdp", time_format = "num" )

# filtering and ordering the data

base <- subset( dat,  geo == countries[ 1 ] & 
                  s_adj == "SCA" & 
                  unit == "CP_MEUR")
base <- base[ order( base$time ), ]

base4 <- subset( dat,  geo == countries[ 1 ] & 
                   s_adj == "SCA" & 
                   unit == "PD10_EUR")
base4 <- base4[ order( base4$time ), ]

# Economy and Finance > Government statistics (gov) > Government finance statistics > Quarterly government finance statistics > Quarterly non-financial accounts for general government
# Database for government financing

dat1 <- get_eurostat( "gov_10q_ggnfa", time_format = "num" )

# filtering and ordering the data

base1 <- subset( dat1,  geo == countries[ 1 ] & 
                   s_adj == "SCA" & 
                   unit == "MIO_EUR")
base1 <- base1[ order( base1$time ), ]

# Economy and Finance > Government statistics (gov) > Government finance statistics > Quarterly government finance statistics > Quarterly government debt
# Database for government debt

dat2 <- get_eurostat( "gov_10q_ggdebt", time_format = "num" )

base2 <- subset( dat2,  geo == countries[ 1 ] & 
                   unit == "PC_GDP" &
                   sector == "S13")
base2 <- base2[ order( base2$time ), ]


# filtering and ordering the data

# Economy and Finance > Interest rates (irt) > Long-term interest rates > Maastricht criterion interest rates
# Database for interest rates

dat3 <- get_eurostat( "irt_lt_mcby_q", time_format = "num" )

# filtering and ordering the data

base3 <- subset( dat3,  geo == countries )
base3 <- base3[ order( base3$time ), ]

#### National Accounts ####

Y  <- subset( base,  na_item == "B1GQ" )        # Gross domestic product at market prices
C  <- subset( base,  na_item == "P31_S14_S15" ) # Household and NPISH final consumption expenditure
I  <- subset( base,  na_item == "P5G" )         # Gross capital formation
G  <- subset( base,  na_item == "P3_S13" )      # Final consumption expenditure of general government
X  <- subset( base,  na_item == "P6" )          # Exports of goods and services
M  <- subset( base,  na_item == "P7" )          # Imports of goods and services

PY  <- subset( base4,  na_item == "B1GQ" )        # 
#PC  <- subset( base4,  na_item == "P31_S14_S15" ) # 
#PI  <- subset( base4,  na_item == "P5G" )         # 
#PG  <- subset( base4,  na_item == "P3_S13" )      # 
#PX  <- subset( base4,  na_item == "P6" )          #
#PM  <- subset( base4,  na_item == "P7" )          # 

# Deflating
Y   <- window( ts( Y$values / PY$values, start=c(1995,1), frequency = 4), start = c( 1999, 1), end = c( 2019, 4) ) 
#C   <- window( ts( C$values / PC$values, start=c(1995,1), frequency = 4), start = c( 1999, 1), end = c( 2019, 4) )
#I   <- window( ts( I$values / PI$values, start=c(1995,1), frequency = 4), start = c( 1999, 1), end = c( 2019, 4) )
#G   <- window( ts( G$values / PG$values, start=c(1995,1), frequency = 4), start = c( 1999, 1), end = c( 2019, 4) )
#X   <- window( ts( X$values / PX$values, start=c(1995,1), frequency = 4), start = c( 1999, 1), end = c( 2019, 4) )
#M   <- window( ts( M$values / PM$values, start=c(1995,1), frequency = 4), start = c( 1999, 1), end = c( 2019, 4) )

#### Population #### 

#Population and social conditions > Labour market (Labour) > Employment and unemployment (Labour force survey) > LFS series - detailed quarterly survey > Population > Population by sex, age, citizenship and labour status

dat4 <- get_eurostat( "lfsq_pganws", time_format = "num" )

# Total population from 15 to 64 years
pop <- subset( dat4,  geo == countries[ 1 ] &
                 age == "Y15-64" &
                 wstatus == "POP" & 
                 citizen == "TOTAL" & 
                 sex == "T")

pop   <- pop[ order( pop$time ), ]
pop   <- window( ts( pop$values, start=c(1998,1), frequency = 4),
                 start = c( 1999, 1), end = c( 2019, 4) ) * 1000

# Per capita figures

ypc = ( Y * 1000000 * 100 ) / pop
#cpc = C * 1000000 / pop
#gpc = G * 1000000 / pop
#ipc = I * 1000000 / pop
#xpc = X * 1000000 / pop
#mpc = M * 1000000 / pop


#### Markups ####

nice_load(file = "markupsdata.RData", object = c("mu"), rename = NULL)

MU <- window( ts( mu, start = c( 1995, 01), frequency = 4 ), 
              start = c( 1999, 1), end = c( 2019, 4) )


#### Government Financing / spending ####

GS <- subset( base1,  na_item == "TE" ) # Government spending
T  <- subset( base1,  na_item == "TR" )  # Governemnt 
D  <- subset( base2,  na_item == "GD" )  # Gross public debt over GDP

PY <- window( ts( PY$values, start=c(1995,1), frequency = 4), 
              start = c( 1999, 1), end = c( 2019, 4) ) 

GS <- window( ts( GS$values, start=c(1999, 1), frequency = 4 ), 
             start = c( 1999, 1), end = c( 2019, 4) ) / PY
T  <- window( ts( T$values, start=c(1999, 1), frequency = 4 ), 
             start = c( 1999, 1), end = c( 2019, 4) ) / PY
D  <- window( ts( D$values, start=c(1999, 1), frequency = 4 ), 
             start = c( 1999, 1), end = c( 2019, 4) )

# Per capita figures

gspc = ( GS * 1000000 * 100 ) / pop
tpc  = ( T  * 1000000 * 100 ) / pop


#### Interest Rates ####

r <- read_xlsx("dados.xlsx", sheet = "OECD.Stat export",
               range = "C24:C107", col_names = FALSE)
colnames(R) <- "r"

R <- read_xlsx("dados.xlsx", sheet = "OECD.Stat export",
                range = "D24:D107", col_names = FALSE)
colnames(R) <- "R"

R <- ts( R$R, start=c(1999,1), frequency = 4) 


#### SVAR ####

## Variables

# Level (log)

y  <- log( ypc )
g  <- log( gspc )
t  <- log( tpc  )
mu <- log( MU )
d  <- D
r  <- R

# First difference

y  <- diff( y )
g  <- diff( g )
t  <- diff( t )
mu <- diff( mu )
d  <- diff( d )
r  <- diff( r )

data <- data.frame( g, t, y, mu ) 

# VAR - lag selection

lagselect <- VARselect(data, lag.max = 12, type = 'const')
lagselect$selection

# VAR estimation

var <- VAR( data, p = 2, type =  "const", 
            season = NULL, 
            exogen = NULL, 
            lag.max = NULL, 
            ic = HQ )
#summary(var)

# SVAR identification(matrices A and B)

Amat       <- matrix( data = NA, nrow = length(data), ncol = length(data))
Amat[1, 1] <- 1
Amat[1, 2] <- 0 
Amat[1, 3] <- 0 
Amat[1, 4] <- 0
#Amat[1, 5] <- 0
#Amat[1, 6] <- 0
Amat[2, 1] <- 0 
Amat[2, 2] <- 1
Amat[2, 3] <- -1.04 # tax revenues elasticity with respect to GDP
Amat[3, 3] <- 1 
Amat[4, 4] <- 1 
#Amat[5, 5] <- 1 
#Amat[6, 6] <- 1 
Amat

Bmat <- diag( length(data) )
Bmat

#SVAR

svar <- SVAR( var,
              Amat = Amat, Bmat = Bmat, 
              estmethod = c("direct"), 
              hessian = F, lrtest = F)

irfs   <- irf( svar, impulse = c( "g", "t" ), 
               response = c( "y", "g", "t", "mu"),
               n.ahead = 20,
               ortho = T, 
               cumulative =F, boot = 0.80)


#### Graphs ####

## Government shock

# Response of per capita output
data_graphs <- data.frame( irfs$Lower$g[ , 3 ], irfs$Upper$g[ , 3 ], irfs$irf$g[ , 3 ],
                   periods = seq( 1:length( irfs$Lower$g[,3] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")

ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )

# Response of markups
data_graphs <- data.frame( irfs$Lower$g[ , 4 ], irfs$Upper$g[ , 4 ], irfs$irf$g[ , 4 ],
                           periods = seq( 1:length( irfs$Lower$g[,4] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")


ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )


## Tax revenues shock

# Response of per capita output
data_graphs <- data.frame( irfs$Lower$t[ , 3 ], irfs$Upper$t[ , 3 ], irfs$irf$t[ , 3 ],
                           periods = seq( 1 : length( irfs$Lower$t[ , 3 ] ) ) )
colnames(data_graphs) <- c("lower", "upper", "response", "periods")

ggplot(data_graphs) + geom_line( aes(x = periods, y = response), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y = "") +
  geom_ribbon( aes(y = response, x = periods, ymin=lower, ymax=upper),
               alpha = 0.2 )

#### One-year Fiscal multiplier ####

muliplier <- sum ( irfs$irf$g[ , 3 ][1:4]   ) / sum ( irfs$irf$g[ , 1 ][1:4]  )


plot( 
  ts( resid(var$varresult$g), start=c(1999, 1), frequency = 4 ) )


sG  <- window( ts( resid(var$varresult$g), start=c(1999, 1), frequency = 4 ),
                 start = c( 2010,4), end = c( 2014, 4) )


library(xlsx)
write.xlsx( sG, file="sG.xlsx")

variance <- fevd( svar, n.ahead=10)
