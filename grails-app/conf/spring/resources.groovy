/*-------------------------------------------------------------------------------------------*
 *                                         RESOURCES                                         *
 *-------------------------------------------------------------------------------------------*/

import grails.plugin.springsecurity.SpringSecurityUtils;

// Place your Spring DSL code here
beans = {

    // Bean registration to permit login by email or username
    userDetailsService(Security.CustomSecUserDetailsService)

    // Bean registration to redirect to the user based on their role
    authenticationSuccessHandler(CustomAuthentication.CustomAuthenticationSuccessHandler) {
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
}

