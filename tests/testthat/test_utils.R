
library(testthat)

expect_match(sona_functions_url("url.thing.com", "GetStudy"), 
             c("https://url.thing.com/services/SonaAPI.svc/GetStudy?"))

