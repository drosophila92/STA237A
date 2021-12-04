if ( !require(ggplot2) )    { install.packages("ggplot2");    library(ggplot2) }
if ( !require(grid) )    { install.packages("grid");    library(grid) }
if ( !require(gtable ) )   { install.packages("gtable");    library(gtable) }
if ( !require(cowplot ) )   { install.packages("cowplot");    library(cowplot) }
if ( !require(scales ) )   { install.packages("scales");    library(scales) }
if ( !require(ggpubr ) )   { install.packages("ggpubr");    library(ggpubr) }

covid <- readRDS("data/covid_north_weekly.RData")
policy <- readRDS("data/policy_weekly_dates.RData")

p1_africa <- 
  ggplot(covid[covid$continent == "Africa",]) +
  geom_rect(aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf, fill = vaccination_policy), 
            data = policy[policy$continent == "Africa", ]) +
  geom_line(aes(Start_date, adjusted_weekly_cases_per_million)) +
  scale_x_date(name = "", labels = scales::date_format("%b %Y")) +
  scale_y_continuous(name = "") +
  scale_fill_manual(values = rev(colorspace::heat_hcl(6))) + 
  facet_wrap( ~ location, scales = "free", nrow = 1 ) +
  theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_text(angle = 45, vjust = 0.5), 
        legend.position = "none")
#p1_africa


p1_asia <- 
  ggplot(covid[covid$continent == "Asia",]) +
  geom_rect(aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf, fill = vaccination_policy), 
            data = policy[policy$continent == "Asia", ]) +
  geom_line(aes(Start_date, adjusted_weekly_cases_per_million)) +
  scale_x_date(name = "", labels = scales::date_format("%b %Y")) +
  scale_y_continuous(name = "") +
  scale_fill_manual(values = rev(colorspace::heat_hcl(6))) + 
  facet_wrap( ~ location, scales = "free", nrow = 1 ) +
  theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_text(angle = 45, vjust = 0.5), 
        legend.position = "none")
#p1_asia

p1_europe <- 
  ggplot(covid[covid$continent == "Europe",]) +
  geom_rect(aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf, fill = vaccination_policy), 
            data = policy[policy$continent == "Europe", ]) +
  geom_line(aes(Start_date, adjusted_weekly_cases_per_million)) +
  scale_x_date(name = "", labels = scales::date_format("%b %Y")) +
  scale_y_continuous(name = "") +
  scale_fill_manual(values = rev(colorspace::heat_hcl(6))) + 
  facet_wrap( ~ location, scales = "free", nrow = 1 ) +
  theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_text(angle = 45, vjust = 0.5), 
        legend.position = "none")
#p1_europe

p1_america <- 
  ggplot(covid[covid$continent == "North America",]) +
  geom_rect(aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf, fill = vaccination_policy), 
            data = policy[policy$continent == "North America", ]) +
  geom_line(aes(Start_date, adjusted_weekly_cases_per_million)) +
  scale_x_date(name = "", labels = scales::date_format("%b %Y")) +
  scale_y_continuous(name = "") +
  scale_fill_manual(values = rev(colorspace::heat_hcl(6))) + 
  facet_wrap( ~ location, scales = "free", nrow = 1 ) +
  theme_bw() +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_text(angle = 45, vjust = 0.5),
        legend.position = "bottom") +
  guides(fill = guide_legend(nrow = 1))

#p1_america

figure1 <- ggarrange(p1_africa, p1_asia, p1_europe, p1_america,
                     vjust = -1.5, nrow = 4, common.legend = TRUE, legend.grob = get_legend(p1_america) )
annotate_figure( figure1, left = textGrob("New cases per million", rot = 90, vjust = 1, gp = gpar(cex = 1.3)),
                 bottom = textGrob("Start_date", gp = gpar(cex = 1.3))  )
