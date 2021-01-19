# Demo usage file

# source The query function file
source("./os_api_query.R")

# import the secret API key
KEY <-readLines("./keyfile")

# call get_address
result <-get_address("133","SE1 8UG", KEY)
resulta <-get_address("133","SE18UG", KEY)
result1 <-get_address("Wellington House","SE1 8UG", KEY)
result1a <-get_address("Wellington House","SE18UG", KEY)
result2 <-get_address("10","SW1A 2AA", KEY)
result3 <-get_address("61","NW9 5DF", KEY)
result4 <-get_address("99","SO01 0ZZ", KEY)
result5 <-get_address("99","SO01 0ZZ", KEY, "Nothing Found")
result6 <-get_address("the meadows","SP5 1EZ", KEY, "Nothing Found")

output <- c(result,resulta,result1,result1a,
            result2,result3,result4,result5,result6)
paste(output)


a = get_address("6","RG13FF",KEY) # solve by looking at SUB_BUILDING_NAME (it's a flat number)
b = get_address("FORGE COTTAGE","CA110RD",KEY) # as previous
c = get_address("375 BUSHBURY LANE","WV108JZ",KEY) # this one is a number and a road name. Would work if you looked for building number

output2 <- c(a,b,c)
paste(output)
paste(output2)