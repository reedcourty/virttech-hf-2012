load_file <- function(filename) {
    logger(paste("A", filename, 
                 "állomány betöltése...", sep=" "))
    load(file=file.path(filename))
    return(data)
}