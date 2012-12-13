# A felhasznált library-k:
library(ggplot2)
library(plyr)

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
OUTPUT_PATH <- file.path(BASE_PATH, "output/net")

# Létrehozzuk a kimeneti könyvtárat (ha már létezik, akkor Warningot kapnánk,
# de a suppressWarnings függvénnyel elrejtjük):
suppressWarnings(dir.create(OUTPUT_PATH))

# A futás során keletkezett logokat ide tesszük:
LOG_FILE <- file.path(BASE_PATH, "metrics_net.R.log")

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
# vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_net_infos.RData"))
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
# net.transmitted.average:
#
# A rajzoló függvényünk:
plotter <- function(datas, ST, ET) {
    
    STS <- gsub("-", "", ST)
    STS <- gsub(":", "", STS)
    STS <- gsub(" ", "", STS)
    
    ETS <- gsub("-", "", ET)
    ETS <- gsub(":", "", ETS)
    ETS <- gsub(" ", "", ETS)
    
    vcdatas_limit <- timestamp_filter(datas, ST, ET)
    
    plot <- ggplot() +
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = net.transmitted.average, 
                                          colour="1")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = net.transmitted.average,
                                           colour="1")) +
        xlab("dátum - idő") + ylab("kB/s") +
        scale_colour_manual(values=c("#4E9A06"),
                            name="",
                            labels=c("net.transmitted.average"))
    
    filename <- paste("net_transmitted_average-", STS, "-", ETS, ".png", sep="")
    
    logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
    ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=20)
}

plotter_dev <- function(datas, ST, ET) {
    
    STS <- gsub("-", "", ST)
    STS <- gsub(":", "", STS)
    STS <- gsub(" ", "", STS)
    
    ETS <- gsub("-", "", ET)
    ETS <- gsub(":", "", ETS)
    ETS <- gsub(" ", "", ETS)
    
    vcdatas_limit <- timestamp_filter(datas, ST, ET)
    
    plot <- ggplot() +
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = net.transmitted.average_vmnic0, 
                                          colour="1")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = net.transmitted.average_vmnic0,
                                           colour="1")) +
        
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = net.transmitted.average_vmnic1, 
                                          colour="2")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = net.transmitted.average_vmnic1,
                                           colour="2")) +
    
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = net.transmitted.average, 
                                          colour="3")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = net.transmitted.average,
                                           colour="3")) +
                                               
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = net.transmitted.average.calc, 
                                          colour="4")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = net.transmitted.average.calc,
                                           colour="4")) +

        xlab("dátum - idő") + ylab("kB/s") +
        scale_colour_manual(values=c("#4E9A06", "#A40000", "#EDD400", "#204A87"),
                            name="",
                            labels=c("net.transmitted.average_vmnic0", 
                                     "net.transmitted.average_vmnic1",
                                     "net.transmitted.average",
                                     "Számított"))
    
    filename <- paste("net_transmitted_average_dev-", STS, "-", ETS, ".png", sep="")
    
    logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
    ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=20)
}

plotter_diff <- function(datas, ST, ET) {
    
    STS <- gsub("-", "", ST)
    STS <- gsub(":", "", STS)
    STS <- gsub(" ", "", STS)
    
    ETS <- gsub("-", "", ET)
    ETS <- gsub(":", "", ETS)
    ETS <- gsub(" ", "", ETS)
    
    vcdatas_limit <- timestamp_filter(datas, ST, ET)
    
    plot <- ggplot() +
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = net.transmitted.average.diff, 
                                          colour="1")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = net.transmitted.average.diff,
                                           colour="1")) +

        xlab("dátum - idő") + ylab("kB/s") +
        scale_colour_manual(values=c("#4E9A06", "#A40000", "#EDD400", "#204A87"),
                            name="",
                            labels=c("Eltérés"))
    
    filename <- paste("net_transmitted_average_diff-", STS, "-", ETS, ".png", sep="")
    
    logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
    ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=20)
}

plot_diff_distribution <- function(datas, ST, ET) {
    
    STS <- gsub("-", "", ST)
    STS <- gsub(":", "", STS)
    STS <- gsub(" ", "", STS)
    
    ETS <- gsub("-", "", ET)
    ETS <- gsub(":", "", ETS)
    ETS <- gsub(" ", "", ETS)
    
    vcdatas_limit <- timestamp_filter(datas, ST, ET)
    
    diff_dist <- ddply(vcdatas_limit, .(net.transmitted.average.diff), 
                       summarize, count = length(unique(timestamp)))
    diff_dist <- data.frame(diff_dist, seq(1:nrow(diff_dist)))
    
    names(diff_dist) <- c("diff","count","seq")
    
    plot <- ggplot(data=diff_dist, aes(x = factor(diff), y=count)) +
        geom_histogram(fill="#4E9A06", stat="identity", colour="#4E9A06") +
        
        theme(axis.text.x = element_text(hjust = 0, size=10, color="#000000")) +
        ylab("Előfordulások száma") + xlab("Eltérés (kB/s)") +
        scale_fill_manual(values = c("1" = "red", "0" = "white"))
    
    filename <- paste("net_transmitted_average_diff-dist", 
                      "-", STS, 
                      "-", ETS, ".png", sep="")
    logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
    ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=4, width=2)
}
#
vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_net_infos.RData"))
#

vcdatas_item <- get_machine(vcdatas, "host-01")

vcdatas_item$net.transmitted.average.calc <- vcdatas_item$net.transmitted.average_vmnic0 + vcdatas_item$net.transmitted.average_vmnic1

vcdatas_item$net.transmitted.average.diff <- vcdatas_item$net.transmitted.average - vcdatas_item$net.transmitted.average.calc

# A teljes időintervallum:
ST <- min(vcdatas_item$timestamp)
ET <- max(vcdatas_item$timestamp)

plotter(vcdatas_item, ST, ET)

ST <- "2012-08-31 16:00:00"
ET <- "2012-08-31 20:00:00"

plotter(vcdatas_item, ST, ET)

ST <- "2012-08-31 17:29:00"
ET <- "2012-08-31 18:11:00"

plotter_dev(vcdatas_item, ST, ET)

# A teljes időintervallum:
ST <- min(vcdatas_item$timestamp)
ET <- max(vcdatas_item$timestamp)

plotter_diff(vcdatas_item, ST, ET)

ST <- "2012-08-31 17:29:00"
ET <- "2012-08-31 18:11:00"

plotter_diff(vcdatas_item, ST, ET)

# A teljes időintervallum:
ST <- min(vcdatas_item$timestamp)
ET <- max(vcdatas_item$timestamp)

plot_diff_distribution(vcdatas_item, ST, ET)

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
