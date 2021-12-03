if ( !require(ggplot2) )    { install.packages("ggplot2");    library(ggplot2) }
if ( !require(grid) )    { install.packages("grid");    library(grid) }
if ( !require(gtable ) )   { install.packages("gtable");    library(gtable) }
if ( !require(cowplot ) )   { install.packages("cowplot");    library(cowplot) }
if ( !require(scales ) )   { install.packages("scales");    library(scales) }
if ( !require(ggpubr ) )   { install.packages("ggpubr");    library(ggpubr) }

covid <- readRDS("data/covid_north.RData")
policy <- readRDS("data/policy_dates.RData")

p1_africa <- 
  ggplot(covid[covid$continent == "Africa",]) +
  geom_rect(aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf, fill = vaccination_policy), 
            data = policy[policy$continent == "Africa", ]) +
  geom_line(aes(Day, new_cases_per_million)) +
  scale_x_date(labels = scales::date_format("%b %Y")) +
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
  geom_line(aes(Day, new_cases_per_million)) +
  scale_x_date(labels = scales::date_format("%b %Y")) +
  scale_y_continuous(name = "New cases per million") +
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
  geom_line(aes(Day, new_cases_per_million)) +
  scale_x_date(labels = scales::date_format("%b %Y")) +
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
  geom_line(aes(Day, new_cases_per_million)) +
  scale_x_date(labels = scales::date_format("%b %Y")) +
  scale_y_continuous(name = "") +
  scale_fill_manual(values = rev(colorspace::heat_hcl(6))) + 
  facet_wrap( ~ location, scales = "free", nrow = 1 ) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
        legend.position = "bottom") +
  guides(fill = guide_legend(nrow = 1))

#p1_america

figure1 <- ggarrange(p1_africa, p1_asia, p1_europe, p1_america,
                     vjust = -1.5, nrow = 4, common.legend = TRUE, legend.grob = get_legend(p1_america) )
figure1
# 
# z1_africa <- ggplotGrob(p1_africa) # Generate a ggplot2 plot grob
# z1_africa  <- gtable_add_rows(z1_africa , unit(0.6, 'cm'), 2) # add new rows in specified position
# z1_africa  <- gtable_add_grob(z1_africa ,
#                            list(rectGrob(gp = gpar(col = NA, fill = gray(0.7))),
#                                 textGrob("Africa", gp = gpar(col = "black",cex=0.9))),
#                            t=2, l=2, b=3, r=20, name = paste(runif(2))) #add grobs into the tab
# 
# z1_asia <- ggplotGrob(p1_asia) # Generate a ggplot2 plot grob
# z1_asia <- gtable_add_rows(z1_asia, unit(0.6, 'cm'), 2) # add new rows in specified position
# z1_asia <- gtable_add_grob(z1_asia,
#                       list(rectGrob(gp = gpar(col = NA, fill = gray(0.7))),
#                            textGrob("Asia", gp = gpar(col = "black",cex=0.9))),
#                       t=2, l=2, b=3, r=20, name = paste(runif(2))) #add grobs into the tab
# 
# z1_europe <- ggplotGrob(p1_europe) # Generate a ggplot2 plot grob
# z1_europe <- gtable_add_rows(z1_europe, unit(0.6, 'cm'), 2) # add new rows in specified position
# z1_europe <- gtable_add_grob(z1_europe,
#                            list(rectGrob(gp = gpar(col = NA, fill = gray(0.7))),
#                                 textGrob("Europe", gp = gpar(col = "black",cex=0.9))),
#                            t=2, l=2, b=3, r=20, name = paste(runif(2))) #add grobs into the tab
# 
# z1_america <- ggplotGrob(p1_america) # Generate a ggplot2 plot grob
# z1_america <- gtable_add_rows(z1_america, unit(0.6, 'cm'), 2) # add new rows in specified position
# z1_america <- gtable_add_grob(z1_america,
#                            list(rectGrob(gp = gpar(col = NA, fill = gray(0.7))),
#                                 textGrob("North America", gp = gpar(col = "black",cex=0.9))),
#                            t=2, l=2, b=3, r=20, name = paste(runif(2))) #add grobs into the tab
# 
# plot_grid(z1_africa, z1_asia, z1_europe, z1_america, nrow = 4)
# 
