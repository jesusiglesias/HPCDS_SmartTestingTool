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
        // Admin
        "/administrator"(controller: 'secUser', action: 'index')
        "/administrator/create"(controller: 'secUser', action: 'create')
        "/administrator/create-error"(controller: 'secUser', action: 'save')
        "/administrator/edit/$id?(.$format)?"(controller: 'secUser', action: 'edit')
        "/administrator/edit-error/$id?(.$format)?"(controller: 'secUser', action: 'update')
        "/administrator/edit/profileImage/$id?(.$format)?"(controller: 'secUser', action: 'editProfileImage')
        "/administrator/edit-error/profileImage/$id?(.$format)?"(controller: 'secUser', action: 'updateProfileImage')
        // User
        "/user/create-error"(controller: 'user', action: 'save')
        "/user/edit-error/$id?(.$format)?"(controller: 'user', action: 'update')
        "/user/edit/profileImage/$id?(.$format)?"(controller: 'user', action: 'editProfileImage')
        "/user/edit-error/profileImage/$id?(.$format)?"(controller: 'user', action: 'updateProfileImage')
        // Department
        "/department/create-error"(controller: 'department', action: 'save')
        "/department/edit-error/$id?(.$format)?"(controller: 'department', action: 'update')
        // Topic
        "/topic/create-error"(controller: 'topic', action: 'save')
        "/topic/edit-error/$id?(.$format)?"(controller: 'topic', action: 'update')
        // Catalog
        "/catalog/create-error"(controller: 'catalog', action: 'save')
        "/catalog/edit-error/$id?(.$format)?"(controller: 'catalog', action: 'update')
        // Question
        "/question/create-error"(controller: 'question', action: 'save')
        "/question/edit-error/$id?(.$format)?"(controller: 'question', action: 'update')
        // Answer
        "/answer/create-error"(controller: 'answer', action: 'save')
        "/answer/edit-error/$id?(.$format)?"(controller: 'answer', action: 'update')
        // Test
        "/test/create-error"(controller: 'test', action: 'save')
        "/test/edit-error/$id?(.$format)?"(controller: 'test', action: 'update')

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
