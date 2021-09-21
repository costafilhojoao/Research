

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

#### Micro data ####

micro  <- read_dta(file = "agggregate_mkups_by_sector.dta")
colnames(micro) <- c("year", "nace", "markup", "shock")

micro[micro == "."] <- "K"

# Create index from annual change data

micro_mkp <- matrix( data = NA,
                     nrow = 11,
                     ncol = ncol( markups_sector))
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

rm(n, m, i, t)

#### Sectoral data ####

nice_load(file = "markupsdata.RData", object = c("nace"), rename = NULL)
nice_load(file = "markupsdata.RData", object = c("sectors"), rename = NULL)
nice_load(file = "markupsdata.RData", object = c("markups_sector"), rename = NULL)

markups_sector <- markups_sector[["Portugal"]]

#### Economic Interpolation ####

# Quarterly sectoral markups (interpolated)

markups_sector_q <- markups_sector

for (j  in 1:length(nace)) {

  mu_a_j  <- ts( micro_mkp[ , j ] * 4, start = 2004, frequency = 1 )
  mu_q_j  <- ts( markups_sector[ , j ], start = c( 1995, 1), frequency = 4 )
  
  mu <- td( mu_a_j ~ 0 + mu_q_j, 
            to = "quarterly", method = "denton-cholette" )
  mu <- predict(mu) 
  markups_sector_q[ , j ] <- mu
}

rm(j, mu_a_j, mu_q_j, mu)

#### Aggregate average price-wedge markup ####

nice_load(file = "markupsdata.RData", object = c("weights"), rename = NULL)

markups_weights <- weights / markups_sector_q

#sample period

syear   <- 1995  #start year
eyear   <- 2019  #end year

#aggregate average markup

mu_micro <- matrix( data = syear:eyear, 
              nrow = ( eyear - syear + 1 ) * 4, 
              ncol = 1 )

#aggregate markup
for (t in 1:nrow( mu_micro )){
  
  mu_micro[t]  <- 1 / sum ( markups_weights[ t, ] )  
  
}


#### Relative contribution #### 

contribution <- matrix(NA, 
                       nrow = nrow( markups_sector_q ), 
                       ncol = ncol( markups_sector_q ) )
colnames( contribution_matrix ) <- sectors

for ( j in 1:length( sectors ) ) {
  
  for ( t in 1:nrow( contribution ) ) {
    
    contribution[ t, j ] <- ( markups_weights[ t , j ] / sum( markups_weights[ t , ] ) ) * 100
    
  } 
}

rm(t,j)

# 2010-2014 recession

contribution_crisis <- matrix( data = NA, nrow = length( sectors ), ncol = 3)
colnames(contribution_crisis) <- c("Sector", "Mean", "Standard Deviation")
contribution_crisis[,1]     <- sectors


for (j in 1:nrow( contribution_crisis )) {
  
  contribution_crisis[j,2] <- round( mean( contribution[63:76,j] ), 2 )
  contribution_crisis[j,3] <- round( sd( contribution[63:76,j] ), 2 )
}

rm(j)

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

