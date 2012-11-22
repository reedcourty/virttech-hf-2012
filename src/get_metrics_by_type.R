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
LOG_FILE <- file.path(BASE_PATH, "get_metrics_by_type.R.log")

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
# Diskkel kapcsolatos metrikák: 
cols <- names(vcdatas)
cols_disk <- subset(cols, grepl(pattern="disk", cols))
cols_storage <- subset(cols, grepl(pattern="storage", cols))
cols <- c(rep("timestamp"), rep("item_id"), cols_disk, cols_storage)

vcd_disk_infos <- vcdatas[,cols]

save_data(data=vcd_disk_infos, filename="vcenter_datas_disk_infos", tsv=FALSE)

rm(vcd_disk_infos)

################################################################################
#
# Memóriával kapcsolatos metrikák: 
cols <- names(vcdatas)
cols_mem <- subset(cols, grepl(pattern="mem", cols))
cols <- c(rep("timestamp"), rep("item_id"), cols_mem)

vcd_mem_infos <- vcdatas[,cols]

save_data(data=vcd_mem_infos, filename="vcenter_datas_mem_infos", tsv=FALSE)

rm(vcd_mem_infos)

################################################################################
#
# CPU-val kapcsolatos metrikák: 
cols <- names(vcdatas)
cols_cpu <- subset(cols, grepl(pattern="cpu", cols))
cols <- c(rep("timestamp"), rep("item_id"), rep("sys.uptime.latest"), cols_cpu)

vcd_cpu_infos <- vcdatas[,cols]

save_data(data=vcd_cpu_infos, filename="vcenter_datas_cpu_infos", tsv=FALSE)

rm(vcd_cpu_infos)

################################################################################
#
# Hálózattal kapcsolatos metrikák: 
cols <- names(vcdatas)
cols_net <- subset(cols, grepl(pattern="net", cols))
cols <- c(rep("timestamp"), rep("item_id"), rep("sys.uptime.latest"), cols_net)

vcd_net_infos <- vcdatas[,cols]

save_data(data=vcd_net_infos, filename="vcenter_datas_net_infos", tsv=FALSE)

rm(vcd_net_infos)


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
