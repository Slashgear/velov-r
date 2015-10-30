Projet BI - Les Vélovs
========================================================
author: Antoine CARON, Adrien Chaussende, Alexandre Galdéano, Cédric Ginot, Thomas Coquan, Sophie Perraud
date: Octobre 2015


Présentation générale
========================================================
L’idée principales : connaître les conditions d’utilisation des vélovs, notamment par rapport à la météo.

Récupération des données via trois webservices :
* État des velovs : Webservices de JCDecaux
* État de la météo : Webservices de Forecast.io
* Altitude des stations vélovs : Webservices de Google

Utilisation unique de l'Open-Data


Nos KPI
========================================================
* Quelle est l'influence de la météo sur l'utilisation des Velovs ?
* Quelle est l'influence d'une station en panne, vide ou pleine sur les stations voisines ?
* Identifier différents groupes de stations.
* Comment ont-été mis en place les stations bonus ?
* Quelles sont les stations les plus actives et les moins actives ?
* Identifier des facteurs de pannes et la récurrence de celle-ci.
* Quelles sont les horaires de forte activité ?
* Quel est l'influence des week-ends ...

Un projet en plusieurs étapes
========================================================

//TODO faire un shéma
Collecte des données par sh et CRON

Traitement des JSON en sql

Import des SQL dans l'ODS

ETL pour l'EDD (SQL et Talend)

Reporting R et QlikSense


Le Bonus
========================================================
type: sub-section
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
t = 0.72886, df = 345, p-value = 0.4666
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 -0.06634603  0.14389896
sample estimates:
       cor 
0.03921043 
```


L'influence de l'altitude sur l'activité d'une station
========================================================
type: sub-section

**Saturation** d'une station = Vélos/ (emplacements vide + Vélos)

**Activité** d'une station correspond à la dispersion des valeurs de saturation. On utilise donc la variance.


Gourpement par Activité
========================================================
![plot of chunk unnamed-chunk-12](Presentation-figure/unnamed-chunk-12-1.png) 
***
![plot of chunk unnamed-chunk-13](Presentation-figure/unnamed-chunk-13-1.png) 

Voisines Vides
========================================================
type: sub-section
![plot of chunk unnamed-chunk-14](Presentation-figure/unnamed-chunk-14-1.png) 
***
**Voisinage d'une station** = l'ensemble des stations situées à moins de 275m.

Voisines Vides
========================================================

![plot of chunk unnamed-chunk-15](Presentation-figure/unnamed-chunk-15-1.png) 
***

```

	Pearson's product-moment correlation

data:  stationEx$SATURATION and stationEx$STAT_VIDES
t = -4.8957, df = 7, p-value = 0.001762
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 -0.9745060 -0.5186647
sample estimates:
       cor 
-0.8797506 
```


Résultats obtenus avec Qlik
========================================================
type: sub-section


Conclusion
========================================================

Le choix du bonus dépend donc uniquement que de l'altitude de la station.
Il reste à montrer que l'altitude impacte l'utilisation de la station.

Pour aller plus loin
========================================================
type: prompt
Grâce à cette collecte de données nous pourrions être en mesure de mettre en place un modèle prédictif afin de permettre aux usagers des Vélovs de déterminer à l'avance si un vélo ou emplacement sera disponible dans le futur.

Il serait intéressant de lier cela avec le projet Web "Lyon Vélov"
