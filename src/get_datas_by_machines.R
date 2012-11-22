# Visszaadja a VM-re/host-ra vonatkozó adatokat:
get_machine <- function(data, machine) {
    results <- subset(data, (data$item_id==machine)==TRUE)
    return(results)
}

# visszaadja a paraméterként átadott itemek adatait:
get_machines <- function(data, machines) {
    results <- data.frame()
    for (machine in machines) {
        m <- subset(data, (data$item_id==machine)==TRUE)
        results <- rbind(results,m)
    }
    return(results)
}