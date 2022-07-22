#### Foreign demand shock

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")


library(OECD)


oecd_list <- get_datasets()

# Quarterly National Accounts Statistics
# https://www.oecd-ilibrary.org/economics/data/oecd-national-accounts-statistics/quarterly-national-accounts_data-00017-en > Click to access: Data 

data_oecd <- get_dataset(dataset = "QNA")

library(reshape2)
data <- subset( data_oecd,
                LOCATION != "PRT" & 
                FREQUENCY == "Q" & 
                MEASURE == "VPVOBARSA" &
                SUBJECT == "B1_GE" )

t <- acast( data, formula = obsTime~LOCATION,
                  fun.aggregate = NULL,
                  value.var = "obsValue" )
t <- t[ 201:(nrow(t)-5), ]

#t <- t[ 201:(nrow(t)), ]

gdp <- matrix(data = NA, 
                   nrow = nrow( t ), 
                   ncol = 1
)

for ( i in 1:nrow( gdp ) ) {
  
  gdp[ i ]  <-  sum( t[i,])
  
}

rm(i)

#### ARIMA ####

library(forecast)
library(urca)

yw <- ts( log( gdp ), start = c( 1997, 1), frequency = 4 )

## Correlogram

par(mfrow=c(1,2))
Acf(yw, lag.max = 12, main='ACF')
Pacf(yw, lag.max = 12, main='PACF')
par(mfrow=c(1,1))

## Função que minimiza um critério de informação
auto.arima <- auto.arima(yw, max.p=5, max.q=5, max.P=2, max.Q=2,
                         seasonal = F)
summary(auto.arima)

#Therefore a SARIMA (2,1,0) with drift

## Teste de estacionariedade

data.ct <- ur.df(yw, type = 'trend', selectlags = 'AIC')
trend <- cbind(t(data.ct@teststat), data.ct@cval)
trend


#Modelo SARIMA(2,1,0)

arima <- Arima(yw, order=c(2,1,0), seasonal=c(0,0,0), include.drift = TRUE)

summary(arima)

par(mfrow=c(1,2))
plot(yw)
lines(fitted(arima), col='red')
plot(arima$residuals)
par(mfrow=c(1,1))

foreign <- arima$residuals

library(xlsx)
write.xlsx( foreign, file="foreign.xlsx")

q <- seq(ISOdate(1997,1,1), by = "quarter", length.out = length(yw))

dados = data.frame( yw, q )

library(ggplot2)
ggplot(data = dados, aes(x = q, y = yw))+
  geom_line(color = "#00AFBB", size = 1.2)+
  labs(x = "", y="ln do PIB da OCDE*", caption = "Fonte: OCDE; Ajustado (PPP); Exclui Portugal")+
  theme_set(theme_bw())

#### Nominal Effective Exchange Rate ####

library(eurostat)

# Economy and finance > Exchange rates (ert) > Effective exchange rate indices (ert_eff) > Industrial countries' effective exchange rates - quarterly data

dat <- get_eurostat( "ert_eff_ic_q", time_format = "num" )

# filtering and ordering the data

base <- subset( dat,  geo == "PT" & 
                  exch_rt == "NEER_IC42")  #Nominal effective exchange rate - 42 trading partners (industrial countries)
base <- base[ order( base$time ), ]

#### Real Effective Exchange Rate ####

base1 <- subset( dat,  geo == "PT" & 
                  exch_rt == "REER_IC42_CPI")  #Real effective exchange rate (deflator: consumer price index - 42 trading partners - industrial countries )
base1 <- base1[ order( base1$time ), ]


