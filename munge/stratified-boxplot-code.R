# Stratified model plots
library(ggthemr)
library(here)
library(tidyverse)
library(gridExtra)
library(latex2exp)
ggthemr(palette = "fresh", layout = "clean")
load(here("cache", "data_stratified-models.RData"))

dta <- output$data
mod_nopih <- output$mod_nopih
mod_pih <- output$mod_pih

pred.tdlu.nopih <- predict(mod_nopih, type = "response")
pred.tdlu.pih <- predict(mod_pih, type = "response")
nopih <- dta %>%
  filter(PIH == 0)
yespih <- dta %>% 
  filter(PIH != 0)

p1 <- data.frame(pred.tdlu.nopih, t.alleles = as.factor(nopih$`T alleles`), pih = nopih$PIH) %>%
  ggplot(aes(x = t.alleles, y = pred.tdlu.nopih, col = t.alleles, fill = t.alleles)) + 
  geom_boxplot(alpha = 0.5, outlier.shape = NA) + 
  xlab("Number of T Alleles") +
  ggtitle("HDP-Negative") +
  annotate("text", x = 2:3, y = c(0,0), 
           label = c(paste("p =", round(summary(mod_nopih)$coef["`T alleles`1", 4], 3)), 
                     paste("p =", round(summary(mod_nopih)$coef["`T alleles`2", 4], 3))),
           family = "Times New Roman") + 
  theme(text = element_text(family = "Times New Roman", 
                            size = 12, 
                            colour = 'black'),
        plot.title = element_text(family = "Times New Roman",
                                  size = 14,
                                  colour = 'black',
                                  hjust = 0.5)) + 
  #ggtitle("HDP-Negative") +
  ylim(0,30) + 
  guides(fill = FALSE, col = FALSE) + 
  xlab("Number of T Alleles") +  
  ylab("Adjusted TDLU Count") 
p1

p2 <- data.frame(pred.tdlu.pih, t.alleles = as.factor(yespih$`T alleles`), pih = yespih$PIH) %>%
  ggplot(aes(x = t.alleles, y = pred.tdlu.pih, col = t.alleles, fill = t.alleles)) + 
  geom_boxplot(alpha = 0.5, outlier.shape = NA) + 
  guides(fill = FALSE, col = FALSE) + 
  ggtitle("HDP-Positive") + 
  annotate("text", x = 2:3, y = c(0,0), 
           label = c(paste("p =", round(summary(mod_pih)$coef["`T alleles`1", 4], 3)), 
                     paste("p =", round(summary(mod_pih)$coef["`T alleles`2", 4], 3))),
           family = "Times New Roman",
           colour = 'black') + 
  ylim(0,30) + 
  xlab("Number of T Alleles") + 
  ylab("Adjusted TDLU Count") +
  theme(text = element_text(family = "Times New Roman", 
                            size = 12, 
                            colour = 'black'),
        plot.title = element_text(family = "Times New Roman",
                                  size = 14,
                                  colour = 'black',
                                  hjust = 0.5)) 

p2

png(filename = "graphs/boxplots_stratified-results.png",
    #path = here("graphs"),
    height = 480*5,
    width = 75*12*5,
    res = 400,
    units = "px")
grid.arrange(arrangeGrob(
  p1, p2,
  ncol = 2, 
  top = textGrob("FIGURE 2: Box plots of adjusted TDLU counts by rs2016347 genotype stratified by HDP status",
                 gp = gpar(fontfamily = "Times New Roman",
                           fontface = "bold",
                           fontsize = 14))),
  bottom = textGrob(unname(TeX("Boxes span the adjusted TDLU count interquartile range (IQR). Whiskers span empirical range within ($Q_1-1.5*IQR, Q_3+1.5*IQR) .")),
                    gp = gpar(fontfamily = "Times New Roman",
                              fontsize = 12),
                    hjust = 0.6))#,
  
dev.off()

