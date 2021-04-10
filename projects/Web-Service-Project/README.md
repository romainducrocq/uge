# Web-Service-Project

****

# Test values

**Employees**
1. >username: ngrumbach  
    password: password  
2. >username: rducrocq  
    password: password  
3. >username: atherond  
    password: password  

**Bank**
1. >balance: 30000  
    currency: USD  
    name: Janis Joplin  
    card number: 0000 1111 2222 3333  
    cvv: 4444  
    expiracy date: May 2025  
2. >balance: 500000  
    currency: PLN  
    name: Kurt Cobain  
    card number: 0123 0123 0123 0123  
    cvv: 0123  
    expiracy date: January 2021  
3. >balance: 60000  
    currency: EUR  
    name: Jimi Hendrix  
    card number: 0123 4567 8910 1112  
    cvv: 1314  
    expiracy date: December 2023  

****

# Build project from scratch

- **shell>** mkdir Web-Service-Project && cd Web-Service-Project && mkdir WS_project
- **shell>** git init
- **shell>** git remote add origin https://github.com/romainducrocq/Web-Service-Project.git 
    > *(or git@github.com:romainducrocq/Web-Service-Project.git for ssh)*
- **eclipse-jee>** run in workspace: /path/to/Web-Service-Project/WS_project:
- **eclipse-jee>** window > preferences > java > compiler > compiler compliance level > 1.8 > apply
- **eclipse-jee>** window > preferences > java > installed jres > add > standard vm > jre home > /path/to/jdk1.8.0_271 > finish > select checkbox > apply and close
- **eclipse-jee>** new > server > apache > tomcat v7.0 server > /path/to/apache-tomcat-7.0.106 > finish
- **eclipse-jee>** new > dynamic web project: RentalProject
- **eclipse-jee>** new > dynamic web project: IfsCarsService
- **eclipse-jee>** new > dynamic web project: IfsCarsServiceClient
- **eclipse-jee>** new > dynamic web project: Bank
- **shell>** git pull origin master
- **shell>** sudo mysql --user="root" --password="1Rootpwd!" <  WS_project/removeDB.sql
- **shell>** sudo mysql --user="root" --password="1Rootpwd!" <  WS_project/createDB.sql
    > *mysql config:*  
    > install: https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/  
    > **shell>** sudo mysql -u root -p  
    > enter password:  
    > **mysql>** FLUSH PRIVILEGES;  
    > **mysql>** ALTER USER 'root'@'localhost' IDENTIFIED BY '1Rootpwd!';  
    > **mysql>** exit  
- **eclipse-jee>** RentalProject > properties > java build path > libraries > add external jars > /path/to/Web-Service-Project/WS_project/{javax.mail.jar, javax.servlet-api-4.0.1.jar, mysql-connector-java-8.0.21.jar}
- **eclipse-jee>** IfsCarsService > properties > java build path > libraries > add external jars > /path/to/Web-Service-Project/WS_project/mysql-connector-java-8.0.21.jar
- **eclipse-jee>** IfsCarsService > properties > deployment assembly > add > java build path entries > mysql-connector-java-8.0.21.jar
- **eclipse-jee>** IfsCarsServiceClient > properties > java build path > libraries > add external jars > /path/to/Web-Service-Project/WS_project/javax.servlet-api-4.0.1.jar
- **eclipse-jee>** Bank > properties > java build path > libraries > add external jars > /path/to/Web-Service-Project/WS_project/mysql-connector-java-8.0.21.jar
- **eclipse-jee>** Bank > properties > deployment assembly > add > java build path entries > mysql-connector-java-8.0.21.jar
- **eclipse-jee>** Bank > new > web service client > Service definition: http://fx.currencysystem.com/webservices/CurrencyServer5.asmx?wsdl > finish
- **eclipse-jee>** project > clean > {RentalProject, Bank} > clean
- **eclipse-jee>** Bank > new > web service > Service implementation > Browse: BankManager > ok > finish
- **eclipse-jee>** IfsCarsService > new > web service client > Service definition: http://localhost:8080/Bank/services/BankManager?wsdl > finish
- **eclipse-jee>** project > clean > IfsCarsService > clean
- **eclipse-jee>** IfsCarsService > new > web service > Service implementation > Browse: IfsCarsService > ok > finish
- **eclipse-jee>** IfsCarsService > webcontent > web-inf > server-config.wsdd > source > add session scope:
    > <ns1:service name="IfsCarService" provider="java:RPC" style="wrapped" use="literal">  
    > ...  
    > **&lt;parameter name="scope" value="session"/&gt;**  
    > </ns1:service>  
- **eclipse-jee>** IfsCarsServiceClient > new > web service client > Service definition: http://localhost:8080/IfsCarsService/services/IfsCarService?wsdl > finish
- **eclipse-jee>** project > clean > IfsCarsServiceClient > clean
- **eclipse-jee>** RentalProject > java resources > src > rentalserver > RentalServer.java > run as > java application
- **eclipse-jee>** RentalProject > java resources > src > employees > EmployeesServer.java > run as > java application
- **eclipse-jee>** window > show view > servers > tomcat v7.0 server at localhost > start
- **eclipse-jee>** RentalProject > run as > run on server > tomcat v7.0 server at localhost
- **eclipse-jee>** Bank > run as > run on server > tomcat v7.0 server at localhost
- **eclipse-jee>** IfsCarsService > run as > run on server > tomcat v7.0 server at localhost
- **eclipse-jee>** IfsCarsServiceClient > run as > run on server > tomcat v7.0 server at localhost
- **firefox>** http://localhost:8080/RentalProject/authenticate
- **firefox>** http://localhost:8080/IfsCarsServiceClient/index
    >The server may need to be restarted multiple times on first deployment.  
    >Repeat as many times as needed:  
    >**eclipse-jee>** window > show view > servers > tomcat v7.0 server at localhost > restart
****

**Useful commands**

- *run mysql*
    > **shell>** sudo service mysql start  
    > **shell>** sudo service mysql status  
    > **shell>** sudo service mysql stop  
    > **shell>** sudo mysql --user="root" --password="1Rootpwd!"  
    > **mysql>** SHOW DATABASES;  
- *delete db*
    > **shell>** mysql --user="root" --password="1Rootpwd!" < WS_project/removeDB.sql
- *kill rmi*
    > **shell>** WS_project/stoprmi.sh

****

**Links**
- github: https://github.com/romainducrocq/Web-Service-Project
- eclipse-jee: https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2020-09/R/eclipse-inst-jre-linux64.tar.gz
- jdk1.8.0_271: https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html
- tomcat 7.0.106: https://tomcat.apache.org/download-70.cgi
- mysql: https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/

****

## Rental Project, @Natacha

## Ifs Cars Service, @Romain

## Bank, @Alexandre

>see notes.txt
