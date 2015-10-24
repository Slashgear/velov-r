options(encoding="UTF8")
require(ggmap)
require(mapproj)

#Load files
stations <- read.csv2("EDD/stations.csv", header = TRUE, sep = ";", quote = "\"")
velov <- read.csv2("EDD/fait.csv", header = TRUE, sep = ";", quote = "\"")

#Select columns
velov <- subset(velov, select=c("ID_STATION", "SATURATION"))
stations <- subset(stations, select=c("ID_STATION","NOM_STATION","LATITUDE","LONGITUDE","ALTITUDE"))

#Group by ID_STATION and Mean
velov <- aggregate(velov,by=list(velov$ID_STATION),FUN="var")
velov$ID_STATION <- velov$Group.1

#Merge infos
stationBonus <- merge(x = stations,y = velov)

sat <- stationBonus$SATURATION

png(filename="stations-saturation.jpg")
boxplot(sat,horizontal=T,main="Variance de la saturation par station",xlab="Variance de la saturation")
dev.off()

#Scale
sat <- scale(sat)

png(filename="stations-saturation-clusters.jpg")
par(mfrow=c(2,2))
cl2 <- kmeans(sat, 2)
cl3 <- kmeans(sat, 3)
cl4 <- kmeans(sat, 4)
cl5 <- kmeans(sat, 5)
plot(sat, col = cl2$cluster)
plot(sat, col = cl3$cluster)
plot(sat, col = cl4$cluster)
plot(sat, col = cl5$cluster)
dev.off()

mapImageData1 <- get_map(location = c(lon = 4.850000, lat = 45.750000),
                         source = "google",
                         zoom = 12)

png(filename="stations-saturation-2.jpg")
d <- data.frame(lat=stationBonus$LONGITUDE,
             lon=stationBonus$LATITUDE,cl2$cluster)
a <- ggmap(mapImageData1, extent = "panel")
a <- a + geom_point(data=d, aes(x = lat,y = lon, colour=cl2$cluster), colour=cl2$cluster)
a <- a + ggtitle("Classement des stations en 2 groupes")
plot(a)
dev.off()

png(filename="stations-saturation-3.jpg")
d <- data.frame(lat=stationBonus$LONGITUDE,
             lon=stationBonus$LATITUDE,cl3$cluster)
a <- ggmap(mapImageData1, extent = "panel")
a <- a + geom_point(data=d, aes(x = lat,y = lon, colour=cl3$cluster), colour=cl3$cluster)
a <- a + ggtitle("Classement des stations en 3 groupes")
plot(a)
dev.off()

png(filename="stations-saturation-4.jpg")
d <- data.frame(lat=stationBonus$LONGITUDE,
             lon=stationBonus$LATITUDE,cl4$cluster)
a <- ggmap(mapImageData1, extent = "panel")
a <- a + geom_point(data=d, aes(x = lat,y = lon,  colour=cl4$cluster), colour=cl4$cluster)
a <- a + ggtitle("Classement des stations en 4 groupes")
plot(a)
dev.off()

png(filename="stations-saturation-5.jpg")
d <- data.frame(lat=stationBonus$LONGITUDE,
             lon=stationBonus$LATITUDE,cl5$cluster)
a <- ggmap(mapImageData1, extent = "panel")
a <- a + geom_point(data=d, aes(x = lat,y = lon, colour=cl5$cluster), colour=cl5$cluster)
a <- a + ggtitle("Classement des stations en 5 groupes")
plot(a)
dev.off()

print(cor.test(scale(stationBonus$ALTITUDE), stationBonus$SATURATION))

png(filename="stations-saturation-altitude.jpg")
plot(scale(stationBonus$ALTITUDE),stationBonus$SATURATION,main="Variance de la saturation par rapport à l'altitude",xlab="Altitude",ylab="Saturation")
line <- lm(scale(stationBonus$ALTITUDE) ~ stationBonus$SATURATION)
abline(line)
dev.off()

sat_alt <- matrix(c(scale(stationBonus$ALTITUDE), stationBonus$SATURATION),ncol=2)

cl_alt <- kmeans(sat_alt,2)

png(filename="stations-saturation-altitude-map-2.jpg")
d <- data.frame(lat=stationBonus$LONGITUDE,
             lon=stationBonus$LATITUDE,cl_alt$cluster)
a <- ggmap(mapImageData1, extent = "panel")
a <- a + geom_point(data=d, aes(x = lat,y = lon), colour=cl_alt$cluster)
a <- a + ggtitle("Groupement par Saturation et Altitude en 2 groupes")
plot(a)
dev.off()

sat_alt <- matrix(c(scale(stationBonus$ALTITUDE), stationBonus$SATURATION,cl_alt$cluster),ncol=3)

sat_alt1 <- matrix(sat_alt[sat_alt[, 3] == 1],ncol=3)
sat_alt2 <- matrix(sat_alt[sat_alt[, 3] == 2],ncol=3)

print(cor.test(sat_alt1[,1], sat_alt1[,2]))
png(filename="stations-saturation-altitude-groupe-1.jpg")
plot(sat_alt1[,1],sat_alt1[,2],main="Variance de la saturation par rapport à l'altitude Groupe 1",xlab="Altitude",ylab="Saturation")
line <- lm(sat_alt1[,1] ~ sat_alt1[,2])
abline(line)
dev.off()


print(cor.test(sat_alt2[,1], sat_alt2[,2]))
png(filename="stations-saturation-altitude-groupe-2.jpg")
plot(sat_alt2[,1],sat_alt2[,2],main="Variance de la saturation par rapport à l'altitude Groupe 2",xlab="Altitude",ylab="Saturation")
line <- lm(sat_alt2[,1] ~ sat_alt2[,2])
abline(line)
dev.off()
