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

# Az alap könyvtárunk elérési útvonala:
BASE_PATH <- "c:/Users/reedcourty/git/virttech-hf-2012/"

# A bemeneti állományokat tartalmazó könyvtár:
INPUT_PATH <- file.path(BASE_PATH, "datas")

# A kimeneti állományok ide fognak kerülni:
OUTPUT_PATH <- file.path(BASE_PATH, "datas")

# Létrehozzuk a kimeneti könyvtárat (ha már létezik, akkor Warningot kapnánk,
# de a suppressWarnings függvénnyel elrejtjük):
suppressWarnings(dir.create(OUTPUT_PATH))

# A futás során keletkezett logokat ide tesszük:
LOG_FILE <- file.path(BASE_PATH, "get_metrics_by_cols.R.log")

logger("")
logger("################################################################################")
logger("")

################################################################################

# Szeretnénk tudni a script futási idejét, ezért elmentjük a jelenlegi időt:
start_time <- Sys.time()
logger(paste("A futás kezdete:", start_time, sep=" "))

################################################################################

vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_cleaned.RData"))

################################################################################
#
# cpu.swapwait.summation
cols <- c(rep("timestamp"), rep("item_id"), rep("cpu.swapwait.summation"),
          rep("cpu.swapwait.summation_0"))
 
vcd_cpu_infos_swapwait <- vcdatas[,cols]
 
save_data(data=vcd_cpu_infos_swapwait, 
          filename="vcenter_datas_cpu_infos_swapwait", tsv=FALSE)
 
rm(vcd_cpu_infos_swapwait)

################################################################################
#
# cpu.idle.summation
cols <- c(rep("timestamp"), rep("item_id"), rep("cpu.idle.summation"),
          rep("cpu.idle.summation_0"))

vcd_cpu_infos_idle <- vcdatas[,cols]

save_data(data=vcd_cpu_infos_idle, 
          filename="vcenter_datas_cpu_infos_idle", tsv=FALSE)

rm(vcd_cpu_infos_idle)

################################################################################
#
# cpu.ready.summation
cols <- c(rep("timestamp"), rep("item_id"), rep("cpu.ready.summation"),
          rep("cpu.ready.summation_0"))

vcd_cpu_infos_ready <- vcdatas[,cols]

save_data(data=vcd_cpu_infos_ready, 
          filename="vcenter_datas_cpu_infos_ready", tsv=FALSE)

rm(vcd_cpu_infos_ready)

################################################################################
#
# Hálózattal kapcsolatos metrikák: 
# cols <- names(vcdatas)
# cols_net <- subset(cols, grepl(pattern="net", cols))
# cols <- c(rep("timestamp"), rep("item_id"), rep("sys.uptime.latest"), cols_net)
# 
# vcd_net_infos <- vcdatas[,cols]
# 
# save_data(data=vcd_net_infos, filename="vcenter_datas_net_infos", tsv=FALSE)
# 
# rm(vcd_net_infos)

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
