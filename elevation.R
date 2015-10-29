options(encoding="UTF8")
require(ggmap)
require(mapproj)

png(filename="stations-boxplot-altitude.jpg")
stations <- read.csv2("EDD/stations.csv", header = TRUE, sep = ";", quote = "\"")
alt <- stations$ALTITUDE
boxplot(alt,horizontal=T,main="Altitude des Stations")
dev.off()

png(filename="stations-cluster-altitude.jpg")
par(mfrow=c(2,2))
cl2 <- kmeans(alt, 2)
cl3 <- kmeans(alt, 3)
cl4 <- kmeans(alt, 4)
cl5 <- kmeans(alt, 5)
dunn2 <- cl2$betweenss/cl2$totss
dunn3 <- cl3$betweenss/cl3$totss
dunn4 <- cl4$betweenss/cl4$totss
dunn5 <- cl5$betweenss/cl5$totss
plot(alt, col = cl2$cluster,main="2 groupes d'altitude",sub=dunn2,ylab="Altitude en m")
plot(alt, col = cl3$cluster,main="3 groupes d'altitude",sub=dunn3,ylab="Altitude en m")
plot(alt, col = cl4$cluster,main="4 groupes d'altitude",sub=dunn4,ylab="Altitude en m")
plot(alt, col = cl5$cluster,main="5 groupes d'altitude",sub=dunn5,ylab="Altitude en m")
dev.off()


mapImageData1 <- get_map(location = c(lon = 4.850000, lat = 45.750000),
                         source = "google",
                         zoom = 12)

png(filename="stations-altitude-3.jpg")
d <- data.frame(lat=stations$LONGITUDE,
                lon=stations$LATITUDE,cl3$cluster)
a <- ggmap(mapImageData1, extent = "panel")
a <- a + geom_point(data=d, aes(x = lat,y = lon), colour=cl3$cluster)
a <- a + ggtitle("Classement des stations en 3 groupes")
plot(a)
dev.off()

png(filename="stations-altitude-4.jpg")
d <- data.frame(lat=stations$LONGITUDE,
                lon=stations$LATITUDE,cl4$cluster)
a <- ggmap(mapImageData1, extent = "panel")
a <- a + geom_point(data=d, aes(x = lat,y = lon), colour=cl4$cluster)
a <- a + ggtitle("Classement des stations en 4 groupes")
plot(a)
dev.off()

png(filename="stations-altitude-2.jpg")
d <- data.frame(lat=stations$LONGITUDE,
                lon=stations$LATITUDE,cl2$cluster)
a <- ggmap(mapImageData1, extent = "panel")
a <- a + geom_point(data=d, aes(x = lat,y = lon), colour=cl2$cluster)
a <- a + ggtitle("Classement des stations en 2 groupes")
plot(a)
dev.off()
