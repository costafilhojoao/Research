###

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

library(eurostat)
library(xlsx)

#### National Accounts ####
 
# Economy and Finance > National accounts (ESA 2010) > Quarterly National accounts > Main GDP aggregates

dat <- get_eurostat( "namq_10_gdp", time_format = "num" )

countries <- c("PT")

countries_names <- c( "Portugal" )

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


# Price index (implicit deflator), 2010=100, national currency

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
C   <- ts( C$values / PC$values, start=c(1995,1), frequency = 4)
I   <- ts( I$values / PI$values, start=c(1995,1), frequency = 4)
G   <- ts( G$values / PG$values, start=c(1995,1), frequency = 4)
X   <- ts( X$values / PX$values, start=c(1995,1), frequency = 4)
M   <- ts( M$values / PM$values, start=c(1995,1), frequency = 4)

#### Population #### 
#Labour market (labour) > Population LFS series > Population by sex, age, citizenship and labour status 

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

y = Y * 1000000000 / pop
c = C * 1000000000 / pop
g = (G + I ) * 1000000000 / pop

gs = g / y

#### Detrending ####

time   <- c( 1:length( g ) )
time2  <- time^2

reg    <- lm( log( g ) ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             start=c(1998,1), frequency = 4) 
cycle                <- ( log ( g ) - trend )

g <- c( window( cycle, start = c( 2010, 3), end = c( 2013, 4) ), rep(0, 86) )

write.xlsx( g, file="data.xlsx")
