#### Fiscal Consolidation and the Euro Crisis: the role of markups
#### 
#### Corresponding author: João Costa-Filho
#### E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao
#### Original austerity data in stata from Brinca et al. (2020) [https://onlinelibrary.wiley.com/doi/10.1111/iere.12482]

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

#### Packages ####

library(haven)
library(plm)
library(nicethings)
library(knitr)
library(kableExtra)
library(stargazer)

#### Datasets ####

#load annual markups variation for selected European countries in Alesina et al. (2015) dataset
nice_load(file = "markupsdata.RData", object = "austerity", rename = NULL)


#load Alesina et al. (2015) dataset

alesina         <- read_dta(file = "alesina.dta")
alesina         <- subset(alesina, year > 2007 & country != "GBR" )
countries_names <- c( rep("Austria", 7),
                      rep("Belgium", 7),
                      rep("Germany", 7),
                      rep("Denmark", 7),
                      rep("Spain", 7),
                      rep("Finland", 7),
                      rep("France", 7),
                      rep("Ireland", 7),
                      rep("Italy", 7),
                      rep("Portugal", 7),
                      rep("Sweden", 7))


alesina$country <- countries_names; rm( countries_names )
alesina$country <- factor( alesina$country )

#alphabetic order
alesina   <- alesina[ order( alesina$country ), ]

#regression dataset
data <- data.frame( country   = alesina$country,
                    year      = alesina$year,
                    dlngdp    = alesina$dlgdp * 100,
                    f_u_t     = alesina$f_u_t * 100,
                    f_a_t     = alesina$f_a_t * 100,
                    gini      = alesina$gini, 
                    markup    = austerity$markup * 100, 
                    markup_t1 = austerity$markup_t1 * 100,
                    markup2   = (austerity$markup * 100 )^2,
                           eb = alesina$eb,
                           tb = alesina$tb
                    )

#attach( data )

#### Panel regression ####

benchmark <- plm( dlgdp ~ f_u_t + f_a_t + eb + tb, 
                  data  = data,
                  index = c( "country", "year" ), 
                  model = "within",
                  effect = "twoways" )
summary( benchmark )
intercep <- within_intercept( benchmark )


inequality <- plm( dlgdp ~ f_u_t + f_a_t + eb + tb + gini,
                   data  = data,
                   index = c( "country", "year" ), 
                   model = "within",
                   effect = "twoways" )
summary( inequality )
intercep <- within_intercept( inequality )


markup <- plm( dlgdp ~ f_u_t + f_a_t + eb + tb + gini + markup | f_u_t + f_a_t + eb + tb + gini + markup_t1,
                   data  = data,
                   index = c( "country", "year" ), 
                   model = "within",
                  effect = "twoways" )
summary( markup )
intercep <- within_intercept( markup )


interaction <- plm( dlgdp ~ f_u_t + f_a_t + eb + tb + gini + markup + gini * markup + eb * markup + tb * markup 
                          | f_u_t + f_a_t + eb + tb + gini + markup_t1 + gini * markup_t1 + + eb * markup_t1 + tb * markup_t1,
               data  = data,
               index = c( "country", "year" ), 
               model = "within" ,
               effect = "twoways" )
summary( interaction )
intercep <- within_intercept( interaction )

#raw table
output <- stargazer( benchmark, inequality, markup, interaction )


#Variables description:

#t_u_t: unanticipated tax shock at time t, % of GDP
#G_u_t: unanticipated spending shock at time t, % of GDP
#g_u_t: unanticipated transfer shock at time t, % of GDP

#t_a_t: anticipated tax shock at time t, % of GDP
#G_a_t: anticipated spending shock at time t, % of GDP
#g_a_t: anticipated transfers shock at time t, % of GDP

#f_u_t: total unanticipated shocks, % of GDP
#f_a_t: total anticipated shocks, % of GDP

#where

#f_u_t = t_u_t + G_u_t + g_u_t
#f_a_t = t_a_t+G_a_t+g_a_t


markup <- pggls( dlgdp ~ f_u_t + f_a_t + gini + markup,
               data  = data,
               index = c( "country", "year" ), 
               model = "pooling",
               effect = "individual")
summary( markup )
