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
    
    validState = state %in% unique(infoHospitals[,7])
    
    states = unique(infoHospitals[,7])
    
    rankingAll <- data.frame(hospital = character(), state = character())ñ
    
    HEAD_VALUE = 1
    
    for (i in states){
        print(i)
        subSetState = subset(infoHospitals, State==i)
        ranking = subSetState[order(subSetState[,2], subSetState[,11]),c(2,11)] 
        
        ranking = transform(ranking, rank = ave(ranking[,2], 
                                                FUN = function(x) rank(x, ties.method = "first")))
        
        ranking = ranking[order(ranking[,3]),c(1,2,3)]
        
        hospitalRank = ranking[ranking$rank == 20, c(1)]
        
        rankingAll <- rbind(rankingAll, data.frame(hospital = hospitalRank, state = i))
        
    }
}