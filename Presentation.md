Lien entre le statut "Bonus" d'une station et son altitude
========================================================
author: Antoine CARON, Adrien Chaussende, Alexandre Galdéano, Cédric Ginot, Thomas Coquan, Sophie Perraud
date: Octobre 2015

Le Bonus
========================================================

Nous nous sommes intéressé à la façon dont JCDECAUX avait groupé ses stations pour former:
- Les stations avec Bonus
- Les stations sans Bonus

Analyse de l'altitude des Stations
========================================================


```
    ALTITUDE    
 Min.   :163.5  
 1st Qu.:172.3  
 Median :175.0  
 Mean   :184.3  
 3rd Qu.:180.1  
 Max.   :287.2  
```

Répartition des altitudes de stations
========================================================

![plot of chunk unnamed-chunk-2](Presentation-figure/unnamed-chunk-2-1.png) 

Groupements par altitudes de stations
========================================================

![plot of chunk unnamed-chunk-3](Presentation-figure/unnamed-chunk-3-1.png) 
***
![plot of chunk unnamed-chunk-4](Presentation-figure/unnamed-chunk-4-1.png) 

Visualisation du groupement
========================================================



![plot of chunk unnamed-chunk-6](Presentation-figure/unnamed-chunk-6-1.png) 
***
![plot of chunk unnamed-chunk-7](Presentation-figure/unnamed-chunk-7-1.png) 

Groupement par "Bonus" actuel
========================================================
![plot of chunk unnamed-chunk-8](Presentation-figure/unnamed-chunk-8-1.png) 

Comparaison entre les deux groupements
========================================================

![plot of chunk unnamed-chunk-9](Presentation-figure/unnamed-chunk-9-1.png) 
***
![plot of chunk unnamed-chunk-10](Presentation-figure/unnamed-chunk-10-1.png) 

Vérifications
========================================================


```r
cor.test(cl2$cluster, stationBonus$BONUS)
```

```

	Pearson's product-moment correlation

data:  cl2$cluster and stationBonus$BONUS
t = -0.72886, df = 345, p-value = 0.4666
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 -0.14389896  0.06634603
sample estimates:
        cor 
-0.03921043 
```

Conclusion
========================================================

Le choix du bonus ne dépend donc uniquement que de l'altitude de la station.
Il reste à montrer que l'altitude impacte l'utilisation de la station.


