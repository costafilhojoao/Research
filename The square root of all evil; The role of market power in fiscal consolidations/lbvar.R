#### Fiscal Consolidation and the Euro Crisis: the role of markups
#### 
#### Corresponding author: João Costa-Filho
#### E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao

setwd("C:/Users/jcfil/Google Drive/Documents/Papers/Acadêmicos/Research/Fiscal Consolidation and the Euro; the role of markups")
#load("lbvardata.RData")

#### Packages ####

library(nicethings)
library(HDeconometrics)
library(ggplot2)

#### Datasets ####

#load 
nice_load(file = "markupsdata.RData", object = "lbvar", rename = NULL)

modelbvar <- lbvar(lbvar,
                    p = 4,
                    delta = 0.5,
                    lambda = 0.05)

ident     <- identification( modelbvar )

responses <- irf(modelbvar, 
                 ident,
                 h = 12,
                 boot = TRUE,
                 M = 1000,
                 unity.shock = TRUE)

#### Graphs ####

figure <- seq( 1, 10000 )

setwd("C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures/LBVAR")


irf_list = list()

for (j in 1:ncol( lbvar ) ) {

  point <- responses[["point.irf"]][["primary"]][,j]
  X     <- data.frame( responses[["density"]][["primary"]][j] )
  M     <- apply(X,1, mean, na.rm = TRUE)
  SD    <- apply(X,1, sd, na.rm = TRUE)
  Z     <- 1.96  
  
  upper <- M +  Z * SD
  lower <- M -  Z * SD
  
  data <- data.frame(point, 
                     upper, 
                     lower,
                     periods = seq(1:length(point)))
  colnames(data) <- c("point", "upper", "lower", "periods")
  
  
  p <- ggplot(data) + geom_line( aes(x = periods, y = point), size = 0.8) + 
    theme_bw() + labs(x = "", y = "") +
    geom_ribbon( aes(y = point, x = periods, ymin=lower, ymax=upper), alpha = 0.2 )  +
    ggtitle( colnames( lbvar )[j]) +  
    theme(plot.title = element_text(hjust = 0.5)) + 
    theme(text = element_text(size=24) ) 
  
  irf_list[[j]] = p 
  
}

rm( j, lower, M, point, SD, upper, X, Z )

for ( j in 1:ncol( lbvar ) ) {
  
  figurename <-paste0('figure',figure[ j ],'.jpg', sep = '')
  jpeg(figurename, quality = 800, bg="transparent")
  #  tiff(figurename)
  print(irf_list[[j]])
  dev.off()
}

rm( j, figurename, p, data )

