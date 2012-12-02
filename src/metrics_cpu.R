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
INPUT_PATH_WP <- file.path(BASE_PATH, "datas_wp")

# A kimeneti állományok ide fognak kerülni:
OUTPUT_PATH <- file.path(BASE_PATH, "output")

# Létrehozzuk a kimeneti könyvtárat (ha már létezik, akkor Warningot kapnánk,
# de a suppressWarnings függvénnyel elrejtjük):
suppressWarnings(dir.create(OUTPUT_PATH))

# A futás során keletkezett logokat ide tesszük:
LOG_FILE <- file.path(BASE_PATH, "metrics_cpu.R.log")

logger("")
logger("################################################################################")
logger("")

################################################################################

# Szeretnénk tudni a script futási idejét, ezért elmentjük a jelenlegi időt:
start_time <- Sys.time()
logger(paste("A futás kezdete:", start_time, sep=" "))

################################################################################

################################################################################
#
# Minden CPU metrika kirajzoltatása:
#
# vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_cpu_infos.RData"))
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
#         scale_fill_manual(name="Virtuális gépek azonosítói")
#     
#     filename <- paste("cpu.metrics.", col, ".png", sep="")
#     
#     logger(paste("Plott mentése", filename, "néven...", sep=" "))
#     
#     ggsave(plot=plot, 
#            filename=file.path(OUTPUT_PATH, filename), 
#            height=6, width=20)
# }

# ################################################################################
# #
# # cpu.swapwait.summation:
# #
# # A rajzoló függvényünk:
# plotter <- function(datas, ST, ET) {
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
#         geom_line(data=vcdatas_limit, aes(x = timestamp, 
#                                           y = cpu.swapwait.summation, 
#                                           colour=item_id)) +
#         geom_point(data=vcdatas_limit, aes(x = timestamp,
#                                            y = cpu.swapwait.summation,
#                                            colour=item_id)) +
#         xlab("dátum - idő") + ylab("milliszekundum") +
#         scale_colour_discrete(name="Virtuális gépek azonosítói")
#     
#     filename <- paste("cpu_swapwait_summation-", STS, "-", ETS, ".png", sep="")
#     
#     logger(paste("Plott mentése", filename, "néven...", sep=" "))
#     
#     ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=20)
# }
# #
# vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_cpu_infos.RData"))
# #
# # Hostoknál nincs ilyen metrikánk:
# vcdatas_vms <- get_machines(vcdatas, VMS)
# #
# # Memóriát spórólunk:
# rm(vcdatas)
# #
# # A teljes időintervallum:
# ST <- min(vcdatas_vms$timestamp)
# ET <- max(vcdatas_vms$timestamp)
# #
# plotter(vcdatas_vms, ST, ET)
# #
# ST <- "2012-08-27 10:00:00"
# ET <- "2012-08-27 10:05:00"
# #
# plotter(vcdatas_vms, ST, ET)
# #
# ST <- "2012-08-27 10:00:00"
# ET <- "2012-08-27 10:35:00"
# #
# plotter(vcdatas_vms, ST, ET)
# #
# ST <- "2012-09-13 10:31:15"
# ET <- "2012-09-13 10:33:30"
# #
# plotter(vcdatas_vms, ST, ET)
# #
# ################################################################################


# ################################################################################
# #
# # cpu.idle.summation:
# #
# # A rajzoló függvényünk:
# plotter <- function(datas, ST, ET) {
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
#         geom_line(data=vcdatas_limit, aes(x = timestamp, 
#                                           y = cpu.idle.summation, 
#                                           colour=item_id)) +
#         geom_point(data=vcdatas_limit, aes(x = timestamp,
#                                            y = cpu.idle.summation,
#                                            colour=item_id)) +
#         xlab("dátum - idő") + ylab("milliszekundum") +
#         scale_colour_discrete(name="Virtuális gép\nazonosítója")
#     
#     filename <- paste("cpu_idle_summation-", vcdatas_limit$item_id, "-", STS, 
#                       "-", ETS, ".png", sep="")
#     
#     logger(paste("Plott mentése", filename, "néven...", sep=" "))
#     
#     ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, 
#            width=20)
# }
# #
# vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_cpu_infos.RData"))
# #
# # Hostoknál nincs ilyen metrikánk:
# vcdatas_vms <- get_machines(vcdatas, VMS)
# #
# # Memóriát spórólunk:
# rm(vcdatas)
# #
# # # Első körben minden VM-et kiplottolunk, hogy lássuk, mit érdemes nézni:
# # for (vm in VMS) {
# #     vcdatas_vm <- get_machine(vcdatas_vms, vm)
# # #
# # # A teljes időintervallum:
# #     ST <- min(vcdatas_vm$timestamp)
# #     ET <- max(vcdatas_vm$timestamp)
# # #
# #     plotter(vcdatas_vm, ST, ET)
# # #
# # }
# #
# # Mutatunk egy mérési hibát:
# #
# vcdatas_vm <- get_machine(vcdatas_vms, "guest-15")
# #
# ST <- min(vcdatas_vm$timestamp)
# ET <- max(vcdatas_vm$timestamp)
# #
# plotter(vcdatas_vm, ST, ET)
# #
# vcdatas_vm <- get_machine(vcdatas_vms, "guest-15")
# #
# ST <- "2012-09-19 22:15:00"
# ET <- "2012-09-19 22:45:00"
# #
# plotter(vcdatas_vm, ST, ET)
# #
# # Nagyon sűrű, periodikussan dolgozik:
# #
# vcdatas_vm <- get_machine(vcdatas_vms, "guest-16")
# #
# ST <- min(vcdatas_vm$timestamp)
# ET <- max(vcdatas_vm$timestamp)
# #
# plotter(vcdatas_vm, ST, ET)
# #
# vcdatas_vm <- get_machine(vcdatas_vms, "guest-16")
# #
# ST <- "2012-09-10 10:00:00"
# ET <- "2012-09-10 14:00:00"
# #
# plotter(vcdatas_vm, ST, ET)
# #
# # Maximális értékek bar chartja:
# #
# item_id <- c()
# max_cpu.idle.summation <- c()
# #
# for (vm in VMS) {
#     vcdatas_vm <- get_machine(vcdatas_vms, vm)
#     # Kiszedjük a mérési hibákat:
#     vcdatas_vm <- subset(vcdatas_vm, vcdatas_vm$cpu.idle.summation <= 20000)
#     
#     item_id <- c(rep(item_id), rep(vm))
#     max_cpu.idle.summation <- c(rep(max_cpu.idle.summation), 
#                                 rep(max(vcdatas_vm$cpu.idle.summation)))    
# }
# #
# max_idle <- data.frame(item_id=item_id, 
#                        max_cpu.idle.summation=max_cpu.idle.summation)
# #
# plot <- ggplot() +
#     geom_bar(data=max_idle, aes(x = item_id, y = max_cpu.idle.summation,
#                                 fill=item_id, stat="bin")) +
#     xlab("Virtuális gépek") + ylab("Max. érték milliszekundumban") +
#     scale_fill_discrete(guide=FALSE) +
#     coord_cartesian(ylim=c(min(max_idle$max_cpu.idle.summation)-100, 
#                          max(max_idle$max_cpu.idle.summation)+100))
# #
# filename <- "cpu_idle_summation-max-barchart.png"
# #
# logger(paste("Plott mentése", filename, "néven...", sep=" "))
# #
# ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=8)
# #
# 
# vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_cpu_infos.RData"))
# #
# # Hostoknál nincs ilyen metrikánk:
# vcdatas_vms <- get_machines(vcdatas, VMS)
# #
# # Memóriát spórólunk:
# rm(vcdatas)
# 
# plot <- ggplot() +
#     geom_histogram(data=vcdatas_vms, aes(x = cpu.idle.summation), 
#                    binwidth = 50, fill="red") + 
#     ylab("") + xlab("A cpu.idle.summation értékek milliszekundumban")
# 
# filename <- "cpu_idle_summation-histogram.png"
# 
# logger(paste("Plott mentése", filename, "néven...", sep=" "))
# 
# ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=4, width=6)
#
# ################################################################################



################################################################################
#
# cpu.ready.summation:
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
                                          y = cpu.ready.summation, 
                                          colour=item_id)) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = cpu.ready.summation,
                                           colour=item_id)) +
        xlab("dátum - idő") + ylab("milliszekundum") +
        scale_colour_discrete(name="Virtuális gép\nazonosítója")
    
    filename <- paste("cpu_ready_summation-", unique(vcdatas_limit$item_id), "-", STS, 
                      "-", ETS, ".png", sep="")
    
    logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
    ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, 
           width=20)
}

plotter_wp <- function(datas, ST, ET) {
    
    STS <- gsub("-", "", ST)
    STS <- gsub(":", "", STS)
    STS <- gsub(" ", "", STS)
    
    ETS <- gsub("-", "", ET)
    ETS <- gsub(":", "", ETS)
    ETS <- gsub(" ", "", ETS)
    
    vcdatas_limit <- timestamp_filter(datas, ST, ET)
    
    plot <- ggplot() +
        geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                          y = cpu.ready.summation, 
                                          colour="1")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = cpu.ready.summation,
                                           colour="1")) +
                                               
        geom_line(data=vcdatas_limit, aes(x = timestamp,
                                          y = cpu.ready.summation_0,
                                          colour="2")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = cpu.ready.summation_0,
                                           colour="2")) +
        
        geom_line(data=vcdatas_limit, aes(x = timestamp,
                                          y = cpu.ready.summation_1,
                                          colour="3")) +
        geom_point(data=vcdatas_limit, aes(x = timestamp,
                                           y = cpu.ready.summation_1,
                                           colour="3")) +
        
        xlab("dátum - idő") + ylab("milliszekundum") +
        scale_colour_manual(values=c("#FF0000", "#00FF00", "#0000FF"),
                            name="CPU-k",
                            labels=c("CPU 0+1", "CPU 0", "CPU 1"))
    
    filename <- paste("cpu_ready_summation-", unique(vcdatas_limit$item_id), "-", STS, 
                      "-", ETS, ".png", sep="")
    
    logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
    ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, 
           width=20)
}


#
vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_cpu_infos.RData"))

#
# Hostoknál nincs ilyen metrikánk:
vcdatas_vms <- get_machines(vcdatas, VMS)

#
# Memóriát spórólunk:
rm(vcdatas)
#
# Első körben minden VM-et kiplottolunk, hogy lássuk, mit érdemes nézni:
for (vm in VMS) {
    vcdatas_vm <- get_machine(vcdatas_vms, vm)
    
    # A teljes időintervallum:
    ST <- min(vcdatas_vm$timestamp)
    ET <- max(vcdatas_vm$timestamp)
    
    plotter(vcdatas_vm, ST, ET)
    
}

# A problémás guest-et is kirajzoljuk:

vcdatas_wp <- load_file(file.path(INPUT_PATH_WP, "vcenter_datas_cleaned_wp.RData"))

ST <- min(vcdatas_wp$timestamp)
ET <- max(vcdatas_wp$timestamp)

plotter_wp(vcdatas_wp, ST, ET)

ST <- "2012-09-12 17:00:00"
ET <- "2012-09-12 17:30:00"

plotter_wp(vcdatas_wp, ST, ET)

vcdatas_vms_l <- vcdatas_vms[, c("timestamp", "item_id", "cpu.ready.summation")]
vcdatas_wp_l <- vcdatas_wp[, c("timestamp", "item_id", "cpu.ready.summation")]

vcdatas_vms_l <- rbind(vcdatas_vms_l, vcdatas_wp_l)

VMS_WP <- c(rep(VMS), rep("guest-24"))

# Maximális értékek bar chartja:
#
item_id <- c()
max_cpu.ready.summation <- c()
#
for (vm in VMS_WP) {
    vcdatas_vm <- get_machine(vcdatas_vms_l, vm)
    
    item_id <- c(rep(item_id), rep(vm))
    max_cpu.ready.summation <- c(rep(max_cpu.ready.summation), 
                                rep(max(vcdatas_vm$cpu.ready.summation)))    
}

vcdatas_vm <- get_machine(vcdatas_wp, "guest-24")

item_id <- c(rep(item_id), rep("guest-24 CPU 0"))
max_cpu.ready.summation <- c(rep(max_cpu.ready.summation),  
                             rep(max(vcdatas_vm$cpu.ready.summation_0)))

item_id <- c(rep(item_id), rep("guest-24 CPU 1"))
max_cpu.ready.summation <- c(rep(max_cpu.ready.summation),  
                             rep(max(vcdatas_vm$cpu.ready.summation_1)))

rm(vcdatas_vm)
#
max_ready <- data.frame(item_id=item_id, 
                        max_cpu.ready.summation=max_cpu.ready.summation)
#
plot <- ggplot() +
    geom_bar(data=max_ready, aes(x = item_id, y = max_cpu.ready.summation,
                                fill=item_id, stat="bin")) +
    xlab("Virtuális gépek") + ylab("Max. érték milliszekundumban") +
    scale_fill_discrete(guide=FALSE) +
    coord_cartesian(ylim=c(min(max_ready$max_cpu.ready.summation)-100, 
                         max(max_ready$max_cpu.ready.summation)+100))
#
filename <- "cpu_ready_summation-max-barchart.png"
#
logger(paste("Plott mentése", filename, "néven...", sep=" "))
#
ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=12)
#

plot <- ggplot() +
        geom_histogram(data=vcdatas_vms_l, aes(x = cpu.ready.summation), 
                       binwidth = 1, fill="blue") + 
        ylab("") + xlab("A cpu.ready.summation értékek milliszekundumban")
    
filename <- "cpu_ready_summation-histogram.png"
    
logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=4, width=6)

# Berajzoljuk a kritikus 5 és 10%-okat:
plot <- ggplot() +
    geom_histogram(data=vcdatas_vms_l, aes(x = cpu.ready.summation), 
                   binwidth = 1, fill="blue") + 
                       ylab("") + xlab("A cpu.ready.summation értékek milliszekundumban") +
    
    geom_vline(aes(xintercept = as.numeric(20000/100*5)), colour="green") + 
    geom_vline(aes(xintercept = as.numeric(20000/100*10)), colour="red")

filename <- "cpu_ready_summation-histogram-w-b.png"

logger(paste("Plott mentése", filename, "néven...", sep=" "))

ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=4, width=6)

################################################################################



# for (vm in VMS) {
#     vcdatas_vm <- get_machine(vcdatas_vms, vm)
#     #
#     ST <- "2012-09-10 00:00:00"
#     ET <- "2012-09-11 00:00:00"
#     #
#     plotter(vcdatas_vm, ST, ET)
#     #
# }

# for (vm in VMS) {
#     vcdatas_vm <- get_machine(vcdatas_vms, vm)
#     #
#     ST <- "2012-09-10 12:00:00"
#     ET <- "2012-09-11 00:00:00"
#     #
#     plotter(vcdatas_vm, ST, ET)
#     #
# }





# ST <- "2012-08-27 10:00:00"
# ET <- "2012-08-27 10:05:00"
# #
# plotter(vcdatas_vms, ST, ET)
# #
# ST <- "2012-08-27 10:00:00"
# ET <- "2012-08-27 10:35:00"
# #
# plotter(vcdatas_vms, ST, ET)
# #
# ST <- "2012-09-13 10:31:15"
# ET <- "2012-09-13 10:33:30"
# #
# plotter(vcdatas_vms, ST, ET)


#
################################################################################








# v <- subset(vcdatas, vcdatas$cpu.swapwait.summation != 0)
# v <- v[,c("timestamp", "item_id", "cpu.swapwait.summation")]

# ST <- "2012-09-13 10:31:15"
# ET <- "2012-09-13 10:33:30"
# 
# STS <- gsub("-", "", ST)
# STS <- gsub(":", "", STS)
# STS <- gsub(" ", "", STS)
# 
# ETS <- gsub("-", "", ET)
# ETS <- gsub(":", "", ETS)
# ETS <- gsub(" ", "", ETS)
# 
# 
# vcdatas_limit <- timestamp_filter(vcdatas, ST, ET)
# 
# plot <- ggplot() +
#     geom_line(data=vcdatas_limit, aes(x = timestamp, 
#                                       y = cpu.swapwait.summation, 
#                                       colour=item_id)) +
#     geom_point(data=vcdatas_limit, aes(x = timestamp,
#                                        y = cpu.swapwait.summation,
#                                        colour=item_id)) +
#     ylab("milliszekundum")
#xlab("dátum - idő") +
#    scale_colour_discrete(name="Virtuális gépek azonosítói")
# 
# filename <- paste("cpu.swapwait.summation-", STS, "-", ETS, ".png", sep="")
# 
# logger(paste("Plott mentése", filename, "néven...", sep=" "))
# 
# ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=20)


# ST <- "2012-08-27 10:00:00"
# ET <- "2012-08-27 10:05:00"
# 
# STS <- gsub("-", "", ST)
# STS <- gsub(":", "", STS)
# STS <- gsub(" ", "", STS)
# 
# ETS <- gsub("-", "", ET)
# ETS <- gsub(":", "", ETS)
# ETS <- gsub(" ", "", ETS)
# 
# 
# vcdatas_limit <- timestamp_filter(vcdatas, ST, ET)
# 
# v <- vcdatas_limit[,c("timestamp", "item_id", "cpu.swapwait.summation")]
# 
# plot <- ggplot() +
#     geom_line(data=vcdatas_limit, aes(x = timestamp,
#                                       y = cpu.swapwait.summation, 
#                                       colour=item_id)) +
#     geom_point(data=vcdatas_limit, aes(x = timestamp,
#                                        y = cpu.swapwait.summation,
#                                        colour=item_id)) +
#     ylab("milliszekundum")
# 
# filename <- paste("cpu.swapwait.summation-", STS, "-", ETS, ".png", sep="")
# 
# logger(paste("Plott mentése", filename, "néven...", sep=" "))
# 
# ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=20)

#
################################################################################




# 
# c("timestamp", "item_id", "sys.uptime.latest", "cpu.idle.summation", 
#   "cpu.idle.summation_0", "cpu.ready.summation", "cpu.ready.summation_0", 
#   "cpu.run.summation", "cpu.run.summation_0", "cpu.swapwait.summation", 
#   "cpu.swapwait.summation_0", "cpu.system.summation", "cpu.system.summation_0", 
#   "cpu.usage.average", "cpu.usagemhz.average", "cpu.usagemhz.average_0", 
#   "cpu.used.summation", "cpu.used.summation_0", "cpu.wait.summation", 
#   "cpu.wait.summation_0", "cpu.usage.average_0", "cpu.usage.average_1", 
#   "cpu.usage.average_2", "cpu.usage.average_3", "cpu.used.summation_1", 
#   "cpu.used.summation_2", "cpu.used.summation_3")

# vcd <- get_machine(vcdatas_limit, "guest-11")
# 
# vcd$calc <- vcd$cpu.run.summation_0 + vcd$cpu.wait.summation_0 + vcd$cpu.ready.summation_0
# 
# print(unique(vcd$calc))
# 
# library(iplots)
# 
# ihist(vcd$calc)
# 
# vcd$calc2 <- vcd$cpu.idle.summation_0 + vcd$cpu.swapwait.summation_0 #+ vcd$cpu.system.summation_0 <---- I/O wait
# 
# vcd$calc2wait <- vcd$cpu.wait.summation_0 - vcd$calc2
# 
# max(unique(vcd$calc2wait))
# min(unique(vcd$calc2wait))
# 
# 
# ihist(vcd$calc2wait)
# 
# 
# 
# vcd$calcusedrun <- vcd$cpu.run.summation_0 - (vcd$cpu.used.summation_0 + vcd$cpu.system.summation_0)
# 
# max(unique(vcd$calcusedrun))
# min(unique(vcd$calcusedrun))
# 
# ihist(vcd$calcusedrun)
# 
# vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_cpu_infos.RData"))
# 
# vcdatas_limit <- timestamp_filter(vcdatas, "2012-09-10 12:00:00",
#                                   "2012-09-10 13:00:00")
# 
# vcd <- get_machine(vcdatas_limit, "host-01")
# 
# df <- cbind(vcd$cpu.usage.average, vcd$cpu.usagemhz.average)
# 
# unique(vcd$cpu.usagemhz.average)
# 
# library(corrgram)
# 
# corrgram(df, order=TRUE, lower.panel=panel.shade,
#          upper.panel=panel.pie, text.panel=panel.txt,
#          main="a")
# 
# 
# 
# plot <- ggplot() +
# 
# 
#     
#     geom_line(data=vcd, aes(x = timestamp, y = cpu.wait.summation_0, colour="1")) +
#     geom_point(data=vcd, aes(x = timestamp, y = cpu.wait.summation_0, colour="1")) +
#     
#     geom_line(data=vcd, aes(x = timestamp, y = cpu.ready.summation_0, colour="2")) +
#     geom_point(data=vcd, aes(x = timestamp, y = cpu.ready.summation_0, colour="2")) +
#     
#     geom_line(data=vcd, aes(x = timestamp, y = cpu.run.summation_0, colour="3")) +
#     geom_point(data=vcd, aes(x = timestamp, y = cpu.run.summation_0, colour="3")) +
#     
#     geom_line(data=vcd, aes(x = timestamp, y = calc, colour="4")) +
#     geom_point(data=vcd, aes(x = timestamp, y = calc, colour="4")) +
#     
#     labs(y = "milliseconds") +
#     
#     scale_colour_manual(values=c("#FF0000", "#00FF00", "#0000FF", "#000000"),
#                         name="CPU",
#                         labels=c("wait", "ready", "run", "calc"))
# 
# filename <- "cpu.metrics.calc.png"
# 
# logger(paste("Plott mentése", filename, "néven...", sep=" "))
# 
# ggsave(plot=plot, 
#        filename=file.path(OUTPUT_PATH, filename), 
#        height=6, width=20)
# 







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
