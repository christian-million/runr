
<!-- README.md is generated from README.Rmd. Please edit that file -->

# runr

<!-- badges: start -->

<!-- badges: end -->

The goal of runr is to make working with running data easier.

## Installation

You can install the development version of runr from
[Github](https://github.com/christian-million/runr) with:

``` r
# install.packages("remotes")

remotes::install_github("christian-million/runr")
```

## Example

To see how I used these functions to prepare for the 2019 California
International Marathon, check out [my blog
posts](https://christianmillion.com/post/running/cim-2019-prep/).

``` r
# Load the package
library(runr)
```

Let’s say I am preparing to run a marathon, and I want to see how fast I
would need to run to hit my goals. First, let’s set some goals:

``` r
 # Setting Goals for Exemplary Purposes
 goal_dist <- 26.2       # Marathon distance in miles
 
 goal_pace <- "08:01"    # Pace in minutes per mile

 goal_time <- "03:30:00" # Total time in hours, minutes, and seconds.
```

``` r
 calc_time(goal_dist, goal_pace) # See below section for why runr isn't perfectly precise right now.
#> [1] "03:30:02"
 calc_pace(goal_dist, goal_time)
#> [1] "08:01"
 calc_dist(goal_time, goal_pace)
#> [1] 26.19543
```

Now that I know my goal time, let’s see how long into the race I should
be at during each mile.

``` r
 calc_splits(goal_dist, goal_time)
#>    distance   splits
#> 1       1.0    08:01
#> 2       2.0    16:02
#> 3       3.0    24:03
#> 4       4.0    32:04
#> 5       5.0    40:05
#> 6       6.0    48:06
#> 7       7.0    56:07
#> 8       8.0 01:04:08
#> 9       9.0 01:12:09
#> 10     10.0 01:20:10
#> 11     11.0 01:28:11
#> 12     12.0 01:36:12
#> 13     13.0 01:44:13
#> 14     14.0 01:52:14
#> 15     15.0 02:00:15
#> 16     16.0 02:08:16
#> 17     17.0 02:16:17
#> 18     18.0 02:24:18
#> 19     19.0 02:32:19
#> 20     20.0 02:40:20
#> 21     21.0 02:48:21
#> 22     22.0 02:56:22
#> 23     23.0 03:04:23
#> 24     24.0 03:12:24
#> 25     25.0 03:20:25
#> 26     26.0 03:28:26
#> 27     26.2 03:30:02
```

We haven’t formally told any of these functions that I am counting miles
and not kilometers. I’m just more used to minute-per-mile pacing. But
what if I wanted to know what my marathon training stats in kilometers?

``` r
goal_dist_km <- mi_to_km(goal_dist) # A wrapper around `convert_dist()`
  
goal_pace_km <- convert_pace(goal_pace, from = "mi", to = "km")

goal_dist_km
#> [1] 42.16481
goal_pace_km
#> [1] "04:59"
```

## Current State and Future Plans

Currently, `runr` is not very precise due to the amount of rounding
errors. The rounding errors were a quick fix for pretty printing. For
now, this is okay, though I would eventually prefer it to be even more
precise.

Currently `runr` really only has functionality to plan theoretical runs.
In the future, I am hoping that it will work with real-world running
data.

There are dependencies on `stringr` and `lubridate`.

  - The only reason that `stringr` is a dependency is because of
    `stringr::str_pad`. I tried some alternatives, like `sprintf()`, but
    depending on my inputs I kept getting errors. I’m hoping to remove
    the `stringr` dependency, as it seems unnecessary. I’ll keep working
    on a pad function that I am happy with.

  - I am okay with the `lubridate` dependency, even though the functions
    used could be replaced with base functions, because in the future I
    imagine there will be more need to rely on it. If not, though, I’ll
    practice base r by creating base equivalents.

## Feedback and Issues

I’m trying to become more familiar with Github’s collaboration tools, so
feel free to submit an issue or pull request.

Any and all feedback is welcome.
