/*-------------------------------------------------------------------------------------------*
 *                                      URL MAPPINGS                                         *
 *-------------------------------------------------------------------------------------------*/

/**
 * It allows to configure the Grails' URL Mapping infrastructure.
 */
class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }

        // Homepage
        "/"(controller: 'login', action: 'auth')

        /* Domain URLS
        ======================================================*/
        // Admin - Grouping URLs
        group("/administrator") {
            "/"(controller: 'secUser', action: 'index')
            "/create"(controller: 'secUser', action: 'create')
            "/create-error"(controller: 'secUser', action: 'save')
            "/edit/$id?(.$format)?"(controller: 'secUser', action: 'edit')
            "/edit-error/$id?(.$format)?"(controller: 'secUser', action: 'update')
            "/edit/profileImage/$id?(.$format)?"(controller: 'secUser', action: 'editProfileImage')
            "/edit-error/profileImage/$id?(.$format)?"(controller: 'secUser', action: 'updateProfileImage')
        }
        // User - Grouping URLs
        group("/user") {
            "/create-error"(controller: 'user', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'user', action: 'update')
            "/edit/profileImage/$id?(.$format)?"(controller: 'user', action: 'editProfileImage')
            "/edit-error/profileImage/$id?(.$format)?"(controller: 'user', action: 'updateProfileImage')
        }
        // Department - Grouping URLs
        group("/department") {
            "/create-error"(controller: 'department', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'department', action: 'update')
        }
        // Topic - Grouping URLs
        group("/topic") {
            "/create-error"(controller: 'topic', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'topic', action: 'update')
        }
        // Catalog - Grouping URLs
        group("/catalog") {
            "/create-error"(controller: 'catalog', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'catalog', action: 'update')
        }
        // Question - Grouping URLs
        group("/question") {
            "/create-error"(controller: 'question', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'question', action: 'update')
        }
        // Answer - Grouping URLs
        group("/answer") {
            "/create-error"(controller: 'answer', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'answer', action: 'update')
        }
        // Test - Grouping URLs
        group("/test") {
            "/create-error"(controller: 'test', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'test', action: 'update')
        }

        /* Errors
        ======================================================*/
        "400"(view: '/error/badRequest')
        "401"(view: '/error/unauthorized')
        "403"(view: '/login/denied')
        "404"(view: '/error/notFound')
        "405"(view: '/error/notAllowed')
        "500"(view: '/error/internalError')
        "503"(view: '/error/unavailableService')

        /* Login controller
        ======================================================*/
        "/reauthenticate"(controller: 'login', action: 'full')

        /* Custom general tasks user
        ======================================================*/
        // LoggedIn
        "/login/loggedIn"(controller: 'customTasksUser', action: 'loggedIn')
        // Error: no role
        "/noRole"(view: 'noRole')
        // Concurrent sessions
        "/concurrentSession"(controller: 'customTasksUser', action: 'invalidSession')
        // Fail authentication
        "/authFail"(controller: 'customTasksUser', action: 'authFail')
        // Switch Admin to User
        "/switchFail"(controller: 'customTasksUser', action: 'switchFail')
        // Restore password
        "/forgotPassword"(controller: 'customTasksUser', action: 'restorePassword')
        // Change password
        "/newPassword"(controller: 'customTasksUser', action: 'changePass')
        // Register normal user
        "/register"(controller: 'customTasksUser', action: 'registerAccount')
        "/register-error"(controller: 'customTasksUser', action: 'saveUserRegistered')
        // Enabled user account
        "/enabledAccount"(controller: 'customTasksUser', action: 'enabledAccount')

        /* Custom general tasks admin (back-end)
        ======================================================*/
        // Reload log config
        "/reloadLogConfig"(controller: 'customTasksBackend', action: 'reloadLogConfig')
        "/dashboard"(controller: 'customTasksBackend', action: 'dashboard')

        /* Custom general tasks normal user (front-end)
        ======================================================*/
        "/contact"(view: "customTasksFrontEnd/Contact")
        "/cookiePolicy"(view: "customTasksFrontEnd/CookiePolicy")
        "/FAQ"(view: "customTasksFrontEnd/FAQ")

        /* Information files
        ======================================================*/
        // Humans.txt
        "/humans.txt"(view: "extraInformation/humans")
        // Robots.txt
        "/robots.txt"(view: "extraInformation/robots")
    }
}
