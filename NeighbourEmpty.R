options(encoding="UTF8")

#Load files
stations <- read.csv2("EDD/stations.csv", header = TRUE, sep = ";", quote = "\"")
velov <- read.csv2("EDD/fait.csv", header = TRUE, sep = ";", quote = "\"")

#Select columns
velov <- subset(velov, select=c("ID_STATION", "SATURATION","STAT_VIDES"))
stations <- subset(stations, select=c("ID_STATION","NOM_STATION","LATITUDE","LONGITUDE"))

#Group by station and stat
velov <- aggregate(velov,by=list(velov$ID_STATION,velov$STAT_VIDES),FUN="mean")

#Merge infos
stationBonus <- merge(x = stations,y = velov)

print(cor.test(stationBonus$SATURATION, stationBonus$STAT_VIDES))
png(filename="stations-saturation-neighbourEmpty.jpg")
plot(stationBonus$SATURATION,stationBonus$STAT_VIDES,main="Saturation moyenne/nombre de voisines vides",xlab="Saturation moyenne",ylab="Nombre de voisines vides")
dev.off()

#Example on some stations
png(filename="stations-saturation-neighbourEmpty-1021.jpg")
stationEx <- stationBonus[stationBonus$ID_STATION == 1021,]
print(cor.test(stationEx$SATURATION, stationEx$STAT_VIDES))
plot(stationEx$SATURATION,stationEx$STAT_VIDES,main="Saturation moyenne/nombre de voisines vides - Station 1021",xlab="Saturation moyenne",ylab="Nombre de voisines vides")
line <- lm(stationEx$STAT_VIDES ~ stationEx$SATURATION)
abline(line)
dev.off()


png(filename="stations-saturation-neighbourEmpty-2014.jpg")
stationEx <- stationBonus[stationBonus$ID_STATION == 2014,]
print(cor.test(stationEx$SATURATION, stationEx$STAT_VIDES))
plot(stationEx$SATURATION,stationEx$STAT_VIDES,main="Saturation moyenne/nombre de voisines vides - Station 2014",xlab="Saturation moyenne",ylab="Nombre de voisines vides")
line <- lm(stationEx$STAT_VIDES ~ stationEx$SATURATION)
abline(line)
dev.off()



png(filename="stations-saturation-neighbourFull-3087.jpg")
stationEx <- stationBonus[stationBonus$ID_STATION == 3087,]
print(cor.test(stationEx$SATURATION, stationEx$STAT_VIDES))
plot(stationEx$SATURATION,stationEx$STAT_VIDES,main="Saturation moyenne/nombre de voisines vides - Station 3087",xlab="Saturation moyenne",ylab="Nombre de voisines vides")
line <- lm(stationEx$STAT_VIDES ~ stationEx$SATURATION)
abline(line)
dev.off()
