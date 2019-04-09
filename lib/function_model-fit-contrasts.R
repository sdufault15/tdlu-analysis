# Setting up contrasts for model coefficients

model_fit_fun <- function(xx, mod, term){
  
  coefs <- mod$coefficients
  contrast <- as.numeric(c(1, # intercept 
                           means$pih.mode, # PIH 
                           1, # T allele = 1
                           0, # T allele = 2
                           means$afb.mean, # AFB,
                           means$age.mean,# Age,
                           means$family.mode, # Family HX
                           means$bmi.mean, # BMI
                           means$parity.mode, # Parity
                           means$men.mean, # BMI
                           0, # Int1
                           0)) # Int2
  
  names(contrast) <- names(coefs)
  contrast.temp <- contrast
  contrast.temp[term] <- 0
  
  out <- exp(coefs[term]*xx + sum(coefs*contrast.temp))
  return(out)
}