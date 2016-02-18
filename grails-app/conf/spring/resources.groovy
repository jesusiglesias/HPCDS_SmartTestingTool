/*-------------------------------------------------------------------------------------------*
 *                                         RESOURCES                                         *
 *-------------------------------------------------------------------------------------------*/

import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.security.core.session.SessionRegistryImpl
import org.springframework.security.web.session.ConcurrentSessionFilter
import CustomConcurrentSessions.CustomConcurrentSessionControlStrategy
import Security.CustomSecUserDetailsService
import CustomAuthentication.CustomAuthenticationSuccessHandler

// Place your Spring DSL code here
beans = {

    // Bean registration to permit login by email or username
    userDetailsService(CustomSecUserDetailsService)

    // Bean registration to redirect to the user based on their role
    authenticationSuccessHandler(CustomAuthenticationSuccessHandler) {
        def conf = SpringSecurityUtils.securityConfig
        requestCache = ref('requestCache')
        defaultTargetUrl = conf.successHandler.defaultTargetUrl
        alwaysUseDefaultTargetUrl = conf.successHandler.alwaysUseDefault
        targetUrlParameter = conf.successHandler.targetUrlParameter
        useReferer = conf.successHandler.useReferer
        redirectStrategy = ref('redirectStrategy')
        // Admin url defined in config
        adminUrl = application.config.springsecurity.urlredirection.admin
        // User url defined in config
        userUrl = application.config.springsecurity.urlredirection.user
    }

    // Bean registration to invalidate concurrent sessions (user role)

    // Mechanism with a thread-safe map to register new sessions. It stores both by session id and by principal
    // And it uses the SessionInformation class which contains some information, such as the last time anything happened on this session, and if it is expired
    sessionRegistry(SessionRegistryImpl)

    // It updates sessionRegistry and checks if the session is marked as expired and - if that is the case  call the configured logoutHandlers
    concurrencyFilter(ConcurrentSessionFilter) {
        sessionRegistry = sessionRegistry // Ensure that every registered session’s “last updated” time is always correct and check if the session is expired then call the configured logout handlers
        logoutHandlers = [ref("rememberMeServices"), ref("securityContextLogoutHandler")] // It updates logout handlers
        expiredUrl='/concurrentSession' // Redirect the user to this url if the number of active sessions for this user exceeds the maximum allowed limit
    }

    concurrentSessionControlStrategy(CustomConcurrentSessionControlStrategy, sessionRegistry) {
        alwaysCreateSession = true // Allow concurrent sessions
        exceptionIfMaximumExceeded = false // If it is true, throw an exception if the concurrent sessions exceed the maximumSession. If not, old sessions of a user are invalidated
        maximumSessions = 1
    }
}
