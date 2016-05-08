package CustomTasksUser

import User.User
import Security.SecUser
import Test.Test
import User.Evaluation
import grails.converters.JSON
import grails.transaction.Transactional

import java.text.SimpleDateFormat

import static grails.async.Promises.*
import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.OK

/**
 * It contains the habitual custom tasks of the normal user.
 */
class CustomTasksFrontEndController {

    def springSecurityService
    def mailService

    static allowedMethods = [formContact: "POST", updatePersonalInfo: "PUT"]

    /**
     * It shows the home page of user.
     */
    def home() {
        log.debug("CustomTasksFrontEndController():home()")

        render view: 'home'
    }

    /**
     * It shows the profile of the current user.
     */
    def profile() {
        log.debug("CustomTasksFrontEndController():profile()")

        def userStatsList

        // ID of current user
        def currentUser = User.get(springSecurityService.currentUser.id)

        userStatsList = testStats(currentUser)

        render view: 'profile', model: [infoCurrentUser: currentUser, currentUser: currentUser, completedTest: userStatsList[1], numberActiveTest: userStatsList[0], numberApprovedTest: userStatsList[3], numberUnapprovedTest: userStatsList[2]]
    }

    /**
     * It obtains the test statistics.
     */
    def private testStats(currentUser) {

        def statsList = []

        // Evaluations of the user
        def completedTest = Evaluation.findAllByUser(currentUser).size()

        // Obtaining number of active test in system - Asynchronous/Multi-thread
        def testPromise = Test.async.findAllByActive(true)

        // Obtaining test approved and unapproved - Asynchronous/Multi-thread
        def suspensePromise = Evaluation.async.findAllByUserAndTestScoreLessThan(currentUser, 5)
        def approvedPromise = Evaluation.async.findAllByUserAndTestScoreGreaterThanEquals(currentUser, 5)

        // Wait all promises
        def results = waitAll(testPromise, suspensePromise, approvedPromise)

        def numberActiveTest = results[0].size()
        def numberUnapprovedTest = results[1].size()
        def numberApprovedTest = results[2].size()

        statsList.push(numberActiveTest)
        statsList.push(completedTest)
        statsList.push(numberUnapprovedTest)
        statsList.push(numberApprovedTest)

        return statsList
    }

    /**
     * It updates the profile of the current normal user.
     *
     * @return return If the current user instance is null or has errors.
     */
    @Transactional
    def updatePersonalInfo() {
        log.debug("CustomTasksFrontEndController():updatePersonalInfo()")

        def userStatsList
        def infoCurrentUser

        // User with params received
        def user = new User(params)

        // It obtains the current user
        User currentUserInstance = User.get(springSecurityService.currentUser.id)
        currentUserInstance.properties = params

        // It checks the date
        if (params.birthDate != "") {

            // Parse birthDate from textField
            def birthDateFormat = new SimpleDateFormat('dd-MM-yyyy').parse(params.birthDate)
            currentUserInstance.birthDate = birthDateFormat
        }

        // Not found
        if (user == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (currentUserInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                userStatsList = testStats(currentUserInstance)
                infoCurrentUser = User.get(springSecurityService.currentUser.id)

                // Clear the list of errors
                currentUserInstance.clearErrors()
                currentUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure.userProfile", "While you were editing, this user has been update from another device or browser. You try it again later.")

                respond currentUserInstance.errors, view:'profile', model: [infoCurrentUser: infoCurrentUser, currentUser: currentUserInstance, completedTest: userStatsList[1], numberActiveTest: userStatsList[0], numberApprovedTest: userStatsList[3], numberUnapprovedTest: userStatsList[2]]
                return
            }
        }

        // Validate the instance
        if (!currentUserInstance.validate()) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            userStatsList = testStats(currentUserInstance)
            infoCurrentUser = User.get(springSecurityService.currentUser.id)

            log.error(infoCurrentUser.name)
            log.error(infoCurrentUser.department.name)

            respond currentUserInstance.errors, view:'profile', model: [infoCurrentUser: infoCurrentUser, currentUser: currentUserInstance, completedTest: userStatsList[1], numberActiveTest: userStatsList[0], numberApprovedTest: userStatsList[3], numberUnapprovedTest: userStatsList[2]]
            return
        }

        try {

            // Save user data
            currentUserInstancee.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userProfileMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'user.label', default: 'User'), currentUserInstance.username])
                    redirect uri: '/profile'
                }
            }
        } catch (Exception exception) {
            log.error("CustomTasksFrontEndController():update():Exception:NormalUser:${currentUserInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            userStatsList = testStats(currentUserInstance)
            infoCurrentUser = User.get(springSecurityService.currentUser.id)

            request.withFormat {
                form multipartForm {
                    flash.userProfileErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'user.label', default: 'User'), currentUserInstance.username])
                    render view: "profile", model: [infoCurrentUser: infoCurrentUser, currentUser: currentUserInstance, completedTest: userStatsList.get(1), numberActiveTest: userStatsList.get(0), numberApprovedTest: userStatsList.get(3), numberUnapprovedTest: userStatsList.get(2)]
                }
            }
        }
    }

    /**
     * It renders the not found message if the user instance was not found.
     */
    protected void notFound() {
        log.debug("CustomTasksFrontEndController():updateProfile:notFound():CurrentUser:${springSecurityService.currentUser.username}")

        request.withFormat {
            form multipartForm {
                flash.userProfileErrorMessage = g.message(code: 'default.not.found.userProfile.message', default:'It has not been able to locate the user. Please. if the problem continues you contact us through the contact form.')
                redirect action: "profile", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
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
