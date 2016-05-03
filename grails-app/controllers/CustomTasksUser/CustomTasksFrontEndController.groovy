package CustomTasksUser

import Security.SecUser

/**
 * It contains the habitual custom tasks of the normal user (front-end).
 */
class CustomTasksFrontEndController {

    def customNormalUserService
    def springSecurityService

    static allowedMethods = [formContact: "POST"]

    /**
     * It shows the home page of user.
     */
    def home() {
        log.debug("CustomTasksFrontEndController():home()")

        render view: 'home'
    }

    /**
     * It shows the cookies policy page of user.
     */
    def cookiesPolicy() {
        log.debug("CustomTasksFrontEndController():cookiesPolicy()")

        render view: 'cookiesPolicy'
    }

    /**
     * It shows the contact page.
     */
    def contact() {
        log.debug("CustomTasksFrontEndController():contact()")

        def subjectList = []

        // Information
        def informationSubject = g.message(code: "layouts.main_auth_user.body.map.contact.form.subject.information", default: 'General information')
        subjectList.push(informationSubject)

        // Dudas y sugerencias
        def suggestionSubject = g.message(code: "layouts.main_auth_user.body.map.contact.form.subject.suggestion", default: 'Doubts and suggestions')
        subjectList.push(suggestionSubject)

        // Error en el sistema
        def errorSubject = g.message(code: "layouts.main_auth_user.body.map.contact.form.subject.error", default: 'Error in system')
        subjectList.push(errorSubject)

        // Eliminar cuenta
        def deleteSubject = g.message(code: "layouts.main_auth_user.body.map.contact.form.subject.deleteAccount", default: 'Delete account user')
        subjectList.push(deleteSubject)

        // Otro
        def anotherSubject = g.message(code: "layouts.main_auth_user.body.map.contact.form.subject.another", default: 'Another')
        subjectList.push(anotherSubject)

        render view: 'contact', model: [subjectList: subjectList]
    }

    /**
     * It sends an email to the administrator from the contact form.
     *
     * @return true If the action was succesful.
     */
    def contactForm() {
        log.debug("CustomTasksFrontEndController():contactForm()")

        def mailTo = grailsApplication.config.grails.mail.username

        // Email of current user
        def emailCurrentUser = SecUser.get(springSecurityService.currentUser.id).email

        if (!customNormalUserService.sendEmail_contactForm(params.name, emailCurrentUser, mailTo, params.subject as String, params.message)) {
            log.error("CustomTasksFrontEndController:contactForm():NOTMailSent:from:${emailCurrentUser}")

            flash.errorContactForm = g.message(code: 'customTasksUser.sendEmail.error', default: 'An internal error has occurred during the sending email. You try it again later.')

        } else {
            log.debug("CustomTasksFrontEndController:contactForm():mailSent:from:${emailCurrentUser}")
            flash.successContactForm = g.message(code: 'customTasksUser.sendEmail.success', default: 'Notification processed. You will receive an email to reset the password in the indicated address.')
        }

        redirect uri: '/contact'
    }
}
