best = function(state, outcome) {
  
  ## Part 2
  ## Author: Javier Samir Rey
  ## Programming Assignment 3: Hospital Quality - Part 1
  
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  infoHospitals <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  infoHospitals[, 11] <- suppressWarnings(as.numeric(infoHospitals[, 11]))
  infoHospitals[, 17] <- suppressWarnings(as.numeric(infoHospitals[, 17]))
  infoHospitals[, 23] <- suppressWarnings(as.numeric(infoHospitals[, 23]))
  
  # Is a valid state
  validState = state %in% unique(infoHospitals[,7])
  
  if (!validState) {
    stop("invalid state")
  }
  
  observations <- data.frame(observation = character())
  observations <- rbind(observations, data.frame(observation = "heart failure"))
  observations <- rbind(observations, data.frame(observation = "heart attack"))
  observations <- rbind(observations, data.frame(observation = "pneumonia"))
  
  # Is a valid outcome
  validOutCome = outcome %in% observations[,1]
  
  if (!validOutCome){
    stop("invalid outcome")
  }
  
  # Sub set states'
  subSetState = subset(infoHospitals, State==state)
  
  # Eval sun seb and min , for outcome
  if (outcome == "heart failure"){
    dataResult = subset(infoHospitals, (State==state & infoHospitals[,17] == min(subSetState[,17], na.rm = TRUE)))  
  } 
  
  if (outcome == "heart attack"){
    dataResult = subset(infoHospitals, (State==state & infoHospitals[,11] == min(subSetState[,11], na.rm = TRUE)))  
  } 
  
  if (outcome == "pneumonia"){
    dataResult = subset(infoHospitals, (State==state & infoHospitals[,23] == min(subSetState[,23], na.rm = TRUE)))  
  }
  
  bestHospital = dataResult[,2]
  bestHospital
}

