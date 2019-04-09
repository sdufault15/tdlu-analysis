#################
# Summary Statistics
# Suzanne Dufault
# February 7, 2019
#################
library(here)

source(here("lib", "lib.R"))
dta <- read_excel(here("data","ResultsForSuzanne.xlsx"), 
                  n_max = 191) # last row is the mean of the TDLUs
view(dfSummary(dta))
mean(dta$TDLUs, na.rm = TRUE)

dta %>% 
  ggplot(aes(x = TDLUs)) + 
  geom_histogram() + 
  #stat_function(fun = dchisq, args = list(df = mean(dta$TDLUs, na.rm = TRUE)), lty = 2, col = 'gray') +
  theme_classic() +
  xlab("TDLU Counts") + 
  ylab("No. of Samples") + 
  ggtitle("Distribution of TDLUs")

epi.descriptives(dta$TDLUs)
sort(unique(dta$TDLUs), decreasing = TRUE)
