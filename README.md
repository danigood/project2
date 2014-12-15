project2
========
#create an empty plate
plate <- matrix(data=NA, nrow=8, ncol=12)
plate <- as.table(plate)
colnames(plate) <- 1:12

#make function to fill the table according to specific instructions
fill.plate <- function() {
std <- readline("Will there be standards (Answer Y or N)? ")
if(std=="Y"){
   num.std <- readline("How many standards will there be? ")
   rep.std <- readline("How many times will the standards be replicated? ")
} else {
   num.std == 0
   rep.std == 0 
   }

}#end
