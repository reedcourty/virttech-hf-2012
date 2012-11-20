# Adatok mentéséhez:
save_data <- function(data, filename, tsv) {
    if (tsv) {
        file <- file.path(OUTPUT_PATH, paste(filename, ".tsv", sep=""))
        
        logger(paste("A", file, "állomány mentése...", sep=" "))
        write.table(data, file , append=FALSE, na="", quote=FALSE, row.names=FALSE, sep="\t")
    }
    file <- file.path(OUTPUT_PATH, paste(filename, ".RData", sep=""))
    
    logger(paste("A", file, "állomány mentése...", sep=" "))
    save(data, file=file.path(OUTPUT_PATH, paste(filename, ".RData", sep="")))
}