#### Fiscal Consolidation and the Euro Crisis: the role of markups
#### 
#### Corresponding author: João Costa-Filho
#### E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao
#### Original code in stata from Brinca et al. (2020) [https://onlinelibrary.wiley.com/doi/10.1111/iere.12482]

#### Data set: Alesina et al. (2015)

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")

#load dataset
library(haven)

data         <- read_dta(file = "alesina.dta")
data$country <- factor( data$country )
attach( data )

#Variables description:

#t_u_t: unanticipated tax shock at time t, % of GDP
#G_u_t: unanticipated spending shock at time t, % of GDP
#g_u_t: unanticipated transfer shock at time t, % of GDP

#t_a_t: anticipated tax shock at time t, % of GDP
#G_a_t: anticipated spending shock at time t, % of GDP
#g_a_t: anticipated transfers shock at time t, % of GDP

#cb: dummy equal to one if the consolidation was more government consumption based
#trb: dummy equal to one if the consolidation was more transfer based
#tb: dummy equal to one if the consolidation was more tax based
#eb: is a dummy equal to one if the consolidation was more expenditure (sum of consumption and transfers) based

#f_u_t: total unanticipated shocks, % of GDP
#f_a_t: total anticipated shocks, % of GDP

#e_u: unexpected deficit reduction policy
#e_a: announced deficit reduction policy

#TB: tax-based program
#EB: expenditure-based program


library(gplots)

base <- subset( data,  country == c("AUS", "BEL", "DEU", "DNK", "ESP", "FIN", "FRA", "GBR",
                                    "IRL", "ITA", "PRT", "SWE") )
plotmeans(dlgdp * 100 ~ country, data = base,
          #main="Heterogeineity across countries",
          n.label = FALSE,
          connect = FALSE,
          p = 0.95,
          ylab = "%",
          barcol = "darkblue")

detach("package:gplots")

countries <- c("AT", "BE", "DK", "DE", "FI", "FR", "IE", "IT", "PT", "ES")
