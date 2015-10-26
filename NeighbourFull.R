options(encoding="UTF8")

#Load files
stations <- read.csv2("EDD/stations.csv", header = TRUE, sep = ";", quote = "\"")
velov <- read.csv2("EDD/fait.csv", header = TRUE, sep = ";", quote = "\"")

#Select columns
velov <- subset(velov, select=c("ID_STATION", "SATURATION","STAT_PLEINES"))
stations <- subset(stations, select=c("ID_STATION","NOM_STATION","LATITUDE","LONGITUDE"))

#Group by station and stat
velov <- aggregate(velov,by=list(velov$ID_STATION,velov$STAT_PLEINES),FUN="mean")

#Merge infos
stationBonus <- merge(x = stations,y = velov)

print(cor.test(stationBonus$SATURATION, stationBonus$STAT_PLEINES))
png(filename="stations-saturation-neighbourFull.jpg")
plot(stationBonus$SATURATION,stationBonus$STAT_PLEINES,main="Saturation moyenne/nombre de voisines pleines",xlab="Saturation moyenne",ylab="Nombre de voisines pleines")
dev.off()

#Example on some stations
png(filename="stations-saturation-neighbourFull-1021.jpg")
stationEx <- stationBonus[stationBonus$ID_STATION == 1021,]
print(cor.test(stationEx$SATURATION, stationEx$STAT_PLEINES))
plot(stationEx$SATURATION,stationEx$STAT_PLEINES,main="Saturation moyenne/nombre de voisines pleines - Station 1021",xlab="Saturation moyenne",ylab="Nombre de voisines pleines")
line <- lm(stationEx$STAT_PLEINES ~ stationEx$SATURATION)
abline(line)
dev.off()


png(filename="stations-saturation-neighbourFull-2014.jpg")
stationEx <- stationBonus[stationBonus$ID_STATION == 2014,]
print(cor.test(stationEx$SATURATION, stationEx$STAT_PLEINES))
plot(stationEx$SATURATION,stationEx$STAT_PLEINES,main="Saturation moyenne/nombre de voisines pleines - Station 2014",xlab="Saturation moyenne",ylab="Nombre de voisines pleines")
line <- lm(stationEx$STAT_PLEINES ~ stationEx$SATURATION)
abline(line)
dev.off()



png(filename="stations-saturation-neighbourFull-3087.jpg")
stationEx <- stationBonus[stationBonus$ID_STATION == 3087,]
print(cor.test(stationEx$SATURATION, stationEx$STAT_PLEINES))
plot(stationEx$SATURATION,stationEx$STAT_PLEINES,main="Saturation moyenne/nombre de voisines pleines - Station 3087",xlab="Saturation moyenne",ylab="Nombre de voisines pleines")
line <- lm(stationEx$STAT_PLEINES ~ stationEx$SATURATION)
abline(line)
dev.off()
