# os_api_query
Using the Ordnance Survey OS PLACES API, to find and complete addresses.

## Environment
Requires installation of R environment. (Developed in R v4.0.2)  
Requires following R package dependencies to be installed:
```
install.packages("tidyverse", "httr", "jsonlite")
```

## Set up
1. Clone repo to local machine
2. in the `os-query-api` folder, create a `keyfile` document and save the OS licence key for accessing the API.

## get_address 

accepts building (number or name) and postcode and will return a full address if an exact match can be found:

`function(building, postcode, api_key, failed_response="")`

> building: building number or name,  
> postcode: postcode  
> api_key:  your API licence key  
> failed_response: (Optional) will be returned as the response string if no match is made.  Defaults to blank string.

See **example.R** file for usage examples:
