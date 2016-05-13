/*-------------------------------------------------------------------------------------------*
 *                                         RESOURCES                                         *
 *-------------------------------------------------------------------------------------------*/

import org.apache.commons.dbcp2.BasicDataSource

// Place your Spring DSL code here
beans = {

    // Connections in Mysql - Avoid connection closed, java.net.SocketException: Broken pipe
    dataSource(BasicDataSource) {

        // Run the evictor every 30 minutes and evict any connections older than 30 minutes
        minEvictableIdleTimeMillis=1800000
        timeBetweenEvictionRunsMillis=1800000
        numTestsPerEvictionRun=3

        // Test the connection while its idle, before borrow and return it
        testOnBorrow=true
        testWhileIdle=true
        testOnReturn=true
        validationQuery="SELECT 1"
    }
}
