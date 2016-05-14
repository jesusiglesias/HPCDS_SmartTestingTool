package Security

import User.User
import grails.transaction.Transactional
import org.apache.commons.validator.routines.EmailValidator
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder

/**
 * Service that contains the habitual security tasks of the user.
 */
@Transactional
class CustomTasksUserService {

    // It gets access to message source by convention
    MessageSource messageSource
    def mailService
    def tokenService
    def passwordEncoder
    def grailsApplication

    /*-------------------------------------------------------------------------------------------*
     *                                     REGISTER USER ACCOUNT                                 *
     *-------------------------------------------------------------------------------------------*/
    /**
     * It creates a encrypt token with the email, saves the token in database and sends the email.
     *
     * @param email Email of the user.
     * @return true If the action is success.
     */
    def send_emailNewUser(String email) {
        log.debug("CustomTasksUserService:send_emailNewUser()")

        // Encrypt
        def token = encrypt_email(email)

        // It saves the token
        create_token(token, 'newAccount')

        // Send email
        try {
            mailService.sendMail {
                async true
                to email
                subject messageSource.getMessage("activateAccount.email.subject", null, "STT - Confirmation of the user account", LocaleContextHolder.locale)
                html(view: '/email/activateAccount', model: [token: token])
            }
            return true
        } catch (Exception e) {
            log.error("CustomTasksUserService:send_emailNewUser()" + e)
            return false
        }
    }

    /**
     * It updates the user account.
     *
     * @param token Token of the user.
     * @return true If the action is successful.
     */
    def update_account(token) {
        log.debug("CustomTasksUserService:update_account()")

        def email = decrypt_email(token) // It decrypts email

        use_token(token) // Status token to true

        def user = User.get(User.findByEmail(email).id) // It obtains the user through its email

        user.enabled = true // It enables the account
    }

    /*-------------------------------------------------------------------------------------------*
     *                                     RESTORE PASSWORD                                      *
     *-------------------------------------------------------------------------------------------*/

    /**
     * Email is validated (exists and valid).
     *
     * @param email Email of the user.
     * @return true If it is valid and exists in database.
     */
    def validate_email(String email) {
        log.debug("CustomTasksUserService:validate_email()")

        def valid_email = EmailValidator.getInstance().isValid(email) // Email valid
        def exist_email = SecUser.findByEmail(email) // Email exists in database

        return [valid: valid_email, exist: exist_email]
    }

    /**
     * It creates a encrypt token with the email, saves the token in database and sends the email.
     *
     * @param email Email of the user.
     * @return true If the action is success.
     */
    def send_email(String email) {
        log.debug("CustomTasksUserService:send_email()")

        // Encrypt
        def token = encrypt_email(email)

        // It saves the token
        create_token(token, 'restore')

        // Send email
        try {
            mailService.sendMail {
                async true
                to email
                subject messageSource.getMessage("resetPassword.email.subject", null, "STT - Reset password", LocaleContextHolder.locale)
                html(view: '/email/resetPassword',
                        model: [token: token])
            }
            return true
        } catch (Exception e) {
            log.error("CustomTasksUserService:send_email()" + e)
            return false
        }
    }

    /**
     * It updates the password of the user.
     *
     * @param params Passwords introduced by user.
     * @return true If the action is successful.
     */
    def update_pass(params) {
        log.debug("CustomTasksUserService:update_pass()")

        def valid = password_confirm(params.password, params.passwordConfirm)

        if (valid.valid && valid.match) { // Valid and equal passwords

            def email = decrypt_email(params.token) // It decrypts email

            def passwordSame = password_same(email, params.password) // It checks if password is equal to the current

            def passwordSameUsername = password_notUsername(email, params.password) // It checks if password if equal to username

            if (!passwordSame.same && !passwordSameUsername.sameUsername) { // New password different

                log.debug("CustomTasksUserService:update_pass():passwordDifferent")

                use_token(params.token)// Status token to true

                def user = SecUser.get(SecUser.findByEmail(email).id) // It obtains the user through its email
                user.password = params.password // It changes password

                return valid << [response: user.save(flush: true, failOnError: true)]

            } else {

                if (passwordSame.same) {
                    // Password equal
                    return passwordSame << [response: false, valid: true, match: true, passwordSame: false]

                } else if (passwordSameUsername.sameUsername) {
                    // Password equal to username
                    return passwordSameUsername << [response: false, valid: true, match: true, passwordSame: true]
                }
            }
        } else {
            return valid << [response: false] // False y error que se encontró
        }
    }

    /**
     * It checks that token is correct (exists, restore type and is not used).
     *
     * @params token Token of the user.
     */
    def check_token(String token, String type) {
        log.debug("CustomTasksUserService:check_token()")

        return tokenService.check_token(token, type)
    }

    /**
     * It creates a token of restore type.
     *
     * @params token Token of the user.
     */
    def private create_token(String token, String type) {
        log.debug("CustomTasksUserService:create_token()")

        return tokenService.save(new Token(token: token, tokenType: type, tokenStatus: false))
    }

    /**
     * It encrypts email.
     *
     * @params email Email to encrypt.
     */
    def private encrypt_email(String email) {
        log.debug("CustomTasksUserService:encrypt_email()")

        return tokenService.encrypt(email)
    }

    /**
     * It decrypts email.
     */
    def private decrypt_email(String token) {
        log.debug("CustomTasksUserService:decrypt_email()")

        return tokenService.decrypt(token)
    }

    /**
     * It checks that new password is correct and is equals to passwordConfirm field.
     *
     * @param password Password introduced by user.
     * @param passwordConfirmation Password to confirm.
     * @return true If the new password is valid.
     */
    def private password_confirm(String password, String passwordConfirmation) {
        log.debug("CustomTasksUserService:password_confirm()")

        String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+\$).{8,}\$"

        return [valid: password.matches(pattern), match: password.equals(passwordConfirmation)]
    }

    /**
     * It checks if the password introduced is equal to the current, searching to the user.
     *
     * @param email Email of the user.
     * @param password Password introduced.
     * @return true If the password introduced is equal.
     */
    def private password_same(String email, String newPassword) {
        log.debug("CustomTasksUserService:password_same()")

        def userOldPassword = SecUser.findByEmail(email).getPassword()

        return [same: passwordEncoder.isPasswordValid(userOldPassword, newPassword, null)]
    }

    /**
     * It checks if the password introduced is equal to the username.
     *
     * @param email Email of the user.
     * @param password Password introduced.
     * @return true If the password introduced is equal tu username.
     */
    def private password_notUsername(String email, String newPassword) {
        log.debug("CustomTasksUserService:password_notUsername()")

        def username = SecUser.findByEmail(email).getUsername()

        return [sameUsername: newPassword.toLowerCase().equals(username.toLowerCase())]
    }

    /**
     * It changes the status token to true.
     *
     * @param token Token.
     * @return true If the action is successful.
     */
    def private use_token(String token) {
        log.debug("CustomTasksUserService:use_token()")

        return tokenService.use_token(token)
    }

    /*-------------------------------------------------------------------------------------------*
     *                                     ACCOUNT STATE                                         *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It creates a encrypt token with the email, saves the token in database and sends the email.
     *
     * @param email Email of the user.
     * @oaram type Error type.
     * @return true If the action has success.
     */
    def send_emailAccountState(String email, String type) {
        log.debug("CustomTasksUserService:send_emailAccountState()")

        def subjectStatus
        def descriptionStatus
        def template
        Object[] args = [email]

        // It obtains the state type
        switch (type) {
            case 'accountExpired':
                subjectStatus = messageSource.getMessage("customTasksUser.login.stateAccount.subject.accountExpired", null, "STT - Notification of user account expired", LocaleContextHolder.locale)
                descriptionStatus = messageSource.getMessage("customTasksUser.login.stateAccount.description.accountExpired", args, "The user with email: <strong>{0}</strong> attempted to access his account expired and notifies the administrator to check the account status and contact with him.", LocaleContextHolder.locale)
                template = '/email/emailStatus'
                break
            case 'passwordExpired':
                subjectStatus = messageSource.getMessage("customTasksUser.login.stateAccount.subject.passwordExpired", null, "STT - Notification of password expired", LocaleContextHolder.locale)
                descriptionStatus = messageSource.getMessage("customTasksUser.login.stateAccount.description.passwordExpired", args, "The user with email: <strong>{0}</strong> attempted to access his account with password expired and notifies the administrator to check the account status and contact with him.", LocaleContextHolder.locale)
                template = '/email/emailStatus'
                break
            case 'accountLocked':
                subjectStatus = messageSource.getMessage("customTasksUser.login.stateAccount.subject.accountLocked", null, "STT - Notification of user account locked", LocaleContextHolder.locale)
                descriptionStatus = messageSource.getMessage("customTasksUser.login.stateAccount.description.accountLocked", args, "The user with email: <strong>{0}</strong> attempted to access his account locked and notifies the administrator to check the account status and contact with him.", LocaleContextHolder.locale)
                template = '/email/emailStatus'
                break
            case 'noRole':
                subjectStatus = messageSource.getMessage("customTasksUser.login.stateAccount.subject.noRole", null, "STT - Notification user without role", LocaleContextHolder.locale)
                descriptionStatus = messageSource.getMessage("customTasksUser.login.stateAccount.description.noRole", args, "The user with email: <strong>{0}</strong> has notified that does not have a role in system and can not access any functionality.", LocaleContextHolder.locale)
                template = '/email/emailNoRole'
        }

        // Send email
        try {
            mailService.sendMail {
                async true
                to grailsApplication.config.grails.mail.username  // Administrator email. It obtains from configuration (Config.groovy)
                subject subjectStatus
                html(view: template,
                        model: [stateAccountMessage: descriptionStatus])
            }
            return true
        } catch (Exception e) {
            log.error("CustomTasksUserService:send_emailAccountState()" + e)
            return false
        }
    }
}