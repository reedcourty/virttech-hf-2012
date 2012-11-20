# Hogy jobban lássuk, mi történik:
logger <- function(str) {
    line <- paste("[", Sys.time(), "] -- ", str, sep="")
    print(line)
    cat(line, file=LOG_FILE, sep="", fill=TRUE, append=TRUE)
}