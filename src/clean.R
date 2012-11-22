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

# Az alap könyvtárunk elérési útvonala:
BASE_PATH <- "c:/Users/reedcourty/git/virttech-hf-2012"

# A bemeneti állományokat tartalmazó könyvtár:
INPUT_PATH <- file.path(BASE_PATH, "anonym_datas_output")

# A kimeneti állományok ide fognak kerülni:
OUTPUT_PATH <- file.path(BASE_PATH, "datas")

# Létrehozzuk a kimeneti könyvtárat (ha már létezik, akkor Warningot kapnánk,
# de a suppressWarnings függvénnyel elrejtjük):
suppressWarnings(dir.create(OUTPUT_PATH))

# A futás során keletkezett logokat ide tesszük:
LOG_FILE <- file.path(BASE_PATH, "clean.R.log")

logger("")
logger("################################################################################")
logger("")

################################################################################

# Szeretnénk tudni a script futási idejét, ezért elmentjük a jelenlegi időt:
start_time <- Sys.time()
logger(paste("A futás kezdete:", start_time, sep=" "))

################################################################################

# Szeretnénk tudni a script futási idejét, ezért elmentjük a jelenlegi időt:
start_time <- Sys.time()
logger(paste("A futás kezdete:", start_time, sep=" "))

################################################################################

# Betöltjük a szükséges RData-t:
vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas.anonym.RData"))

# Oszlopnevek alakítása:
colnames <- names(vcdatas)

# Levágjuk az oszlopvégi "_"-t:
for (col in colnames) {
    if (grepl("_$", col)) {
        new_col <- gsub("_$", "", col)
        logger(paste(col, "oszlop átnevezése...", "Új név:", new_col , sep=" "))
        names(vcdatas)[names(vcdatas)==col] <- new_col
    }
}

names(vcdatas)[names(vcdatas)=="disk.commands.summation_mpx.vmhba32.C0.T0.L0"] <- "disk.commands.summation_mpx"
names(vcdatas)[names(vcdatas)=="disk.commands.summation_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.commands.summation_t10"
names(vcdatas)[names(vcdatas)=="disk.commandsAborted.summation_mpx.vmhba32.C0.T0.L0"] <- "disk.commandsAborted.summation_mpx"
names(vcdatas)[names(vcdatas)=="disk.commandsAborted.summation_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.commandsAborted.summation_t10"
names(vcdatas)[names(vcdatas)=="disk.deviceLatency.average_mpx.vmhba32.C0.T0.L0"] <- "disk.deviceLatency.average_mpx"
names(vcdatas)[names(vcdatas)=="disk.deviceLatency.average_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.deviceLatency.average_t10"
names(vcdatas)[names(vcdatas)=="disk.kernelLatency.average_mpx.vmhba32.C0.T0.L0"] <- "disk.kernelLatency.average_mpx"
names(vcdatas)[names(vcdatas)=="disk.kernelLatency.average_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.kernelLatency.average_t10"
names(vcdatas)[names(vcdatas)=="disk.queueLatency.average_mpx.vmhba32.C0.T0.L0"] <- "disk.queueLatency.average_mpx"
names(vcdatas)[names(vcdatas)=="disk.queueLatency.average_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.queueLatency.average_t10"
names(vcdatas)[names(vcdatas)=="disk.totallatency.average_mpx.vmhba32.C0.T0.L0"] <- "disk.totallatency.average_mpx"
names(vcdatas)[names(vcdatas)=="disk.totallatency.average_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.totallatency.average_t10"
names(vcdatas)[names(vcdatas)=="disk.totalreadlatency.average_mpx.vmhba32.C0.T0.L0"] <- "disk.totalreadlatency.average_mpx"
names(vcdatas)[names(vcdatas)=="disk.totalreadlatency.average_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.totalreadlatency.average_t10"
names(vcdatas)[names(vcdatas)=="disk.totalwritelatency.average_mpx.vmhba32.C0.T0.L0"] <- "disk.totalwritelatency.average_mpx"
names(vcdatas)[names(vcdatas)=="disk.totalwritelatency.average_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.totalwritelatency.average_t10"
names(vcdatas)[names(vcdatas)=="disk.numberRead.summation_mpx.vmhba32.C0.T0.L0"] <- "disk.numberRead.summation_mpx"
names(vcdatas)[names(vcdatas)=="disk.numberRead.summation_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.numberRead.summation_t10"
names(vcdatas)[names(vcdatas)=="disk.numberWrite.summation_mpx.vmhba32.C0.T0.L0"] <- "disk.numberWrite.summation_mpx"
names(vcdatas)[names(vcdatas)=="disk.numberWrite.summation_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.numberWrite.summation_t10"
names(vcdatas)[names(vcdatas)=="disk.read.average_mpx.vmhba32.C0.T0.L0"] <- "disk.read.average_mpx"
names(vcdatas)[names(vcdatas)=="disk.read.average_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.read.average_t10"
names(vcdatas)[names(vcdatas)=="disk.write.average_mpx.vmhba32.C0.T0.L0"] <- "disk.write.average_mpx"
names(vcdatas)[names(vcdatas)=="disk.write.average_t10.SCST_FIOitimagesvol_3729fe61"] <- "disk.write.average_t10"

################################################################################
#
# A hibás sorokat (új eszközök megjelenése az adatok gyűjtése közben) elhajigáljuk:
# Több metrika van egy sorban, ilyenkor ezek új sorba kerülnek, hiányzó 
# oszlopértékekkel (pl. timestamp), ezért ezeket eldobjuk:
#
# vcdatas <- subset(vcdatas, is.na(vcdatas$timestamp)==FALSE)

################################################################################
# Mentünk:
save_data(vcdatas, "vcenter_datas_cleaned", tsv=FALSE)


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
