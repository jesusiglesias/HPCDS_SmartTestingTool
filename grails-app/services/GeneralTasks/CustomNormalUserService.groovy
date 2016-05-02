package GeneralTasks

import grails.transaction.Transactional
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

/**
 * Service that contains the habitual tasks of the normal user.
 */
@Transactional
class CustomNormalUserService {

    // It gets access to message source by convention
    MessageSource messageSource
    def mailService

    /**
     * It sends an email from form contact.
     *
     * @param name Name introduced by user.
     * @param emailcurrentUser Email of the current user.
     * @param mailTo Email destination.
     * @param subject Subject introduced by user.
     * @param message Message introduced by user.
     * @return true If the action is successful.
     */
    def sendEmail_contactForm(String name, String emailcurrentUser, String mailTo, subject, String message) {
        log.debug("CustomNormalUserService:sendEmail_contactForm()")

        Object[] args = [emailcurrentUser, subject]

        try {
            mailService.sendMail {
                to mailTo
                from emailcurrentUser
                subject messageSource.getMessage("layouts.main_auth_user.body.map.contact.form.email.subject", args, "[STT: Contact form] - User: {0}, subject: {1}", LocaleContextHolder.locale)
                html(view: '/email/contactForm', model: [name: name, email: emailcurrentUser, subject: subject, message: message])
            }
            return true

        } catch (Exception e) {
            e.printStackTrace()
            return false
        }
    }
}