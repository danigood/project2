project2
========

Welcome to my final project, which is a program that will create a plate map for qPCR quickly and easily, in addition to generating the necessary master mixes for reagents needed to complete said qPCR. Currently, the program is configured to design two types of qPCR plates that we use in our lab: a plate with a standard curve for quantitative analysis or a plate with a housekeeping gene for quantitative analysis. The master mixes calculated for each type of plate are currently configured for the two types of probes that we use in our lab.

See a sample plate layout below.

```r   
  plate <- matrix(data=NA, nrow=8, ncol=12)
  plate <- as.table(plate)
  colnames(plate) <- 1:12  
  num.std <- 9
	start.std <- 10
	mul.std <- 10
	rep.std <- 3
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
	probe.name <- "mE1A"
	plate[1:number.standards] <- paste(plate.std, probe.name, sep=" ")
	#adding non-template controls
	num.NTC <- number.standards+rep.std+1
	NTC.start <- number.standards+1
	plate[NTC.start:num.NTC] <- "NTC"
	#add samples
	sample.names <- "Atc Mock,Atc MAV 1,Atc MAV 2,Atc MAV 3,Atc MAV 4,Atc MAV 5,Atc MAV 6,B6 Mock,B6 MAV 1,B6 MAV 2,B6 MAV 3,B6 MAV 4,B6 MAV 5,B6 MAV 6"
	sample.rep <- 3
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
	plate[samples.start:samples.end] <- paste(sorted.samples, probe.name, sep=" ")
	print(plate)
```

See a sample of the master mix calculations below:
```r
	primers.probe <- 48*1.04*0.2
	taq <- 48*1.04*5
	water <- 48*1.04*0.4
	master.mix.mE1A <- matrix(data = NA, nrow = 7, ncol = 3)
	master.mix.mE1A[1,1:3] <- c("For 10 µL reactions where","2 µL of DNA is added to each reaction,", "the master mix is as follows:")
	master.mix.mE1A[2,1] <- c("mE1A")
	master.mix.mE1A[3,1:3] <- c("Forward Primer (10 µM):", primers.probe,"µL")
	master.mix.mE1A[4,1:3] <-c("Reverse Primer (10 µM):", primers.probe,"µL")
	master.mix.mE1A[5,1:3] <-c("Probe (2 µM):", primers.probe,"µL")
	master.mix.mE1A[6,1:3] <-c("2x Taqman:", taq,"µL")
	master.mix.mE1A[7,1:3] <-c("Water:", water,"µL")
	master.mix.mE1A <- as.table(master.mix.mE1A)
  print(master.mix.mE1A)
```

Extra Features:


+ Will throw an warning message if there are too many samples for one plate.


+ The master mix calculations automatically account for pipetting error.

To run the program, load the R script file 'MakeAPlateMap.R' into your workspace, empty your global environment, then run using source. Follow the prompts given by the program. Once the program is complete, it will generate a text document titled 'platemap.txt'. This file can be read from R Studio, or you can import it into Excel for further manipulation (choose import > text file > separated by commas).