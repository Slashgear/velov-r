options(encoding="UTF8")
require(xts)

#velov <- read.csv2("EDD/fait.csv", header = TRUE, sep = ";", quote = "\"")

s_velov <- velov[velov$ID_STATION == 2014,]
View(s_velov)
s_velov$ID_TEMPS <-  as.POSIXct(strptime(s_velov$ID_TEMPS, "%d/%m/%y %H:%M:%S"))
s_velov.ts <- xts(s_velov, order.by=s_velov$ID_TEMPS)
View(s_velov)
View(s_velov.ts)
png("saturation-plot-2014.jpg")
plot.ts(s_velov.ts$SATURATION['2015-09-20/2015-09-27'],main="Evolution saturation station 2014 sur 2015-09-20/2015-09-27",xlab="Temps",ylab="saturation")
line <- mean(as.numeric(s_velov.ts$SATURATION['2015-09-20/2015-09-27']))
abline(h = line)
dev.off()
