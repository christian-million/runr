## code to prepare `conversion_table` dataset goes here
# Load Necessary Packages
library(robotstxt)
library(rvest)
library(dplyr)
library(tidyr)
library(stringr)

# URL of Website to scrape
url <- "https://metricunitconversion.globefeed.com/length_conversion_table.asp"

# Is is acceptable to scrape this webpage?
robotstxt::paths_allowed(url)

# Read webpage and convert all tables to a dataframe
conversion_html <- url %>%
  xml2::read_html() %>%
  rvest::html_nodes("table") %>%
  rvest::html_table()

# Select the dataframe that uses Miles, not Kilometer
conversion <- conversion_html[[1]]

conversion_table <- conversion[-1,]%>%
  mutate(from = str_extract(X1, "(?<=\\().+?(?=\\))"))%>%
  select(from, X2:X10) %>%
  mutate_at(vars(X2:X10), as.numeric)

names(conversion_table) <- c("from", conversion_table$from)

usethis::use_data(conversion_table)
