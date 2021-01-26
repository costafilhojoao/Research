#### Fiscal Consolidation and the Euro Crisis: the role of markups
#### 
#### Corresponding author: João Costa-Filho
#### E-mail: joao.costa@iseg.ulisboa.pt; Twitter: @costafilhojoao


library(WDI); library(dplyr)
options(mc.cores = parallel::detectCores())

# Grab gdp, consumption and investment (lcu constant prices)
gdp_cons_inv <- WDI(indicator = c("NY.GDP.MKTP.KN","NE.CON.TOTL.KN", "NE.GDI.FTOT.KN"), 
                    start = 1970)

gdp_cons_inv_1 <- gdp_cons_inv%>% 
  filter(complete.cases(.)) %>% 
  rename(GDP = NY.GDP.MKTP.KN,
         CONS = NE.CON.TOTL.KN,
         GFCF = NE.GDI.FTOT.KN) %>% 
  group_by(country) %>% 
  arrange(year) %>%
  mutate(dl_gdp = c(NA, diff(log(GDP))), 
         dl_cons = c(NA, diff(log(CONS))),
         dl_gfcf = c(NA, diff(log(GFCF))),
         more_than_10= sum(!is.na(dl_gfcf))>10) %>%
  arrange(country, year) %>%
  ungroup %>%
  filter(more_than_10 & is.finite(dl_gfcf))

# Complete cases then add a time index (starts at one for every country)
gdp_cons_inv_1 <- gdp_cons_inv_1 %>%
  ungroup %>%
  filter(complete.cases(.)) %>% 
  group_by(country) %>% 
  mutate(time= 1:n())

# Takes a while to run, so I'll just do it with English speaking countries plus Chile (liberal commodity economy)
gdp_cons_inv_2 <- gdp_cons_inv_1 %>% 
  ungroup %>% 
  filter(country %in% c("United States", "United Kingdom", "Australia", 
                        "New Zealand", "Chile", "Canada", "Ireland", "South Africa"))


rm( gdp_cons_inv, gdp_cons_inv_1, gdp_cons_inv_2 )
