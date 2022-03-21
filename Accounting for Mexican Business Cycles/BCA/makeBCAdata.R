######  Accounting for Mexican Business Cycles
######  Brinca and Costa-Filho

# This code prepares the data for the Business Cycle Accounting 
# and creates the data.mat file

#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/Accounting for Mexican Business Cycles/BCA")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("BCAData.RData")

#### Packages ####

library(OECD)       # OECD database
library(tempdisagg) # Quarterly interpolation - Denton-Cholette Method
library(readxl)
library(R.matlab)
library(ggplot2)
library(gridExtra)


#### Quarterly National Accounts - OECD ####

# https://www.oecd-ilibrary.org/economics/data/aggregate-national-accounts/gross-domestic-product-sna-1993_data-00795-en

dat1 <- get_dataset( "QNA", filter = "MEX") # Mexico

base <- subset( dat1,  FREQUENCY == "Q" &      # Quarterly
                       MEASURE   == "CQRSA")   # Millions of national currency, current prices, quarterly levels, s.a.

browse_metadata("QNA")

# Expenditure data

Y  <- subset( base,  SUBJECT == "B1_GE" )       # Gross domestic product - expenditure approach
C  <- subset( base,  SUBJECT == "P31S14_S15" )  # Private final consumption expenditure
G  <- subset( base,  SUBJECT == "P3S13" )       # Final consumption expenditure of general government
I  <- subset( base,  SUBJECT == "P5" )          # Gross capital formation
X  <- subset( base,  SUBJECT == "P6" )          # Exports of goods and services
M  <- subset( base,  SUBJECT == "P7" )          # Imports of goods and services

# Quarterly OECD flows are originally multiplied by 4

Y = window( ts( as.numeric( Y$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
            start = c( 1993, 1), end = c( 2020, 4 ) )
C = window( ts( as.numeric( C$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
start = c( 1993, 1), end = c( 2020, 4 ) )
G = window( ts( as.numeric( G$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
start = c( 1993, 1), end = c( 2020, 4 ) )
I = window( ts( as.numeric( I$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
start = c( 1993, 1), end = c( 2020, 4 ) )
X = window( ts( as.numeric( X$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
start = c( 1993, 1), end = c( 2020, 4 ) )
M = window( ts( as.numeric( M$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
start = c( 1993, 1), end = c( 2020, 4 ) )

# Deflator

base <- subset( dat1,  
                FREQUENCY == "Q" &           # Quarterly
                MEASURE   == "DNBSA")        # Deflator, national base/reference year, s.a.

PY  <- subset( base,  SUBJECT == "B1_GE" )       # Gross domestic product - expenditure approach
#PC  <- subset( base,  SUBJECT == "P31S14_S15" )  # Private final consumption expenditure
#PG  <- subset( base,  SUBJECT == "P3S13" )       # Final consumption expenditure of general government
#PI  <- subset( base,  SUBJECT == "P51" )         # Gross fixed capital formation
#PX  <- subset( base,  SUBJECT == "P6" )          # Exports of goods and services
#PM  <- subset( base,  SUBJECT == "P7" )          # Imports of goods and services

PY = window( ts( as.numeric( PY$ObsValue ), start = c( 1993 , 1), frequency = 4 ),
             start = c( 1993, 1), end = c( 2020, 4 ) )
PY = PY / PY[ length( PY ) ]

# Deflated variables

Y_real = ( Y * 1000000 / 4 ) / PY
C_real = ( C * 1000000 / 4 ) / PY
G_real = ( G * 1000000 / 4 ) / PY
I_real = ( I * 1000000 / 4 ) / PY
X_real = ( X * 1000000 / 4 ) / PY
M_real = ( M * 1000000 / 4 ) / PY
  

#### Labor Market ####

# Economic Outlook No 110 - December 2021
#https://stats.oecd.org/OECDStat_Metadata/ShowMetadata.ashx?Dataset=EO110_INTERNET&ShowOnWeb=true&Lang=en

search <- search_dataset( "Economic Outlook", 
                          data = get_datasets(), 
                          ignore.case = TRUE)

dat2 <- get_dataset( "EO110_INTERNET", filter = "MEX") # Mexico

base <- subset( dat2,  FREQUENCY == "Q" )      # Quarterly

H  <- subset( base,  VARIABLE == "HRS" )       # Hours worked per worker, total economy
H  <- window( ts( as.numeric( H$ObsValue ), start = c( 1991, 1), frequency = 4 ),
              start = c( 1993, 1), end = c( 2020, 4 ) )

E  <- subset( base,  VARIABLE == "ET" )       # Total employment (national accounts basis)
E  <- window( ts( as.numeric( E$ObsValue ), start = c( 1991, 1), frequency = 4 ),
              start = c( 1993, 1), end = c( 2020, 4 ) )

browse_metadata("EO110_INTERNET")


#### Population Data ####

dat3 <- get_dataset( "HISTPOP", filter = "MEX", start_time = 1993, end_time = 2020) # Mexico

base <- subset( dat3,  
                SEX == "T" )           # Total

POP <- subset( base, AGE == "15-64" ) # Working age population: 15 to 64 years old

browse_metadata("HISTPOP")

# Quarterly interpolation - Denton-Cholette Method 

iP <- td( ts( as.numeric( POP$ObsValue ), start = 1993, frequency = 1  ) ~ 1, 
          to = "quarterly", method = "denton-cholette", conversion = "mean" )

iP <- predict( iP )


#### Tax on goods and services ####

# https://data.oecd.org/tax/tax-on-goods-and-services.htm


TAX <- read_xlsx("tax.xlsx", sheet = "Sheet1",
                #range = "C2:C101",
                col_names = TRUE)

#dat4 <- get_dataset( "REV" )

base <- subset( TAX, LOCATION  == "MEX" &   # Mexico
                     INDICATOR == "TAXGOODSERV" & 
                     MEASURE   == "PC_GDP")   


tax <- base$Value

itax <- td( ts( tax, start = 1980, frequency = 1  ) ~ 1, 
          to = "quarterly", method = "denton-cholette", conversion = "mean" )

tax <- window( ts( predict( itax ), start = c( 1980, 1), frequency = 4 ),
               start = c( 1993, 1), end = c( 2020, 4 ) )


#### Consumption of Durables Goods ####

search <- search_dataset( "Final consumption", 
                          data = get_datasets(), 
                          ignore.case = TRUE)

dat5 <- get_dataset( "SNA_TABLE5", filter = "MEX" )

base <- subset( dat5, 
                TRANSACT == "P311B" &
                MEASURE == "C")

NDUR  <- ts( ( as.numeric( base$ObsValue ) ), start = 1993, frequency = 1 )  # annual data for household's consumption of durables goods
NDUR  <- NDUR * 1000000

NDUR <- td( NDUR ~ 0 + Y, 
               to = 4, 
               conversion = "mean", 
               method = "denton-cholette" )
NDUR <- predict( NDUR ) / 4


dur = NDUR / PY

deltad = 1 - ( 1 - 0.25 )^( 1 /4 ) # Annualized depreciation rate for durables taken to be 25%

durables_stock = matrix( data = NA, nrow = length(dur), ncol = 1)

durables_stock[ 1 ] = dur[ 1 ] * 16

for ( j in 1:(nrow( durables_stock )-1) ) {
  
  durables_stock[ j + 1 ] = ( 1 - deltad ) * durables_stock[ j ] + dur[ j ]
  
}

dur_serv = 0.01 * durables_stock
deprec   = deltad * durables_stock 

#### Per Capita Values ####

taxes_gdp = Y_real * tax / 100

ypc <- ( Y_real - taxes_gdp + dur_serv + deprec ) / iP
cpc <- ( C_real - dur - taxes_gdp ) / iP
xpc <- I_real / iP
gpc <- ( G_real + X_real - M_real ) / iP
hpc <- ( H / 4 * E ) / iP / 1300
t   <- seq( from = 1993.25, to = 2021, by = 0.25 )

#### Write .mat file for the BCA exercise ####

writeMat("data.mat", t = t, ypc = ypc, xpc = xpc, hpc = hpc, gpc = gpc, iP = iP )

writeMat("data2.mat", t = t[ t < 2015.25],
                      ypc = ypc[ time( ypc ) < 2015],
         xpc = xpc[ time( xpc ) < 2015], hpc = hpc[ time( hpc ) < 2015],
         gpc = gpc[ time( gpc ) < 2015], iP = iP[ time( iP ) < 2015] )

#### Graphs ####

# window: 12 quarters after the start of the recession

#GDP

r1 = window( ypc, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( ypc, start = c( 2008, 1 ), end = c( 2010, 4 ) ); r2 = r2 / r2[1] * 100
r3 = window( ypc, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p1 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = r3 ), size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "Output", y= "" ) +
  theme(text = element_text(size=12) ) 


#Hours

r1 = window( hpc, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( hpc, start = c( 2008, 1 ), end = c( 2010, 4 ) ); r2 = r2 / r2[1] * 100
r3 = window( hpc, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p2 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = r3 ), size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "Hours", y= "" ) +
  theme(text = element_text(size=12) )


#Investment

r1 = window( xpc, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( xpc, start = c( 2008, 1 ), end = c( 2010, 4 ) ); r2 = r2 / r2[1] * 100
r3 = window( xpc, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p3 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = r3 ), size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "Investment", y= "" ) +
  theme(text = element_text(size=12) )


#Government Consumption wedge

r1 = window( gpc, start = c( 1994, 3 ), end = c( 1997, 2 ) ); r1 = r1 / r1[1] * 100 
r2 = window( gpc, start = c( 2008, 1 ), end = c( 2010, 4 ) ); r2 = r2 / r2[1] * 100
r3 = window( gpc, start = c( 2019, 4 ), end = c( 2020, 4 ) ); r3 = r3 / r3[1] * 100

max.len = max( length(r1), length(r2), length(r3) )


r1 = c( r1, rep(NA, max.len - length( r1 ) ) )
r2 = c( r2, rep(NA, max.len - length( r2 ) ) )
r3 = c( r3, rep(NA, max.len - length( r3 ) ) )

data <- data.frame( r1, r2, r3, 
                    time = c( seq( -1, length( r1 )-2 ) ),
                    base = rep( 100, length( r1 ) ) )

p4 <- ggplot(data) + 
  geom_line( aes(x = time, y = r1 ), size = 1.5, linetype = "dotdash") +
  geom_line( aes(x = time, y = r2 ), size = 1.5, linetype = "longdash") +
  geom_line( aes(x = time, y = r3 ), size = 1.5, linetype = "solid") +
  geom_line( aes(x = time, y = base), colour = "gray", linetype = "dotdash", size = 0.75) +
  theme_classic() + labs(x = "Gov Cons + Net exports", y= "" ) +
  theme(text = element_text(size=12) )


grid.arrange( p1, p2, p3, p4 )



