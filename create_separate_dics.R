library(tidyverse)

#make fixes to datadic
datadic <- read_csv('KSADS_ML_Applet/data_dic_old.csv')

#change all dropdown to radio
datadic <- datadic %>%
  mutate(`Field Type` = ifelse(`Field Type` == 'dropdown', 'radio', `Field Type`),
         #attach section header as h3 in question field
         `Field Label` = ifelse(!is.na(`Section Header`) & nchar(`Section Header`) > 1, paste0("### ", `Section Header`, "\\r\\n\\r\\n", `Field Label`), `Field Label`)) %>%
  rename(`Section Header (defunct)` = `Section Header`) %>%
  #add autoadvance to missed radio buttons, turn 'descriptive' into 'markdown-message'
  mutate(`Allow` = ifelse(`Field Type` == 'radio' & is.na(multipleChoice) & is.na(`Allow`), 'autoAdvance', `Allow`),
         `Field Type` = ifelse(`Field Type` == 'descriptive', 'markdown-message', `Field Type`)) %>%
  #get rid of single quotes in conditional logic
  mutate(`Branching Logic (Show field only if...)` = str_replace_all(`Branching Logic (Show field only if...)`, "\'", ""))


#change all NA in the write_csv to '"
write_csv(datadic, 'KSADS_ML_Applet/data_dic.csv', na = '')


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
#write_csv(separate_data_dic$timeline, 'KSADS-timeline/data_dic.csv')
#file.copy('KSADS_ML_Applet/convert.js', 'KSADS-timeline/convert.js')

#create the all the repos

#loop through the filter and copy process

#change display name and description and run the node 

for (i in activity_names) {
  
  write_csv(separate_data_dic[[i]], paste0('KSADS-', i, '/data_dic.csv'), na = '')
  #file.copy('KSADS-timeline/convert.js', paste0('KSADS-', i, '/convert.js'))
  
} 


for (i in activity_names) {
  
  print(paste0('https://raw.githubusercontent.com/hotavocado/KSADS-', i, '/main/protocols/KSADS_', i, '/KSADS_', i, '_schema'))

}



#rerun code to save all datadic
#rerun the node file
#re push to github
#readd the first several applets, and refresh the others.

