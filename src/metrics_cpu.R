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

vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_cpu_infos.RData"))

# vcdatas_limit <- timestamp_filter(vcdatas, "2012-09-10 12:00:00",
#                                  "2012-09-10 13:00:00")
#
# vcdatas_limit <- vcdatas
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
#         ylab(col)
#     
#     filename <- paste("cpu.metrics.", col, ".png", sep="")
#     
#     logger(paste("Plott mentése", filename, "néven...", sep=" "))
#     
#     ggsave(plot=plot, 
#            filename=file.path(OUTPUT_PATH, filename), 
#            height=6, width=20)
# }

################################################################################
#
# cpu.swapwait.summation:
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
# filename <- "cpu.swapwait.summation.png"
# 
# logger(paste("Plott mentése", filename, "néven...", sep=" "))
#      
# ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=20)


ST <- "2012-09-13 10:31:15"
ET <- "2012-09-13 10:33:30"

STS <- gsub("-", "", ST)
STS <- gsub(":", "", STS)
STS <- gsub(" ", "", STS)

ETS <- gsub("-", "", ET)
ETS <- gsub(":", "", ETS)
ETS <- gsub(" ", "", ETS)


vcdatas_limit <- timestamp_filter(vcdatas, ST, ET)

plot <- ggplot() +
    geom_line(data=vcdatas_limit, aes(x = timestamp, 
                                      y = cpu.swapwait.summation, 
                                      colour=item_id)) +
    geom_point(data=vcdatas_limit, aes(x = timestamp,
                                       y = cpu.swapwait.summation,
                                       colour=item_id)) +
    ylab("milliszekundum")

filename <- paste("cpu.swapwait.summation-", STS, "-", ETS, ".png", sep="")

logger(paste("Plott mentése", filename, "néven...", sep=" "))

ggsave(plot=plot, filename=file.path(OUTPUT_PATH, filename), height=6, width=20)

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
