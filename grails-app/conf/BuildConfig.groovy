/*-------------------------------------------------------------------------------------------*
 *                                     BUILD CONFIGURATION                                   *
 *-------------------------------------------------------------------------------------------*/

grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6

// Name war creation task
grails.project.war.file = "target/${appName}.war"

grails.project.fork = [
    // Configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
    // Compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

    // Configure settings for the test-app JVM, uses the daemon by default
    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    // Configure settings for the run-app JVM
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // Configure settings for the run-war JVM
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // Configure settings for the Console UI JVM
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {

    // Inherit Grails' default dependencies
    inherits("global") {
    }

    log "error" // Log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // Whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        mavenLocal()
        grailsCentral()
        mavenCentral()

        // Uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"

    }

    // Dependencies
    dependencies {
        // Log4j Extra RollingFileAppender
        compile 'log4j:apache-log4j-extras:1.2.17'

        // MySQL
        runtime 'mysql:mysql-connector-java:5.1.37'

        test "org.grails:grails-datastore-test-support:1.0.2-grails-2.4"
    }

    // Plugins
    plugins {
        // Plugins for the build system only
        build ":tomcat:7.0.55.3" // or ":tomcat:8.0.22"

        // Plugins for the compile step
        // asset-pipeline 2.0+ requires Java 7, use version 1.9.x with Java 6
        compile ":asset-pipeline:2.5.7"
        // Cache
        compile ':cache:1.1.8'
        // Brute force Defender
        compile "org.grails.plugins:bruteforce-defender:1.1"
        // Jasypt encryption
        compile "org.grails.plugins:jasypt-encryption:1.3.1"
        // Mail
        compile "org.grails.plugins:mail:1.0.7"
        // Spring Security Core
        compile "org.grails.plugins:spring-security-core:2.0.0"
        // Scaffolding method
        compile ":scaffolding:2.1.2"

        // Plugins needed at runtime but not for compilation
        runtime ":hibernate4:4.3.10" // or ":hibernate:3.6.10.18"
        runtime ":database-migration:1.4.0"
    }
}
