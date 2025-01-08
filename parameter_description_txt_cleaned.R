getwd()
setwd("~/Desktop/Group5/")
data_parameter <- read.delim("IMPC_parameter_description.txt", header = TRUE, sep = " ", check.names = TRUE)
View(data_parameter)

process_line <- function(x) {
  comma_pos <- unlist(gregexpr(',',x));
  comma_n = length(comma_pos)
  c(trimws(substr(x,1,comma_pos[1]-1)),trimws(substr(x,comma_pos[1]+1,comma_pos[comma_n-1]-1)),trimws(substr(x,comma_pos[comma_n-1]+1,comma_pos[comma_n]-1)),trimws(substr(x,comma_pos[comma_n]+1,nchar(x))))
}
data_parameter_2 <- t(mapply(process_line,data_parameter[[2]]))
typeof(data_parameter_2)
data_parameter_2<- as.data.frame(data_parameter_2, row.names = NULL, HEADER = FALSE)
View(data_parameter_2) #For some reason row.names = NULL hasn't worked 
names(data_parameter_2) <- c("impcParameterOrigId", "name", "description", "parameterId")
row.names(data_parameter_2) <- NULL
View(data_parameter_2)


#Now formatted properly,, converting NA's into just blanks 

#Check for NA's in all columns 

print(sum(is.na(data_parameter_2[3]))) #NA's are not official NA's just the string "NA" 
data_parameter_2<- as.matrix(data_parameter_2)
make_blank <- sub('NA', '', data_parameter_2)
View(make_blank)
typeof(make_blank) #[1] character - so convert to dataframe 
make_blank <- as.data.frame(make_blank)

edit_erroneous<- edit(file = "reformatted_parameter_description_2.csv", editor="xedit") #Trying to manually edit entry number row 1364 [29815]

#Save reformatted data table as a csv file
write.csv(make_blank, file = "reformatted_parameter_description_2.csv")
#make_blank is the final formatted matrix


checking_blanks <- function(x){
  sum(make_blank[,x] == "")
}

print(checking_blanks(3)) #Checking for total blanks in the third columnn


print(max(nchar(make_blank$name))) #[1] 300
print(max(nchar(make_blank$description))) #[1] 110
print(max(nchar(make_blank$parameterId))) #[1] 16 

line
