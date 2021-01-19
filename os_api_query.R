# required packages: un-comment to install.
# install.packages("tidyverse", "httr", "jsonlite")
library(tidyverse) ; library(httr) ; library(jsonlite)

OS_PATH <- "https://api.ordnancesurvey.co.uk/places/v1/addresses/find?"

# Query the Ordnance Survey address finder API
# Accepts building number and postcode:
# returns: data table containing top match.

get_address <- function(building, postcode, api_key, failed_response="") {
  
  # build search and request strings & execute 
  building = casefold(building, upper = TRUE)
  postcode = gsub(" ", "", casefold(postcode, upper = TRUE))
  search_string <- paste(building, postcode)
  
  request <- GET(url = OS_PATH, 
                 query = list(query = search_string,
                              maxresults = 1,
                              key = api_key
                 )
  )
  
  # STOP if server response status is not 200.
  if(request$status_code != 200) 
    stop(paste("Error: Expected 200 Status response from API, received:", 
               request$status))

  response <- content(request, as = "text", encoding = "UTF-8")
  
  # Build a data frame containing the response
  req <- fromJSON(response)
  df <- req$results$DPA
  df <- add_missing_columns(df)
  
  df <- select(df, ADDRESS, BUILDING_NUMBER, BUILDING_NAME,
               SUB_BUILDING_NAME, POSTCODE)
  
  stripped_postcode = gsub(" ", "", df$POSTCODE)
  
  # check building number match
  if (!is.na(df$BUILDING_NUMBER)) {
    if (str_detect(building, df$BUILDING_NUMBER) && 
      postcode == stripped_postcode) {
      return(df$ADDRESS)
    } 
  }
  
  # check building name match
  if (!is.na(df$BUILDING_NAME)) {
    building_response <-c(df$BUILDING_NAME, df$SUB_BUILDING_NAME)
    if ((any(str_detect(building_response, building)) || 
        any(str_detect(building, building_response))) && 
        postcode == stripped_postcode) {
      return(df$ADDRESS)
    }
  }
  return(failed_response)
}

add_missing_columns <- function(data) {
  if (!"BUILDING_NUMBER" %in% colnames(data)) {data$BUILDING_NUMBER = NA}
  if (!"BUILDING_NAME" %in% colnames(data)) {data$BUILDING_NAME = NA}
  if (!"SUB_BUILDING_NAME" %in% colnames(data)) {data$SUB_BUILDING_NAME = NA}
  return(data)
}