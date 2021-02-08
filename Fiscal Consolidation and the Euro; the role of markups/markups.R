#### Fiscal Consolidation and the Euro Crisis: the role of markups
#### 
#### Corresponding author: João Costa-Filho
#### E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao


#setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")
#load("markupsdata.RData")

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

# Hierarquical data
data <- data.frame(dates, markups_growth)
colnames(data) <- c("dates", colnames(markups_growth))

data <- melt(data, measure.vars =  colnames(markups_growth),
             variable_name = "countries")

hierarquical <- subset( data, data$dates > "2009-12-01" )



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

#### Sectoral distribution of markups - skewness and kurtosis ####

#skewness

skewness <- matrix(data = NA, 
                   nrow = nrow( markups_europe ), 
                   ncol = ncol( markups_europe )
)

colnames( skewness ) <- countries_names


for ( i in 1:ncol( markups_europe ) ) {
  
  skewness[, i]  <-  apply( markups_growth_sector[[i]],
                              1,                                   #1 indicates rows
                              skewness, 
                              na.rm = TRUE)
  
}


#Pearson's measure of kurtosis

kurtosis <- matrix(data = NA, 
                   nrow = nrow( markups_europe ), 
                   ncol = ncol( markups_europe )
)

colnames( kurtosis ) <- countries_names


for ( i in 1:ncol( markups_europe ) ) {
  
  kurtosis[, i]  <-  apply( markups_growth_sector[[i]],
                            1,                                   #1 indicates rows
                            kurtosis, 
                            na.rm = TRUE)
  
}

rm(i)

#### Tables ####

# Descriptive statistics - markup growth by country (2010-2014)

#transform into time series
markups_growth <- ts( markups_growth, start = c( syear, 1 ) , frequency = 4 )

kable( t(
  summary( 
    subset( markups_growth, 
            time( markups_growth ) > 2009.75 &  time( markups_growth ) < 2015),
    digits = 2
  )
),
format = "latex", 
booktabs = TRUE, digits = 1,
col.names = c( "Min.", "Q1", "Median", "Mean", "Q3", "Max." ) )


# Materials share elasticity by country

kable( data.frame( countries_names, alpham ),
       format = "latex", booktabs = TRUE, 
       col.names = c( "Countries", "\\alpha_m" ) )


#### Graphs ####

figure <- seq( 1, 10000 )

#transform into time series

markups_europe <- ts( markups_europe,
                      start = c( syear, 1 ),
                      frequency = 4 )

#2010-2014 period
recession = read.table(textConnection( 
  "Peak, Trough
2010-03-01, 2014-12-01"), sep=',',
  colClasses=c('Date', 'Date'), header=TRUE)

#sample dates
dates  <- seq(as.Date('1995-03-01'), as.Date('2019-12-01'), by='quarter') 


# Aggregate markup growth by country

# Levels

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures/Aggregate Markups/Levels")

plot_list = list()

for ( i in 1:ncol( markups_europe ) ) {
  
  mu_i  <- markups_europe[ , i ] / markups_europe[ , i ][ time( markups_europe[ , i ]) == 2008] * 100
  data  <- data.frame( dates, mu_i )
  
  p <- ggplot(data) + geom_line(aes(x = dates, y =  mu_i ), size = 0.8) + 
    theme_bw() + 
    geom_rect(data=recession, aes(xmin=Peak,
                                   xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
    labs(x = "") + ylab( TeX( "$\\mu$" ) ) + theme(aspect.ratio=1) + 
    ggtitle( countries_names[ i ] ) +
    theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text(size=24) ) 

  plot_list[[i]] = p 

}


for ( i in 1:ncol( markups_europe ) ) {
  figurename <-paste0('figure',figure[ i ],'.jpg', sep = '')
  jpeg(figurename, quality = 800, bg="transparent")
#  tiff(figurename)
  print(plot_list[[i]])
  dev.off()
}

# Growth

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures/Aggregate Markups/Growth")

plot_list = list()

for ( i in 1:ncol( markups_growth ) ) {
  
  mu_i  <- markups_growth[ , i ]
  data  <- data.frame( dates, mu_i )
  
  p <- ggplot(data) + geom_line(aes(x = dates, y =  mu_i ), size = 0.8) + 
    theme_bw() + 
    geom_rect(data=recession, aes(xmin=Peak,
                                  xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
    labs(x = "") + ylab( TeX( "$\\hat{\\mu}$" ) ) + theme(aspect.ratio=1) + 
    ggtitle( countries_names[ i ] ) +
    theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text(size=24) ) 
  
  plot_list[[i]] = p 
  
}


for ( i in 1:ncol( markups_europe ) ) {
  figurename <-paste0('figure',figure[ i ],'.jpg', sep = '')
  jpeg(figurename, quality = 800, bg="transparent")
  #  tiff(figurename)
  print(plot_list[[i]])
  dev.off()
}

rm( mu_i )

# Skewness by country

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures/Skewness")

plot_list = list()

for ( i in 1:ncol( skewness ) ) {
  
  s_i   <- skewness[ , i ]
  data  <- data.frame( dates, s_i )
  
  p <- ggplot(data) + geom_line(aes(x = dates, y =  s_i ), size = 0.8) + 
    theme_bw() + 
    geom_rect(data=recession, aes(xmin=Peak,
                                  xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
    labs(x = "") + ylab( TeX( "$skewness$" ) ) + theme(aspect.ratio=1) + 
    ggtitle( countries_names[ i ] ) +
    theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text(size=24) ) 
  
  plot_list[[i]] = p 
  
}


for ( i in 1:ncol( skewness ) ) {
  figurename <-paste0('figure',figure[ i ],'.jpg', sep = '')
  jpeg(figurename, quality = 800, bg="transparent")
  #  tiff(figurename)
  print(plot_list[[i]])
  dev.off()
}

rm(s_i )

# Kurtosis by country

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures/Kurtosis")

plot_list = list()

for ( i in 1:ncol( kurtosis ) ) {
  
  k_i   <- kurtosis[ , i ]
  data  <- data.frame( dates, k_i )
  
  p <- ggplot(data) + geom_line(aes(x = dates, y =  k_i ), size = 0.8) + 
    theme_bw() + 
    geom_rect(data=recession, aes(xmin=Peak,
                                  xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
    labs(x = "") + ylab( TeX( "$kurtosis$" ) ) + theme(aspect.ratio=1) + 
    ggtitle( countries_names[ i ] ) +
    theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text( size=24 ) ) 
  
  plot_list[[i]] = p 
  
}


for ( i in 1:ncol( kurtosis ) ) {
  figurename <-paste0('figure',figure[ i ],'.jpg', sep = '')
  jpeg(figurename, quality = 800, bg="transparent")
  #  tiff(figurename)
  print(plot_list[[i]])
  dev.off()
}

rm( k_i, i )

#### Relative contribution #### 

#list for the relative contribution of each sector by country
contribution <- list()

contribution_matrix <- matrix(NA, nrow = nrow( markups_europe ), ncol = length( sectors ) )
colnames( contribution_matrix ) <- sectors

for ( i in 1:length( countries ) ) {
  
  for ( j in 1:length( sectors ) ) {
    
    for ( t in 1:nrow( contribution_matrix ) ) {
      
      contribution_matrix[ t, j ] <- ( markups_weights_list[[i]][ t , j ] / sum( markups_weights_list[[i]][ t , ] ) ) * 10
      
      } 
    }
  
  contribution[[i]] <- contribution_matrix
  
}

names(contribution) <- countries_names 

rm(i, j, t, contribution_matrix)


# Total Sample

contribution_total <- list()

contribution_sum <- matrix( data = NA, nrow = length( sectors ), ncol = 3)
colnames(contribution_sum) <- c("Sector", "Mean", "Standard Deviation")
contribution_sum[,1]     <- sectors

for ( i in 1:length( countries ) ) {

  for (j in 1:nrow(contribution_sum)) {
    
    
    contribution_sum[j,2] <- round( mean( contribution[[i]][,j] ), 2)
    contribution_sum[j,3] <- round( sd( contribution[[i]][,j] ), 2 )
  }
  
  contribution_total[[i]] <- contribution_sum
  
}

names( contribution_total ) <- countries_names 

rm(i, j)


kable(contribution_total[["Portugal"]], 
      format = "latex",
      booktabs = TRUE)

# 2010-2014 recession

contribution_crisis <- list()

for ( i in 1:length( countries ) ) {
  
  for (j in 1:nrow( contribution_sum )) {
    
    
    contribution_sum[j,2] <- round( mean( contribution[[i]][63:73,j] ), 2)
    contribution_sum[j,3] <- round( sd( contribution[[i]][63:73,j] ), 2 )
  }
  
  contribution_crisis[[i]] <- contribution_sum
  
}

names( contribution_crisis ) <- countries_names 

rm(i, j, contribution_sum)


kable(contribution_crisis[["Portugal"]], 
      format = "latex",
      booktabs = TRUE)



#### Dataset for LBVAR ####

# Spread

# For Portugal only, so far

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Empirics/Markups")

lrate <- read_xlsx("Quarterly data/DataOECD.xlsx", 
                   sheet = "OECD.Stat export",
                   range = "D8:D107", 
                   col_names = FALSE)

srate <- read_xlsx("Quarterly data/DataOECD.xlsx", 
                   sheet = "OECD.Stat export",
                   range = "E8:E107", col_names = FALSE)

spread = lrate - srate
spread = ts(spread, start = c(1995,1), frequency = 4)

# Primary 

primary <- read_xlsx("Annual data/DataOECD.xlsx", 
                  sheet = "OECD.Stat export",
                  range = "C8:C32", col_names = FALSE)
colnames(primary) <- "primary"
primary <- ts(primary, start = syear, end = eyear, frequency = 1)

primary <- td(primary ~ 1, to = "quarterly", method = "denton-cholette")
primary <- predict(primary)


# Debt

debt <- read_xlsx("Annual data/DataOECD.xlsx", 
                     sheet = "OECD.Stat export",
                     range = "D8:D32", col_names = FALSE)
colnames(debt) <- "debt"
debt <- ts(debt, start = syear, end = eyear, frequency = 1)

debt <- td(debt ~ 1, to = "quarterly", method = "denton-cholette")
debt <- predict(debt)


# Value Added

data <- subset( dat,  geo == "PT" & na_item == "B1G" & unit == "CP_MEUR" )  
data <- data[ order( data$time ), ]

VA <- matrix( data = NA, 
              nrow = eyear-syear+1, 
              ncol = length( sectors ) )

colnames( VA ) <- sectors 

for (j in 1:ncol( VA ) ){
  
  base <- subset( data, nace_r2 == nace[ j ] ) 
  base <- base[ 1:nrow( VA ), ]
  VA[ , j ] <- base$values
  
}

rm(j, base)

VA <- ts(VA, start = syear, end = eyear, frequency = 1)


VA_q <- matrix( data = NA, 
        nrow = ( eyear-syear +1) * 4, 
        ncol = length( sectors ) )
colnames( VA_q ) <- sectors


for (j in 1:ncol(VA) ){
  
  m1 <- td(VA[,j] ~ 1, to = "quarterly", method = "denton-cholette")
  
  VA_q[,j] <- predict(m1)
  
}
rm(j, m1)


VA_growth <- VA_q

time                 <- c(1:nrow( VA_growth ) )
time2                <- time^2

for (j in 1:ncol( VA_growth ) ) {
  
  VA_s   <- VA_q[,j]
  reg    <- lm( log( VA_s ) ~ time + time2 )
  beta0  <- reg[["coefficients"]][["(Intercept)"]]
  beta1  <- reg[["coefficients"]][["time"]]
  beta2  <- reg[["coefficients"]][["time2"]]
  trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
               start=c(1995,1), frequency = 4) 
  cycle                <- ( log( VA_s )-trend ) * 100
  
  VA_growth[,j] <- cycle
  
}

rm(j, reg, beta0, beta1, beta2, trend, cycle, VA_s)

#hours

hours <- read_xlsx("Quarterly data/DataOECD.xlsx", 
                     sheet = "OECD.Stat export",
                     range = "C8:C107", col_names = FALSE)
colnames(hours) <- "hours"
hours <- ts(hours, start = c(1995,1), frequency = 4)

reg    <- lm( log( hours ) ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             start=c(1995,1), frequency = 4) 
hours_growth    <- ( log( hours ) - trend ) * 100

reg    <- lm( spread ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             start=c(1995,1), frequency = 4) 
spread_growth    <- spread - trend 


reg    <- lm( primary ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             start=c(1995,1), frequency = 4) 
primary_growth    <- spread - trend 

reg    <- lm( debt ~ time + time2 )
beta0  <- reg[["coefficients"]][["(Intercept)"]]
beta1  <- reg[["coefficients"]][["time"]]
beta2  <- reg[["coefficients"]][["time2"]]
trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
             start=c(1995,1), frequency = 4) 
debt_growth    <- debt - trend 

lbvar <- data.frame(primary,
                            debt_growth,
                            spread_growth,
                            hours_growth,
                            markups_growth, 
                            VA_growth 
                    )

colnames( lbvar ) <- c( "primary",
                                   "debt",
                                   "spread",
                                   "hours",
                                   sectors,
                                   sectors
                                    )

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")
