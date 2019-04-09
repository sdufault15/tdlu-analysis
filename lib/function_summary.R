# Adds IRR values to table

summary_function <- function(model){
  temp <- summary(model)
  temp2 <- data.frame(temp$coef) %>%
    mutate(irr = exp(temp$coef[,1]),
           ci.lb = exp(temp$coef[,1] - 1.96*temp$coef[,2]),
           ci.ub = exp(temp$coef[,1] + 1.96*temp$coef[,2]))
  
  names(temp2) <- c("Coefficient", "Standard Error", "Z Value", "p-value", "IRR", "CI.lb", "CI.ub")
  rownames(temp2) <- rownames(temp$coef)
  return(temp2)
}