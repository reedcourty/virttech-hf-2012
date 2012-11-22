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
BASE_PATH <- "c:/Users/reedcourty/git/virttech-hf-2012/"

# A bemeneti állományokat tartalmazó könyvtár:
INPUT_PATH <- file.path(BASE_PATH, "anonym_datas_output")

# A kimeneti állományok ide fognak kerülni:
OUTPUT_PATH <- file.path(BASE_PATH, "anonym_datas_output")

# Létrehozzuk a kimeneti könyvtárat (ha már létezik, akkor Warningot kapnánk,
# de a suppressWarnings függvénnyel elrejtjük):
suppressWarnings(dir.create(OUTPUT_PATH))

# A futás során keletkezett logokat ide tesszük:
LOG_FILE <- file.path(BASE_PATH, "anonym.R.log")

logger("")
logger("################################################################################")
logger("")

################################################################################

# Szeretnénk tudni a script futási idejét, ezért elmentjük a jelenlegi időt:
start_time <- Sys.time()
logger(paste("A futás kezdete:", start_time, sep=" "))

################################################################################

# Betöltjük a szükséges RData-t:
vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas.RData"))

# Kiszedjük az IQN-ből a host azonosítókat:
# Mivel ezt csak a tényleges IQN azonosítók használatával lehetséges, ezért
# itt egy külső, a repository-ban nem szereplő függvényt hívunk meg. A függvény
# megkeresi a kérdéses oszlopokat és átnevezi az IQN értékeket nem azonosítható
# értékekre.
# Pl.: 
# names(vcdatas)[names(vcdatas)=="storagepath.totalreadlatency.average_iqn..."] 
#       <- "storagepath.totalreadlatency.average_iqn.com.vmware.host01"

# A függvény beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/anonym_iqn.R", 
       encoding = "UTF-8")

# A függvény meghívása:
vcdatas <- anonym_iqn(vcdatas)

################################################################################
# Mentünk:

save_data(vcdatas, "vcenter_datas.anonym", tsv=FALSE)

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
