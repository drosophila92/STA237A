# STA237A
STA237A final project

In this project, we are planning to look at the effect of government policy responses, and in particular, vaccination policy on the spread of Covid, which is measured by # of new cases per-capita across a few selected countries. To examing the (partial) effect of vaccination policy on reducing the Covid growth while controlling the potential effects from other government actions (face covering, travel restrictions etc.), we plan to build ARIMAX models (a.k.a. time series regression models with covariates).

Beyond drawing statistical associations between vaccination policy and covid infection rate, we plan to derive a cause and effect relationships between these two variables, thus entailing modeling the potential outcomes. To this end, instead of using the full-range of data (Jan 2020 - Nov 2021), we will build ARIMAX models based on a subset of historical data (e.g. April 2020 - Dec 2020), so that we could pretend as if we traveled a few months back and live in a parallel world where there was no government guidance on vaccination. In this hypothetical setting, we were able to make "forecasts" for a few months, and compare with the realized data when vaccination is in place.


Data source: [Our World in Data](https://ourworldindata.org/), where the dynamic of Covid growth worldwide and government policy responses to Covid are well curated. 

# Referece
+ Hossain MS, Ahmed S, Uddin MJ. Impact of weather on COVID-19 transmission in south Asian countries: An application of the ARIMAX model. Sci Total Environ. 2021 Mar 20;761:143315. doi: 10.1016/j.scitotenv.2020.143315. Epub 2020 Nov 2. PMID: 33162141; PMCID: PMC7605795.
+ Edward E. Time series models with covariates, and a case study of polio. 2016 April 14. https://ionides.github.io/531w16/notes18/notes18.html
