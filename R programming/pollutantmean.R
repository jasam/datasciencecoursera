pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  ## Part 1
  ## Author: Javier Samir Rey
  ## Create Date: 04/12/2014
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files

  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".

  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used

  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
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
  
  ## Calculate mean
  mean(dataFrame[,pollutant],na.rm=TRUE)
}