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
  postcode = casefold(postcode, upper = TRUE)
  search_string <- paste(building, postcode)
  
  request <- GET(url = OS_PATH, 
                 query = list(query = search_string,
                              maxresults = 1,
                              key = api_key
                 )
  )
  
  # request$status_code
  response <- content(request, as = "text", encoding = "UTF-8")
  
  # Build a data frame containing the response
  req <- fromJSON(response)
  df <- req$results$DPA

  if (!"BUILDING_NUMBER" %in% colnames(df)) {df$BUILDING_NUMBER = ""}
  if (!"BUILDING_NAME" %in% colnames(df)) {df$BUILDING_NAME = ""}
  
  df <- select(df, ADDRESS, BUILDING_NUMBER, BUILDING_NAME, POSTCODE)
  
  if (df$BUILDING_NUMBER != "") {
    # generate checksum to validate against and check response
    checksum = paste(df$BUILDING_NUMBER, df$POSTCODE)
    if (checksum == search_string) {
      return(df$ADDRESS)
    } 
  }
  
  if (df$BUILDING_NAME != "") {
    if (str_detect(df$BUILDING_NAME, building) == TRUE && 
        postcode == df$POSTCODE) {
      return(df$ADDRESS)
    }
  }
  return(failed_response)
}