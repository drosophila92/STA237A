if ( !require(dplyr ) )   { install.packages("dplyr");    library(dplyr) }

# Read data
vaccination <- read.csv("data/covid-vaccination-policy.csv")
infection <- read.csv("data/owid-covid-data.csv")

# rename colnames
colnames(infection)[1] = c("Code")
colnames(infection)[4] = c("Day")

# countries with 90-day history before policy start
date_range <- 
vaccination %>% 
  split(.$Entity) %>% 
  lapply(., function(x){
    x <- mutate(x, accu = cumsum(x$vaccination_policy))
    idx <- which(x$accu > 0)
    if(length(idx) == 0 ){
      return(NULL)
    }
    # 90 days before
    else if(idx[1]-1 >= 90){
      return(x[ c(seq(idx[1]-90L, idx[1]-1L), idx), ] )
    }
    else{
      return( NULL )
    }
  }) %>% 
  bind_rows()


covid <-
  infection %>%
  right_join(date_range, by = c("Code","Day"))

# keep north hemisphere
covid_north <-
  covid %>% 
  filter(continent %in% c("Asia","Europe","North America","Africa"))

covid_north$Day = as.Date(covid_north$Day)

# countries without vaccination policy by March 1, 2021
no_vaccination <-
  covid_north %>%
  dplyr::select(location,Day,vaccination_policy) %>%
  group_by(location) %>%
  filter(Day > "2021-3-1") %>%
  filter(vaccination_policy == 0) %>%
  distinct(location)

# remove countries with short vaccination history
covid_north <-
  covid_north %>%
  filter(!(location %in% no_vaccination$location))

# remove countries with low testing rate
covid_north <-
  covid_north %>%
  filter(total_tests_per_thousand >= 10) %>% 
  mutate(new_tests_per_million = new_tests_per_thousand * 10^3 )


# keep relevant columns
covid_north <-
  covid_north %>%
  dplyr::select(c("location","Day","continent","new_cases_per_million","new_tests_per_million", "vaccination_policy"))

# countries with <5% NAs
NA_filter <- 
covid_north %>%
  group_by(location, continent) %>%
  summarise( prop_NA = sum(is.na(Day), is.na(new_cases_per_million), is.na(new_tests_per_million), is.na(vaccination_policy) )/ (4*length(Day)) ) %>% 
  filter( prop_NA  < 0.05 )

# remove countries with too many NAs
covid_north <-
  covid_north %>%
  filter(location %in% NA_filter$location)

# countries with high regional GDP ranking
GDP_filter <- 
  data.frame(location = c("South Africa", "Morocco", "Ghana", "Cote d'Ivoire", "India", "Japan", "Saudi Arabia", "Indonesia",
                "United Kingdom", "Italy", "Russia", "Portugal", "United States", "Canada", "Mexico", "Guatemala"),
  GDPrank = rep(1:4, 4))


# keep top GDP countries by continent
covid_north <-
  covid_north %>%
  right_join(GDP_filter, by = "location")

covid_north$vaccination_policy <- as.factor(covid_north$vaccination_policy)
str(covid_north)

saveRDS(covid_north, "data/covid_north.RData")

start <- 
  covid_north %>% 
  split(.$location) %>% 
  lapply( function(x) {
    idx = which( diff(as.integer(x$vaccination_policy)) != 0 )
    x[sort(c(1L,idx +1L)), ]
  } ) %>% 
  bind_rows() %>% 
  mutate(start = Day) %>% 
  select(c(location, start, continent, vaccination_policy))

end <- 
  covid_north %>% 
  split(.$location) %>% 
  lapply( function(x) {
    idx = which( diff(as.integer(x$vaccination_policy)) != 0 )
    x[sort(c(idx, length(x$Day) )), ]
  } ) %>% 
  bind_rows() %>% 
  mutate(end = Day) %>% 
  select(c(location, end, continent, vaccination_policy))

policy <- merge(start, end)

saveRDS(policy, file = "data/policy_dates.RData")