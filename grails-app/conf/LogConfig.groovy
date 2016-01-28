/*-------------------------------------------------------------------------------------------*
 *                                   LOG4J CONFIGURATION                                     *
 *-------------------------------------------------------------------------------------------*/

import org.apache.log4j.Level
import org.apache.log4j.PatternLayout
import org.apache.log4j.rolling.RollingFileAppender
import org.apache.log4j.rolling.TimeBasedRollingPolicy
import grails.util.Metadata

/* Log configuration
 =================================================================== */

// App name
//def appName = "${myAppName}"
def myAppName = Metadata.current.'app.name'
// Log dir
def logHome= './logs'
// Log name
def logName = {String baseName -> "${logHome}/${myAppName}_${baseName}.log"}
// Log backup
def backups = '/backups/'
// Pattern
def customPatternExtended = new PatternLayout(conversionPattern:  '%d{yyyy-MM-dd HH:mm:ss} %t %-5p [%c{2}] - %m%n')
def customPattern = new PatternLayout(conversionPattern: '%-5p [%c{2}] - %m%n')
// Levels
def DEBUG = 'DEBUG'
def WARN = 'WARN'
def ERROR = 'ERROR'
// Info Logged
def infoLogged = [
        'grails.app.conf',
        'grails.app.taglib',
        'grails.app.filters',
        'grails.app.services',
        'grails.app.controllers',
        'grails.app.domain'
]

// Log4j closure
log4j.main = {

    // Appenders
    appenders {

        console name: 'stdout',
                layout: customPattern,
                threshold: Level.DEBUG

        /*console name: 'stderr',
                  layout: customPattern,
                  threshold: Level.ERROR*/

        // Disable the stacktrace.log file, it's already going to error anyway
        'null' name: 'stacktrace'

        // Log files created depending on the environment
        environments {
            development {
                rollingFile name: "debugLog", threshold: Level.toLevel(DEBUG), fileName: logName('Debug'), append: false, layout: customPatternExtended, maxFileSize: "100MB"
            }
            test {
                rollingFile name: "warnLog", threshold: Level.toLevel(WARN), fileName: logName('Warn'), append: false, layout: customPatternExtended, maxFileSize: "100MB"
            }
            production {

                // Prod dir
                def catalinaBase = System.properties.getProperty('catalina.base')
                logHome = !catalinaBase ? '/tmp': "${catalinaBase}/logs"

                // Log backup dir
                def backupDir = logHome+backups
                // Create "backups" directory
                new File(backupDir).mkdirs()
                // Delete "backups" directory and ".log" file in "/tmp"
                new File("/tmp/backups").deleteDir()
                new File("/tmp/${myAppName}_Error.log").delete()

                def rollingFile = new RollingFileAppender(
                        name: "errorLog",
                        threshold: Level.toLevel(ERROR),
                        layout: customPatternExtended,
                        immediateFlush: true,
                        append: false
                )

                // Rolling policy
                // Rollover each day, compress and save in logs/backups directory.
                def rollingPolicy = new TimeBasedRollingPolicy(
                        fileNamePattern: "${backupDir}${myAppName}.%d{yyyy-MM-dd}.log.gz",
                        activeFileName: logName('Error'),
                )

                rollingPolicy.activateOptions()
                rollingFile.setRollingPolicy rollingPolicy

                appenders {
                    appender rollingFile
                }

                /* Other appenders
                ========================================= */
                /*appender new TimeAndSizeRollingAppender(
                        name: "errorLog",
                        threshold: Level.toLevel(ERROR),
                        fileName: logName('Error'),
                        datePattern: "'.'yyyy-MM-dd",
                        layout: customPatternExtended,
                        immediateFlush: true,
                        append: false,
                        maxFileSize: "100MB",
                        compressionAlgorithm: 'GZ',
                        compressionMinQueueSize: 1,
                )
                */

                /*appender new DailyRollingFileAppender(
                        name: "errorLog",
                        threshold: Level.toLevel(ERROR),
                        fileName: logName('Error'),
                        append: false,
                        datePattern: "'.'yyyy-MM-dd-HH-mm",
                        layout: customPatternExtended,
                        immediateFlush: true
                )*/
            }
        }
    }

    // Error type
    error   'org.codehaus.groovy.grails.web.servlet',        // controllers
            'org.codehaus.groovy.grails.web.pages',          // GSP
            'org.codehaus.groovy.grails.web.sitemesh',       // layouts
            'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
            'org.codehaus.groovy.grails.web.mapping',        // URL mapping
            'org.codehaus.groovy.grails.commons',            // core/classloading
            'org.codehaus.groovy.grails.plugins',            // plugins
            'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
            'org.springframework',
            'org.hibernate',
            'net.sf.ehcache.hibernate'

    // Logging
    environments {
        development {
            // Debug type
            debug 'org.hibernate.SQL'

            debug stdout: infoLogged, debugLog: infoLogged, additivity: false

            root {
                debug 'debugLog', 'stdout'
                warn ' '
                error ' '
            }
        }
        test {
            // Debug type
            debug 'org.hibernate.SQL'

            warn stdout: infoLogged, warnLog: infoLogged, additivity: false
            root {
                warn 'warnLog', 'stdout'
                error ' '
            }
        }
        production {
            error errorLog: infoLogged, additivity: false
            root {
                error 'errorLog'
            }
        }
    }
}