/*-------------------------------------------------------------------------------------------*
 *                                      URL MAPPINGS                                         *
 *-------------------------------------------------------------------------------------------*/

/**
 * It allows to configure the Grails' URL Mapping infrastructure.
 */
class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // Homepage
        "/"(controller: 'login', action: 'auth')

        /****************************/
        // TODO
        // Provisional
        "/index"(view: 'index')

        // Errors
        "400"(view: '/error/badRequest')
        "401"(view: '/error/unauthorized')
        "403"(view: '/login/denied')
        "404"(view: '/error/notFound')
        "405"(view: '/error/notAllowed')
        "500"(view: '/error/internalError')
        "503"(view: '/error/unavailableService')

        /* Login controller
        ======================================================*/
        "/reauthenticate" (controller: 'login', action: 'full')

        /* Custom general tasks user
        ======================================================*/
        // LoggedIn
        "/login/loggedIn" (controller: 'customTasksUser', action: 'loggedIn')
        // Error: no role
        "/noRole" (view: 'noRole')
        // Concurrent sessions
        "/concurrentSession" (controller: 'customTasksUser', action: 'invalidSession')
        // Fail authentication
        "/authFail" (controller: 'customTasksUser', action: 'authFail')
        // Switch Admin to User
        "/switchFail" (controller: 'customTasksUser', action: 'switchFail')
        // Restore password
        "/forgotPassword" (controller: 'customTasksUser', action: 'restorePassword')
        // Change password
        "/newPassword" (controller: 'customTasksUser', action: 'changePass')

        /* Custom general tasks admin (back-end)
        ======================================================*/
        // Reload log config
        "/reloadLogConfig" (controller: 'customTasksBackend', action: 'reloadLogConfig')
        "/dashboard" (controller: 'customTasksBackend', action: 'dashboard')

        /* Information files
        ======================================================*/
        // Humans.txt
        "/humans.txt" (view: "extraInformation/humans")
        // Robots.txt
        "/robots.txt" (view: "extraInformation/robots")
	}
}
