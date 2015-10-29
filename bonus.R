options(encoding="UTF8")
require(ggmap)
require(mapproj)

stations <- read.csv2("EDD/stations.csv", header = TRUE, sep = ";", quote = "\"")
velov <- read.csv2("EDD/fait.csv", header = TRUE, sep = ";", quote = "\"")
bonus <- factor(velov$BONUS)
velov$BONUS <- as.integer(bonus)
velov <- aggregate(velov,by=list(velov$ID_STATION),FUN="mean")
velov <- subset(velov, select=c("ID_STATION", "BONUS"))
stationBonus <- merge(x = stations,y = velov)


mapImageData1 <- get_map(location = c(lon = 4.850000, lat = 45.750000),
                         source = "google",
                         zoom = 12)

png(filename="current-bonus.jpg")
d <- data.frame(lat=stationBonus$LONGITUDE,
                lon=stationBonus$LATITUDE,stationBonus$BONUS)
a <- ggmap(mapImageData1, extent = "panel",legend="topright")
a <- a + geom_point(data=d, aes(x = lat,y = lon),colour=stationBonus$BONUS)
a <- a + ggtitle("Stations avec Bonus")
plot(a)
dev.off()

alt <- stationBonus$ALTITUDE
cl2 <- kmeans(alt, 2)

print(cor.test(cl2$cluster, stationBonus$BONUS))
