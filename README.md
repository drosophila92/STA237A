# STA237A final project

In this project, we are planning to look at the effect of government policy responses, and in particular, vaccination policy on the spread of Covid, which is measured by # of new cases per-capita across a few selected countries. To examine the effect of vaccination policy on reducing the Covid growth, we plan to 1) build ARIMA model as the null model, 2) include the vaccination policy in the ARIMAX models (a.k.a. time series regression models) and 3) examine how much more variations are explained by introducing the vaccination policy comparing with the null ARIMA model. For both models, we will use a subset of historical data (e.g. April 2020 - Dec 2020), instead of the full range data (Jan 2020 - Nov 2021).

In addition, we will make "forecasts" for a few months after the modeling period based on ARIMA and ARIMAX models. This will allow the assessment of the model prediction accuracy by comparing model predictions with the realized data, where many other potentially contributing factors such as face covering, travel restrictions, weather conditions are also at play.
 
Data source: [Our World in Data](https://ourworldindata.org/), where the dynamic of Covid growth worldwide and government policy responses to Covid are well curated. 

# Reference
+ Hossain, Md. S., Ahmed, S., & Uddin, Md. J. (2021). Impact of weather on COVID-19 transmission in south Asian countries: An application of the ARIMAX model. The Science of the Total Environment, 761, 143315. https://doi.org/10.1016/j.scitotenv.2020.143315
+ Edward E. Time series models with covariates, and a case study of polio. 2016 April 14. Retrieved November 6, 2021, from https://ionides.github.io/531w16/notes18/notes18.html
+ Hyndman, R. J. (2010, October 4). The ARIMAX model muddle | R-bloggers. Retrieved November 6, 2021, from https://www.r-bloggers.com/2010/10/the-arimax-model-muddle

