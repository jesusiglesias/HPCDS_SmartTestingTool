package CustomTasksUser

import grails.util.Environment
import grails.util.Holders
import org.codehaus.groovy.grails.plugins.log4j.Log4jConfig
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.web.WebAttributes

/**
 * It contains the habitual custom tasks of the user.
 */
class CustomTasksUserController {

    def springSecurityService

    // Store the hash of external config files
    private static Map<String, Integer> fileHashMap = [:]

    // Obtain the default url of users
    @Value('${springsecurity.urlredirection.admin}')
    def adminUrlRedirection
    @Value('${springsecurity.urlredirection.user}')
    def userUrlRedirection
    @Value('${springsecurity.urlredirection.noRole}')
    def rootUrlRedirection

    /**
     * It obtains the default url redirection based on role from the call successHandler.defaultTargetUrl.
     *
     * @return urlRedirection   Url to redirection to the user.
     */
    def loggedIn () {
        log.debug("CustomTasksUserController:loggedIn()")

        // Redirection to admin url
        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
            log.debug("CustomTasksUserController:loggedIn():adminRole")
            redirect uri: adminUrlRedirection

        } else if (SpringSecurityUtils.ifAllGranted('ROLE_USER')) {  // Redirection to user url
            log.debug("CustomTasksUserController:loggedIn():userRole")
            redirect uri: userUrlRedirection

        } else { // Redirection to /noRole url
            log.error("CustomTasksUserController:loggedIn():noRole:User:${springSecurityService.authentication.principal.username}:Email:${springSecurityService.authentication.principal.email}") // It obtains the username and email from cache by principal
            // TODO Página que pida al usuario deslogear
            redirect uri: rootUrlRedirection
        }
    }

    /**
     * It creates a flash message about a invalid session of the user with user role.
     *
     * @return invalidSession Message to show to the user.
     */
    def invalidSession() {
        log.debug("CustomTasksUserController:invalidSession()")

        // TODO Add default
        flash.invalidSession =  g.message(code: "customTasksUser.login.invalidSession")
        redirect (controller: 'login', action: 'auth', params: params)
    }

    /**
     * Callback after a failed login. Redirects to the "/" page with a warning message.
     *
     * @return failMessage Message to show to the user.
     */
    def authFail() {
        log.debug("CustomTasksUserController:authFail()")

        // TODO Add default
        String failMessage = ''

        // Fail exceptions
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                log.error("CustomTasksUserController:authFail():accountExpired:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failMessage = g.message(code: "springSecurity.errors.login.expired")
            }
            else if (exception instanceof CredentialsExpiredException) {
                log.error("CustomTasksUserController:authFail():passwordExpired:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failMessage = g.message(code: "springSecurity.errors.login.passwordExpired")
            }
            else if (exception instanceof DisabledException) {
                log.error("CustomTasksUserController:authFail():accountDisabled:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failMessage = g.message(code: "springSecurity.errors.login.disabled")
            }
            else if (exception instanceof LockedException) {
                log.error("CustomTasksUserController:authFail():accountLocked:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failMessage = g.message(code: "springSecurity.errors.login.locked")
            }
            else {
                log.debug("CustomTasksUserController:authFail():fail")

                failMessage = g.message(code: "springSecurity.errors.login.fail")
            }
        }

        // TODO Add default
        flash.message = failMessage
        redirect (controller: 'login', action: 'auth')
    }

    /**
     * If the switch fails, then the user will be redirected to its default URL, displaying a message.
     *
     * @return switchFailMessage Message to show to the user.
     */
    def switchFail () {
        log.debug("CustomTasksUserController:switchFail()")

        // TODO Add default and change message
        String switchFailMessage = ''

        // Switch fail exceptions
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                log.error("CustomTasksUserController:switchFail():accountExpired:admin_switch")

                switchFailMessage = g.message(code: "springSecurity.errors.login.expired")
            } else if (exception instanceof CredentialsExpiredException) {
                log.error("CustomTasksUserController:switchFail():passwordExpired:admin_switch")

                switchFailMessage = g.message(code: "springSecurity.errors.login.passwordExpired")
            } else if (exception instanceof DisabledException) {
                log.error("CustomTasksUserController:switchFail():disabled:admin_switch")

                switchFailMessage = g.message(code: "springSecurity.errors.login.disabled")
            } else if (exception instanceof LockedException) {
                log.error("CustomTasksUserController:switchFail():accountLocked:admin_switch")

                switchFailMessage = g.message(code: "springSecurity.errors.login.locked")
            }
        }

        // TODO Add default
        flash.message = switchFailMessage

        // Redirection to admin url
        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
            log.debug("CustomTasksUserController:switchFail():adminRole:admin_switch")
            redirect uri: adminUrlRedirection

        } else if (SpringSecurityUtils.ifAllGranted('ROLE_USER')) {  // Redirection to user url
            log.debug("CustomTasksUserController:switchFail():userRole:admin_switch")
            redirect uri: userUrlRedirection
        }
    }

    /**
     * It reloads automatically the changes done in Log4j external file.
     */
    def reloadLogConfig () {
        log.debug("CustomTasksUserController:reloadConfig()")

        // External files of properties
        ConfigObject config = Holders.config
        List locations = config.grails.config.locations

        int hashCode
        String text

        // It finds all the external file locations with contains a pattern
        locations.findAll {
            // It checks only in classpath and Log4j file
            return (it instanceof String || it instanceof GString) && (it.toString().contains("classpath:") && it.toString().contains("LogConfig"))

        }.each { String filePath ->
            try {
                // It reads the contents of file
                text = Holders.applicationContext.getResource(filePath)?.file?.text
            } catch (FileNotFoundException e) {
                // Ignore the exception if file not found on specified path
                log.error("CustomTasksUserController:reloadConfig():File not found: ${e.message}")

                // TODO Add default
                flash.reloadConfig = g.message(code:"customTasksUser.reloadConfig.notFound", default: "")
            }
            // If file have data
            if (text) {
                // Calculate hashCode of text
                hashCode = text.hashCode()
                if (!fileHashMap.containsKey(filePath) || fileHashMap.get(filePath) != hashCode) {
                    // Merge existing config with the text of file
                    config = config.merge(new ConfigSlurper(Environment.current.name).parse(text))

                    // Reconfigure log4j
                    Log4jConfig.initialize(config)

                    fileHashMap.put(filePath, hashCode)

                    log.debug("CustomTasksUserController:reloadConfig():Configuration updated successfully")

                    // TODO Add default
                    flash.reloadConfig = g.message(code: "customTasksUser.reloadConfig.success", default: "")

                } else {
                    log.debug("CustomTasksUserController:reloadConfig():No changes")

                    // TODO Add default
                    flash.reloadConfig = g.message(code: "customTasksUser.reloadConfig.noChanges" , default: "")
                }
            }
        }
        // TODO
        redirect(uri: '/index')
    }
}
