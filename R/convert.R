#' Converts distance and pace units to and from different metrics
#'
#'
#'@param x distance or pace to convert
#'@param from metric abbreviation to convert from
#'@param to metric abbreviation to convert to
#'
#'@return numeric or character vector
#'
#'@details `mi_to_km()` and `km_to_mi()` are wrappers around `convert_dist()`,
#' since those are the most commonly used running units.
#'
#'@examples
#'
#' five_k <- 5
#'
#' pace <- "08:30"
#'
#' convert_dist(five_k, from = 'km', to = 'mi')
#'
#' km_to_mi(five_k)
#'
#' convert_pace(pace, from = 'mi', to = 'km')
#'
#'@name convert
#'
NULL

#' @rdname convert
#' @export
convert_dist <- function(x, from, to){

  multiplier <- runr::conversion_table[[to]][runr::conversion_table$from == from]

  x * multiplier

}

#' @rdname convert
#' @export
mi_to_km <- function(x){

  convert_dist(x, from = "mi", to = "km")

}

#' @rdname convert
#' @export
km_to_mi <- function(x){

  convert_dist(x, from = "km", to = "mi")

}

#' @rdname convert
#' @export
convert_pace <- function(x, from, to){

  secs <- time_to_sec(x)

  multiplier <- runr::conversion_table[[to]][runr::conversion_table$from == from]

  sec_to_time(secs / multiplier)

}
