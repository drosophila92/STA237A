if ( !require(ggplot2) )    { install.packages("ggplot2");    library(ggplot2) }
if ( !require(forecast) )    { install.packages("forecast");    library(forecast) }
if ( !require(dplyr) )    { install.packages("dplyr");    library(dplyr) }
if ( !require(ggpubr ) )   { install.packages("ggpubr");    library(ggpubr) }
if ( !require(grid) )    { install.packages("grid");    library(grid) }
if ( !require(purrr) )    { install.packages("purrr");    library(purrr) }

covid <- readRDS("data/covid_north_contrast.RData")

fit1 = lm(ctrst_adjusted_new_cases_per_million ~ new_tests_per_million + continent, data = covid)
fit1.anova <- anova(fit1)
fit1.anova$`% variance explained` <- fit1.anova$`Sum Sq` / sum( fit1.anova$`Sum Sq` ) * 100

knitr::kable(fit1.anova, digits = 1)

summary(fit1)

# 
# 
# figure3 <- 
#   ggplot(covid, aes(weekly_tests_per_million, adjusted_weekly_cases_per_million)) +
#   geom_point() +
#   geom_smooth(formula = y~x, method = "loess") +
#   stat_regline_equation(  label.x.npc = 0.05, label.y.npc = 0.95, aes(label = ..rr.label..) ) +
#   labs(x = "Adjusted weekly tests per million",
#        y = "Adjusted weekly cases per million") + 
#   facet_wrap( ~ continent, scale = "free") +
#   
#   theme_bw()
# figure3
