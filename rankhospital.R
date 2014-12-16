rankhospital <- function(state, outcome, num = "best") {
  
  ## Author: Javier Samir Rey
  ## Programming Assignment 3: Hospital Quality - Part 2
  
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  ## Author: Javier Samir Rey
  ## Programming Assignment 3: Hospital Quality - Part 2
  
  infoHospitals <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  infoHospitals[, 17] <- suppressWarnings(as.numeric(infoHospitals[, 17]))
  
  
  subSetState = subset(infoHospitals, State=="TX")
  subSetState[order(subSetState[,17]),c(2,17)]
  test = subSetState[order(subSetState[,17]),c(2,17)]
  
  ranking = transform(test, rank = ave(test[,2], 
                            FUN = function(x) rank(x, ties.method = "first"))
  
}