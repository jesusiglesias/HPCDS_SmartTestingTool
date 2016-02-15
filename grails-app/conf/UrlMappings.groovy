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
        "/"(controller: 'login')

        /****************************/
        // TODO
        // Provisional
        "/index"(view: 'index')

        // Errors
        "404"(view: '/notFound')
        "500"(view:'/error')

        /* Custom tasks user
        ======================================================*/
        // LoggedIn
        "/login/loggedIn" (controller: 'customTasksUser', action: 'loggedIn')
        // Concurrent sessions
        "/login/concurrentSession" (controller: 'customTasksUser', action: 'invalidSession')
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
