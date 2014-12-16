#create an empty plate
plate <- matrix(data=NA, nrow=8, ncol=12)
plate <- as.table(plate)
colnames(plate) <- 1:12

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
	probe.name <- readline("What is the name of the probe? ")
	paste(plate.std, probe.name, sep=" ")
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
	paste(sorted.samples, probe.name, sep=" ")
	if(samples.end > 96){
		print('There are too many samples for one plate')
	}
	plate[samples.start:samples.end] <- sorted.samples
	#calculate the master mixes for each
	primers.probe <- samples.end*1.04*0.2
	taq <- samples.end*1.04*5
	water <- samples.end*1.04*0.4
	master.mix.mE1A <- matrix(data = NA, nrow = 7, ncol = 3)
	master.mix.mE1A[1,1] <- c("For 10 µL reactions where 2 µL of DNA is added to each reaction, the master mix is as follows:")
	master.mix.mE1A[2,1] <- c(probe.name)
	master.mix.mE1A[3,1:3] <- c("Forward Primer (10 µM):", primers.probe,"µL")
	master.mix.mE1A[4,1:3] <-c("Reverse Primer (10 µM):", primers.probe,"µL")
	master.mix.mE1A[5,1:3] <-c("Probe (2 µM):", primers.probe,"µL")
	master.mix.mE1A[6,1:3] <-c("2x Taqman:", taq,"µL")
	master.mix.mE1A[7,1:3] <-c("Water:", water,"µL")
} else { 
	#if two probes so no stds
	num.std <- 0
	rep.std <- 0
	probe1 <- readline("What is the first probe name (if using mE1A and GAPDH, put mE1A as the first probe)? ")
	probe2 <- readline("What is the second probe name? ")
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
	if(set2.end > 96){
		print('There are too many samples for one plate')
	}
	plate[set2.start:set2.end] <- set2 
#calculate the master mixes for each
primers.probe <- (samples.end-3)*1.04*0.2
taq <- (samples.end-3)*1.04*5
water <- (samples.end-3)*1.04*2.4
master.mix <- matrix(data = NA, nrow = 11, ncol = 3)
master.mix[1,1] <- c("For 10 µL reactions where 2 µL of DNA is added to each reaction, the master mix is as follows:")
master.mix[2,1] <- c(probe1)
master.mix[3,1:3] <- c("Forward Primer (10 µM):", primers.probe,"µL")
master.mix[4,1:3] <-c("Reverse Primer (10 µM):", primers.probe,"µL")
master.mix[5,1:3] <-c("Probe (2 µM):", primers.probe,"µL")
master.mix[6,1:3] <-c("2x Taqman:", taq,"µL")
master.mix[7,1:3] <-c("Water:", water,"µL") 
GAPDHprimprob <- (samples.end-3)*1.04*0.5
GAPDHwater <- (samples.end-3)*1.04*2.5
master.mix[8,1] <- c(probe2)
master.mix[9,1:3] <- cat("Primer/Probe Mix", GAPDHprimprob,"µL")
master.mix[10,1:3] <- cat("2x Taqman:", taq,"µL")
master.mix[11,1:3] <- cat("Water:", GAPDHwater,"µL") }

#write file for plate map
write.csv(plate, "platemap.csv") 



