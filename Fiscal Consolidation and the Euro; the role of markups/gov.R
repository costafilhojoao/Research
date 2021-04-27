###

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

library(eurostat)
library(xlsx)

#### National Accounts ####
 
# Economy and Finance > National accounts (ESA 2010) > Quarterly National accounts > Main GDP aggregates

#dat <- get_eurostat( "namq_10_gdp", time_format = "num" ) #quarterly

dat <- get_eurostat( "nama_10_gdp", time_format = "num" ) #annual

#countries <- c("PT")

#countries_names <- c( "Portugal" )

#for quarterly data
base <- subset( dat,  geo == countries[ 1 ] & 
                      s_adj == "SCA" & 
                      unit == "CP_MEUR")
base   <- base[ order( base$time ), ]

#for annual data
base <- subset( dat,  geo == countries[ 1 ] & 
                      unit == "CP_MEUR")
base   <- base[ order( base$time ), ]

Y  <- subset( base,  na_item == "B1GQ" )        # Gross domestic product at market prices
C  <- subset( base,  na_item == "P31_S14_S15" ) # Household and NPISH final consumption expenditure
I  <- subset( base,  na_item == "P5G" )         # Gross capital formation
G  <- subset( base,  na_item == "P3_S13" )      # Final consumption expenditure of general government
X  <- subset( base,  na_item == "P6" )          # Exports of goods and services
M  <- subset( base,  na_item == "P7" )          # Imports of goods and services

library(readxl)
Y <- read_xlsx("NA.xlsx", 
                sheet = "Sheet 1",
                range = "B31:B55", 
                col_names = FALSE)
G <- read_xlsx("NA.xlsx", 
               sheet = "Sheet 1",
               range = "D31:D55", 
               col_names = FALSE)
C <- read_xlsx("NA.xlsx", 
               sheet = "Sheet 1",
               range = "F31:F55", 
               col_names = FALSE)
I <- read_xlsx("NA.xlsx", 
               sheet = "Sheet 1",
               range = "H31:H55", 
               col_names = FALSE)
X <- read_xlsx("NA.xlsx", 
               sheet = "Sheet 1",
               range = "J31:J55", 
               col_names = FALSE)
M <- read_xlsx("NA.xlsx", 
               sheet = "Sheet 1",
               range = "L31:L55", 
               col_names = FALSE)



# Price index (implicit deflator), 2010=100, national currency

#for quarterly data
base <- subset( dat,  geo == countries[ 1 ] & 
                  s_adj == "SCA" & 
                  unit == "PD10_NAC")
base   <- base[ order( base$time ), ]

#for annual data
base <- subset( dat,  geo == countries[ 1 ] & 
                      unit == "PD10_NAC")
base   <- base[ order( base$time ), ]

PY  <- subset( base,  na_item == "B1GQ" )        # Gross domestic product at market prices
PC  <- subset( base,  na_item == "P31_S14_S15" ) # Household and NPISH final consumption expenditure
PI  <- subset( base,  na_item == "P5G" )         # Gross capital formation
PG  <- subset( base,  na_item == "P3_S13" )      # Final consumption expenditure of general government
PX  <- subset( base,  na_item == "P6" )          # Exports of goods and services
PM  <- subset( base,  na_item == "P7" )          # Imports of goods and services


PY <- read_xlsx("price.xlsx", 
               sheet = "Sheet 1",
               range = "B31:B55", 
               col_names = FALSE)
PG <- read_xlsx("price.xlsx", 
               sheet = "Sheet 1",
               range = "D31:D55", 
               col_names = FALSE)
PC <- read_xlsx("price.xlsx", 
               sheet = "Sheet 1",
               range = "F31:F55", 
               col_names = FALSE)
PI <- read_xlsx("price.xlsx", 
               sheet = "Sheet 1",
               range = "H31:H55", 
               col_names = FALSE)
PX <- read_xlsx("price.xlsx", 
               sheet = "Sheet 1",
               range = "J31:J55", 
               col_names = FALSE)
PM <- read_xlsx("price.xlsx", 
               sheet = "Sheet 1",
               range = "L31:L55", 
               col_names = FALSE)


# Deflating
Y   <- ts( Y$values / PY$values, start=c(1995,1), frequency = 1) 
C   <- ts( C$values / PC$values, start=c(1995,1), frequency = 1)
I   <- ts( I$values / PI$values, start=c(1995,1), frequency = 1)
G   <- ts( G$values / PG$values, start=c(1995,1), frequency = 1)
X   <- ts( X$values / PX$values, start=c(1995,1), frequency = 1)
M   <- ts( M$values / PM$values, start=c(1995,1), frequency = 1)

Y   <- ts( Y$...1 / PY$...1, start=c(1995,1), frequency = 1) 
C   <- ts( C$...1 / PC$...1, start=c(1995,1), frequency = 1) 
I   <- ts( I$...1 / PI$...1, start=c(1995,1), frequency = 1) 
G   <- ts( G$...1 / PG$...1, start=c(1995,1), frequency = 1) 
X   <- ts( X$...1 / PX$...1, start=c(1995,1), frequency = 1) 
M   <- ts( M$...1 / PM$...1, start=c(1995,1), frequency = 1) 

#### Population #### 
#Labour market (labour) > Population LFS series > Population by sex, age, citizenship and labour status 

dat2 <- get_eurostat( "lfsq_pganws", time_format = "num" )

#annual
dat2 <- get_eurostat( "lfsa_pganws", time_format = "num" )


# Total population from 15 to 64 years
pop <- subset( dat2,  geo == countries[ 1 ] &
                      age == "Y15-64" &
                      wstatus == "POP" & 
                      citizen == "TOTAL" & 
                      sex == "T")

pop   <- pop[ order( pop$time ), ]
pop   <- ts( pop$values, start=c(1998,1), frequency = 4) * 1000

pop   <- ts( pop$values, start=c(1995,1), frequency = 1) * 1000


pop <- read_xlsx("pop.xlsx", 
               sheet = "Sheet 1",
               range = "B14:B38", 
               col_names = FALSE)



# Per capita figures

y = Y * 1000000000 / pop
c = C * 1000000000 / pop
g = ( G + I ) * 1000000000 / pop

y  = Y * 1000000000 / pop$...1
c  = C * 1000000000 / pop$...1
g  = ( G + I ) * 1000000000 / pop$...1
nx = ( X - M ) / Y 

gs = ts( g / y, start=c(1995,1), frequency = 1)
gs[ time(gs) == 2006]

#### Detrending ####

time   <- c( 1:length( g ) )
time2  <- time^2

reg    <- lm( log( g ) ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
#             start=c(1998,1), frequency = 4) 
              start=c(1995,1), frequency = 1) 
cycle                <- ( log ( g ) - trend )

#g <- c( window( cycle, start = c( 2010, 3), end = c( 2013, 4) ), rep(0, 86) )
g <- c( 0, window( cycle, start = c( 2007 ), end = c( 2014) ), rep(0, 20) )

reg    <- lm( log( y ) ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             #             start=c(1998,1), frequency = 4) 
             start=c(1995,1), frequency = 1) 
cycle                <- ( log ( y ) - trend )

#y <- c( window( cycle, start = c( 2010, 3), end = c( 2013, 4) ), rep(0, 86) )
y <- c( 0, window( cycle, start = c(2007), end = c( 2014) ), rep(0, 20) )

reg    <- lm( log( c ) ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             #             start=c(1998,1), frequency = 4) 
             start=c(1995,1), frequency = 1) 

cycle                <- ( log ( c ) - trend )

#c <- c( window( cycle, start = c( 2010, 3), end = c( 2013, 4) ), rep(0, 86) )
c <- c( 0, window( cycle, start = c( 2007), end = c( 2014) ), rep(0, 20) )

data <- data.frame( y, c, g)

write.xlsx( data, file="data.xlsx")




reg    <- lm( nx  ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             #             start=c(1998,1), frequency = 4) 
             start=c(1995,1), frequency = 1) 

cycle                <- ( nx - trend ) * 100
plot(cycle)

#c <- c( window( cycle, start = c( 2010, 3), end = c( 2013, 4) ), rep(0, 86) )
c <- c( 0, window( cycle, start = c( 2007), end = c( 2014) ), rep(0, 20) )


