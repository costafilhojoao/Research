

#### Housekeeping ####

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

rm(list = ls())  # clear the memory 
graphics.off()   # close graphs

#### Packages ####

library(haven)
library(nicethings)
library(tempdisagg)
library(ggplot2)
library(latex2exp)


#### Sectoral data ####

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
               #"K",
               "L",
               "M",
               "N",
               #"O", Public administration and defence and compulsory social security were not considered
               #"P",
               #"Q",
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
               #"Financial and insurance activities",
               "Real estate activities",
               "Professional, scientific and technical activities",
               "Administrative and support service activities",
               #"Public administration and defence; compulsory social security" were not conidered
               #"Education",
               #"Human health and social work activities",
               "Arts, entertainment and recreation",
               "Other service activities were removed"
)

nice_load(file = "markupsdata.RData", object = c("markups_sector"), rename = NULL)

markups_sector <- markups_sector[["Portugal"]]

markups_sector <- subset( markups_sector, select = sectors )

#### Micro data ####

micro  <- read_dta(file = "agggregate_mkups_by_sector.dta")
colnames(micro) <- c("year", "nace", "markup", "shock")

# Create index from annual change data

micro_mkp <- matrix( data = NA,
                     nrow = 11,
                     ncol = length( sectors ) )
rownames( micro_mkp ) <- seq( 2004, 2014)
colnames( micro_mkp ) <- sectors 

# 2004 = 100

micro_mkp[1,] <- rep( 100, ncol(micro_mkp) )

for (j  in 1:length(nace)) {
  
  for (t  in 2:nrow( micro_mkp )) {
    
    n <- nace[j]
    m <- subset( micro, nace == n )
    micro_mkp[ t, j ] <- micro_mkp[t-1,j] * ( 1 + m$markup[t] )
    
  }
  
}

rm(n, m, j, t)

#### Economic Interpolation ####

# Quarterly sectoral markups (interpolated)

markups_sector_q <- markups_sector[1:80, ]

for (j  in 1:length(nace)) {

  mu_a_j  <- ts( micro_mkp[ , j ] * 4, start = 2004, frequency = 1 )
  mu_q_j  <- ts( markups_sector[ 1:80, j ], start = c( 1995, 1), frequency = 4 )
  
  mu <- td( mu_a_j ~ 0 + mu_q_j, 
            to = "quarterly", method = "denton-cholette" )
  mu <- predict(mu) 
  markups_sector_q[ , j ] <- mu
}

rm(j, mu_a_j, mu_q_j, mu)

#### Aggregate average price-wedge markup ####

nice_load(file = "markupsdata.RData", object = c("output_q"), rename = NULL)

output_q <- subset( output_q[ 1:80, ], select = sectors )

#sample period

syear   <- 1995  #start year
eyear   <- 2014  #end year

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

rm( totalrow, yjt, t, j)

markups_weights <- weights / markups_sector_q

#aggregate average markup

mu_micro <- matrix( data = NA, 
              nrow = ( eyear - syear + 1 ) * 4, 
              ncol = 1 )

#aggregate markup
for (t in 1:nrow( mu_micro )){
  
  mu_micro[t]  <- 1 / sum ( markups_weights[ t, ] )  
  
}

#### Graph - aggregate ####

#sample dates
dates  <- seq(as.Date('1995-03-01'), as.Date('2014-12-01'), by='quarter') 
mu_micro <- ts( mu_micro, start = c( syear, 1 ) , frequency = 4 )

data <- data.frame( mu_micro, dates )
colnames(data) <- c( "mu", "dates")

ggplot(data) + geom_line( aes(x = dates, y = mu), color = "#0073D9", size = 1.5) + 
  theme_classic() + labs(x = "", y= "") #+ ylab( TeX( "$\\hat{Y}$" ) ) 

#### Relative contribution #### 

contribution <- matrix(NA, 
                       nrow = nrow( markups_sector_q ), 
                       ncol = ncol( markups_sector_q ) )
colnames( contribution ) <- sectors

for ( j in 1:length( sectors ) ) {
  
  for ( t in 1:nrow( contribution ) ) {
    
    contribution[ t, j ] <- ( markups_weights[ t , j ] / sum( markups_weights[ t , ] ) ) * 100
    
  } 
}

rm(t,j)

# 2010-2014 recession

contribution_crisis <- matrix( data = NA, nrow = length( sectors ), ncol = 2)
colnames(contribution_crisis) <- c("Mean", "Standard Deviation")

for (j in 1:nrow( contribution_crisis )) {
  
  contribution_crisis[j,1] <- round( mean( contribution[63:76,j] ), 2 ) 
  contribution_crisis[j,2] <- round( sd( contribution[63:76,j] ), 2 ) 
}

rm(j)

contribution_crisis <- data.frame( sectors, 
                                   contribution_crisis[,1],
                                   contribution_crisis[,2])
colnames(contribution_crisis) <- c("Sectors", "Mean", "Standard Deviation")

contribution_crisis   <- contribution_crisis[ order( contribution_crisis$Mean,
                                                     decreasing = TRUE  ), ]

#### Graphs ####

recessions = read.table(textConnection( #it does not include the two previous recessions
  "Peak, Trough
2002-03-01, 2003-06-01
2008-03-01, 2009-03-01
2010-09-01, 2013-03-01"), sep=',',
  colClasses=c('Date', 'Date'), header=TRUE)

dates  <- seq(as.Date('1995-03-01'), as.Date('2019-12-01'), by='quarter')

for (j  in 1:length(nace)) {

data <- data.frame( mu = markups_sector_q[ , j ] , dates )

ggplot(data) + geom_line(aes(x = dates, y =  mu ), size = 0.8) + 
  theme_bw() + 
  geom_rect(data=recessions, aes(xmin=Peak,
                                 xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
  labs(x = "") + ylab( TeX( "$\\mu^j$" ) ) + theme(aspect.ratio=1) + 
    ggtitle( sectors[ j ] ) +
  theme(plot.title = element_text( hjust = 0.5) ) + theme(text = element_text(size=24) ) 

}

rm(j, data)

