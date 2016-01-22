/**
 * Script to perform actions at different times
 */

// LogConfig.groovy path
def LogConfigPath = "${basedir}/grails-app/conf/LogConfig.groovy"
// DBConfig.groovy path
def DBConfigPath = "${basedir}/grails-app/conf/DBConfig.groovy"
// logs dir path
def deleteLogDir = "${basedir}/logs"

// It adds file to destination path during war creation event
eventCreateWarStart = { warName, stagingDir ->
    ant.copy(todir: "${stagingDir}/WEB-INF/classes/external-config") {
        print ('_Events():CreateWarStart:copy:Logconfig.groovy')
        fileset(file: LogConfigPath)
        fileset(file: DBConfigPath)
    }
}

// It deletes the "logs" directory and its contents recursively
eventCreateWarEnd = {warName, stagingDir ->

    def devEnv = 'development'
    def testEnv = 'test'

    if (System.getProperty('grails.env') == devEnv ||  System.getProperty('grails.env') == testEnv) {
        print ("_Events():CreateWarEnd:deleteDir:logs")
        ant.delete(dir:deleteLogDir)
    }
}