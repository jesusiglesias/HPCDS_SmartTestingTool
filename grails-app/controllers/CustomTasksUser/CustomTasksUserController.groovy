package CustomTasksUser

import grails.transaction.Transactional
import grails.util.Environment
import grails.util.Holders
import org.codehaus.groovy.grails.plugins.log4j.Log4jConfig
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.AuthenticationServiceException
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
     * @return urlRedirection Url to redirection to the user.
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

        flash.errorInvalidSessionAuthenticationException =  g.message(code: "customTasksUser.login.invalidSession", default: 'Your user account is logged in from another browser or location.')
        redirect (controller: 'login', action: 'auth', params: params)
    }

    /**
     * Callback after a failed login. Redirects to the "/" page with a warning message.
     *
     * @return failMessage Message to show to the user.
     */
    def authFail() {
        log.debug("CustomTasksUserController:authFail()")

        String failMessage = ''
        String failUserMessage = ''
        String failAuthenticationMessage = ''

        // Fail exceptions
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                log.error("CustomTasksUserController:authFail():accountExpired:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failMessage = g.message(code: "customTasksUser.login.expired", default: 'Sorry, your user account has expired. Please, you contact with the administrator.')
            }
            else if (exception instanceof CredentialsExpiredException) {
                log.error("CustomTasksUserController:authFail():passwordExpired:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failMessage = g.message(code: "customTasksUser.login.passwordExpired", default: 'Sorry, your password has expired. Please, you contact with the administrator.')
            }
            else if (exception instanceof DisabledException) {
                log.error("CustomTasksUserController:authFail():accountDisabled:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failMessage = g.message(code: "customTasksUser.login.disabled", default: 'Sorry, your account is disabled. Please, you check your email to activate it.')
            }
            else if (exception instanceof LockedException) {
                log.error("CustomTasksUserController:authFail():accountLocked:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failMessage = g.message(code: "customTasksUser.login.locked", default: 'Sorry, your account is locked. Please, you check your email to activate it.')
            }
            else if (exception instanceof AuthenticationServiceException) {
                log.error("CustomTasksUserController:authFail():authenticationService")

                failAuthenticationMessage = g.message(code: "customTasksUser.login.authenticationException", default: 'An internal error has occurred during log in.')
            } else {
                log.debug("CustomTasksUserController:authFail():fail")

                failUserMessage = g.message(code: "customTasksUser.login.fail", default: '<strong>Sorry, we were not able to find a user with these credentials.</strong>')
            }
        }

        // TODO
        flash.errorLogin = failMessage
        flash.errorLoginUser = failUserMessage
        flash.errorInvalidSessionAuthenticationException = failAuthenticationMessage
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
     * Render the view to restore the password
     *
     * @return restore_pass View
     */
    def restore_pass(){
        render view: '/restore/restore_pass'
    }

    /**
     * Send email
     *
     * @return TODO
     */
    @Transactional(readOnly = false)
    def send_email(){

        def errors = []

        def valid_email = userService.validate_email(params.email) // Validación email

        if(valid_email.valid && valid_email.exist){ // Si es válido y existe

            if (!userService.send_email(params.email)) {
                println("entro !userService")
                transactionStatus.setRollbackOnly()
                errors?.add("Error al enviar el email")
            } else {
                //redirect action:'auth', controller:'login' // Redirección login
                redirect uri: '/'
                return
            }

        }else{ // Se añade el error encontrado

            if (!valid_email.valid) { // No es válido
                errors?.add(!valid_email.valid?"user.email.invalid.label":null)
            } else { // No existe
                errors?.add(!valid_email.exist?"user.email.exist.label":null)
            }
        }

        render view:'/restore/restore_pass', model:[errors:errors] // Renderizar la misma vista para mostrar los errores
    }

    /**
     * Si el token existe, es del tipo correcto y no ha sido usado
     * muestro la vista de cambio de contraseña sino muestro el error 404
     * @param token
     * @return
     */
    def change_pass(String token) {
        if (userService.check_token(token)) {
            render view: '/restore/change_pass'
        } else {
            render view: '/error'
            //response.sendError(404)
        }
    }

    /**
     * Verifico que el token exista y sea del tipo correcto
     * que no haya sido usado. Si se cumple se actualiza la contraseña
     * que consta de su validación primero
     * @return
     */
    @Transactional(readOnly = false)
    def update_pass(){

        def errors = []
        if(userService.check_token(params.token)){ // Se verifica la integridad del token

            def update_user = userService.update_pass(params) // Intento de actualizar el password (validación)

            if(update_user.response){ // Respuesta true
                //redirect action:'auth', controller:'login'
                println ("Contraseña modificada correctamente")
                redirect uri: '/'
                return
            }

            if (!update_user.valid) { // Contraseña inválida (no cumple los requisitos)
                errors?.add(!update_user.valid?"user.password.error":null)
            } else if (!update_user.match) { // Contraseña diferente (confirmPassword)
                errors?.add(!update_user.match?"user.password.confirm.error":null)
            } else { // Contraseña no es diferente a la anterior
                errors?.add(!update_user.passwordSame?"user.password.same":null)
            }

        }else{ // Intento de alterar el token
            errors.add('user.invalid.token') // Error token inválido
        }
        render view: '/restore/change_pass', model:['errors': errors]
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
