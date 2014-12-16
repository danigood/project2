project2
========
#create an empty plate
plate <- matrix(data=NA, nrow=8, ncol=12)
plate <- as.table(plate)
colnames(plate) <- 1:12

probe <- readline("Will there be more than one probe used Y or N? ")
   
   if(probe == "N"){
   probe.name <- readline("What probe will be used? ")
   } else {
   probe1 <- readline("What is the first probe name? ")
   probe2 <- readline("What is the second probe name? ") }

std <- readline("Will there be standards Y or N? ")

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
   paste(plate.std, "probe.name", sep=" ")
   plate[1:number.standards] <- plate.std
#adding non-template controls
   num.NTC <- number.standards+rep.std+1
   NTC.start <- number.standards+1
   plate[NTC.start:num.NTC] <- "NTC"
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
   samples.start <- num.NTC+1
   samples.end <- num.NTC+num.samples
   paste(sorted.samples, "probe.name", sep=" ")
   plate[samples.start:samples.end] <- sorted.samples
} else { 
#if two probes so no stds
   num.std <- 0
   rep.std <- 0
   sample.rep <- readline("How many times will you be replicating each sample in the plate? ")
   sample.rep <- as.numeric(sample.rep)
#adding non-template controls
   num.NTC <- (sample.rep)*2
   plate[1:num.NTC] <- "NTC"
#add samples
   sample.names <- readline("Input the names of each sample and separate each with a comma: ")
   split.names <- strsplit(sample.names, ",")
   split.names <- unlist(split.names)
   num.samples <- length(split.names)*sample.rep
   sample.rep <- sample.rep-1
   samples <- split.names
   for(i in 1:sample.rep){ 
   samples <- c(samples, split.names)
   } 
   sorted.samples <- sort(samples)
   samples.start <- num.NTC+1
   samples.end <- num.NTC+num.samples
   set1 <- paste(sorted.samples, probe1, sep=" ")
   set2 <- paste(sorted.samples, probe2, sep=" ")
   plate[samples.start:samples.end] <- set1
   set2.start <- samples.end+1
   set2.end <- samples.end+num.samples
   plate[set2.start:set2.end] <- set2 }

#write.csv(plate, "platemap.csv")

#}#endfunction