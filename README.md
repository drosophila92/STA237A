# STA237A final project

In this project, we are planning to look at the effect of government policy responses, and in particular, vaccination policy on the spread of Covid, which is measured by # of new cases per-capita across a few selected countries. To examine the effect of vaccination policy on reducing the Covid growth, we plan to 1) build ARIMA model as the null model, 2) include the vaccination policy in the ARIMAX models (a.k.a. time series regression models) and 3) examine how much more variations are explained by introducing the vaccination policy comparing with the null ARIMA model. For both models, we will use a subset of historical data (e.g. April 2020 - Dec 2020), instead of the full range data (Jan 2020 - Nov 2021).

In addition, we will make "forecasts" for a few months after the modeling period based on ARIMA and ARIMAX models. This will allow the assessment of the model prediction accuracy by comparing model predictions with the realized data, where many other potentially contributing factors such as face covering, travel restrictions, weather conditions are also at play.
 
Data source: [Our World in Data](https://ourworldindata.org/), where the dynamic of Covid growth worldwide and government policy responses to Covid are well curated. 

To keep track of our latest project progress, check the [project report](https://docs.google.com/document/d/1mLVGCqgoFnD9lBLHMLsJCH9e5bdnuzaUxqxj2XuNoJ4/edit?usp=sharing) and [presentation slides](https://docs.google.com/presentation/d/1vkR1hbfJ4n93x9V6-DSgULi_Gs2n-iIjJObrVRvfapo/edit?usp=sharing).

# Reference
+ Hossain, Md. S., Ahmed, S., & Uddin, Md. J. (2021). Impact of weather on COVID-19 transmission in south Asian countries: An application of the ARIMAX model. The Science of the Total Environment, 761, 143315. https://doi.org/10.1016/j.scitotenv.2020.143315
+ Edward E. Time series models with covariates, and a case study of polio. 2016 April 14. Retrieved November 6, 2021, from https://ionides.github.io/531w16/notes18/notes18.html
+ Hyndman, R. J. (2010, October 4). The ARIMAX model muddle | R-bloggers. Retrieved November 6, 2021, from https://www.r-bloggers.com/2010/10/the-arimax-model-muddle

Main text for project report for collaboration and review:
