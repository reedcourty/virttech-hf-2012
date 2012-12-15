# A felhasznált library-k:
library(ggplot2)

# Saját külső modulok:
# Naplózó függvény beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/logger.R", 
       encoding = "UTF-8")

# A betöltést segítő függvény beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/load_file.R", 
       encoding = "UTF-8")

# A mentést segítő függvény beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/save_data.R", 
       encoding = "UTF-8")

# Az időintervallum szűrő beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/timestamp_filter.R", 
       encoding = "UTF-8")

# Az item szűrő beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/get_datas_by_machines.R", 
       encoding = "UTF-8")

# Az infrastuktúra információk beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/infrastructure_infos.R", 
       encoding = "UTF-8")

# Az alap könyvtárunk elérési útvonala:
BASE_PATH <- "c:/Users/reedcourty/git/virttech-hf-2012/"

# A bemeneti állományokat tartalmazó könyvtár:
INPUT_PATH <- file.path(BASE_PATH, "datas")

# A kimeneti állományok ide fognak kerülni:
OUTPUT_PATH <- file.path(BASE_PATH, "output")

# Létrehozzuk a kimeneti könyvtárat (ha már létezik, akkor Warningot kapnánk,
# de a suppressWarnings függvénnyel elrejtjük):
suppressWarnings(dir.create(OUTPUT_PATH))

# A futás során keletkezett logokat ide tesszük:
LOG_FILE <- file.path(BASE_PATH, "metrics_ds.R.log")

logger("")
logger("################################################################################")
logger("")

################################################################################

# Szeretnénk tudni a script futási idejét, ezért elmentjük a jelenlegi időt:
start_time <- Sys.time()
logger(paste("A futás kezdete:", start_time, sep=" "))

################################################################################

# ################################################################################
# #
# # Az összes disk.* metrika kirajzolása:
# #
# 
# vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_disk_infos.RData"))
# 
# # # A teljes időintervallum:
# ST <- min(vcdatas$timestamp)
# ET <- max(vcdatas$timestamp)
# 
# STS <- gsub("-", "", ST)
# STS <- gsub(":", "", STS)
# STS <- gsub(" ", "", STS)
# 
# ETS <- gsub("-", "", ET)
# ETS <- gsub(":", "", ETS)
# ETS <- gsub(" ", "", ETS)
#     
# vcdatas_limit <- timestamp_filter(vcdatas, ST, ET)
# 
# # Memóriát spórólunk:
# rm(vcdatas)
# 
# cols <- names(vcdatas_limit)
# 
# sequence <- seq(from = 3, to = length(cols), by = 1)
# 
# for (i in sequence) {
#     col <- as.character(names(vcdatas_limit)[i])
#     
#     logger(paste(col, "metrikák plottolása...", sep=" "))
#     
#     plot <- ggplot() +
#         geom_line(data=vcdatas_limit, aes(x = timestamp, y = vcdatas_limit[, i], colour=item_id)) +
#         geom_point(data=vcdatas_limit, aes(x = timestamp, y = vcdatas_limit[, i], colour=item_id)) +
#         ylab(col) +
#         scale_colour_discrete(name="Virtuális gépek azonosítói")
#     
#     filename <- paste("disk.metrics.", col, "-", STS,"-", ETS, ".png", sep="")
#     
#     logger(paste("Plott mentése", filename, "néven...", sep=" "))
#     
#     ggsave(plot=plot, 
#            filename=file.path(OUTPUT_PATH, filename), 
#            height=6, width=20)
# }
# #
# ################################################################################

################################################################################
#
# disk.*latency* metrikák kirajzolása:
#
# A rajzoló függvényünk:
latency_plotter <- function(datas, ST, ET) {
    
    STS <- gsub("-", "", ST)
    STS <- gsub(":", "", STS)
    STS <- gsub(" ", "", STS)
    
    ETS <- gsub("-", "", ET)
    ETS <- gsub(":", "", ETS)
    ETS <- gsub(" ", "", ETS)
    
    vcdatas_limit <- timestamp_filter(datas, ST, ET)

    plot <- ggplot() +
        
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                y = disk.deviceLatency.average_t10, 
                                colour="1")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp, 
                                 y = disk.deviceLatency.average_t10, 
                                 colour="1")) +
        
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = disk.kernelLatency.average_t10, 
                                          colour="2")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp, 
                                           y = disk.kernelLatency.average_t10, 
                                           colour="2")) +
        
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = disk.totallatency.average_t10, 
                                          colour="3")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp, 
                                           y = disk.totallatency.average_t10, 
                                           colour="3")) +
        
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = sum_latency, colour="4")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp, 
                                           y = sum_latency, colour="4")) +
        
        labs(y = "milliszekundum", x = "dátum - idő") +
        
        scale_colour_manual(values=c("#4E9A06", "#A40000", "#EDD400", "#204A87"), 
                            name="Latency-k",
                            labels=c("Device", "Kernel", "Total", "Számított"))
    
    filename <- paste("disk_metrics_sumlatency-", STS, "-", ETS, ".png", sep="")
        
    logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
    ggsave(plot=plot, 
           filename=file.path(OUTPUT_PATH, filename), height=4, width=10)   
}


vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_disk_infos.RData"))

# Latency-vel kapcsolatos metrikák: 
cols <- names(vcdatas)

# "atency", hogy a Latency és a latency is benne legyen. Tudom, csúnya :D
cols_latency <- subset(cols, grepl(pattern="atency", cols))
cols_latency <- subset(cols_latency, grepl(pattern="virtual", cols_latency)==FALSE)
cols <- c(rep("timestamp"), rep("item_id"), cols_latency)

vcd <- vcdatas[,cols]

# Memóriát spórolunk:
rm(vcdatas)

vcd <- get_machine(vcd, "host-01")

vcd$sum_latency <- vcd$disk.deviceLatency.average_t10 + vcd$disk.kernelLatency.average_t10

vcd$calc <- vcd$sum_latency - vcd$disk.totallatency.average_t10

# A teljes időintervallum:
ST <- min(vcd$timestamp)
ET <- max(vcd$timestamp)

latency_plotter(vcd, ST, ET)

ST <- "2012-09-10 12:00:00"
ET <- "2012-09-10 12:30:00"

latency_plotter(vcd, ST, ET)

ST <- "2012-09-12 01:35:00"
ET <- "2012-09-12 01:40:00"

latency_plotter(vcd, ST, ET)

ST <- "2012-09-19 02:30:00"
ET <- "2012-09-19 02:40:00"

latency_plotter(vcd, ST, ET)

#unique(vcd$disk.kernelLatency.average_t10)
#vcd$timestamp[vcd$disk.kernelLatency.average_t10==50]

# Memóriát spórolunk:
rm(vcd)
#
################################################################################

# ################################################################################
# #
# # storage*.*latency* metrikák:
# #
# # A rajzoló függvényünk:
# stlatency_plotter <- function(datas, ST, ET) {
#     
#     STS <- gsub("-", "", ST)
#     STS <- gsub(":", "", STS)
#     STS <- gsub(" ", "", STS)
#     
#     ETS <- gsub("-", "", ET)
#     ETS <- gsub(":", "", ETS)
#     ETS <- gsub(" ", "", ETS)
#     
#     vcdatas_limit <- timestamp_filter(datas, ST, ET)
# 
#     plot <- ggplot() +
#         
#         
#         geom_line(data=vcdatas_limit, 
#                   aes(x = timestamp, 
#                       y = storagepath.totalwritelatency.average_iqn.com.vmware.host01,
#                       colour="1")) +
#         geom_point(data=vcdatas_limit,
#                    aes(x = timestamp,
#                        y = storagepath.totalwritelatency.average_iqn.com.vmware.host01,
#                        colour="1")) +
#          
#         geom_line(data=vcdatas_limit,
#                   aes(x = timestamp,
#                       y = storageadapter.totalwritelatency.average_vmhba0,
#                       colour="2")) +
#         geom_point(data=vcdatas_limit,
#                    aes(x = timestamp, 
#                        y = storageadapter.totalwritelatency.average_vmhba0, 
#                        colour="2")) +
#              
#         geom_line(data=vcdatas_limit, 
#                   aes(x = timestamp, 
#                       y = disk.totalwritelatency.average_t10, colour="3")) +
#         geom_point(data=vcdatas_limit, 
#                    aes(x = timestamp, 
#                        y = disk.totalwritelatency.average_t10, colour="3")) +
#         
#         labs(y = "milliszekundum", x = "dátum - idő") +
#         
#         scale_colour_manual(values=c("#4E9A06", "#A40000", "#204A87"), 
#                             name="Latency-k",
#                             labels=c("Storage adapter", "Storage path", "Disk"))
#     
#     filename <- paste("disk_metrics_storage_latency", "-", STS, "-", ETS, 
#                       ".png", sep="")
#         
#     logger(paste("Plott mentése", filename, "néven...", sep=" "))
#     
#     ggsave(plot=plot, 
#            filename=file.path(OUTPUT_PATH, filename), height=4, width=10)   
# }
# 
# vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_disk_infos.RData"))
# 
# # Latency-vel kapcsolatos metrikák: 
# cols <- names(vcdatas)
# 
# # "atency", hogy a Latency és a latency is benne legyen. Tudom, csúnya :D
# cols_latency <- subset(cols, grepl(pattern="atency", cols))
# cols_latency <- subset(cols_latency, grepl(pattern="virtual", 
#                                            cols_latency)==FALSE)
# cols <- c(rep("timestamp"), rep("item_id"), cols_latency)
# 
# vcd <- vcdatas[,cols]
# 
# vcd <- get_machine(vcd, "host-01")
# 
# # A teljes időintervallum:
# ST <- min(vcd$timestamp)
# ET <- max(vcd$timestamp)
# 
# stlatency_plotter(vcd, ST, ET)
# 
# ST <- "2012-09-10 12:00:00"
# ET <- "2012-09-10 12:30:00"
# 
# stlatency_plotter(vcd, ST, ET)

################################################################################

# Elmentjük a jelenlegi időt, és kivonjuk belőle a futás elején rögzitett
# értéket, így megkapva a futási időt:
end_time <- Sys.time()
elapsed_time <- end_time - start_time
logger(paste("A futás vége: ", end_time, sep=""))
logger(paste("Eltelt idő a futás kezdete óta:", as.numeric(elapsed_time, 
                                                           units="secs"),
             "másodperc",
             sep=" "))

################################################################################
