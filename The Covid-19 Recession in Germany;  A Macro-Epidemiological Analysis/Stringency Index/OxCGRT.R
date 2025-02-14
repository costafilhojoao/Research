library(readxl)
library(fpp3)
library(gridExtra)
library(RcppRoll)
library(ggthemes)
#####create daily  series

Days <- seq(from = as.Date("2020-01-01"), to = as.Date("2021-06-27"), by = "day")


####################################

c1_school_closing <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                sheet = "c1_school_closing", range = "C46:TZ46", col_names = F)

c1_school_closing <- as.numeric(c1_school_closing[1,])

c1_school_closing_flag <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                     sheet = "c1_flag", range = "C46:TZ46", col_names = F)

c1_school_closing_flag <- as.numeric(c1_school_closing_flag[1,])


c1_school_closing_flag[is.na(c1_school_closing_flag)] = 0

c1_school_closing <- tibble(Days, Ordinal = c1_school_closing, Flag = c1_school_closing_flag)

c1_school_closing <- c1_school_closing %>%
  as_tsibble(index = Days)

c1_school_closing <- c1_school_closing %>%
  mutate(Index = (100/3)*(Ordinal - 0.5*(1 - Flag))) #3 = maximum value, 1 because it has a flag

grid.arrange(
  c1_school_closing %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c1_school_closing %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c1_school_closing %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
)



###################################

c2_workplace_closing <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                   sheet = "c2_workplace_closing", range = "C46:TZ46", col_names = F)




c2_workplace_closing_flag <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                   sheet = "c2_flag", range = "C46:TZ46", col_names = F)

c2_workplace_closing <- as.numeric(c2_workplace_closing[1,])

c2_workplace_closing_flag <- as.numeric(c2_workplace_closing_flag[1,])


c2_workplace_closing_flag[is.na(c2_workplace_closing_flag)] = 0

c2_workplace_closing <- tibble(Days, Ordinal = c2_workplace_closing , Flag = c2_workplace_closing_flag)

c2_workplace_closing  <- c2_workplace_closing  %>%
  as_tsibble(index = Days)

c2_workplace_closing <- c2_workplace_closing  %>%
  mutate(Index = (100/3)*(Ordinal - 0.5*(1 - Flag)))



grid.arrange(
  c2_workplace_closing %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c2_workplace_closing %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c2_workplace_closing %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
)



###################################
 
c3_cancel_public_events <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                      sheet = "c3_cancel_public_events", range = "C46:TZ46", col_names = F)

c3_cancel_public_events_flag <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                      sheet = "c3_flag", range = "C46:TZ46", col_names = F)


c3_cancel_public_events<- as.numeric(c3_cancel_public_events[1,])

c3_cancel_public_events_flag <- as.numeric(c3_cancel_public_events_flag[1,])


c3_cancel_public_events_flag[is.na(c3_cancel_public_events_flag)] = 0

c3_cancel_public_events <- tibble(Days, Ordinal = c3_cancel_public_events , Flag = c3_cancel_public_events_flag)

c3_cancel_public_events  <- c3_cancel_public_events  %>%
  as_tsibble(index = Days)

c3_cancel_public_events <- c3_cancel_public_events  %>%
  mutate(Index = (100/2)*(Ordinal - 0.5*(1 - Flag)))


grid.arrange(
  c3_cancel_public_events %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c3_cancel_public_events %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c3_cancel_public_events %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
)







##################################

c4_restrictions_on_gatherings <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                            sheet = "c4_restrictions_on_gatherings", range = "C46:TZ46", col_names = F)

c4_restrictions_on_gatherings_flag <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                                 sheet = "c4_flag", range = "C46:TZ46", col_names = F)

c4_restrictions_on_gatherings<- as.numeric(c4_restrictions_on_gatherings[1,])

c4_restrictions_on_gatherings_flag <- as.numeric(c4_restrictions_on_gatherings_flag[1,])


c4_restrictions_on_gatherings_flag[is.na(c4_restrictions_on_gatherings_flag)] = 0

c4_restrictions_on_gatherings <- tibble(Days, Ordinal = c4_restrictions_on_gatherings , Flag = c4_restrictions_on_gatherings_flag)

c4_restrictions_on_gatherings  <- c4_restrictions_on_gatherings  %>%
  as_tsibble(index = Days)

c4_restrictions_on_gatherings <- c4_restrictions_on_gatherings %>%
  mutate(Index = (100/4)*(Ordinal - 0.5*(1 - Flag)))



grid.arrange(
  c4_restrictions_on_gatherings %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c4_restrictions_on_gatherings %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c4_restrictions_on_gatherings %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 

)


###############################

c5_close_public_transport <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                        sheet = "c5_close_public_transport", range = "C46:TZ46", col_names = F)

c5_close_public_transport_flag <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                             sheet = "c5_flag", range = "C46:TZ46", col_names = F)

c5_close_public_transport<- as.numeric(c5_close_public_transport[1,])

c5_close_public_transport_flag <- as.numeric(c5_close_public_transport_flag[1,])


c5_close_public_transport_flag[is.na(c5_close_public_transport_flag)] = 0

c5_close_public_transport<- tibble(Days, Ordinal = c5_close_public_transport , Flag = c5_close_public_transport_flag)

c5_close_public_transport <- c5_close_public_transport  %>%
  as_tsibble(index = Days)

c5_close_public_transport <- c5_close_public_transport %>%
  mutate(Index = (100/2)*(Ordinal - 0.5*(1 - Flag)))


grid.arrange(
  c5_close_public_transport %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c5_close_public_transport %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c5_close_public_transport %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 

)


############################

c6_stay_at_home_requirements <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                           sheet = "c6_stay_at_home_requirements", range = "C46:TZ46", col_names = F)

c6_stay_at_home_requirements_flag <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                           sheet = "c6_flag", range = "C46:TZ46", col_names = F)

c6_stay_at_home_requirements<- as.numeric(c6_stay_at_home_requirements[1,])

c6_stay_at_home_requirements_flag <- as.numeric(c6_stay_at_home_requirements_flag[1,])


c6_stay_at_home_requirements_flag[is.na(c6_stay_at_home_requirements_flag)] = 0

c6_stay_at_home_requirements <- tibble(Days, Ordinal = c6_stay_at_home_requirements , Flag = c6_stay_at_home_requirements_flag)

c6_stay_at_home_requirements <- c6_stay_at_home_requirements  %>%
  as_tsibble(index = Days)

c6_stay_at_home_requirements <- c6_stay_at_home_requirements %>%
  mutate(Index = (100/3)*(Ordinal - 0.5*(1 - Flag)))

grid.arrange(
  c6_stay_at_home_requirements %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c6_stay_at_home_requirements %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c6_stay_at_home_requirements %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
)




############################

c7_movementrestrictions <-  read_excel("OxCGRT_timeseries_all.xlsx", 
                                       sheet = "c7_movementrestrictions", range = "C46:TZ46", col_names = F)

c7_movementrestrictions_flag <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                           sheet = "c7_flag", range = "C46:TZ46", col_names = F)


c7_movementrestrictions<- as.numeric(c7_movementrestrictions[1,])

c7_movementrestrictions_flag <- as.numeric(c7_movementrestrictions_flag[1,])


c7_movementrestrictions_flag[is.na(c7_movementrestrictions_flag)] = 0

c7_movementrestrictions <- tibble(Days, Ordinal = c7_movementrestrictions , Flag = c7_movementrestrictions_flag)

c7_movementrestrictions <- c7_movementrestrictions  %>%
  as_tsibble(index = Days)

c7_movementrestrictions <- c7_movementrestrictions %>%
  mutate(Index = (100/2)*(Ordinal - 0.5*(1 - Flag)))



grid.arrange(
  c7_movementrestrictions %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c7_movementrestrictions %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c7_movementrestrictions %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
)




#######################

c8_internationaltravel <- read_excel("OxCGRT_timeseries_all.xlsx", 
                                     sheet = "c8_internationaltravel", range = "C46:TZ46", col_names = F)

c8_internationaltravel<- as.numeric(c8_internationaltravel[1,])




c8_internationaltravel<- tibble(Days, Ordinal = c8_internationaltravel)

c8_internationaltravel <- c8_internationaltravel %>%
  as_tsibble(index = Days)

c8_internationaltravel <- c8_internationaltravel %>%
  mutate(Index = (100/4)*(Ordinal))



grid.arrange(
  c8_internationaltravel %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
,
  c8_internationaltravel %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
)


########################################
################################################
##to focus on economic measures only, remove sub_index H1
##but first, try to replicate data of website to see if own calculations are right 

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

autoplot(cases, colours = c("blue", "green"))  + scale_color_manual(values=c("#D55E00", "#0072B2")) + scale_x_continuous(breaks = steps) +  guides(scale = "none") + theme(axis.text.x = element_text(angle = 45, vjust = 0.5)) + xlab("Days") + ylab("Value") 


################################create weekly index averages and plot with weekly cases and interventions############################

#manipulate index into weekly average
total_index_1.1 <- total_index %>%
  filter_index("2020-01-01" ~ "2021-01-03") %>%
  index_by(weeks) %>%
  summarise(WA = mean(Index))

total_index_1.2 <- total_index %>%
  filter_index("2021-01-04" ~ "2021-06-27") %>%
  index_by(weeks) %>%
  summarise(WA = mean(Index)) %>%
  mutate(weeks = (nrow(total_index_1.1)+1):78)

weekly_index <- rbind(total_index_1.1, total_index_1.2) %>%
  as_tsibble(index = weeks)

autoplot(weekly_index) + geom_vline(aes(xintercept = 12), color = "orange") + geom_vline(aes(xintercept = 45), color = "orange") +  geom_vline(aes(xintercept = 51), color = "orange")  +  xlab("Weeks since the beginning of 2020") + ylab("Stringency Index") + ggtitle("Average weekly stringency index") + theme_minimal()


write.table(weekly_index %>% select(weeks,WA), "OCSI.dat", row.names = F)

##create weekly case average
daily_cases <-read_excel("Fallzahlen_Gesamtuebersicht.xlsx", range = "C5:C492", col_names = FALSE)

daily_cases <- daily_cases$...1

days <- seq(from = as.Date("2020-02-26"), to = as.Date("2021-06-27"), by = "day")

cases <- tibble(days, daily_cases)

cases_beginning <- tibble(days = seq(from = as.Date("2020-01-01"), to = as.Date("2020-02-25"), by = "day"), daily_cases = rep(0, length( seq(from = as.Date("2020-01-01"), to = as.Date("2020-02-25"), by = "day"))))

cases <- rbind(cases_beginning,cases)

cases <- cases %>%
  mutate(days = ymd(days)) %>%
  as_tsibble(index = days)

cases <- cases %>%
    mutate(weeks = isoweek(days))

cases_1.1 <- cases %>%
  filter_index("2020-01-01" ~ "2021-01-03") %>%
  index_by(weeks) %>%
  summarise(WC = mean(daily_cases)) 

cases_1.2 <- cases %>%
  filter_index("2021-01-04" ~ "2021-06-27") %>%
  index_by(weeks) %>%
  summarise(WC = mean(daily_cases)) %>%
  mutate(weeks = (nrow(total_index_1.1)+1):78)

weekly_cases <- rbind(cases_1.1, cases_1.2) %>%
  as_tsibble(index = weeks)

autoplot(weekly_cases)

weekly_combined <- weekly_index %>%
  mutate(WC = weekly_cases$WC/1000)

colnames(weekly_combined) <- c("Days", "OCSI", "Cases")

weekly_combined <- weekly_combined %>%
  pivot_longer(c("Cases","OCSI"), names_to = "Series")



autoplot(weekly_combined)  + scale_color_manual(values=c("black", "#0072B2")) + scale_x_continuous(breaks = c(12,20,40,45,51,60,80)) +  guides(scale = "none") + theme_hc() + geom_vline(aes(xintercept = 12), color = "orange") + geom_vline(aes(xintercept = 45), color = "orange") +  geom_vline(aes(xintercept = 51), color = "orange")  +  xlab("Weeks since the beginning of 2020") + ylab("Value")






##compare with rolling
weekly_index <- weekly_index %>%
   mutate(ravg =  roll_mean(weekly_index$WA, n =3, fill = NA)) 

autoplot(weekly_index, ravg) + geom_vline(xintercept = 12) + geom_vline(xintercept = 45) + geom_vline(xintercept = 51) ##that's were comparability comes in -> close to rolling average 

 




























####social vs work restrictions

grid.arrange(
  c2_workplace_closing %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
  ,
  c4_restrictions_on_gatherings %>%
    autoplot(Ordinal) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
  ,
  c2_workplace_closing %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
  ,
  c4_restrictions_on_gatherings %>%
    autoplot(Flag) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
  ,
  c2_workplace_closing %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-10-12")), color = "blue") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
  , 
  c4_restrictions_on_gatherings %>%
    autoplot(Index) + geom_vline(aes(xintercept = as.Date("2020-03-16")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-03-22")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-11-02")), color = "#D55E00") + geom_vline(aes(xintercept = as.Date("2020-12-16")), color = "#D55E00") + xlab("Days") 
)





