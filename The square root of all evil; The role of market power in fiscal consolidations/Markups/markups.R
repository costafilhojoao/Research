#### The square root of all evil: the role of market power in fiscal consolidations
####  Brito, P., Costa, L., Costa Filho, J., and Santos, C.
####  Correspondence: João Ricardo Costa Filho (joaocostafilho.com)


#### Housekeeping ####

setwd("G:/Meu Drive/Documents/Papers/Acadêmicos/Research/The square root of all evil; The role of market power in fiscal consolidations/Markups")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

load("markupsdata.RData")

#### Packages ####

library(tempdisagg)
library(readxl)
library(ggplot2)
library(knitr)
library(kableExtra)
library(reshape)
library(ggridges)
library(latex2exp)
library(moments)
library(eurostat)
library(reshape2)
library(dplyr)

#### Raw data ####

#Get Eurostat National accounts aggregate by industry (up to NACE A*64) data

dat <- get_eurostat( "nama_10_a64", time_format = "num" )

# Jones (2011) data on intermediate goods share

alpham <-  c(  0.497,           #"Austria",
               0.595,           #"Belgium"
               0.527,           #"Cyprus"  - Jones (2011) average 
               0.488,           #"Denmark",
               0.527,           #"Estonia" - Jones (2011) average 
               0.502,           #"Germany",
               0.545,           #"Finland",
               0.511,           #"France",
               0.539,           #"Ireland"
               0.533,           #"Italy" 
               0.527,           #"Latvia"   - Jones (2011) average
               0.527,           #"Lithuania"   - Jones (2011) average
               0.527,           #"Luxembourg"  - Jones (2011) average
               0.529,           #"Netherlands",
               0.542,           #"Portugal",
               0.527,           #"Slovenia"  - Jones (2011) average
               0.527,           #"Slovakia"  - Jones (2011) average
               0.510,           #"Spain",
               0.543            #"Sweden"
               )

#### Interpolation: annual to quarterly #### 

#sample countries code
countries <- c("AT", "BE", "CY", "DK", "EE", "DE", "FI", "FR", "IE", "IT", "LV", 
               "LT", "LU", "NL", "PT", "SI", "SK", "ES", "SE")

#Greece, Malta, Monaco, Montenegro, UK

#https://ec.europa.eu/eurostat/documents/3859598/5889816/KS-BM-05-002-EN.PDF/62e82e02-4632-438b-a284-e8fe75984b32?version=1.0
# page 10, map legend

countries_names <- c( "Austria", "Belgium", "Cyprus", "Denmark", "Estonia", 
                      "Germany", "Finland", "France", "Ireland", "Italy", 
                      "Latvia", "Lithuania", "Luxembourg", "Netherlands",
                      "Portugal", "Slovenia", "Slovakia", "Spain", "Sweden" )

#Statistical classification of economic activities in the European Community
nace      <- c("A", 
               "B", 
               "C",
               "D",
               "E",
               "F",
               "G",
               "H",
               "I",
               "J",
               "K",
               "L",
               "M",
               "N",
               #"O", Public administration and defence and compulsory social security were not considered
               "P",
               "Q",
               "R",
               "S"
               )


sectors   <- c("Agriculture, forestry and fishing", 
               "Mining and quarrying", 
               "Manufacturing",
               "Electricity, gas, steam and air conditioning supply",
               "Water supply; sewerage, waste management and remediation activities",
               "Construction",
               "Wholesale and retail trade; repair of motor vehicles and motorcycles",
               "Transportation and storage",
               "Accommodation and food service activities",
               "Information and communication",
               "Financial and insurance activities",
               "Real estate activities",
               "Professional, scientific and technical activities",
               "Administrative and support service activities",
               #"Public administration and defence; compulsory social security" were not conidered
               "Education",
               "Human health and social work activities",
               "Arts, entertainment and recreation",
               "Other service activities were removed"
)

#sample period

syear   <- 1995  #start year
eyear   <- 2019  #end year

#matrix for markups for each country
markups_europe <- matrix( data = NA, 
                        nrow = ( eyear - syear + 1 ) * 4, 
                        ncol = length( countries ) )
colnames( markups_europe ) <- countries_names  


#list with the matrices of markups weights by sector, for each country
markups_weights_list = list()

#list with the matrices of markup by sector, for each country
markups_sector = list()


#estimation of the markups for country i, sector j at time t and aggregates
for ( i in 1:length( countries ) ){
  
  #data for selected economic activities
  data <- data.frame()
  
  j = 1
  
  while ( j < length( nace ) + 1 ) {
    
    base <- subset( dat,  geo == countries[ i ] & nace_r2 == nace[ j ] & unit == "CP_MEUR" )  
  
    data <- rbind( data, base )
  
    j = j + 1
  }


  #ascending dates
  data   <- data[ order( data$time ), ]


### Sectors

#### Denton-Cholette Method 

## Intermediate Consumption

  intermediate <- matrix( data = NA, 
                          nrow = eyear - syear + 1, 
                          ncol = length( nace ) )

  rownames( intermediate ) <- seq( syear, eyear )
  colnames( intermediate ) <- sectors 

  for (j in 1:ncol( intermediate ) ){

     base <- subset( data, nace_r2 == nace[ j ] & na_item == "P2" ) 
     base <- base[ 1:nrow( intermediate ), ]
     intermediate[ , j ] <- base$values
  
  }


  intermediate <- ts( intermediate, start = syear, end = eyear, frequency = 1 )

  #matrix for quarterly interpolation
  intermediate_q <- matrix( data = NA, 
                          nrow = ( eyear - syear + 1 ) * 4, 
                          ncol = length( nace ) )
  colnames( intermediate_q ) <- sectors

  #quarterly interpolation
  for (j in 1:ncol(intermediate) ){
  
    m1 <- td( intermediate[ , j ] ~ 1, to = "quarterly", method = "denton-cholette" )
  
    intermediate_q[ , j ] <- predict( m1 )
  
  }


  ## Gross Output

  output_g  <- matrix( data = syear:eyear, 
                       nrow = eyear - syear + 1, 
                       ncol = length( nace ) )

  colnames( output_g ) <- sectors 


  for (j in 1:ncol( output_g ) ){
  
    base <- subset( data, nace_r2 == nace[ j ] & na_item == "P1" ) 
    base <- base[ 1:nrow( output_g ), ]
    output_g[ , j ] <- base$values
    
  }


  # Other taxes less other subsidies on production
  
  taxes  <- matrix( data = syear:eyear, 
                       nrow = eyear - syear + 1, 
                       ncol = length( nace ) )
  
  colnames( taxes ) <- sectors 
  
  
  for (j in 1:ncol( taxes ) ){
    
    base <- subset( data, nace_r2 == nace[ j ] & na_item == "D29X39" ) 
    base <- base[ 1:nrow( taxes ), ]
    taxes[ , j ] <- base$values
    
  }
  
  # Output minus taxes plus subsidies on production
  
  output <- output_g - taxes
  
  output <- ts( output, start = syear, end = eyear, frequency = 1 )
  
  #matrix for quarterly interpolation
  output_q <- matrix( data = NA, 
                            nrow = ( eyear - syear + 1 ) * 4, 
                            ncol = length( nace ) )
  colnames( output_q ) <- sectors 

  #quarterly interpolation
  for (j in 1:ncol( output ) ){
  
    m1 <- td(output[,j] ~ 1, to = "quarterly", method = "denton-cholette")
  
    output_q[,j] <- predict( m1 )
  
  }

  #### Markups #### 

  #sectoral markups (stored also in the markups_sector list)
  markups <- alpham[ i ] * ( output_q / intermediate_q ) -> markups_sector[[i]]

  #weight matrix
  weights <- matrix( data = NA, 
                     nrow = ( eyear - syear + 1 ) * 4, 
                     ncol = length( nace ) )
  colnames( weights ) <- sectors

  #weights
  for (t in 1:nrow( output_q )){

      for (j in 1:ncol( output_q ) ){
      
        totalrow        <- sum( output_q[ t, ] )
        yjt             <- output_q[ t, j ]
        weights[ t, j ] <- yjt /  totalrow

        }
  }

  #weigthed sectoral markups
  markups_weights <- weights / markups -> markups_weights_list[[i]]

  #aggregate markup matrix
  mu <- matrix( data = syear:eyear, 
                nrow = ( eyear - syear + 1 ) * 4, 
                ncol = 1 )

  #aggregate markup
  for (t in 1:nrow( mu )){
  
     mu[t]  <- 1 / sum ( markups_weights[ t, ] )  
  
    }


markups_europe[ , i ] <- mu

}

names( markups_sector ) <- countries_names

rm( data, m1, mu, i, j, t, totalrow, yjt, intermediate, intermediate_q,
    output, output_q, output_g, base, markups_weights, taxes, markups)



#### Subset: EU countries in Alesina et al. (2015) ####

# Data for the panel regressions

attach( data.frame( markups_europe ) )

austerity <- data.frame( Austria, Belgium, Denmark, Germany, 
                         Finland, France, Ireland, Italy, 
                         Portugal, Spain, Sweden)
detach( data.frame( markups_europe ) )

austerity <- ts( austerity, start = c( syear, 1 ) , frequency = 4 )


#calculate 4-quarters accumulated aggregate markup change by country
austerity <- log( ( austerity + lag( austerity, 1 ) + lag( austerity, 2 ) + lag( austerity, 3 ) ) / 4 ) -
             log( ( lag( austerity, 4 ) + lag( austerity, 5 ) + lag( austerity, 6 ) + lag( austerity, 7 ) ) / 4 )

colnames( austerity ) <- c( "Austria", "Belgium", "Denmark", "Germany", 
                            "Finland", "France", "Ireland", "Italy", 
                            "Portugal", "Spain", "Sweden")

#select the 4th quarter of each year to build annual (calendar-based) markup variation
austerity_t <- subset( austerity, 
                       time( austerity ) == 2008.75 | time( austerity ) == 2009.75 |
                       time( austerity ) == 2010.75 | time( austerity ) == 2011.75 |
                       time( austerity ) == 2012.75 | time( austerity ) == 2013.75 |
                       time( austerity ) == 2014.75 )

#transform into panel data format
austerity_t <- t( austerity_t )
austerity_t <- data.frame( country = rownames( austerity_t ), austerity_t  )
colnames( austerity_t ) <- c("country", seq( 2008, 2014 ) )
rownames( austerity_t ) <- NULL
austerity_t <- melt( austerity_t, id.vars = "country")
colnames( austerity_t ) = c("country", "year", "markup")
austerity_t <- austerity_t[ with( austerity_t, order(country, year)), ]

#select the lagged (t-1) 4th quarter of each year to build annual (calendar-based) markup variation
austerity_t1 <- subset( austerity, 
                       time( austerity ) == 2007.75 | time( austerity ) == 2008.75 |
                         time( austerity ) == 2009.75 | time( austerity ) == 2010.75 |
                         time( austerity ) == 2011.75 | time( austerity ) == 2012.75 |
                         time( austerity ) == 2013.75 )

#transform into panel data format
austerity_t1 <- t( austerity_t1 )
austerity_t1 <- data.frame( country = rownames( austerity_t1 ), austerity_t1  )
colnames( austerity_t1 ) <- c("country", seq( 2008, 2014 ) )
rownames( austerity_t1 ) <- NULL
austerity_t1 <- melt( austerity_t1, id.vars = "country")
colnames( austerity_t1 ) = c("country", "year", "markup")
austerity_t1 <- austerity_t1[ with( austerity_t1, order(country, year)), ]

austerity <- data.frame( austerity_t, austerity_t1$markup  )
colnames(austerity) <- c("country", "year", "markup", "markup_t1") 

rm( austerity_t, austerity_t1 )

#### Aggregate markups growth #### 

#log-linear quadratic detrended markups by country

markups_growth <- matrix(data = NA, 
                         nrow = nrow( markups_europe ), 
                         ncol = ncol( markups_europe )
                         )

colnames( markups_growth ) <- colnames( markups_europe )

time                 <- c( 1:nrow( markups_europe ) )
time2                <- time^2

for ( i in 1:ncol( markups_growth ) ) {
  
  mu_i   <- markups_europe[ , i ]
  reg    <- lm( log( mu_i ) ~ time + time2 )
  beta0  <- reg[["coefficients"]][["(Intercept)"]]
  beta1  <- reg[["coefficients"]][["time"]]
  beta2  <- reg[["coefficients"]][["time2"]]
  trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
               start=c(1995,1), frequency = 4) 
  cycle                <- ( log( mu_i )- trend ) * 100
  
  markups_growth[ , i ] <- cycle
  
}

rm( mu_i, reg, beta0, beta1, beta2, trend, cycle, i )



#### Sectoral markups growth by country ####

markups_growth_sector <- markups_sector

for ( i in 1:ncol( markups_growth ) ) {
  
  for (j in 1:length( nace )) {
  
  mu_ij  <- markups_sector[[i]][ , j ]
  reg    <- lm( log( mu_ij ) ~ time + time2 )
  beta0  <- reg[["coefficients"]][["(Intercept)"]]
  beta1  <- reg[["coefficients"]][["time"]]
  beta2  <- reg[["coefficients"]][["time2"]]
  trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
               start=c(1995,1), frequency = 4) 
  cycle                <- ( log( mu_ij )- trend ) * 100
  
  markups_growth_sector[[i]][ , j ] <- cycle
  
  }
}

rm( reg, beta0, beta1, beta2, mu_ij, i, j, time, time2, cycle, trend )

#### Materials share elasticity by country ####

kable( data.frame( countries_names, alpham ),
       format = "latex", booktabs = TRUE, 
       col.names = c( "Countries", "\\alpha_m" ) )


#### Economic interpolation ####

macro_mu <- read_xlsx("macromarkups.xlsx", 
               sheet = "Planilha1",
               range = "B1:B11", 
               col_names = FALSE)

macro_mu    <- ts( macro_mu$...1 * 4, start = 2004, frequency = 1 )

sectoral_mu <- ts( markups_europe[ , 15 ], start = c( 1995, 1), frequency = 4 )

mu <- td( macro_mu ~ 0 + sectoral_mu, 
          to = "quarterly", method = "denton-cholette" )
mu <- predict(mu) 

 
