if ( !require(ggplot2) )    { install.packages("ggplot2");    library(ggplot2) }
if ( !require(forecast) )    { install.packages("forecast");    library(forecast) }
if ( !require(dplyr) )    { install.packages("dplyr");    library(dplyr) }
if ( !require(ggpubr ) )   { install.packages("ggpubr");    library(ggpubr) }
if ( !require(grid) )    { install.packages("grid");    library(grid) }
if ( !require(purrr) )    { install.packages("purrr");    library(purrr) }

covid <- readRDS("data/covid_north.RData")

fit1 = lm(new_cases_per_million ~ new_tests_per_million + continent, data = covid)
fit1.anova <- anova(fit1)
fit1.anova$`% variance explained` <- fit1.anova$`Sum Sq` / sum( fit1.anova$`Sum Sq` ) * 100

knitr::kable(fit1.anova, digits = 1)

summary(fit1)

fit2 = lm(new_cases_per_million ~ new_tests_per_million, data = covid)
anova(fit2, fit1)


figure3 <- 
  ggplot(covid, aes(new_tests_per_million, new_cases_per_million)) +
  geom_point() +
  geom_smooth(formula = y~x, method = "loess") +
  stat_regline_equation(  label.x.npc = 0.05, label.y.npc = 0.95, aes(label = ..rr.label..) ) +
  labs(x = "New tests per million",
       y = "New cases per million") + 
  facet_wrap( ~ location, scale = "free") +
  
  theme_bw()
figure3


# # rows with missing values
# idx <- apply(covid, 1, function(x) any(is.na(x)) )
# # complete records  
# covid_complete <- covid[!idx,]
# 
# fit_complete <- lm(new_cases_per_million ~ new_tests_per_million, data = covid_complete)
# covid_complete$adjusted_new_cases_per_million <- residuals(fit_complete)
# 
# ggplot(covid_complete, aes(continent, adjusted_new_cases_per_million)) +
#   geom_boxplot()
# 
#   
# covid_list <- 
#   split(covid_complete, covid_complete$location)
# 
# fit_residual <- 
#   lapply(covid_list, function(x){
#     fit = lm(new_cases_per_million ~ new_tests_per_million,  data = x)
#     data.frame(residual = residuals(fit) )
#   })
# 
# covid_list<- 
#   mapply(covid_list, fit_residual, FUN = "cbind", SIMPLIFY = FALSE)
# 
# covid_corrected <- 
#   bind_rows(covid_list)
# 
# ggplot(covid_corrected, aes(continent, residual)) +
#   geom_boxplot()
# 
# anova(lm(residual ~ continent, data = covid_corrected))
