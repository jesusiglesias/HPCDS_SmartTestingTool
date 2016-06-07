package CustomTasksUser

import Security.SecUser
import grails.converters.JSON
import org.apache.commons.lang.StringUtils

/**
 * It contains the habitual information tasks of the normal user.
 */
class CustomTasksUserInformationController {

    def mailService
    def springSecurityService

    static allowedMethods = [contactForm: "POST"]

    /**
     * It shows the cookies policy page of user.
     */
    def cookiesPolicy() {
        log.debug("CustomTasksUserInformationController():cookiesPolicy()")

        render view: 'CookiesPolicy'
    }

    /**
     * It shows the FAQ page to user.
     */
    def faq() {
        log.debug("CustomTasksUserInformationController():faq()")

        render view: 'FAQ'
    }

    /**
     * It shows the contact page.
     */
    def contact() {
        log.debug("CustomTasksUserInformationController():contact()")

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

        render view: 'Contact', model: [subjectList: subjectList]
    }

    /**
     * It sends an email to the administrator from the contact form.
     *
     * @return true If the action was succesful.
     */
    def contactForm() {
        log.debug("CustomTasksUserInformationController():contactForm()")

        def responseData
        def mailTo = grailsApplication.config.grails.mail.username

        // Back-end validation
        if (!StringUtils.isNotBlank(params.name) || !StringUtils.isNotBlank(params.subject) || !StringUtils.isNotBlank(params.message)) {
            responseData = [
                    'status' : "errorValidationContact",
                    'message': g.message(code: 'layouts.main_auth_user.body.map.contact.validation.backend.null', default: 'Please fill out all current fields to send the contact form.')
            ]

            render responseData as JSON
            return
        }

        // Back-end validation - Maxlength, name
        if (params.name.length() > 65) {
            responseData = [
                    'status' : "errorMaxLengthNameContact",
                    'message': g.message(code: 'layouts.main_auth_user.body.map.contact.validation.backend.maxlength.name', default: '<strong>Name</strong> field can not exceed 65 characters.')
            ]

            render responseData as JSON
            return
        }

        // Back-end validation - Maxlength, message
        if (params.message.length() > 1000) {
            responseData = [
                    'status' : "errorMaxLengthMessageContact",
                    'message': g.message(code: 'layouts.main_auth_user.body.map.contact.validation.backend.maxlength.message', default: '<strong>Message</strong> field cant not exceed 1000 characters.')
            ]

            render responseData as JSON
            return
        }

        // Email of current user
        def emailCurrentUser = SecUser.get(springSecurityService.currentUser.id).email

        try {

            mailService.sendMail {
                to mailTo
                subject g.message(code: "layouts.main_auth_user.body.map.contact.form.email.subject", default: '[STT: Contact form] - User: {0}, subject: {1}', args: [params.name, params.subject])
                html(view: '/email/contactForm', model: [name: params.name, email: emailCurrentUser, subject: params.subject, message: params.message])
            }

            log.debug("CustomTasksUserInformationController:contactForm():mailSent:from:${emailCurrentUser}")

            responseData = [
                    'status' : "successContact",
                    'message': g.message(code: 'customTasksUser.contactform.success', default: 'Notification has been processed. We will contact you as soon as possible.')
            ]

            render responseData as JSON

        } catch (Exception e) {
            log.error("CustomTasksUserInformationController:contactForm():NOTMailSent:from:${emailCurrentUser}")

            responseData = [
                    'status' : "errorContact",
                    'message': g.message(code: 'customTasksUser.contactform.error', default: 'An internal error has occurred during the sending email. You try it again later.')
            ]

            render responseData as JSON
        }
    }
}