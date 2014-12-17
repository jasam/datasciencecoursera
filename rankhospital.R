rankhospital <- function(state, outcome, num = "best") {
  
  ## Author: Javier Samir Rey
  ## Programming Assignment 3: Hospital Quality - Part 2
  
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
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
  
  ## Only state selected
  subSetState = subset(infoHospitals, State==state)
  
  ## Order sub set for after ranking, column 2 = name hospital
  
  if (outcome == "heart failure"){
    ranking = subSetState[order(subSetState[,2], subSetState[,17]),c(2,17)]  
  } 
  
  if (outcome == "heart attack"){
    ranking = subSetState[order(subSetState[,2], subSetState[,11]),c(2,11)]  
  } 
  
  if (outcome == "pneumonia"){
    ranking = subSetState[order(subSetState[,2], subSetState[,23]),c(2,23)] 
  }
  
  ## ADD ranking like other column to data frame
  ranking = transform(ranking, rank = ave(ranking[,2], 
                                          FUN = function(x) rank(x, ties.method = "first")))
  
  ranking = ranking[order(ranking[,3]),c(1,2,3)]
  
  HEAD_VALUE = 1
  
  if (num == "best") {
    hospitalRank = ranking[ranking$rank == HEAD_VALUE, c(1)] 
  }
  
  else if (num == "worst") {
    ## Complete cases only
    ranking =  ranking[complete.cases(ranking),]
    tailRank = tail(ranking[3], n=1)
    hospitalRank = ranking[ranking$rank == tailRank[,1], c(1)] 
  }
  
  else {
    hospitalRank = ranking[ranking$rank == num, c(1)] 
  }
  
  ## Return NA if result not available
  
  if (length(hospitalRank) == 0) {
      NA
  }
  
  else {
      hospitalRank
  }
  
}