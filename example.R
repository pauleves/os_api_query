# Demo usage file

# source The query function file
source("./os_api_query.R")

# import the secret API key
KEY <-readLines("./keyfile")

# call get_address
result <- c(get_address("133","SE1 8UG", KEY),
            get_address("133","SE18UG", KEY),
            get_address("Wellington House","SE1 8UG", KEY),
            get_address("Wellington House","SE18UG", KEY),
            get_address("10","SW1A 2AA", KEY),
            get_address("61","NW9 5DF", KEY),
            get_address("99","SO01 0ZZ", KEY), # should return a blank string
            get_address("99","SO01 0ZZ", KEY, "Nothing Found"),
            get_address("the meadows","SP5 1EZ", KEY, "Nothing Found")
            )

paste(result)
