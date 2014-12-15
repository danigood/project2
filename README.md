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
   number.standards <- rep.std*num.std
   
   plate.std <- c(start.std)
   num.std <- num.std-1
   x <- start.std
   for(i in 1:num.std){
   x <- x*mul.std
   plate.std <- c(plate.std, x)
   }
   add.std <- plate.std
   rep.std <- rep.std - 1
   for(i in 1:rep.std){ 
   plate.std <- c(plate.std, add.std)
   }
   plate.std <- sort(plate.std)
   plate[1:number.standards] <- plate.std
#adding non-template controls
   plate[1:rep.std,num.std+1] <- "NTC"
#add samples
   sample.names <- readline("Input the names of each sample and separate each with a comma: ")
   sample.rep <- readline("How many times will you be replicating each sample in the plate? ")
   sample.rep <- as.numeric(sample.rep)
   split.names <- strsplit(sample.names, ",")
   split.names <- unlist(split.names)
   num.samples <- length(split.names)*sample.rep
   sample.rep <- sample.rep-1
   samples <- split.names
   for(i in 1:sample.rep){ 
   samples <- c(samples, split.names)
   } 
   sorted.samples <- sort(samples)
   
} else {
   num.std == 0
   rep.std == 0 
   }
probe <- readline("Will there be more than one probe used? ")

if(std=="N"){

}#end
