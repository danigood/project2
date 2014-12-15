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
   num.std <- as.numeric(num.std)
   start.std <- readline("What is the lowest stardard value? ")
   start.std <- as.numeric(start.std)
   mul.std <- readline("What is the multiplication factor between standards? ")
   mul.std <- as.numeric(mul.std)
   rep.std <- readline("How many times will the standards be replicated? ")
   rep.std <- as.numeric(rep.std)
} else {
   num.std == 0
   rep.std == 0 
   }
probe <- readline("What probe will you be using? ")

}#end
