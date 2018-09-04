#' Access The Study List
#'
#' Retrieves the list of studies in the system based on study type.
#'
#'
#' @param main_url main URL of the sona system you are using
#' @param active should all studies be included (-1), just the active ones (1), or just the inactive ones (0)
#' @param approved should all studies be included (-1), just the approved ones (1), or just the un-approved ones (0)
#' @param web_flag should all studies be included (-1), just the web ones (1), or just the lab ones (0)
#' @param survey_flag should all studies be included (-1), just the online surveys ones (1), or all non-online survey ones (0)
#'
#' @importFrom stats setNames
#'
#' @export
sona_getstudy <- function(main_url = "https://usu.sona-systems.com", active = -1, approved = -1, web_flag = -1, survey_flag = -1){

  ## Initial url
  api_url <- sona_functions_url(main_url, fun = "GetStudyList")
  request <- sona_url_set_up(api_url, active, approved, web_flag, survey_flag)

  ## Error Check
  if (httr::status_code(request) >= 400) {
    stop(github_error(request))
  }

  request

}



"GetParticipantStats" ## page 34
"GetStudyStats" ## page 35
"ActivateUser" ## page 45
"DeactivateUser" ## page 46



