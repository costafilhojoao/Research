#### Fiscal Consolidation and the Euro Crisis: the role of markups
#### 
#### Corresponding author: João Costa-Filho
#### E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao


library(HDeconometrics)

figures_path <- "C:/Users/jcfil/Google Drive/Documents/Docência/ISEG/2020-2021 - MUFFINs/Materials share/Manuscript/Figures"


#lbvar(Y, p = 1, delta = 0, lambda = 0.05, xreg = NULL, ps = FALSE,
#      tau = 10 * lambda)


modelbvar <- lbvar(data_econometrics,
                    p = 4,
                    delta = 0.5,
                    lambda = 0.05)

ident     <- identification(modelbvar)

responses <- irf(modelbvar, 
                 ident,
                 h = 12,
                 boot = TRUE,
                 M = 1000,
                 unity.shock = TRUE)


setwd(figures_path)

irf_list = list()

for (j in 1:ncol(data_econometrics)) {

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
    ggtitle( colnames(data_econometrics)[j]) +  
    theme(plot.title = element_text(hjust = 0.5)) + 
    theme(text = element_text(size=24) ) 
  
  irf_list[[j]] = p 
  
}

for (j in 1:ncol(data_econometrics)) {
  
  figurename <-paste0(figure[j+48,],'.jpg', sep = '')
  jpeg(figurename, quality = 800, bg="transparent")
  #  tiff(figurename)
  print(irf_list[[j]])
  dev.off()
}
#rm(datag, p, figurename, j, mu_s)

