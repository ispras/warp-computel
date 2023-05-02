# checking and installing dependencies

library("seqinr")


args <- commandArgs(trailingOnly = TRUE)

functionsFile = args[1]
coverage.file = args[2]
reads.mapped = args[3]
tel.length.out = args[4]
tel.var.out = args[5]


source(functionsFile)

pattern="TTAGGG"
num.haploid.chr=23
min.seed=12
genome.length=3101804739
qualt = 25
rl = 100


############################################## 				Compute telomere length			##########################################


cat("estimating telomere length \n")
base.cov = base.coverage(coverage.file)
#tel.length.out = file.path(output.dir, telLengthFile)
tel.length  = get.tel.length(coverage.file, fastqs, rl, pl= nchar(pattern),
								base.cov, num.haploid.chr, 
								genome.length, min.seed,
								tel.length.out)
    
	
########################## 				Compute telomere variants			##########################

cat("\n\ncomputing telomeric variant composition\n")

#tel.var.out = file.path(output.dir, telVariantsFile)
tel.var  = count.variants(file = reads.mapped, pattern = pattern,  
                              tel.var.out, qual.threshold = qualt)
    


