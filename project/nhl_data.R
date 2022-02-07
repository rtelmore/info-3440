## Ryan Elmore
## Get NHL Data

library(dplyr)
library(janitor)
library(readxl)
library(magrittr)

files <- list.files(path = "project/data/")

files_goalies <- files[grepl("g", files)]
df_goalies <- readxl::read_xlsx(paste("project/data/", files_goalies, sep = "")) %>% 
  janitor::clean_names()

files_skaters <- files[!grepl("g", files)]

for (i in seq_along(files_skaters)){
  dat <- readxl::read_xlsx(paste("project/data/", 
                                 files_skaters[i], sep = "")) %>% 
    janitor::clean_names() %>% 
    dplyr::mutate(s_percent = as.numeric(s_percent),
                  fow_percent = as.numeric(fow_percent))
  print(i)
  if(exists("result")){
    result <- dplyr::bind_rows(result, dat)
  } else result <- dat
}

write_csv(df_goalies, file = "project/data/goalies.csv")
write_csv(result, file = "project/data/skaters.csv")
