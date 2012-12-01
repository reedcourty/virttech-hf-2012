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
INPUT_PATH_1 <- file.path(BASE_PATH, "datas-20120826-0904")
INPUT_PATH_2 <- file.path(BASE_PATH, "datas-20120905-0924")

# A kimeneti állományok ide fognak kerülni:
OUTPUT_PATH <- file.path(BASE_PATH, "datas")

# Létrehozzuk a kimeneti könyvtárat (ha már létezik, akkor Warningot kapnánk,
# de a suppressWarnings függvénnyel elrejtjük):
suppressWarnings(dir.create(OUTPUT_PATH))

# A futás során keletkezett logokat ide tesszük:
LOG_FILE <- file.path(BASE_PATH, "longterm_aggregato.R.log")

logger("")
logger("################################################################################")
logger("")

################################################################################

# Szeretnénk tudni a script futási idejét, ezért elmentjük a jelenlegi időt:
start_time <- Sys.time()
logger(paste("A futás kezdete:", start_time, sep=" "))

################################################################################

vcdatas1 <- load_file(file.path(INPUT_PATH_1, "vcenter_datas_cleaned.RData"))

logger(paste("Az első adathalmaz sorainak száma:", nrow(vcdatas1), sep=" "))

vcdatas2 <- load_file(file.path(INPUT_PATH_2, "vcenter_datas_cleaned.RData"))

logger(paste("A második adathalmaz sorainak száma:", nrow(vcdatas2), sep=" "))

vcdatas_limit <- timestamp_filter(vcdatas2, min(vcdatas2$timestamp),
                                  "2012-09-30 00:00:00")
rm(vcdatas2)

vcdatas <- data.frame()
vcdatas <- rbind(vcdatas1, vcdatas_limit)

rm(vcdatas1)

save_data(data=vcdatas, filename="vcenter_datas_cleaned", tsv=FALSE)

rm(vcdatas)
rm(vcdatas_limit)

# ################################################################################
# 
# vcdatas1 <- load_file(file.path(INPUT_PATH_1, "vcenter_datas_cpu_infos.RData"))
# 
# logger(paste("Az első adathalmaz sorainak száma:", nrow(vcdatas1), sep=" "))
# 
# vcdatas2 <- load_file(file.path(INPUT_PATH_2, "vcenter_datas_cpu_infos.RData"))
# 
# logger(paste("A második adathalmaz sorainak száma:", nrow(vcdatas2), sep=" "))
# 
# vcdatas <- data.frame()
# vcdatas <- rbind(vcdatas1, vcdatas2)
# 
# rm(vcdatas1)
# rm(vcdatas2)
# 
# save_data(data=vcdatas, filename="vcenter_datas_cpu_infos", tsv=FALSE)
# 
# ################################################################################
# 
# vcdatas1 <- load_file(file.path(INPUT_PATH_1, "vcenter_datas_disk_infos.RData"))
# 
# logger(paste("Az első adathalmaz sorainak száma:", nrow(vcdatas1), sep=" "))
# 
# vcdatas2 <- load_file(file.path(INPUT_PATH_2, "vcenter_datas_disk_infos.RData"))
# 
# logger(paste("A második adathalmaz sorainak száma:", nrow(vcdatas2), sep=" "))
# 
# vcdatas <- data.frame()
# vcdatas <- rbind(vcdatas1, vcdatas2)
# 
# rm(vcdatas1)
# rm(vcdatas2)
# 
# save_data(data=vcdatas, filename="vcenter_datas_disk_infos", tsv=FALSE)
# 
# ################################################################################
# 
# vcdatas1 <- load_file(file.path(INPUT_PATH_1, "vcenter_datas_mem_infos.RData"))
# 
# logger(paste("Az első adathalmaz sorainak száma:", nrow(vcdatas1), sep=" "))
# 
# vcdatas2 <- load_file(file.path(INPUT_PATH_2, "vcenter_datas_mem_infos.RData"))
# 
# logger(paste("A második adathalmaz sorainak száma:", nrow(vcdatas2), sep=" "))
# 
# vcdatas <- data.frame()
# vcdatas <- rbind(vcdatas1, vcdatas2)
# 
# rm(vcdatas1)
# rm(vcdatas2)
# 
# save_data(data=vcdatas, filename="vcenter_datas_mem_infos", tsv=FALSE)
# 
# ################################################################################
# 
# vcdatas1 <- load_file(file.path(INPUT_PATH_1, "vcenter_datas_net_infos.RData"))
# 
# logger(paste("Az első adathalmaz sorainak száma:", nrow(vcdatas1), sep=" "))
# 
# vcdatas2 <- load_file(file.path(INPUT_PATH_2, "vcenter_datas_net_infos.RData"))
# 
# logger(paste("A második adathalmaz sorainak száma:", nrow(vcdatas2), sep=" "))
# 
# vcdatas <- data.frame()
# vcdatas <- rbind(vcdatas1, vcdatas2)
# 
# rm(vcdatas1)
# rm(vcdatas2)
# 
# save_data(data=vcdatas, filename="vcenter_datas_net_infos", tsv=FALSE)

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
