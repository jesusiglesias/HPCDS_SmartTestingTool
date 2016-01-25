# HP CDS - SMART TESTING TOOL PROJECT 

## CONTENTS OF THIS FILE
-------------
       
* General requirements
* Recommended tools
* Installation
* Configuration
* Branches
* Version
* Help
* Contributors
     
### Introduction
    
**Smart testing tool** is a HP CDS solution for online evaluation of different topics through test that it intended as a tool for internal qualification of personnel. 

### General requirements

This project requires the following tools for the right running:
     
* **[Apache Tomcat]** - open source software implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. The latest stable version released to date is: 8.0.30.
* **[Grails SDK]** - a powerful Groovy-based web application framework for the JVM. The version used in the project was the 2.5.3.
* **[Java JDK]** - Java SE Development Kit for Java Developers. The latest stable version released to date is: 8u72.
* **[MySQL]** - the world's most popular open source database. The latest stable version released to date is: 5.7.10.

## Recommended tools

The following tools are recommended:

* MySQL database management. For example: **[MySQL Workbench]**.
    
## Installation

There are two ways to process the installation. The first is faster and easier while the second requires a more complex and time consuming process.

* The first way[^1] consists to deploy the *.war* file attached in the project in a JSP/Servlet container, as for example: Tomcat. To do this, you must start Tomcat and type in the browser the following url (localhost mode): **`http://localhost:8080`**. Then, you select *"Tomcat Web Application Manager Section"* and in *"WAR file to deploy"* section you choose the file *.war* and press in *Deploy* button. Once completed these steps, your project will be available at the following URL: **`http://localhost:8080/[WarFileNameORprojectName]`**.

* The second way[^2] is to clone the complete project and open it in a IDE (Integrated Development Environment). This type of installation permits to modify the project and deploy it directly running the app with the IDE or deploying in a external container, hence, like
the first way. Here, it is necessary to obtain the *.war* file to deploy in a container. For this, you type in console the next command: **`grails war`** or **`grails prod war`**. A file will be generated in **/projectPath/target** directory. Then, you can follow the above steps.

## Configuration

In both cases, it is necessary to create the database. For this project, the database's name used for the production environment is: **PROD_HPCDS_SMTT** or if you prefer setting it for yourself, you must:

* Create the **DBConfig.groovy** file located in **/projectPath/grails-app/conf/** and add the database configuration. The schema of this file using **MySQL** is:
```sh
// Custom general configuration
dataSource {
    driverClassName = "com.mysql.jdbc.Driver"
    username = "username"
    password = "password"
}

// Custom environments configuration
environments {
    development {
        dataSource {
            url = "jdbc:mysql://localhost/nameDB?useUnicode=yes&characterEncoding=UTF-8"
        }
    }
    test {
        dataSource {
            url = "jdbc:mysql://localhost/nameDB?useUnicode=yes&characterEncoding=UTF-8"
        }
    }
    production {
        dataSource {
            url = "jdbc:mysql://localhost/nameDB?useUnicode=yes&characterEncoding=UTF-8"
        }
    }
}
```

* Or locate this file in the *.war* file in **`/WEB-INF/classes/external-config/`** and modify it with the desired configuration. Also, if the *.war* file is deployed in a container, this configuration can be established in the following path: **`/tomcatPath/web-apps/WarFileNameORprojectName/WEB-INF/classes/external-config/`**. Then, you only have to restart the application from Tomcat to add or update the new configuration.

If you decide to continue the second mode, you must make sure you have installed an IDE such as: **IntelliJ IDEA**. Besides, you need:

* Configure the database with above steps.
* Add the the following *.jar* in the *lib* directory of the project:
    * **[MySQL Connector]** - JDBC Driver for MySQL.  
    * **[Log4j Rolling Appender]** - for Log4j functionality. 

## Branches
    
* `master` is the main branch that contains the different versions of the project.
* `develop` is the development branch where it has been working throughout the project.
* `gh-pages` is the branch that saves the site of the project in GitHub.

## Version

The current version is: **1.0.0**

## Help
If you don't know how to use or configure *Apache Tomcat* and *MySQL* or need general support, I would recommend the following resources for learning and asking questions:
    
* **[Apache Tomcat Documentation]**
* **[Grails Wiki]**
* **[Java JDK Documentation]**
* **[MySQL Documentation]**

## Contributors
    
This project has been developed by **Jesús Iglesias**, student at University of Valladolid (UVa), like end of degree work for the *HP CDS* company.

For questions directly pertaining to the project, you can contact with the author via [Github](https://github.com/jesusiglesias) or [Email](jesusgiglesias@gmail.com).
    
[^1]: It requires to create the database in the OS.
[^2]: It requires to create the database and an extra configuration of the project.

[//]:# (Reference links used in the body.)

   [Apache Tomcat]: <http://tomcat.apache.org>
   [Grails SDK]: <https://grails.org/download.html>
   [Java JDK]: <http://www.oracle.com/technetwork/es/java/javase/downloads/index.html>
   [MySQL]: <http://dev.mysql.com/downloads/mysql/>
   [MySQL Workbench]:  <https://www.mysql.com/products/workbench/>
   [jQuery]: <http://jquery.com>
   [Apache Tomcat Documentation]: <http://tomcat.apache.org/tomcat-8.0-doc/index.html>
   [Grails Wiki]: <https://grails.org/wiki/Documentation>
   [Java JDK Documentation]: <http://www.oracle.com/technetwork/java/javase/documentation/jdk8-doc-downloads-2133158.html>
   [MySQL Documentation]: <https://dev.mysql.com/doc/refman/5.7/en/>
   [MySQL Connector]: <http://dev.mysql.com/downloads/connector/j/>
   [Log4j Rolling Appender]: <http://www.simonsite.org.uk/download.htm>
   



