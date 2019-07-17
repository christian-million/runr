#' Switch between time (hh:mm:ss) and seconds
#'
#'
#'@param x numeric seconds or character time
#'
#'@return numeric or character vector
#'
#'@examples
#'
#' time_to_sec("08:30")
#'
#' sec_to_time(3700)
#'
#'@name time
#'
NULL

#' @rdname time
#' @export
time_to_sec <- function(x){

  new_x <- ifelse(nchar(x)<6, paste0('00:', x), x)

  secs <- lubridate::period_to_seconds(lubridate::hms(new_x))

  round(secs, 0)

}

#' @rdname time
#' @export
sec_to_time <- function(x){
  secs <- round(x, 0)
  time <- lubridate::seconds_to_period(secs)

  hour   <- stringr::str_pad(string = as.character(time$hour), width = 2, pad = 0)
  minute <- stringr::str_pad(string = as.character(time$minute), width = 2, pad = 0)
  second <- stringr::str_pad(string = as.character(time$second), width = 2, pad = 0)

   ifelse(time$hour < 1,
           paste(minute, second, sep = ':'),
           paste(hour, minute, second, sep = ':'))

}

