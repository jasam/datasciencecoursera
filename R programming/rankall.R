rankall <- function(outcome, num = "best") {
    
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    infoHospitals <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    infoHospitals[, 11] <- suppressWarnings(as.numeric(infoHospitals[, 11]))
    infoHospitals[, 17] <- suppressWarnings(as.numeric(infoHospitals[, 17]))
    infoHospitals[, 23] <- suppressWarnings(as.numeric(infoHospitals[, 23]))
    
    observations <- data.frame(observation = character())
    observations <- rbind(observations, data.frame(observation = "heart failure"))
    observations <- rbind(observations, data.frame(observation = "heart attack"))
    observations <- rbind(observations, data.frame(observation = "pneumonia"))
    
    ## Is a valid outcome
    validOutCome = outcome %in% observations[,1]
    
    if (!validOutCome){
        stop("invalid outcome")
    }
    
    ## Order States
    states = sort(unique(infoHospitals[,7]))
    
    rankingAll <- data.frame(hospital = character(), state = character())
    
    HEAD_VALUE = 1
    
    for (i in states) {
        subSetState = subset(infoHospitals, State==i)
        
        if (outcome == "heart failure"){
            ranking = subSetState[order(subSetState[,2], subSetState[,17]),c(2,17)]  
        } 
        
        if (outcome == "heart attack"){
            ranking = subSetState[order(subSetState[,2], subSetState[,11]),c(2,11)]  
        } 
        
        if (outcome == "pneumonia"){
            ranking = subSetState[order(subSetState[,2], subSetState[,23]),c(2,23)] 
        }
        
        ranking = transform(ranking, rank = ave(ranking[,2], 
                                                FUN = function(x) rank(x, ties.method = "first")))
        
        ranking = ranking[order(ranking[,3]),c(1,2,3)]
        
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
        
        
        if (length(hospitalRank) == 0) {
            rankingAll <- rbind(rankingAll, data.frame(hospital = NA, state = i))
            
        }
        
        else {
            
            rankingAll <- rbind(rankingAll, data.frame(hospital = hospitalRank, state = i))
        }              
        
    }
    
    rankingAll
}