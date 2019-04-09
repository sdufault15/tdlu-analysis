# Adds a CI

ci_fun <- function(tab){
  temp <- tab %>%
    mutate(`IRR (95% CI)` = paste0(round(IRR, 3), " (", format(round(CI.lb, 3), nsmall = 3), ", ", format(round(CI.ub,3), nsmall = 3), ")")) %>%
    dplyr::select(Coefficient, `Standard Error`, `Z Value`, `p-value`, `IRR (95% CI)`)
  rownames(temp) <- gsub("PIH", "HDP", rownames(tab))
  return(temp)
}