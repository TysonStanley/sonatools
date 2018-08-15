

sona_url <- function(main_url){

  main_url <- stringr::str_remove(main_url, "/$")

  if (isFALSE(stringr::str_detect(main_url, "https://"))){
    main_url <- paste0("https://", main_url)
  }

  api_url <- paste0(main_url, "/services/SonaAPI.svc")
  api_url

}

sona_functions_url <- function(main_url, fun){

  api_url <- sona_url(main_url)
  fun_url <- paste0(api_url, "/", fun, "?")

  fun_url

}


sona_url_set_up <- function(api_url, active, approved, web_flag, survey_flag){

  ## Get secrets
  username_password <- sona_get_secrets()
  username <- username_password[1]
  password <- username_password[2]

  ## Parse and build the full url with the query
  request_url <- httr::parse_url(api_url)
  request_url$username <- username
  request_url$password <- password
  request_url$query <- list(active = active,
                            approved = approved,
                            web_flag = web_flag,
                            survey_flag = survey_flag)
  request_url <- httr::build_url(request_url)

  ## Request the url
  request <- httr::GET(request_url)
  request

}



## from devtools
github_error <- function(req) {
  text <- httr::content(req, as = "text", encoding = "UTF-8")
  parsed <- tryCatch(jsonlite::fromJSON(text, simplifyVector = FALSE),
                     error = function(e) {
                       list(message = text)
                     })
  errors <- vapply(parsed$errors, `[[`, "message", FUN.VALUE = character(1))

  structure(
    list(
      call = sys.call(-1),
      message = paste0(parsed$message, " (", httr::status_code(req), ")\n",
                       if (length(errors) > 0) {
                         paste("* ", errors, collapse = "\n")
                       })
    ), class = c("condition", "error", "github_error"))
}

## From tidyverse package
text_col <- function(x) {
  # If RStudio not available, messages already printed in black
  if (!rstudioapi::isAvailable()) {
    return(x)
  }
  
  if (!rstudioapi::hasFun("getThemeInfo")) {
    return(x)
  }
  
  theme <- rstudioapi::getThemeInfo()
  
  if (isTRUE(theme$dark)) crayon::white(x) else crayon::black(x)
  
}

sonatools_version <- function(x) {
  version <- as.character(unclass(utils::packageVersion(x))[[1]])
  crayon::italic(paste0(version, collapse = "."))
}

search_conflicts <- function(path = search()){
  
  ## Search for conflicts
  confs <- conflicts(path,TRUE)
  ## Grab those with the sonatools package
  sonatools_conflicts <- confs$`package:sonatools`
  
  ## Find which packages have those functions that are conflicted
  if (length(sonatools_conflicts) != 0){
    other_conflicts <- list()
    for (i in sonatools_conflicts){
      other_conflicts[[i]] <- lapply(confs, function(x) any(grepl(i, x))) %>%
        do.call("rbind", .) %>%
        data.frame %>%
        setNames(c("conflicted")) %>%
        tibble::rownames_to_column() %>%
        .[.$conflicted == TRUE &
            .$rowname != "package:sonatools",]
    }
  } else {
    other_conflicts <- data.frame()
  }
  other_conflicts
}



