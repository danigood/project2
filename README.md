project2
========
#create an empty plate
plate <- matrix(data=NA, nrow=8, ncol=12)
plate <- as.table(plate)
colnames(plate) <- 1:12

#make function to fill the table according to specific instructions
fill.plate <- function() {
#filling standards
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

   plate.std <- c(start.std)
   num.std <- num.std-1
   x <- start.std
   for(i in 1:num.std){
   x <- x*mul.std
   plate.std <- c(plate.std, x)
   }
   num.std <- num.std+1
   plate.std <- matrix(plate.std, nrow=rep.std, ncol=num.std, byrow=TRUE)
   plate[1:rep.std,1:num.std] <- plate.std
#adding non-template controls
   plate[1:rep.std,num.std+1] <- "NTC"
   
} else {
   num.std == 0
   rep.std == 0 
   }
probe <- readline("What probe will you be using? ")

}#end
