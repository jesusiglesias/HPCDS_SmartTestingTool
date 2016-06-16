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
            "/import"(controller: 'secUser', action: 'importAdmin')
            "/uploadFile"(controller: 'secUser', action: 'uploadFileAdmin')
        }
        // User - Grouping URLs
        group("/user") {
            "/"(controller: 'user', action: 'index')
            "/create-error"(controller: 'user', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'user', action: 'update')
            "/edit/profileImage/$id?(.$format)?"(controller: 'user', action: 'editProfileImage')
            "/edit-error/profileImage/$id?(.$format)?"(controller: 'user', action: 'updateProfileImage')
            "/import"(controller: 'user', action: 'importUser')
            "/uploadFile"(controller: 'user', action: 'uploadFileUser')
        }
        // Department - Grouping URLs
        group("/department") {
            "/"(controller: 'department', action: 'index')
            "/create-error"(controller: 'department', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'department', action: 'update')
            "/import"(controller: 'department', action: 'importDepartment')
            "/uploadFile"(controller: 'department', action: 'uploadFileDepartment')
        }
        // Topic - Grouping URLs
        group("/topic") {
            "/"(controller: 'topic', action: 'index')
            "/create-error"(controller: 'topic', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'topic', action: 'update')
            "/import"(controller: 'topic', action: 'importTopic')
            "/uploadFile"(controller: 'topic', action: 'uploadFileTopic')
        }
        // Catalog - Grouping URLs
        group("/catalog") {
            "/"(controller: 'catalog', action: 'index')
            "/create-error"(controller: 'catalog', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'catalog', action: 'update')
            "/import"(controller: 'catalog', action: 'importCatalog')
            "/uploadFile"(controller: 'catalog', action: 'uploadFileCatalog')
        }
        // Question - Grouping URLs
        group("/question") {
            "/"(controller: 'question', action: 'index')
            "/create-error"(controller: 'question', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'question', action: 'update')
            "/import"(controller: 'question', action: 'importQuestion')
            "/uploadFile"(controller: 'question', action: 'uploadFileQuestion')
        }
        // Answer - Grouping URLs
        group("/answer") {
            "/"(controller: 'answer', action: 'index')
            "/create-error"(controller: 'answer', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'answer', action: 'update')
            "/import"(controller: 'answer', action: 'importAnswer')
            "/uploadFile"(controller: 'answer', action: 'uploadFileAnswer')
        }
        // Test - Grouping URLs
        group("/test") {
            "/"(controller: 'test', action: 'index')
            "/create-error"(controller: 'test', action: 'save')
            "/edit-error/$id?(.$format)?"(controller: 'test', action: 'update')
            "/import"(controller: 'test', action: 'importTest')
            "/uploadFile"(controller: 'test', action: 'uploadFileTest')
        }
        // Evaluation - Grouping URLs
        group("/evaluation") {
            "/"(controller: 'evaluation', action: 'index')
        }

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

        /* Custom general tasks admin
        ======================================================*/
        // Reload log config
        "/reloadLogConfig"(controller: 'customTasksBackend', action: 'reloadLogConfig')
        "/dashboard"(controller: 'customTasksBackend', action: 'dashboard')

        /* Custom general tasks normal user
        ======================================================*/
        "/home"(controller: 'customTasksFrontEnd', action: 'home')
        "/topicSelected/$id?(.$format)?"(controller: 'customTasksFrontEnd', action: 'topicSelected')
        "/testSelected/$id?(.$format)?"(controller: 'customTasksFrontEnd', action: 'testSelected')
        "/calculateEvaluation"(controller: 'customTasksFrontEnd', action: 'calculateEvaluation')
        "/scoreObtained"(controller: 'customTasksFrontEnd', action: 'scoreObtained')
        "/scores"(controller: 'customTasksFrontEnd', action: 'scores')
        "/profile"(controller: 'customTasksFrontEnd', action: 'profile')
        "/profile-error"(controller: 'customTasksFrontEnd', action: 'updatePersonalInfo')
        "/profileAvatar"(controller: 'customTasksFrontEnd', action: 'profileAvatar')
        "/profileAvatar-error"(controller: 'customTasksFrontEnd', action: 'updateAvatar')
        "/profilePassword"(controller: 'customTasksFrontEnd', action: 'profilePassword')

        /* Custom general tasks normal user (information)
        ======================================================*/
        "/contact"(controller: 'customTasksUserInformation', action: 'contact')
        "/cookiesPolicy"(controller: 'customTasksUserInformation', action: 'cookiesPolicy')
        "/faq"(controller: "customTasksUserInformation", action: 'faq')

        /* Errors
        ======================================================*/
        "400"(view: '/error/badRequest')
        "401"(view: '/error/unauthorized')
        "403"(view: '/login/denied')
        "404"(view: '/error/notFound')
        "405"(view: '/error/notAllowed')
        "500"(view: '/error/internalError')
        "503"(view: '/error/unavailableService')

        /* Information files
        ======================================================*/
        // Humans.txt
        "/humans.txt"(view: "extraInformation/humans")
        // Robots.txt
        "/robots.txt"(view: "extraInformation/robots")
    }
}
