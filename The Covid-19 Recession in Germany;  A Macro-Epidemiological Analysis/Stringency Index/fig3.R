# The Covid-19 Recession in Germany: A Macro-Epidemiological Analysis
# Krause, Costa, and Costa-Filho (2025)

# This is a free software: you can redistribute it and/or modify it under                                                                //
# the terms of the GNU General Public License as published by the Free                                                                   //
# Software Foundation, either version 3 of the License, or (at your option)                                                              //
#  any later version.  See <http://www.gnu.org/licenses/> for more information.                                                           //
  
# This code was written by Willi Krause. # For R 3.6.1.

library(readxl)
library(fpp3)
library(gridExtra)
library(RcppRoll)
library(ggthemes)

Days <- seq(from = as.Date("2020-01-01"), to = as.Date("2021-06-27"), by = "day")

total_index <- read_excel("OxCGRT_timeseries_all.xlsx", sheet = "stringency_index", range = "C46:TZ46", col_names = F)

total_index <- as.numeric(total_index[1,])

total_index <- tibble(Days = Days, Index = total_index)

total_index <- total_index %>%
  as_tsibble(index = Days)

autoplot(total_index,Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "orange") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "green") +  geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "red") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "orange") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "red") + xlab("Days") + ylab("Stringency Index") + ggtitle("Oxford Stringency Index and Nationwide Lockdowns")

total_index <- total_index %>%
  mutate(weeks = isoweek(Days))

total_index <- total_index %>%
  mutate(diffs = difference(Index,1))

total_index <- total_index %>%
  mutate(avg_change= roll_mean(total_index$diffs, n = 7, fill = NA))

autoplot(total_index, avg_change)


##plot index along with cases
daily_cases <-read_excel("Fallzahlen_Gesamtuebersicht.xlsx", range = "C5:C492", col_names = FALSE)

daily_cases <- daily_cases$...1

days <- seq(from = as.Date("2020-02-26"), to = as.Date("2021-06-27"), by = "day")

cases <- tibble(days, daily_cases)

cases <- cases %>%
  mutate(days = ymd(days)) %>%
  as_tsibble(index = days)

cases <- cases %>%
  mutate(ravg =  roll_mean(cases$daily_cases, n = 7, fill = NA)/1000)

autoplot(cases, ravg)


Stringency_Index <- total_index %>%
  filter_index("2020-02-26" ~ "2021-06-27") %>%
  as_tibble() %>%
  select(Index)

Stringency_Index <- Stringency_Index$Index

cases$Stringency_Index <- Stringency_Index

cases <- cases %>%
  select(-daily_cases)

colnames(cases) <- c("Days", "Infections", "OCSI")

cases <- cases %>%
  pivot_longer(c( "Infections", "OCSI"), names_to = "Series")

steps = c(as.Date("2020-03-22"), as.Date("2020-07-01"), as.Date("2020-09-05"), as.Date("2020-10-15") , as.Date("2020-12-16"), as.Date("2021-04-01"), as.Date("2021-07-01"))

autoplot(cases, colours = c("blue", "green"))  + scale_color_manual(values=c("black", "#0072B2")) +  guides(scale = "none") + theme_economist_white() +  geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-28")), col = "green") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") + ylab("Value") 

