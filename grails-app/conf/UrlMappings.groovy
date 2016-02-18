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
        "404"(view: '/notFound')
        "500"(view:'/error')

        /* Login controller
        ======================================================*/
        "/reauthenticate" (controller: 'login', action: 'full')

        /* Custom tasks user
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
        // Reload log config
        "/reloadLogConfig" (controller: 'customTasksUser', action: 'reloadLogConfig')

        /* Information files
        ======================================================*/
        // Humans.txt
        "/humans.txt" (view: "extraInformation/humans")
        // Robots.txt
        "/robots.txt" (view: "extraInformation/robots")
	}
}
