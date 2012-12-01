# A felhasznált library-k:
library(plyr)

# Saját külső modulok:
# Naplózó függvény beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/logger.R", 
       encoding = "UTF-8")

# A mentést segítő függvény beinclude-olása:
source("c:/Users/reedcourty/git/virttech-hf-2012/src/save_data.R", 
       encoding = "UTF-8")

# Az alap könyvtárunk elérési útvonala:
BASE_PATH <- "c:/Users/reedcourty/git/virttech-hf-2012/"

# A bemeneti állományokat tartalmazó könyvtár:
INPUT_PATH <- file.path(BASE_PATH, "anonym_datas_with_problem")

# A kimeneti állományok ide fognak kerülni:
OUTPUT_PATH <- file.path(BASE_PATH, "anonym_datas_output_with_problem")

# Létrehozzuk a kimeneti könyvtárat (ha már létezik, akkor Warningot kapnánk,
# de a suppressWarnings függvénnyel elrejtjük):
suppressWarnings(dir.create(OUTPUT_PATH))

# A futás során keletkezett logokat ide tesszük:
LOG_FILE <- file.path(BASE_PATH, "aggregator_wp.R.log")

logger("")
logger("################################################################################")
logger("")

################################################################################

# Szeretnénk tudni a script futási idejét, ezért elmentjük a jelenlegi időt:
start_time <- Sys.time()
logger(paste("A futás kezdete:", start_time, sep=" "))

################################################################################

# Összegyűjtjük a bementi könyvtár tartalmát:
INPUT_LOG_FILES <- file.path(INPUT_PATH,dir(INPUT_PATH))
# Nekünk csak az állományok kellenek, a könyvtárakat eldobjuk:
INPUT_LOG_FILES <- INPUT_LOG_FILES[!file.info(INPUT_LOG_FILES)$isdir]

INPUT_RFILE <- paste(OUTPUT_PATH, "vcenter_datas_wp.RData", sep="/")

# Csak a CPU metrikákra és a timestampre van szükségünk, a többi oszlopot
# skippeljük:

colskip <- c(NA)

for (c in seq(2, 70)) {
    if (c <= 26) {
        colskip <- c(colskip, rep(NA))
    }
    else {
        colskip <- c(colskip, rep("NULL"))
    }
}

# Végig megyünk az összes naplóállományon:
for (INPUT_FILE in INPUT_LOG_FILES) {
    
    logger(paste("A", OUTPUT_PATH, "állomány betöltése...", sep=" "))
    
    tryCatch(load(file=file.path(INPUT_RFILE)),
             error=function(e) {
                 logger(paste(INPUT_RFILE, "ezt a hibát dobta:", e, sep=" "));
                 if (charmatch("Error in readChar(con, 5L, useBytes = TRUE): cannot open the connection\n",e)) {
                     logger(paste("Az RData állomány létrehozása...", sep=" "))
                     vcdatas <- data.frame()
                     save_data(data=vcdatas, filename="vcenter_datas_wp", 
                               tsv=FALSE)
                     logger(paste("A", OUTPUT_PATH, "állomány betöltése...", 
                                  sep=" "))
                     load(file=file.path(INPUT_RFILE))
                 }
             }
    )
    
    vcdatas <- data
    rm(data)
    
    # Megszerezzük a naplóállomány nevét:
    filename <- basename(INPUT_FILE)
    
    splitted <- strsplit(filename,"-")
    item_id <- paste(splitted[[1]][1],splitted[[1]][2],sep="-")
    
    df <- data.frame()
    
    # Megnyitjuk a bemeneti állományt:
    logger(paste(filename, "megnyitása...", sep=" "))
    
    tryCatch(df <- read.table(INPUT_FILE, header=TRUE, sep=";", 
                              encoding="UTF-8", stringsAsFactors=FALSE, 
                              na.strings="NA", fill=TRUE, colClasses=colskip), 
             error=function(e) {
                 logger(paste(INPUT_FILE, "ezt a hibát dobta:", e, sep=" "));
             }
    )
    
    # Kiszedjük az oszlop nevéből az UTF-8 BOM-ot:
    if (grepl(pattern="^X.U.FEFF.", x=names(df)[1])) {
        names(df)[1] <- strsplit(x=names(df)[1], split="X.U.FEFF.")[[1]][2]
    }
    
    # Ha az utolsó oszlopunk nem szolgáltat adatot, akkor megszabadulunk tőle
    # (Az oszlopok felsorolásánal a sor végén van egy felesleges ";", ezért
    # van több oszlopunk, mint kellene):
    
    if (nrow(df) == nrow(subset(df, is.na(df$X)))) {
        df <- subset(df, select=-c(X))
    }
    
    # Hozzáadjuk az aktuális állomány nevet a df-hez:
    df <- data.frame(df, item_id)
    names(df)[which( colnames(df)=="item_id" )] <- c("item_id")
    
    # Átállítjuk az időlokalizációt "English"-re az adatok miatt:
    Sys.setlocale(category = "LC_TIME", locale = "English")
    #Sys.getlocale(category = "LC_ALL")
    
    # 08/26/2012 23:01:40
    df$timestamp <- strptime(df$timestamp, "%m/%d/%Y %H:%M:%S")
    
    # Visszaállítjuk az időlokalizációt:
    Sys.setlocale(category = "LC_TIME", locale = "Hungarian_Hungary.1250")
    #Sys.getlocale(category = "LC_ALL")
    
    vcdatas <- rbind.fill(vcdatas, df)
    rm(df)
    
    logger(paste("Az adathalmaz sorainak aktuális száma:", nrow(vcdatas), 
                 sep=" "))
    
    logger(paste("Az RData állomány mentése...", sep=" "))
    save_data(data=vcdatas, filename="vcenter_datas_wp", tsv=FALSE)
    
}

save_data(data=vcdatas, filename="vcenter_datas_wp", tsv=FALSE)

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