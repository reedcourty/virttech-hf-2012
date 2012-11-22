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

vcdatas <- load_file(file.path(INPUT_PATH, "vcenter_datas_net_infos.RData"))

ST <- "2012-09-10 20:00:00"
ET <- "2012-09-10 22:00:00"

STS <- gsub("-", "", ST)
STS <- gsub(":", "", STS)
STS <- gsub(" ", "", STS)

ETS <- gsub("-", "", ET)
ETS <- gsub(":", "", ETS)
ETS <- gsub(" ", "", ETS)

vcdatas_limit <- timestamp_filter(vcdatas, ST, ET)

cols <- names(vcdatas_limit)

sequence <- seq(from = 3, to = length(cols), by = 1)

for (i in sequence) {
    col <- as.character(names(vcdatas_limit)[i])
    
    logger(paste(col, "metrikák plottolása...", sep=" "))
    
    plot <- ggplot() +
        geom_line(data=vcdatas_limit, aes(x = timestamp, y = vcdatas_limit[, i], colour=item_id)) +
        geom_point(data=vcdatas_limit, aes(x = timestamp, y = vcdatas_limit[, i], colour=item_id)) +
        ylab(col)
    
    filename <- paste("net.metrics.", STS, "-", ETS, "-", col, ".png", sep="")
    
    logger(paste("Plott mentése", filename, "néven...", sep=" "))
    
    ggsave(plot=plot, 
           filename=file.path(OUTPUT_PATH, filename), 
           height=6, width=20)
}



v <- get_machine(vcdatas_limit, "host-01")
names(v)

max(v$net.transmitted.average)

max(v$net.transmitted.average_vmnic0)
max(v$net.transmitted.average_vmnic1)

v$calc <- v$net.transmitted.average_vmnic0 + v$net.transmitted.average_vmnic1
v$calc2 <- v$net.transmitted.average - v$calc

unique(v$calc2)

library(iplots)

ihist(v$calc2)

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
