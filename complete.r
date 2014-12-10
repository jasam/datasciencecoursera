complete <- function(directory, pollutant, id = 1:332) {
  
  ## Part 2
  ## Author: Javier Samir Rey
  ## Create Date: 04/12/2014
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files

  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
        
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  ## List files from directory 
  files = dir(directory)
  
  ## Transform file names into number
  idsFiles = 1:332
  
  ## Select only files about parameter selected
  files = files[idsFiles %in% id]
  
  ## Load data from files selected
  dataFiles = lapply(file.path(directory,files),read.csv)
  
  ## Generate data frame from data loaded
  dataFrame = do.call(rbind.data.frame,dataFiles)
  
  nrow(na.omit(dataFrame))
  sum(complete.cases(dataFrame))
  
  df <- data.frame(x = numeric(), y = numeric())
  
  for(i in id) {
    dataFiles = lapply(file.path(directory,files[i]),read.csv)
    df <- rbind(df, data.frame(x = id, y = sum(complete.cases(dataFrame))))
  } 

  df <- data.frame(x = numeric(), y = numeric())
  df <- rbind(df, data.frame(x = 1, y = 1))
  
}