timestamp_filter <- function(data, st, et) {
    START_DATETIME <- as.POSIXct(st)
    END_DATETIME <- as.POSIXct(et)
    
    data <- subset(data, as.numeric(data$timestamp) > as.numeric(START_DATETIME))
    data <- subset(data, as.numeric(data$timestamp) < as.numeric(END_DATETIME))
    
    return(data)
}