/*-------------------------------------------------------------------------------------------*
 *                                        CONFIGURATION                                      *
 *-------------------------------------------------------------------------------------------*/

/* Location of external files
 ============================================================================================= */
grails.config.locations = [ "classpath:./external-config/LogConfig.groovy", // Log4j war mode
                            //"file:${userHome}/LogConfig.groovy", // Log4j run-app mode
                            "classpath:./external-config/DBConfig.groovy" // DataSource war mode
                            //"file:${userHome}/DBConfig.groovy", // DataSource run-app mode
                          ]

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
    all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }
}

grails.converters.encoding = "UTF-8"
// Scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// Enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// Packages to include in Spring bean scanning
grails.spring.bean.packages = []
// Whether to disable processing of multi part requests
grails.web.disable.multipart=false

// Request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// Configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// Configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// Set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// Configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

environments {
    development {
        grails.logging.jul.usebridge = true
        grails.serverURL = "http://localhost:8080/${appName}"
    }
    production {
        grails.logging.jul.usebridge = false

        // TODO Change to own domain
        grails.serverURL = "http://192.168.0.201:8080/${appName}"
    }
}

/* Other configurations
 ============================================================================================= */
// Default value of pagination
paginate.defaultValue = 0

/* Mail configuration
 ============================================================================================= */
grails {
    mail {
        host = "smtp.gmail.com"
        port = 465
        username = 'info.smartestingtool@gmail.com'
        password = "stt2016tfg"
        props = ["mail.smtp.auth":"true",
                 "mail.smtp.socketFactory.port":"465",
                 "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                 "mail.smtp.socketFactory.fallback":"false"]
    }
}

/* Jasypt encryptation configuration
 ============================================================================================= */
jasypt {
    algorithm = "PBEWITHSHA256AND256BITAES-CBC-BC"
    providerName = "BC"
    password = "sttHPCDSTfg"
    keyObtentionIterations = 1000
}

/* Brute-force Defender configuration
 ============================================================================================= */
grails.plugin.springsecurity.useSecurityEventListener = true

bruteforcedefender {
    time = 5 // Minutes maintaining failed attempts allowed
    allowedNumberOfAttempts = 5 // Number of failed attempts before blocking the user
}

/* Spring Security Core configuration
 ============================================================================================= */
grails.plugin.springsecurity.userLookup.userDomainClassName = 'Security.SecUser'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'Security.SecUserSecRole'
grails.plugin.springsecurity.authority.className = 'Security.SecRole'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/**':              ['permitAll'], /** It includes: /humans.txt, /robots.txt **/
    '/assets/**':       ['permitAll'],
    '/**/js/**':        ['permitAll'],
    '/**/css/**':       ['permitAll'],
    '/**/images/**':    ['permitAll'],
    '/**/favicon.ico':  ['permitAll'],

    /* Login controller
    ======================================================*/
    '/login/full':      ['IS_AUTHENTICATED_REMEMBERED'],
    '/login/**':        ['permitAll'],

    // TODO
	'/index':           ['permitAll'],
	'/index.gsp':       ['permitAll'],

    /* Domain
    ======================================================*/
    '/SecUser/**':      ['ROLE_ADMIN'],
    '/User/**':         ['ROLE_ADMIN'],
    '/Department/**':   ['ROLE_ADMIN'],
    '/Topic/**':        ['ROLE_ADMIN'],
    '/Catalog/**':      ['ROLE_ADMIN'],
    '/Question/**':     ['ROLE_ADMIN'],
    '/Answer/**':       ['ROLE_ADMIN'],
    '/Test/**':         ['ROLE_ADMIN'],
    '/Evaluation/**':   ['ROLE_ADMIN'],

    /* Custom general tasks user
    ======================================================*/
    // LoggedIn
    '/customTasksUser/loggedIn':           ['IS_AUTHENTICATED_REMEMBERED'],
    // No role
    '/noRole':                             ['IS_AUTHENTICATED_REMEMBERED'], // User must be authenticated by explicit login or remember me cookie
    // Concurrent sessions
    '/customTasksUser/invalidSession':     ['permitAll'],
    // Fail authentication
    '/customTasksUser/authFail':           ['permitAll'],
    // Switch Admin to User
    '/customTasksUser/switchFail':         ['ROLE_ADMIN', 'IS_AUTHENTICATED_FULLY', "authentication.name == 'admin_switch'"],
    '/j_spring_security_switch_user':      ['ROLE_ADMIN', 'IS_AUTHENTICATED_FULLY'],
    '/j_spring_security_exit_user':        ["authentication.name == 'admin_switch'"],
    // User account state
    'customTasksUser/statusNotification':  ['permitAll'],
    // Register normal user
    "/customTasksUser/registerAccount":    ['permitAll'],
    // Restore password
    'customTasksUser/restorePassword':     ['permitAll'],
    // Password
    'customTasksUser/sendEmail':           ['permitAll'],
    'customTasksUser/changePass':          ['permitAll'],
    'customTasksUser/updatePass':          ['permitAll'],
    '/customTasksUser/**':                 ['permitAll'],

    /* Custom tasks admin (back-end)
    ======================================================*/
    // Reload Log config
    '/customTasksBackend/reloadLogConfig':     ['ROLE_ADMIN'],
    '/customTasksBackend/reloadLogConfigAJAX': ['ROLE_ADMIN'],
    '/customTasksBackend/dashboard':           ['ROLE_ADMIN'],
    '/customTasksBackend/profileImage':        ['ROLE_ADMIN', 'ROLE_USER'],
    '/customTasksBackend/**':                  ['ROLE_ADMIN']
]

// URL of login page (default: "/login/auth")
grails.plugin.springsecurity.auth.loginFormUrl = '/'
grails.plugin.springsecurity.failureHandler.defaultFailureUrl = '/authFail'

// Default URL - If true, always redirects to the value of successHandler.defaultTargetUrl (default: "/") after successful authentication; otherwise
// redirects to originally-requested page.
grails.plugin.springsecurity.successHandler.alwaysUseDefault = false
// Default post-login URL if there is no saved request that triggered the login
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/login/loggedIn'

// It stores the last username in a HTTP session
grails.plugin.springsecurity.apf.storeLastUsername = true

// Login form parameters
grails.plugin.springsecurity.apf.usernameParameter = 'stt_hp_username'
grails.plugin.springsecurity.apf.passwordParameter = 'stt_hp_password'

/*  Remember me cookie configuration
======================================================*/
// Remember-me cookie name; should be unique per application
grails.plugin.springsecurity.rememberMe.cookieName = 'STT_remember_me'
// Max age of the cookie in seconds
grails.plugin.springsecurity.rememberMe.tokenValiditySeconds = 604800
// Value used to encode cookies; should be unique per application
grails.plugin.springsecurity.rememberMe.key = 'sttHPCDSTfg'
// Login form cookie parameter
grails.plugin.springsecurity.rememberMe.parameter = '_stt_hp_remember_me'

/*  Switch user configuration
======================================================*/
// Activate switch user filter
grails.plugin.springsecurity.useSwitchUserFilter = true
// Url for redirect after switching
grails.plugin.springsecurity.switchUser.targetUrl = '/login/loggedIn'
// Url for redirect after an error during an attempt to switch
grails.plugin.springsecurity.switchUser.switchFailureUrl = '/switchFail'
// Username request parameter name
grails.plugin.springsecurity.switchUser.usernameParameter = 'stt_hp_username'

// URL redirection based on role
springsecurity.urlredirection.admin = '/dashboard'
springsecurity.urlredirection.user = '/user/create'
springsecurity.urlredirection.noRole = '/noRole'