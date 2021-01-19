# Demo usage file

# source The query function file
source("./os_api_query.R")

# import the secret API key
KEY <-readLines("./keyfile")

# call get_address
result <-get_address("133","SE1 8UG", KEY)
result1 <-get_address("Wellington House","SE1 8UG", KEY)
result2 <-get_address("10","SW1A 2AA", KEY)
result3 <-get_address("61","NW9 5DF", KEY)
result4 <-get_address("99","SO01 0ZZ", KEY)
result5 <-get_address("99","SO01 0ZZ", KEY, "Nothing Found")
result6 <-get_address("the meadows","SP5 1EZ", KEY, "Nothing Found")

output <- c(result,result1,result2,result3,result4,result5,result6)
paste(output)




