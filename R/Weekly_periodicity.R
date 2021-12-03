if ( !require(ggplot2) )    { install.packages("ggplot2");    library(ggplot2) }
if ( !require(forecast) )    { install.packages("forecast");    library(forecast) }
if ( !require(dplyr) )    { install.packages("dplyr");    library(dplyr) }
if ( !require(ggpubr ) )   { install.packages("ggpubr");    library(ggpubr) }
if ( !require(grid) )    { install.packages("grid");    library(grid) }

covid <- readRDS("data/covid_north.RData")


covid_list <- 
  split(covid, covid$location)

arima_fit <- 
  covid_list %>% 
  lapply(function(x) auto.arima(x$new_cases_per_million))

arima_model <- 
  arima_fit %>% 
  lapply(function(x) substr( capture.output(summary(x))[2], 1, 12 ) )

arima_residual <- 
   lapply(seq_along(arima_fit), function(i) data.frame(location =  names(arima_fit)[i], residual = arima_fit[[i]]$residuals))

ariam_acf <- 
  lapply(seq_along(arima_residual), function(i){
     p <-  ggAcf(arima_residual[[i]]$residual, type = "correlation")
     p <- p +
       ggtitle(paste0(arima_residual[[i]]$location[1], ":", arima_model[i] )) +
       scale_y_continuous(name = "") + 
       scale_x_continuous(name = "", breaks = (0:5)*5 ) +
       theme_bw() +
       theme(plot.title = element_text(hjust = 0.5))

     
  })

figure2 <- ggarrange(plotlist = ariam_acf, nrow = 4, ncol = 4 )
annotate_figure( figure2, left = textGrob("Residual ACF", rot = 90, vjust = 1, gp = gpar(cex = 1.3)),
                 bottom = textGrob("Lag", gp = gpar(cex = 1.3)) )

