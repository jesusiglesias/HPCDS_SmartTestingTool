package CustomTasksUser

import User.User
import Security.SecUser
import Test.Test
import User.Evaluation
import grails.converters.JSON

/**
 * It contains the habitual custom tasks of the normal user.
 */
class CustomTasksFrontEndController {

    def springSecurityService
    def mailService

    static allowedMethods = [formContact: "POST"]

    /**
     * It shows the home page of user.
     */
    def home() {
        log.debug("CustomTasksFrontEndController():home()")

        render view: 'home'
    }

    /**
     * It shows the scores of the current user.
     */
    def scores() {
        log.debug("CustomTasksFrontEndController():scores()")

        // ID of current user
        def currentUser = User.get(springSecurityService.currentUser.id)
        def evaluations = Evaluation.findAllByUser(currentUser)

        render view: 'scores', model: [evaluations: evaluations]
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

        def responseData
        def mailTo = grailsApplication.config.grails.mail.username

        // Email of current user
        def emailCurrentUser = SecUser.get(springSecurityService.currentUser.id).email

        try {

            mailService.sendMail {
                to mailTo
                subject g.message(code: "layouts.main_auth_user.body.map.contact.form.email.subject", default: '[STT: Contact form] - User: {0}, subject: {1}', args: [params.name, params.subject])
                html(view: '/email/contactForm', model: [name: params.name, email: emailCurrentUser, subject: params.subject, message: params.message])
            }

            log.debug("CustomTasksFrontEndController:contactForm():mailSent:from:${emailCurrentUser}")

            responseData = [
                        'status': "successContact",
                        'message': g.message(code: 'customTasksUser.sendEmail.success', default: 'Notification processed. You will receive an email to reset the password in the indicated address.')
            ]

            render responseData as JSON

        } catch (Exception e) {
            log.error("CustomTasksFrontEndController:contactForm():NOTMailSent:from:${emailCurrentUser}")

            responseData = [
                    'status': "errorContact",
                    'message': g.message(code: 'customTasksUser.sendEmail.error', default: 'An internal error has occurred during the sending email. You try it again later.')
            ]

            render responseData as JSON
        }
    }
}
