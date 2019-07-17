# Creating an R package to help process running data
usethis::create_package("runr",
                        fields = list(Title = "Functions for Runners",
                                      `Authors@R` = 'person("Christian", "Million",
                                       email = "christianmillion93@gmail.com",
                                       role = c("aut", "cre"))',
                                      Description = "Provides functions and data to make analyzing running data easier.",
                                      License = "MIT + file LICENSE"),
                        rstudio = TRUE,
                        open = TRUE)

# Add this script to the .Rbuildignore file
usethis::use_build_ignore(c("create_runr.R"))

usethis::use_git_ignore(c(".Rproj.user/",
                          ".Rproj.user",
                          ".Rhistory",
                          ".RData",
                          ".Ruserdata"))

# Use lu.R to process raw data and save to data/lu.rda
usethis::use_data_raw("conversion_table")

# Create and then edit the template README.rmd
usethis::use_readme_rmd()
usethis::use_mit_license("Christian Million")

# Create files for my functions and then add them to runr/R/
usethis::use_r("calc")      # For calculating things like pace, distance, splits, and time
usethis::use_r("convert")   # Convert between different measurements (mi, km, mi/min, km/min)
usethis::use_r("time")      # convert to seconds / format.

# Add dependencies
usethis::use_package("lubridate")
usethis::use_package("stringr")

# Document my functions by adding #', @params, and @export then:
devtools::document()

# Install Package
devtools::install()



# Create A pkgdown Website
usethis::use_pkgdown(destdir = "docs")

pkgdown::build_site()

pkgdown::preview_site()

# Template to organize reference section
pkgdown::template_reference()
