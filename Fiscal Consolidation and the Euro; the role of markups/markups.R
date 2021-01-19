#### Fiscal Consolidation and the Euro Crisis: the role of markups
#### 
#### Corresponding author: João Costa-Filho
#### E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao


working_path <- "C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Empirics/Markups" 
figures_path <- "C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures"

#setwd(working_path)
#load("markups.RData")

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

#### Raw data ####

#Get Eurostat National accounts aggregate by industry (up to NACE A*64) data

dat <- get_eurostat( "nama_10_a64", time_format = "num" )


#### Annual to quarterly #### 

#sample countries code

countries <- c( "AT",
                "BE",
                "BG",
                "CH",
                "CY",
                "CZ",
                "DE",
                "DK",
                "EE",
                "EL",
                "ES",
                "FI",
                "FR",
                "HR",
                "HU",
                "IE",
                "IT",
                "LT",
                "LU",
                "LV",
                "MT",
                "NL",
                "NO",
                "PL",
                "PT",
                "RO",
                "RS",
                "SE",
                "SI",
                "SK",
                "TR",
                "UK",
                "ME",
                "BA",
                "AL",
                "MK",
                "IS",
                "LI"
                )

countries <- c( "ES", "PT" )

#https://ec.europa.eu/eurostat/documents/3859598/5889816/KS-BM-05-002-EN.PDF/62e82e02-4632-438b-a284-e8fe75984b32?version=1.0
# page 10, map legend
countries_names <- c( "AT",
                      "BE",
                      "BG",
                      "CH",
                      "CY",
                      "CZ",
                      "DE",
                      "DK",
                      "EE",
                      "EL",
                      "ES",
                      "FI",
                      "FR",
                      "HR",
                      "HU",
                      "IE",
                      "IT",
                      "LT",
                      "LU",
                      "LV",
                      "MT",
                      "NL",
                      "NO",
                      "PL",
                      "PT",
                      "RO",
                      "RS",
                      "SE",
                      "SI",
                      "SK",
                      "TR",
                      "UK",
                      "ME",
                      "BA",
                      "AL",
                      "MK",
                      "IS",
                      "LI"
                      )

countries_names <- c( "Spain", "Portugal" )

#statistical classification of economic activities in the European Community
nace      <- c("A", 
               "B", 
               "C",
               #"C10-C12", "C13-C15", "C16", "C17", "C18", "C19", "C20", "C21", "C22",
               #"C23", "C24", "C25", "C26", "C27", "C28", "C29", "C30", "C31_C32",
               #"C33", 
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
               #"O", Public administration and defence; compulsory social security were not conidered
               "P",
               "Q",
               "R",
               "S"
               )


sectors   <- c("Agriculture, forestry and fishing", 
               "Mining and quarrying", 
               "Manufacturing",
               #"C10-C12", "C13-C15", "C16", "C17", "C18", "C19", "C20", "C21", "C22",
               #"C23", "C24", "C25", "C26", "C27", "C28", "C29", "C30", "C31_C32",
               #"C33", 
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


for ( i in length( countries ) ){
  
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


  ## Output

  output <- matrix( data = syear:eyear, 
                    nrow = eyear - syear + 1, 
                    ncol = length( nace ) )

  colnames( output ) <- sectors 


  for (j in 1:ncol(output) ){
  
    base <- subset( data, nace_r2 == nace[ j ] & na_item == "P1" ) 
    base <- base[ 1:nrow( output ), ]
    output[ , j ] <- base$values
    
  }


  output <- ts(output, start = syear, end = eyear, frequency = 1)

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

  alpham <- 0.605944444444444 #average production function elasticity from Santos, Brito and Costa (2020)

  #sectoral markups
  markups <- alpham * ( output_q / intermediate_q )

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
  markups_weights <- weights / markups 

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

markups_europe <- ts( markups_europe, start = c( syear, 1 ) , frequency = 4 )

#### Graphs ####

figure <- seq( 1, 1000 )

#Portugal
#https://www.ffms.pt/crises-na-economia-portuguesa/5042/documentos-do-comite

recessions = read.table(textConnection( #it does not include the two previous recessions
  "Peak, Trough
2002-03-01, 2003-06-01
2008-03-01, 2009-03-01
2010-09-01, 2013-03-01"), sep=',',
  colClasses=c('Date', 'Date'), header=TRUE)


dates  <- seq(as.Date('1995-03-01'), as.Date('2019-12-01'), by='quarter') #Portugal

data   <- data.frame(dates, markups_europe )

setwd(figures_path)

figurename <-paste0(figure[1,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y = mu ), size = 0.8) + 
  theme_bw() +
  geom_rect(data=recessions, aes(xmin=Peak,
                                 xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
  labs(x = "") + ylab(TeX("$\\mu$")) + theme(text = element_text(size=24) ) 
dev.off()


plot_list = list()

for (j in 1:ncol(markups)) {
  
  mu_s   <- markups[,j]
  datag  <- data.frame(dates, mu_s)
  
  p <- ggplot(datag) + geom_line(aes(x = dates, y = mu_s), size = 0.8) + 
    theme_bw() + 
    geom_rect(data=recessions, aes(xmin=Peak,
                                   xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
    labs(x = "") + ylab(TeX("$\\mu$")) + theme(aspect.ratio=1) + 
    ggtitle(nace[ j ]) +
    theme(plot.title = element_text(hjust = 0.5)) + theme(text = element_text(size=24) ) 

  plot_list[[j]] = p 

}


for (j in 1:ncol(markups)) {
  figurename <-paste0(figure[j+1],'.jpg', sep = '')
  jpeg(figurename, quality = 800, bg="transparent")
#  tiff(figurename)
  print(plot_list[[j]])
  dev.off()
}


#kable(sectors, format = "latex", booktabs = TRUE)


#### Distribution of markups - level #### 

quarter <- matrix(NA, nrow = nrow(markups), ncol = 1)

count <- 1

for (a in syear:eyear ) {
  
  for (b in 1:4) {
  
    q = paste(a, b)  
    quarter[count] <- q
    
    count <- count + 1
  }
}

rm(a,b,q, count)


data <- data.frame(quarter, markups)
colnames(data) <- c("dates", colnames(markups))

data <- melt(data, measure.vars =  colnames(markups),
             variable_name = "sector")



# Recession 2002-03-01, 2003-06-01

datag1 <- subset( data, data$dates == c("2002 1", "2002 2") )
datag2 <- subset( data, data$dates == c("2002 3", "2002 4") )
datag3 <- subset( data, data$dates == c("2003 1", "2003 2") )

datag <- rbind(datag1, datag2, datag3)
rm(datag1, datag2, datag3)

figurename <-paste0(figure[20,],'.jpg')
jpeg(figurename, quality = 600, bg="transparent")
ggplot(datag, aes(x = value, y = dates, fill = ..x..)) +
  geom_density_ridges_gradient(rel_min_height = 0.01, 
                               show.legend = FALSE) +
  # labs(title = 'Real income distribution in Brazil') +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  ) +
  xlim(0.79, 10) + labs(x = "", y = "Quarter") + theme_bw()
dev.off()

# Recession 2008-03-01, 2009-03-01

datag1 <- subset( data, data$dates == c("2008 1", "2008 2") )
datag2 <- subset( data, data$dates == c("2008 3", "2008 4") )
datag3 <- subset( data, data$dates == c("2009 1") )

datag <- rbind(datag1, datag2, datag3)
rm(datag1, datag2, datag3)

figurename <-paste0(figure[21,],'.jpg')
jpeg(figurename, quality = 600, bg="transparent")
ggplot(datag, aes(x = value, y = dates, fill = ..x..)) +
  geom_density_ridges_gradient(rel_min_height = 0.01, 
                               show.legend = FALSE) +
  # labs(title = 'Real income distribution in Brazil') +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  ) +
  xlim(0.79, 10) + labs(x = "", y = "Quarter") + theme_bw()
dev.off()

# Recession 2010-09-01, 2013-03-01

datag1 <- subset( data, data$dates == c("2010 1", "2010 2") )
datag2 <- subset( data, data$dates == c("2010 3", "2010 4") )
datag3 <- subset( data, data$dates == c("2011 1", "2011 2") )
datag4 <- subset( data, data$dates == c("2011 3", "2011 4") )
datag5 <- subset( data, data$dates == c("2012 1", "2012 2") )
datag6 <- subset( data, data$dates == c("2012 3", "2012 4") )
datag7 <- subset( data, data$dates == c("2013 3") )

datag <- rbind(datag1, datag2, datag3, datag4, datag5, datag6, datag7)
rm(datag1, datag2, datag3, datag4, datag5, datag6, datag7)

figurename <-paste0(figure[22,],'.jpg')
jpeg(figurename, quality = 600, bg="transparent")
ggplot(datag, aes(x = value, y = dates, fill = ..x..)) +
  geom_density_ridges_gradient(rel_min_height = 0.01, 
                               show.legend = FALSE) +
 # labs(title = 'Real income distribution in Brazil') +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  ) +
  xlim(0.79, 10) + labs(x = "", y = "Quarter") + theme_bw()
dev.off()

rm(datag)

#### Distribution of markups - growth #### 

markups_growth <- matrix(data = NA, 
                         nrow = nrow(markups), 
                         ncol = ncol(markups))

colnames(markups_growth) <- colnames(markups)

time                 <- c(1:length(mu))
time2                <- time^2

for (j in 1:ncol(markups_growth)) {
  
  mu_s   <- markups[,j]
  reg    <- lm( log( mu_s ) ~time + time2 )
  beta0  <- reg[["coefficients"]][["(Intercept)"]]
  beta1  <- reg[["coefficients"]][["time"]]
  beta2  <- reg[["coefficients"]][["time2"]]
  trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
               start=c(1995,1), frequency = 4) 
  cycle                <- ( log( mu_s )-trend ) * 100
  
  markups_growth[,j] <- cycle
  
}

rm(reg, beta0, beta1, beta2, time, time2, trend, cycle, mu_s)

s <-  apply(markups_growth,1, skewness, na.rm = TRUE)
s <- ts(s, start = c(1991,1), frequency = 4)

k <-  apply(markups_growth,1, kurtosis, na.rm = TRUE)  # Pearson's measure of kurtosis
k <- ts(k, start = c(1991,1), frequency = 4)

setwd(figures_path)

data <- data.frame(s, k , dates)

figurename <-paste0(figure[89,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y = s), size = 0.8) + 
  theme_bw() + theme(text = element_text(size=24) ) +
  geom_rect(data=recessions, aes(xmin=Peak,
                                 xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
  labs(x = "", y = "Skewness") 
dev.off()

figurename <-paste0(figure[90,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y = k), size = 0.8) + 
  theme_bw() + theme(text = element_text(size=24) ) +
  geom_rect(data=recessions, aes(xmin=Peak,
                                 xmax=Trough, ymin=-Inf, ymax=+Inf), fill='gray', alpha=0.2) +
  labs(x = "", y = "Kurtosis") 
dev.off()

data <- data.frame(quarter, markups_growth)
colnames(data) <- c("dates", colnames(markups_growth))

data <- melt(data, measure.vars =  colnames(markups),
             variable_name = "sector")

# Recession 2002-03-01, 2003-06-01

datag1 <- subset( data, data$dates == c("2002 1", "2002 2") )
datag2 <- subset( data, data$dates == c("2002 3", "2002 4") )
datag3 <- subset( data, data$dates == c("2003 1", "2003 2") )

datag <- rbind(datag1, datag2, datag3)
rm(datag1, datag2, datag3)

figurename <-paste0(figure[42,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(datag, aes(x = value, y = dates, fill = ..x..)) +
  geom_density_ridges_gradient(rel_min_height = 0.01, 
                               show.legend = FALSE) +
  # labs(title = 'Real income distribution in Brazil') +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  ) +
  xlim(-20, 20) + labs(x = "", y = "Quarter") + theme_bw()
dev.off()

# Recession 2008-03-01, 2009-03-01

datag1 <- subset( data, data$dates == c("2008 1", "2008 2") )
datag2 <- subset( data, data$dates == c("2008 3", "2008 4") )
datag3 <- subset( data, data$dates == c("2009 1") )

datag <- rbind(datag1, datag2, datag3)
rm(datag1, datag2, datag3)

figurename <-paste0(figure[43,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(datag, aes(x = value, y = dates, fill = ..x..)) +
  geom_density_ridges_gradient(rel_min_height = 0.01, 
                               show.legend = FALSE) +
  # labs(title = 'Real income distribution in Brazil') +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  ) +
  xlim(-20, 20) + labs(x = "", y = "Quarter") + theme_bw()
dev.off()

# Recession 2010-09-01, 2013-03-01

datag1 <- subset( data, data$dates == c("2010 1", "2010 2") )
datag2 <- subset( data, data$dates == c("2010 3", "2010 4") )
datag3 <- subset( data, data$dates == c("2011 1", "2011 2") )
datag4 <- subset( data, data$dates == c("2011 3", "2011 4") )
datag5 <- subset( data, data$dates == c("2012 1", "2012 2") )
datag6 <- subset( data, data$dates == c("2012 3", "2012 4") )
datag7 <- subset( data, data$dates == c("2013 3") )

datag <- rbind(datag1, datag2, datag3, datag4, datag5, datag6, datag7)
rm(datag1, datag2, datag3, datag4, datag5, datag6, datag7)

figurename <-paste0(figure[44,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(datag, aes(x = value, y = dates, fill = ..x..)) +
  geom_density_ridges_gradient(rel_min_height = 0.01, 
                               show.legend = FALSE) +
  # labs(title = 'Real income distribution in Brazil') +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  ) +
  xlim(-20, 20) + labs(x = "", y = "Quarter") + theme_bw()
dev.off()

rm(datag)


#### Relative contribution #### 

contribution <- matrix(1:100, nrow = nrow(markups), ncol = ncol(markups))
colnames(contribution) <- colnames(markups)


for (j in 1:ncol(contribution)) {
  
  for (t in 1:nrow(contribution)) {
   
    contribution[t,j] <- ( markups_weights[t,j] / sum ( markups_weights[t,] ) ) * 100
  
  }
}
rm(t,j)


# Total Sample

contribution_sum <- matrix(data = NA, nrow = ncol(markups), ncol = 3)
colnames(contribution_sum) <- c("Sector", "Mean", "Standard Deviation")
contribution_sum[,1]     <- colnames(markups)

for (j in 1:nrow(contribution_sum)) {
  
  contribution_sum[j,2] <- round( mean( contribution[,j] ), 2)
  contribution_sum[j,3] <- round( sd( contribution[,j] ), 2 )
}

rm(j)


kable(contribution_sum, 
      format = "latex",
      booktabs = TRUE)

# 2010-2013 recession

contribution_sum_euro <- matrix(data = NA, nrow = ncol(markups), ncol = 3)
colnames(contribution_sum_euro) <- c("Sector", "Mean", "Standard Deviation")
contribution_sum_euro[,1]     <- colnames(markups)

for (j in 1:nrow(contribution_sum_euro)) {
  
  contribution_sum_euro[j,2] <- round( mean( contribution[63:73,j] ), 2)
  contribution_sum_euro[j,3] <- round( sd( contribution[63:73,j] ), 2 )
}

rm(j)


kable(contribution_sum_euro, 
      format = "latex",
      booktabs = TRUE)

#### Detrended Markups ####

time                 <- c(1:length(mu))
time2                <- time^2
reg                  <- lm( log( mu ) ~time + time2 )
beta0                <- reg[["coefficients"]][["(Intercept)"]]
beta1                <- reg[["coefficients"]][["time"]]
beta2                <- reg[["coefficients"]][["time2"]]
trend                <- ts(beta0 + beta1 * time + beta2 * time2, 
                           start=c(1995,1), frequency = 4)
cycle                <- ( log( mu )-trend ) * 100

data  <- data.frame(dates, cycle)
colnames(data) <- c("dates", "mu")

figurename <-paste0(figure[23,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y = mu), size = 0.8) + 
  theme_bw() + theme(text = element_text(size=24) ) +
  geom_rect(data=recessions, aes(xmin=Peak,
                                 xmax=Trough,
                                 ymin=-Inf,
                                 ymax=+Inf), 
            fill='gray', alpha=0.2) +
  labs(x = "", y = "%") #+ theme(aspect.ratio=1)
dev.off()

detrended_list <- list()

for (j in 1:ncol(markups)) {
  
  mu_s   <- markups[,j]
  reg    <- lm( log( mu_s ) ~time + time2 )
  beta0  <- reg[["coefficients"]][["(Intercept)"]]
  beta1  <- reg[["coefficients"]][["time"]]
  beta2  <- reg[["coefficients"]][["time2"]]
  trend  <- ts(beta0 + beta1 * time + beta2 * time2, 
               start=c(1995,1), frequency = 4) 
  cycle                <- ( log( mu_s )-trend ) * 100

  datag  <- data.frame(dates, cycle)
  colnames(datag) <- c("dates", "cycle")
  
  p <- ggplot(datag) + geom_line(aes(x = dates, y = cycle), size = 0.8) + 
    theme_bw() + theme(text = element_text(size=24) ) +
    geom_rect(data=recessions, aes(xmin=Peak,
                                   xmax=Trough,
                                   ymin=-Inf,
                                   ymax=+Inf),
              fill='gray', alpha=0.2) +
    labs(x = "", y = "%") + theme(aspect.ratio=1) + 
    ggtitle(sectors[j,]) +
    theme(plot.title = element_text(hjust = 0.5))
  
  detrended_list[[j]] = p 
}

rm(reg, beta0, beta1, beta2, time, time2, trend, cycle, p)



for (j in 1:ncol(markups)) {
  figurename <-paste0(figure[j+23,],'.jpg', sep = '')
  jpeg(figurename, quality = 800, bg="transparent")
  #  tiff(figurename)
  print(detrended_list[[j]])
  dev.off()
}
rm(datag, figurename, j, mu_s)


#### Dispersion: markups and spread ####

setwd(working_path)

lrate <- read_xlsx("Quarterly data/DataOECD.xlsx", 
                   sheet = "OECD.Stat export",
                   range = "D8:D107", 
                   col_names = FALSE)

srate <- read_xlsx("Quarterly data/DataOECD.xlsx", 
                   sheet = "OECD.Stat export",
                   range = "E8:E107", col_names = FALSE)

spread = lrate - srate
spread = ts(spread, start = c(1995,1), frequency = 4)

data   <- data.frame(dates, mu, spread)
colnames(data) <- c("dates", "mu", "spread")

setwd(figures_path)

figurename <-paste0(figure[45,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y = spread), size = 0.8) + 
  theme_bw() + theme(text = element_text(size=24) ) +
  geom_rect(data=recessions, aes(xmin=Peak,
                                 xmax=Trough, 
                                 ymin=-Inf, 
                                 ymax=+Inf), 
            fill='gray', alpha=0.2) +
  labs(x = "", y = "%") 
dev.off()


figurename <-paste0(figure[46,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data, aes(mu, spread))+ geom_point()+ 
  geom_smooth(method='lm', colour='red') + 
  xlab(TeX("$\\mu$")) + theme_bw() + theme(text = element_text(size=24) )
dev.off()


#### Dispersion: markups and Debt ####

setwd(working_path)

primary <- read_xlsx("Annual data/DataOECD.xlsx", 
                  sheet = "OECD.Stat export",
                  range = "C8:C32", col_names = FALSE)
colnames(primary) <- "primary"
primary <- ts(primary, start = syear, end = eyear, frequency = 1)

primary <- td(primary ~ 1, to = "quarterly", method = "denton-cholette")
primary <- predict(primary)

debt <- read_xlsx("Annual data/DataOECD.xlsx", 
                     sheet = "OECD.Stat export",
                     range = "D8:D32", col_names = FALSE)
colnames(debt) <- "debt"
debt <- ts(debt, start = syear, end = eyear, frequency = 1)

debt <- td(debt ~ 1, to = "quarterly", method = "denton-cholette")
debt <- predict(debt)


data <- data.frame(dates, debt, primary, mu)
colnames(data) <- c("dates", "debt", "primary", "mu")

setwd(figures_path)

figurename <-paste0(figure[47,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data) + geom_line(aes(x = dates, y = debt), size = 0.8) + 
  theme_bw() + theme(text = element_text(size=24) ) +
  geom_rect(data=recessions, aes(xmin=Peak,
                                 xmax=Trough, 
                                 ymin=-Inf, 
                                 ymax=+Inf), 
            fill='gray', alpha=0.2) +
  labs(x = "", y = "%GDP")
dev.off()

figurename <-paste0(figure[48,],'.jpg')
jpeg(figurename, quality = 800, bg="transparent")
ggplot(data, aes(mu, debt))+ geom_point()+ 
  geom_smooth(method='gam', colour='red') + 
  xlab(TeX("$\\mu$")) + theme_bw() + theme(text = element_text(size=24) )
dev.off()

#### Database for Econometric Exercises ####

VA <- matrix( data = NA, 
              nrow = eyear-syear+1, 
              ncol = nrow(sectors) )

colnames( VA ) <- t( sectors ) 

setwd(working_path)

range <- "BD32:BD56"

for (j in 1:ncol(VA) ){
  
  d <- read_xlsx("Annual data/Value added.xlsx", 
                 sheet = sheets[j],
                 range = range, 
                 col_names = FALSE)
  
  VA[,j] <- d$...1  
  
}


VA <- ts(VA, start = syear, end = eyear, frequency = 1)


VA_q <- matrix( data = NA, 
        nrow = ( eyear-syear +1) * 4, 
        ncol = nrow(sectors) )
colnames( VA_q ) <- t( sectors )


for (j in 1:ncol(VA) ){
  
  m1 <- td(VA[,j] ~ 1, to = "quarterly", method = "denton-cholette")
  
  VA_q[,j] <- predict(m1)
  
}
rm(j, m1)


VA_growth <- matrix(data = NA, 
                         nrow = nrow(VA_q), 
                         ncol = ncol(VA_q))

colnames(VA_growth) <- paste0( "VA ", colnames(VA_q) )

time                 <- c(1:length(mu))
time2                <- time^2

for (j in 1:ncol(VA_growth)) {
  
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

rm(reg, beta0, beta1, beta2, trend, cycle, VA_s)

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

data_econometrics <- data.frame(primary,
                                debt_growth,
                                spread_growth,
                                hours_growth,
                                markups_growth, 
                                VA_growth 
                                )

colnames(data_econometrics ) <- c( "primary",
                                   "debt",
                                   "spread",
                                   "hours",
                                   colnames(markups_growth),
                                   colnames(VA_growth)
                                    )

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Empirics/Econometrics/Dynamic Structural Factor Model/Estimation")

#library(xlsx)
#write.xlsx(data_DFM,file="data.xlsx")
#setwd(working_path)



