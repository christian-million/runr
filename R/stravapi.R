#' Create Strava API Token
#'
#'
#'
#'@export
create_token <- function(app_name, client_id, client_secret, scope = "public", cache = FALSE){
  app <- httr::oauth_app(appname = app_name,
                         key = client_id,
                         secret = client_secret)
  end_point <- httr::oauth_endpoint(request = "https://www.strava.com/oauth/authorize?",
                                    authorize = "https://www.strava.com/oauth/authorize",
                                    access = "https://www.strava.com/oauth/token")
  httr::oauth2.0_token(endpoint = end_point, app = app, scope = scope, cache = cache)
}

#' Calls the Strava API
#'
#'
#'@export
stravapi <- function(path, ...){

  url <- httr::modify_url("https://www.strava.com/", path = paste0("api/v3/", path))

  resp <- httr::GET(url, ...)

  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- httr::content(resp, as = 'parsed')

  return(parsed)

}

#' Get Runs by Dates
#'
#'
#'
#'@export
get_runs <- function(from, to = Sys.time(), token){

ids <- get_run_ids(from, to, token)
paths <- paste0("activities/", ids)

  if(length(paths) == 1){
    out <- list(stravapi(paths, token))
  } else {
    out <- lapply(paths, stravapi, token)
  }
return(out)
}

#' Get Run ID's by Date
#'
#'
#'
#'@export
get_run_ids <- function(from, to = Sys.time(), token){
  after = as.integer(as.POSIXct(from))
  before = as.integer(as.POSIXct(to))

  out <- stravapi("athlete/activities/", token, query = list(before = before,
                                                after = after))

  parsed_data <- sapply(out, function(x)x[["id"]])
  parsed_data
}


#' Helper Function
#'
#'
#'@export
df_rbind <- function(x, y){
  rbind(as.data.frame(x), as.data.frame(y))
}

#' Convert Strava API return to data.frame
#'
#'
#'
#'@export
act_to_df <- function(x){

  to_df <- function(x){

    splits_df <- Reduce(df_rbind, x[["splits_standard"]])

    overall_df <- data.frame(x[c('distance', 'elapsed_time', 'moving_time', 'start_date_local', 'calories')],
                             splits = I(list(splits_df)),
                             stringsAsFactors = FALSE)
    overall_df
  }

 acts <- lapply(x, to_df)

 Reduce(df_rbind, acts)

}
