if ( !require(dplyr) )    { install.packages("dplyr");    library(dplyr) }
if ( !require(purrr) )    { install.packages("purrr");    library(purrr) }

covid <- readRDS("./data/covid_north.RData")
covid_complete <- readRDS("./data/covid_north_complete.RData")

fit_complete <- lm(new_cases_per_million ~ new_tests_per_million + continent, data = covid_complete)
covid_complete$adjusted_new_cases_per_million <- residuals(fit_complete)

covid_adjusted <- 
  covid %>% 
  merge(   select(covid_complete, c(location, Day, adjusted_new_cases_per_million) ), all = TRUE )


# treat records with one missing entry all NA
# rows with missing values
idx <- apply(covid_adjusted , 1, function(x) any(is.na(x)) )
covid_adjusted[idx,]$new_cases_per_million <- NA
covid_adjusted[idx,]$new_tests_per_million <- NA
covid_adjusted[idx,]$adjusted_new_cases_per_million <- NA

covid_list <- split(covid_adjusted, covid_adjusted$location)

# # check time span
# test <- 
#   covid_list %>% 
#   lapply( function(x){
#     start = strptime( x$Day[1], format = "%Y-%m-%d")
#     end = strptime( x$Day[dim(x)[1]], format = "%Y-%m-%d")
#     
#     span = difftime(end, start)
#     as.numeric(span, units = "days")
#   })

covid_weekly <- 
  covid_list %>% 
  lapply( function(x){
    len = 7 * dim(x)[1] %/% 7
    x[seq_len(len),]
  } ) %>%
  lapply( function(x) {
    idx = which( seq_along(x$Day) %% 7 == 1 )
    mutate(x, Start_date = rep(x$Day[idx], each = 7) )
  }) %>% 
  lapply( function(x) {
    df <- 
      group_by(x, Start_date, location, continent, GDPrank) %>% 
      summarize(weekly_cases_per_million = sum(new_cases_per_million, na.rm = TRUE),
                weekly_tests_per_million = sum(new_tests_per_million, na.rm = TRUE), 
                vaccination_policy = min(as.integer(vaccination_policy) -1L ),
                adjusted_weekly_tests_per_million = sum(adjusted_new_cases_per_million, na.rm = TRUE) ) 
    df$type <- "training"
    df$type[tail(seq_len(dim(df)[1]), 4L)] <- "validation"
    df
   }) %>% 
  bind_rows()
  
saveRDS(covid_weekly, "./data/covid_north_weekly.RData")
