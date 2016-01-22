/**
 * Script to perform differents actions at different times with Apache Ant
 */

// LogConfig path
def LogConfigPath = "${basedir}/grails-app/conf/LogConfig.groovy"
// DBConfig path
def DBConfigPath = "${basedir}/grails-app/conf/DBConfig.groovy"

// It adds file to destination path during run app start event
eventRunAppStart = {

    // Run app mode
    ant.copy(todir: "${basedir}/target/classes/external-config") {
        print('_Events():RunAppStart:copy:Logconfig,DBConfig')
        fileset(file: LogConfigPath)
        fileset(file: DBConfigPath)
    }
}

// It adds file to destination path during war creation event
eventCreateWarStart = { warName, stagingDir ->

    // War mode
    ant.copy(todir: "${stagingDir}/WEB-INF/classes/external-config") {
        print ('_Events():CreateWarStart:copy:Logconfig,DBConfig')
        fileset(file: LogConfigPath)
        fileset(file: DBConfigPath)
    }
}

// It deletes the "logs" directory and its contents recursively
// It performs tasks when war creation event finishes
eventCreateWarEnd = {warName, stagingDir ->

    // Read properties from file
    ant.property file: 'application.properties'
    def appName = ant.project.properties.'app.name'

    // logs dir path
    def deleteLogDir = "${basedir}/logs"
    // .log file path
    def deleteLogFile = "/tmp/${appName}_Error.log"

    // Environments
    def devEnv = 'development'
    def testEnv = 'test'
    def prodEnv = "production"

    // It deletes the "logs" directory and its contents recursively
    if (System.getProperty('grails.env') == devEnv ||  System.getProperty('grails.env') == testEnv) {
        print ("_Events():CreateWarEnd:deleteDir:logs")
        ant.delete(dir:deleteLogDir)
    }

    // It deletes log in /tmp directory
    if (System.getProperty('grails.env') == prodEnv) {
        print ("_Events():CreateWarEnd:deleteFile:.log")
        ant.delete(file:deleteLogFile)
    }
}

// It modifies the "display-name" element in web.xml during webxml creation event
eventWebXmlStart = { webXmlFile ->

    print("_Events():WebXmlStart:display_name")

    // Web.xml file update
    def tmpWebXmlFile = new File(projectWorkDir, webXmlFile)
    ant.replace(file: tmpWebXmlFile, token: "@grails.app.version@",
            value: "${grailsAppVersion}")
}