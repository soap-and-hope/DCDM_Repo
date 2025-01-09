getwd()
setwd("~/Desktop/Group5/")
data_procedure <- read.delim("IMPC_procedure.txt", header = TRUE, sep = "", check.names = TRUE)
View(data_procedure)

#Method One
install.packages("stringr")
library(stringr)
data_procedure_2 <- str_split_fixed(data_procedure$procedureId..name..description..isMandatory..impcParameterOrigId, ",", 4)
View(data_procedure_2)
colnames(data_procedure_2) <- c("name", "description", "isMandatory", "impcParameterOrigId")


#This didn't work as commas are not just separating columns but are also embedded in the texts -> can't use string split
#procedureID is entirely missing - so removed from final column names

#Method Two
process_line <- function(x) {
  comma_pos <- unlist(gregexpr(',',x));
  comma_n = length(comma_pos)
  c(trimws(substr(x,1,comma_pos[1]-1)),trimws(substr(x,comma_pos[1]+1,comma_pos[comma_n-1]-1)),trimws(substr(x,comma_pos[comma_n-1]+1,comma_pos[comma_n]-1)),trimws(substr(x,comma_pos[comma_n]+1,nchar(x))))
}

data_procedure_3 <- t(mapply(process_line,data_procedure[[2]]))
typeof(data_procedure_3)
data_procedure_3 <- as.data.frame(data_procedure_3)
names(data_procedure_3) <- c("name", "description", "isMandatory", "impcParameterOrigId")
row.names(data_procedure_3) <- NULL
View(data_procedure_3)

#For correctly formatted data frame use data_procedure_3 + Method Two script