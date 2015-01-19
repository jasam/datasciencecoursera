corr <- function(directory, threshold = 0) {
  ## Part 3
  ## Author: Javier Samir Rey
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations

  files = dir(directory)
  numberFiles = 1:332

  ##Correlations for observations with threshold success
  correlations <- numeric()

  for(i in numberFiles) {
    dataFiles = lapply(file.path(directory,files[i]),read.csv)
    dataFrame = do.call(rbind.data.frame,dataFiles)
    completeCases <- dataFrame[complete.cases(dataFrame),]
    countWithThresHold <- nrow(completeCases)
  
    if (countWithThresHold > threshold){
      nitrateValues <- completeCases["nitrate"]
      sulfateValues <- completeCases["sulfate"]
      correlation <- cor(nitrateValues,sulfateValues)
      correlations <- c(correlations, correlation)
    }
  
  }
  correlations
}
