/*-------------------------------------------------------------------------------------------*
 *                                   DATABASE CONFIGURATION                                  *
 *-------------------------------------------------------------------------------------------*/

// General configuration
dataSource {
    pooled = true
    driverClassName = "" // Defined in DBConfig.groovy
    dialect = ""         // Defined in DBConfig.groovy
    username = ""        // Defined in DBConfig.groovy
    password = ""        // Defined in DBConfig.groovy
}

// Hibernate configuration
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    //cache.provider_class='com.opensymphony.oscache.hibernate.OSCacheProvider'
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
    format_sql = true
}

// Environments configuration
environments {
    development {
        dataSource {
            dbCreate = "create-drop"
            url = "" // Defined in DBConfig.groovy
            logssql=true
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "" // Defined in DBConfig.groovy
            logssql = true
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "" // Defined in DBConfig.groovy
        }
    }
}

