#' Securely Set Username and Password
#'
#' Securely tell R what your username and password is by calling this function once.
#' It saves the information in a hidden file (.Rprofile). sona_get_secrets() then
#' looks in this file for your information so that you can share code without
#' accidentally sharing private information.
#'
#' @param username your administrator username for SONA-Systems
#' @param password your administrator password for SONA-Systems tied to the username
#'
#' @export
sona_set_secrets <- function(username, password){

  Sys.setenv(SONA_username = username,
             SONA_password = password)

}

#' Delete Username and Password from .Rprofile
#'
#' Remove the information from .Rprofile that were set in sona_set_secrets().
#'
#'
#' @export
sona_unset_secrets <- function(){

  Sys.unsetenv("SONA_username")
  Sys.unsetenv("SONA_password")

}

#' Get Username and Password from .Rprofile
#'
#' View the username and password you set up via sona_set_secrets(). Mainly an internal
#' function.
#'
#' @export
sona_get_secrets <- function(){
  username <- Sys.getenv("SONA_username")
  password <- Sys.getenv("SONA_password")

  c(username, password)
}

sona_set_secrets("tim", "U!M34")
sona_get_secrets()
sona_unset_secrets()
