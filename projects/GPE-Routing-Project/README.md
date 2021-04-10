# [Gestion de Projet 2, M2 SIA] 
## Grand Paris Express Routing
### El Fenni Hassen, Fredj Najeh, Romain Ducrocq

****

**Links**

Slides: https://slides.com/sebastianhorl/gpe-project  
Otp tutorial: http://docs.opentripplanner.org/en/dev-2.x/Basic-Tutorial/  
Csv bounding box: https://boundingbox.klokantech.com/  
Otp jar: https://repo1.maven.org/maven2/org/opentripplanner/otp/2.0.0/  
ile-de-france-latest.osm.pbf: https://download.geofabrik.de/europe/france/ile-de-france.html  
IDFM_gtfs.zip: https://data.iledefrance-mobilites.fr/explore/dataset/offre-horaires-tc-gtfs-idf/table/  

**Commands**

IDF:  
osmconvert ile-de-france-latest.osm.pbf -b=2.167993,48.696374,2.581354,49.01398 --complete-ways -o=idf.pbf  

IDF GPE:  
osmconvert ile-de-france-latest.osm.pbf -b=2.070163,48.707927,2.595584,49.027041 --complete-ways -o=idf-gpe.pbf

java -Xmx4G -jar otp-2.0.0-shaded.jar --build --serve .  

java -Xmx4G -jar otp-2.0.0-shaded.jar --build --save .  
java -Xmx4G -jar otp-2.0.0-shaded.jar --load .  
java -Xmx4G -jar otp-2.0.0-shaded.jar --buildStreet .  
java -Xmx4G -jar otp-2.0.0-shaded.jar --loadStreet --save .  
java -Xmx4G -jar otp-2.0.0-shaded.jar --load .  

127.0.0.1:8080  

**Tree**

├── data  
│&nbsp;&nbsp;&nbsp;├── demand.xlsx  
│&nbsp;&nbsp;&nbsp;├── gpe-idf.csv  
│&nbsp;&nbsp;&nbsp;├── idf.csv  
│&nbsp;&nbsp;&nbsp;└── laposte_hexasmal.csv  
├── otp-gpe-idf  
│&nbsp;&nbsp;&nbsp;├── gtfs  
│&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;└── idfm-gpe.gtfs.zip  
│&nbsp;&nbsp;&nbsp;├── ile-de-france-latest.osm.pbf  
│&nbsp;&nbsp;&nbsp;└── otp  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── graph.obj  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── idf-gpe.pbf  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── idfm-gpe.gtfs.zip  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── otp-2.0.0-shaded.jar  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── streetGraph.obj  
├── otp-idf  
│&nbsp;&nbsp;&nbsp;├── ile-de-france-latest.osm.pbf  
│&nbsp;&nbsp;&nbsp;└── otp  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── graph.obj  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── idfm.gtfs.zip  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── idf.pbf  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── otp-2.0.0-shaded.jar  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── streetGraph.obj  
└── Routing.ipynb  
