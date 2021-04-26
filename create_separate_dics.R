library(tidyverse)

datadic <- read_csv('data_dic.csv')

activity_names <- unique(datadic$`Form Name`)

separate_dataset <- function(x) {
  
  data = filter(datadic, `Form Name` == x)
  return(data)
  
}

separate_data_dic <- map(activity_names, separate_dataset)

look <- separate_data_dic[[1]]

names(separate_data_dic) <- activity_names

separate_data_dic$timeline

setwd('/Users/mike.xiao/Documents/GitHub/')

#timeline section
write_csv(separate_data_dic$timeline, 'KSADS-timeline/data_dic.csv')
file.copy('KSADS_ML_Applet/convert.js', 'KSADS-timeline/convert.js')
