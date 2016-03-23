package CustomTasksUser

import grails.transaction.Transactional
import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.AuthenticationServiceException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.web.WebAttributes

/**
 * It contains the habitual custom general tasks of the user.
 */
class CustomTasksUserController {

    def springSecurityService
    def customTasksUserService

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
        String messageType = ''
        String failDisabledMessage = ''
        String failUserMessage = ''
        String failAuthenticationMessage = ''

        // Fail exceptions
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                log.error("CustomTasksUserController:authFail():accountExpired:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                messageType = "accountExpired"
                failMessage = g.message(code: "customTasksUser.login.expired", default: 'Sorry, your user account has expired. Please, you enter your email to contact with administrator.')
            }
            else if (exception instanceof CredentialsExpiredException) {
                log.error("CustomTasksUserController:authFail():passwordExpired:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                messageType = "passwordExpired"
                failMessage = g.message(code: "customTasksUser.login.passwordExpired", default: 'Sorry, your password has expired. Please, you enter your email to contact with administrator.')
            }
            else if (exception instanceof DisabledException) {
                log.error("CustomTasksUserController:authFail():accountDisabled:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                failDisabledMessage = g.message(code: "customTasksUser.login.disabled", default: 'Sorry, your account is disabled. Please, you check your email to activate it.')
            }
            else if (exception instanceof LockedException) {
                log.error("CustomTasksUserController:authFail():accountLocked:UserOrEmailIntroduced:${session['SPRING_SECURITY_LAST_USERNAME']}")

                messageType = "accountLocked"
                failMessage = g.message(code: "customTasksUser.login.locked", default: 'Sorry, your user account has been locked by the administrator or exceed the limit of failed login attempts. Please, you enter your email to contact with administrator.')
            }
            else if (exception instanceof AuthenticationServiceException) {
                log.error("CustomTasksUserController:authFail():authenticationService")

                failAuthenticationMessage = g.message(code: "customTasksUser.login.authenticationException", default: 'An internal error has occurred during log in.')
            } else {
                log.debug("CustomTasksUserController:authFail():fail")

                failUserMessage = g.message(code: "customTasksUser.login.fail", default: '<strong>Sorry, we were not able to find a user with these credentials.</strong>')
            }
        }

        flash.errorLogin = failMessage
        flash.errorMessageType = messageType
        flash.errorDisabledLogin = failDisabledMessage
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

        String switchFailMessage = ''

        // Switch fail exceptions
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                log.error("CustomTasksUserController:switchFail():accountExpired:admin_switch")

                switchFailMessage = g.message(code: "customTasksUser.switchFail.expired", default: 'ERROR! The user account to switch has expired. Please, you check the settings.')
            } else if (exception instanceof CredentialsExpiredException) {
                log.error("CustomTasksUserController:switchFail():passwordExpired:admin_switch")

                switchFailMessage = g.message(code: "customTasksUser.switchFail.passwordExpired", default: 'ERROR! The user password to switch has expired. Please, you check the settings.')
            } else if (exception instanceof DisabledException) {
                log.error("CustomTasksUserController:switchFail():disabled:admin_switch")

                switchFailMessage = g.message(code: "customTasksUser.switchFail.disabled", default: 'ERROR! The user account to switch is disabled. Please, you check the settings.')
            } else if (exception instanceof LockedException) {
                log.error("CustomTasksUserController:switchFail():accountLocked:admin_switch")

                switchFailMessage = g.message(code: "customTasksUser.switchFail.locked", default: 'ERROR! The user account to switch is locked. Please, you check the settings.')
            } else if (exception instanceof AuthenticationServiceException) {
                log.error("CustomTasksUserController:switchFail():authenticationService")

                switchFailMessage = g.message(code: "customTasksUser.switchFail.authenticationException", default: 'An internal error has occurred during switching.')
            }
        }

        flash.errorSwitchUser = switchFailMessage

        // Redirection to admin url
        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
            log.debug("CustomTasksUserController:switchFail():adminRole:admin_switch")
            redirect uri: adminUrlRedirection

            /* TODO Añadir en user layout */
        } else if (SpringSecurityUtils.ifAllGranted('ROLE_USER')) {  // Redirection to user url
            log.debug("CustomTasksUserController:switchFail():userRole:admin_switch")
            redirect uri: userUrlRedirection
        }
    }

    /*-------------------------------------------------------------------------------------------*
    *                                    USER ACCOUNT STATE                                      *
    *-------------------------------------------------------------------------------------------*/
    /**
     * It checks the email entered by user and sends to admin an information email.
     */
    def statusNotification () {
        log.debug("CustomTasksUserController:statusNotification():from:${params.email}")

        // Email validation
        def valid_email = customTasksUserService.validate_email(params.email)

        // Email is valid and exists
        if(valid_email.valid && valid_email.exist){

            if (!customTasksUserService.send_emailAccountState(params.email, params.type)) { // Error
                log.debug("CustomTasksUserController:statusNotification():NOTMailSent")
                render("notSent")
            } else { // Mail sent
                log.debug("CustomTasksUserController:statusNotification():mailSent")
                render("sent")
            }
        }else{ // Email is not valid
            log.debug("CustomTasksUserController:statusNotification():invalid/notExists")
            render("notSent")
        }
    }

    /*-------------------------------------------------------------------------------------------*
    *                                     REGISTER NORMAL USER                                   *
    *-------------------------------------------------------------------------------------------*/
    /**
     * It renders the view to create a new normal account.
     *
     * @return register View to introduce the information of the user account.
     */
    def registerAccount() {
        render view: '/login/register'
    }

    /*-------------------------------------------------------------------------------------------*
     *                                     RESTORE PASSWORD                                      *
    *-------------------------------------------------------------------------------------------*/
    /**
     * It renders the view to restore the password.
     *
     * @return restorePassword View to introduce the email of the user account.
     */
    def restorePassword(){
        render view: '/login/restorePassword'
    }

    /**
     * It checks the user email and sends an email to restore the password.
     *
     * @return restorePassword View to inform the user of the success or failure of the action.
     */
    @Transactional(readOnly = false)
    def sendEmail(){
        log.debug("CustomTasksUserController:sendEmail():email:${params.email}")

        // Email validation
        def valid_email = customTasksUserService.validate_email(params.email)

        // Email is valid and exists
        if(valid_email.valid && valid_email.exist){

            if (!customTasksUserService.send_email(params.email)) {
                log.debug("CustomTasksUserController:sendEmail():NOTMailSent")

                // Roll back in database
                transactionStatus.setRollbackOnly()

                flash.errorRestorePassword = g.message(code: 'customTasksUser.sendEmail.error', default: 'An internal error has occurred during the sending email. You try it again later.')

            } else {
                log.debug("CustomTasksUserController:sendEmail():mailSent:${params.email}")
                flash.successRestorePassword = g.message(code: 'customTasksUser.sendEmail.success', default: 'An email has been sent to restore the password to the following address:<br/>{0}.', args: [params.email])

                redirect uri: '/forgotPassword'
                return
            }
        }else{ // Email is not valid
            log.debug("CustomTasksUserController:sendEmail():invalid/notExists")

            if (!valid_email.valid) { // Invalid
                log.error("ForgotPassword():email:invalid:${params.email}")
                flash.errorRestorePassword = g.message(code: 'customTasksUser.sendEmail.invalid', default: '{0} email entered is invalid.', args: [params.email])

            } else { // Not exist
                log.error("ForgotPassword():email:doesNotExist:${params.email}")
                flash.errorRestorePassword = g.message(code: 'customTasksUser.sendEmail.notExist', default: '{0} email entered does not exist.', args: [params.email])
            }
        }
        redirect uri: '/forgotPassword'
    }

    /**
     * It checks the token. If this is correct, the view to change the password is displayed.
     *
     * @param token Token.
     * @return View If token is correct. If not error page is displayed.
     */
    def changePass(String token, Boolean newPasswordAgain) {
        log.debug("CustomTasksUserController:changePass()")

        if (newPasswordAgain) {
            render view: '/login/newPassword'

        } else {
            if (customTasksUserService.check_token(token)) {
                render view: '/login/newPassword'
            } else {
                response.sendError(404)
            }
        }
    }

    /**
     * It checks that token is correct and updates the password if it satisfies the rules.
     *
     * @return View Displaying the success or failure of the password update.
     */
    @Transactional(readOnly = false)
    def updatePass(){
        log.debug("CustomTasksUserController:updatePass()")

        if(customTasksUserService.check_token(params.token)){ // It checks again the integrity of the token

            def update_user = customTasksUserService.update_pass(params) // Password validation

            if(update_user.response){ // Respuesta true
                log.debug("CustomTasksUserController:updatePass():successful")

                flash.newPasswordSuccessful = g.message(code: 'views.login.auth.newPassword.successful', default: 'New password set correctly.')

                redirect uri: '/'
                return
            }

            if (!update_user.valid) { // Invalid password
                log.debug("CustomTasksUserController:updatePass():invalidPassword")

                flash.errorNewPassword = g.message(code: 'customTasksUser.updatePassword.invalidPassword', default: 'The password you entered does not meet the requirements.')

            } else if (!update_user.match) { // Password not equal that passwordConfirm field
                log.debug("CustomTasksUserController:updatePass():passwordIsDifferent")

                flash.errorNewPassword = g.message(code: 'customTasksUser.updatePassword.differentPassword', default: 'The passwords you entered do not match.')

            } else { // Password is not different than the previous
                log.debug("CustomTasksUserController:updatePass():passwordIsEqualPrevious")

                flash.errorNewPassword = g.message(code: 'customTasksUser.updatePassword.equalPassword', default: 'The password you entered can not be the same as the current.')
            }

        }else{ // Token altered
            log.debug("CustomTasksUserController:updatePass():tokenAltered")

            flash.errorNewPassword = g.message(code: 'customTasksUser.updatePassword.invalidToken', default: 'Invalid security token. Please, you enter again your email to send a new email.')
        }

        redirect uri: '/newPassword', params: [token: params.token, newPasswordAgain: true]
    }
}
