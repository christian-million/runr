#' Calculate Pace, Time, Distance, and Splits
#'
#'@description  Inspired by https://davidrroberts.wordpress.com/2016/04/04/running-pace-and-time-calculator-function-for-r/
#'
#'@param distance numeric distance traveled (Units irrelavant)
#'@param time character time vector "hh:mm:ss" or "mms:ss"
#'@param pace character pace vector "hh:mm:ss" or "mms:ss"
#'
#'@return `calc_pace()` and `calc_time()` return character vectors.
#'`calc_distance()` returns a numeric vector. `calc_splits()` return a data.frame.
#'
#'@examples
#'
#' dist <- 26.2
#'
#' pace <- "08:01"
#'
#' time <- "03:30:00"
#'
#' calc_time(dist, pace)
#' calc_pace(dist, time)
#' calc_dist(time, pace)
#' calc_splits(dist, time)
#'@name calc
#'
NULL

#' @rdname calc
#' @export
calc_pace <- function(distance, time){

  secs <- time_to_sec(time)
  pace <- secs / distance
  sec_to_time(pace)

}

#' @rdname calc
#' @export
calc_splits <- function(distance, time){

  splits <- data.frame(distance = unique(c(1:floor(distance), distance)))

  pace <- time_to_sec(calc_pace(distance, time))

  splits$sec <- splits$distance * pace

  splits$splits <- sec_to_time(splits$sec)

  splits[c('distance', 'splits')]

}

#' @rdname calc
#' @export
calc_time <- function(distance, pace){

  time <- time_to_sec(pace) * distance

  sec_to_time(time)

}

#' @rdname calc
#' @export
calc_dist <- function(time, pace){

  secs <- time_to_sec(time)

  speed <- time_to_sec(pace)

  dist <- secs / speed

  dist
}
