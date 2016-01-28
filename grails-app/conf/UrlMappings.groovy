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

        "/"(view:"/index")
        "500"(view:'/error')

        /* Custom tasks user
        ======================================================*/
        // Concurrent sessions
        "/login/concurrentSession" (controller: 'customTasksUser', action: 'invalidSession')
        // Reload config
        "/reloadConfig" (controller: 'customTasksUser', action: 'reloadConfig')

        /* Information files
        ======================================================*/
        // Humans.txt
        "/humans.txt" (view: "extraInformation/humans")
        // Robots.txt
        "/robots.txt" (view: "extraInformation/robots")
	}
}
