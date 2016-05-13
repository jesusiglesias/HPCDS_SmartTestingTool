package CustomTasksUser

import User.User
import Security.SecUser
import Test.Test
import User.Evaluation
import grails.converters.JSON
import grails.transaction.Transactional
import org.apache.commons.lang.StringUtils
import java.text.SimpleDateFormat
import static grails.async.Promises.*
import static org.springframework.http.HttpStatus.NOT_FOUND

/**
 * It contains the habitual custom tasks of the normal user.
 */
class CustomTasksFrontEndController {

    // Mime-types allowed in image
    private static final contentsType = ['image/png', 'image/jpeg', 'image/gif']

    def springSecurityService
    def mailService

    static allowedMethods = [formContact: "POST", updatePersonalInfo: "PUT", updateAvatar: "POST"]

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
        bindData(currentUserInstance, this.params, [exclude:['username', 'birthDate']])

        log.error(currentUserInstance.username)

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
     * It shows the image of profile page of the current user.
     */
    def profileAvatar() {
        log.debug("CustomTasksFrontEndController():profileAvatar()")

        def userStatsList

        // ID of current user
        def currentUser = User.get(springSecurityService.currentUser.id)

        userStatsList = testStats(currentUser)

        render view: 'profileAvatar', model: [currentUser: currentUser, completedTest: userStatsList[1], numberActiveTest: userStatsList[0], numberApprovedTest: userStatsList[3], numberUnapprovedTest: userStatsList[2]]
    }

    /**
     * It updates the profile image of the current normal user.
     *
     * @return return If the current user instance is null or has errors.
     */
    @Transactional
    def updateAvatar() {
        log.debug("CustomTasksFrontEndController():updateAvatar()")

        def userStatsList

        // User with params received
        def user = new User(params)

        if (user == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFoundAvatar()
            return
        }

        // Get the avatar file from the multi-part request
        def filename = request.getFile('avatarUser')

        // It checks that mime-types is correct: ['image/png', 'image/jpeg', 'image/gif']
        if (!filename.empty && !contentsType.contains(filename.getContentType())) {

            flash.userProfileAvatarErrorMessage = g.message(code: 'default.validation.mimeType.image', default: 'The profile image must be of type: <strong>.png</strong>, <strong>.jpeg</strong> or <strong>.gif</strong>.')
            redirect uri: "/profileAvatar"
            return
        }

        // It obtains the current user
        User currentUserInstance = User.get(springSecurityService.currentUser.id)

        // Update the image and mime type
        currentUserInstance.avatar = filename.bytes
        currentUserInstance.avatarType = filename.contentType

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (currentUserInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                currentUserInstance.clearErrors()
                flash.userProfileAvatarErrorMessage = g.message(code: 'default.optimistic.locking.failure.userProfile', default: 'While you were editing, this user has been update from another device or browser. You try it again later.')

                redirect uri: "/profileAvatar"
                return
            }
        }

        // Validate the instance
        if (!currentUserInstance.validate()) {

            userStatsList = testStats(currentUserInstance)
            respond currentUserInstance.errors, view:'profileAvatar', model: [currentUser: currentUserInstance, completedTest: userStatsList[1], numberActiveTest: userStatsList[0], numberApprovedTest: userStatsList[3], numberUnapprovedTest: userStatsList[2]]
            return
        }

        try {

            // Update profile image
            currentUserInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userProfileAvatarMessage = g.message(code: 'default.myProfile.avatar.success', default: 'The profile image has been updated successfully.')
                    redirect uri: '/profileAvatar'
                }
            }

        } catch (Exception exception) {
            log.error("CustomTasksFrontEndController():updateAvatar():Exception:NormalUser:${currentUserInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userProfileAvatarErrorMessage = g.message(code: 'default.myProfile.avatar.error', default: 'ERROR! While updating the profile image.')

                    redirect uri: "/profileAvatar"
                }
            }
        }
    }

    /**
     * It renders the not found message if the user instance was not found.
     */
    protected void notFoundAvatar() {
        log.debug("CustomTasksFrontEndController():updateProfile:notFoundAvatar():CurrentUser:${springSecurityService.currentUser.username}")

        request.withFormat {
            form multipartForm {
                flash.userProfileAvatarErrorMessage = g.message(code: 'default.not.found.userProfile.message', default:'It has not been able to locate the user. Please. if the problem continues you contact us through the contact form.')
                redirect action: "profileAvatar", method: "GET"
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

        // Back-end validation
        if ( !StringUtils.isNotBlank(params.name) || !StringUtils.isNotBlank(params.subject) || !StringUtils.isNotBlank(params.message)  ) {
            responseData = [
                    'status': "errorValidationContact",
                    'message': g.message(code: 'layouts.main_auth_user.body.map.contact.validation.backend.null', default: 'Please fill out all current fields to send the contact form.')
            ]

            render responseData as JSON
            return
        }

        // Back-end validation - Maxlength, name
        if ( params.name.length() > 65) {
            responseData = [
                    'status': "errorMaxLengthNameContact",
                    'message': g.message(code: 'layouts.main_auth_user.body.map.contact.validation.backend.maxlength.name', default: '<strong>Name</strong> field can not exceed 65 characters.')
            ]

            render responseData as JSON
            return
        }

        // Back-end validation - Maxlength, message
        if ( params.message.length() > 1000) {
            responseData = [
                    'status': "errorMaxLengthMessageContact",
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

            log.debug("CustomTasksFrontEndController:contactForm():mailSent:from:${emailCurrentUser}")

            responseData = [
                        'status': "successContact",
                        'message': g.message(code: 'customTasksUser.contactform.success', default: 'Notification has been processed. We will contact you as soon as possible.')
            ]

            render responseData as JSON

        } catch (Exception e) {
            log.error("CustomTasksFrontEndController:contactForm():NOTMailSent:from:${emailCurrentUser}")

            responseData = [
                    'status': "errorContact",
                    'message': g.message(code: 'customTasksUser.contactform.error', default: 'An internal error has occurred during the sending email. You try it again later.')
            ]

            render responseData as JSON
        }
    }
}