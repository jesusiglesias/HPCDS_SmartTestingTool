package CustomTasksUser

import User.User
import Security.SecUser
import Test.Test
import Test.Topic
import User.Evaluation
import grails.converters.JSON
import grails.transaction.Transactional
import groovy.time.TimeCategory
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
    def passwordEncoder

    static allowedMethods = [formContact: "POST", updatePersonalInfo: "PUT", updateAvatar: "POST", updatePassword: "PUT"]

    /**
     * It shows the home page of the user.
     */
    def home() {
        log.debug("CustomTasksFrontEndController():home()")

        // It obtains the visible topic
        def activeTopics = Topic.findAllByVisibility(true, [sort:"name", order:"asc"])

        def numberActiveTest = []

        // It obtains the number of active test for each topic
        activeTopics.each { topic ->
            def result = Test.findAllByTopicAndActive(topic, true).size()
            numberActiveTest.push(result)
        }

        render view: 'home', model: [activeTopics: activeTopics, numberActiveTest: numberActiveTest]
    }

    /**
     * It shows the topic page with test to the user.
     */
    def topicSelected() {
        log.debug("CustomTasksFrontEndController():topicSelected()")

        def allowedDate = []

        // Security in topic
        if (params.id != null) {

            // It checks if params.id is an UUID type
            try{
                UUID uuidTopic = UUID.fromString(params.id);

                def topicInstance = Topic.findById(uuidTopic)
                def topicInstanceActiveTest = Test.findAllByTopicAndActive(topicInstance, true)

                // URL maliciously introduced because the topic is not visible
                if (!topicInstance.visibility || topicInstanceActiveTest.size() == 0 ) {
                    response.sendError(404)
                } else {

                    log.error(topicInstanceActiveTest)

                    // Today
                    def todayDate = new Date().clearTime()

                    // It checks if each test is accesible by date
                    topicInstanceActiveTest.each { test ->

                        use(TimeCategory) {

                            if(todayDate >= test.initDate && todayDate <= test.endDate) {
                                allowedDate.push(true)
                            } else {
                                allowedDate.push(false)
                            }
                        }
                    }

                    log.error(allowedDate)

                    // Tooltip messages
                    def accessible = g.message(code:"layouts.main_auth_user.body.topicSelected.tooltip.accessible", default:"Accessible test")
                    def inaccessible = g.message(code:"layouts.main_auth_user.body.topicSelected.tooltip.inaccessible", default:"Inaccessible test")

                    render view: 'topicSelected', model: [topicName: topicInstance.name, availableTotalTest: topicInstanceActiveTest, allowedDate:allowedDate, todayDate: todayDate, accessible: accessible, inaccessible: inaccessible]
                }
            } catch (IllegalArgumentException exception){ // Params.id is not valid UUID
                log.error("CustomTasksFrontEndController():topicSelected():Exception:paramsTopic:notUUID:${exception}")

                response.sendError(404)
            }
        } else {
            response.sendError(404)
        }
    }

    /**
     * It shows the test page of the topic selected by user.
     */
    def testSelected() {
        log.debug("CustomTasksFrontEndController():testSelected()")

        render view: 'testSelected'
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
        bindData(currentUserInstance, this.params, [exclude:['version', 'username', 'birthDate']])

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

                // Clear the list of errors
                currentUserInstance.clearErrors()
                flash.userProfileErrorMessage = g.message(code:"default.optimistic.locking.failure.userProfile", default:"While you were editing, this user has been update from another device or browser. You try it again later.")

                redirect uri: "/profile"
                return
            }
        }

        // Validate the instance
        if (!currentUserInstance.validate()) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            // It obtains the statistics
            userStatsList = testStats(currentUserInstance)

            // It obtains the original data of the user
            User.withNewSession {
                infoCurrentUser = User.get(springSecurityService.currentUser.id)
                // Avoid lazy load - without session; stats section (department)
                User.get(springSecurityService.currentUser.id).department
            }

            // Avoid lazy load - without session; list of department in _personalData (when user chooses several departments)
            currentUserInstance.department = User.get(springSecurityService.currentUser.id).department

            respond currentUserInstance.errors, view:'profile', model: [infoCurrentUser: infoCurrentUser, currentUser: currentUserInstance, completedTest: userStatsList[1], numberActiveTest: userStatsList[0], numberApprovedTest: userStatsList[3], numberUnapprovedTest: userStatsList[2]]
            return
        }

        try {

            // Save user data
            currentUserInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userProfileMessage = g.message(code: 'default.myProfile.personalInfo.success', default: 'Your personal information has been successfully updated.')
                    redirect uri: '/profile'
                }
            }
        } catch (Exception exception) {
            log.error("CustomTasksFrontEndController():update():Exception:NormalUser:${currentUserInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userProfileErrorMessage = g.message(code: 'default.myProfile.personalInfo.error', default: 'ERROR! While updating your personal information.')
                    redirect uri: '/profile'
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

        // Not found
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
                    flash.userProfileAvatarMessage = g.message(code: 'default.myProfile.avatar.success', default: 'Your profile image has been updated successfully.')
                    redirect uri: '/profileAvatar'
                }
            }

        } catch (Exception exception) {
            log.error("CustomTasksFrontEndController():updateAvatar():Exception:NormalUser:${currentUserInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userProfileAvatarErrorMessage = g.message(code: 'default.myProfile.avatar.error', default: 'ERROR! While updating your profile image.')
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
     * It shows the password page of the current user.
     */
    def profilePassword() {
        log.debug("CustomTasksFrontEndController():profilePassword()")

        def userStatsList

        // ID of current user
        def currentUser = User.get(springSecurityService.currentUser.id)

        userStatsList = testStats(currentUser)

        render view: 'profilePassword', model: [currentUser: currentUser, completedTest: userStatsList[1], numberActiveTest: userStatsList[0], numberApprovedTest: userStatsList[3], numberUnapprovedTest: userStatsList[2]]
    }

    /**
     * It updates the password of the current normal user.
     *
     * @return return If the current user instance is null or has errors.
     */
    @Transactional
    def updatePassword() {
        log.debug("CustomTasksFrontEndController():updatePassword()")

        def pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+\$).{8,}\$"

        // User with params received
        def user = new User(params)

        // Not found
        if (user == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFoundPassword()
            return
        }

        // Back-end validation - Current password
        if (!StringUtils.isNotBlank(params.currentPassword)) {

            flash.userProfilePasswordErrorMessage = g.message(code: 'default.myProfile.password.current', default: '<strong>Current password</strong> field is required.')
            redirect uri: "/profilePassword"
            return
        }

        // It obtains the current user
        User currentUserInstance = User.get(springSecurityService.currentUser.id)

        // Back-end validation - Current password and password in database
        if (!passwordEncoder.isPasswordValid(currentUserInstance.password, params.currentPassword, null)) {

            flash.userProfilePasswordErrorMessage = g.message(code: 'default.myProfile.password.current.match', default: '<strong>Current password</strong> field does not match with your password in force.')
            redirect uri: "/profilePassword"
            return
        }

        // Back-end validation - New password
        if (!StringUtils.isNotBlank(params.password)) {

            flash.userProfilePasswordErrorMessage = g.message(code: 'default.myProfile.password.new', default: '<strong>New password</strong> field is required.')
            redirect uri: "/profilePassword"
            return
        }

        // Back-end validation - New password matches with pattern and maxlength
        if (!params.password.matches(pattern) || params.password.length() > 32) {

            flash.userProfilePasswordErrorMessage = g.message(code: 'default.myProfile.password.new.match', default: '<strong>New password</strong> field does not match with the required pattern.')
            redirect uri: "/profilePassword"
            return
        }

        // Back-end validation - New password different to username
        if (params.password.toLowerCase().equals(currentUserInstance.username.toLowerCase())) {

            flash.userProfilePasswordErrorMessage = g.message(code: 'default.myProfile.password.notUsername', default: '<strong>New password</strong> field must not be equal to username.')
            redirect uri: "/profilePassword"
            return
        }

        // Back-end validation - Confirm password
        if (!StringUtils.isNotBlank(params.confirmPassword)) {

            flash.userProfilePasswordErrorMessage = g.message(code: 'default.myProfile.password.confirm', default: '<strong>Confirm password</strong> field is required.')
            redirect uri: "/profilePassword"
            return
        }

        // Back-end validation - New password and confirm password equals
        if (!params.password.equals(params.confirmPassword)) {

            flash.userProfilePasswordErrorMessage = g.message(code: 'default.myProfile.password.confirm.match.newPassword', default: '<strong>New password</strong> and <strong>Confirm password</strong> fields must match.')
            redirect uri: "/profilePassword"
            return
        }

        // Bind data
        bindData(currentUserInstance, this.params, [include: ['password', 'confirmPassword']])

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (currentUserInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                currentUserInstance.clearErrors()
                flash.userProfilePasswordErrorMessage = g.message(code: 'default.optimistic.locking.failure.userProfile', default: 'While you were editing, this user has been update from another device or browser. You try it again later.')

                redirect uri: "/profilePassword"
                return
            }
        }

        try {

            // Update profile image
            currentUserInstance.save(flush: true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userProfilePasswordMessage = g.message(code: 'default.myProfile.password.success', default: 'Your password has been successfully updated.')
                    redirect uri: '/profilePassword'
                }
            }

        } catch (Exception exception) {
            log.error("CustomTasksFrontEndController():updatePassword():Exception:NormalUser:${currentUserInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userProfilePasswordErrorMessage = g.message(code: 'default.myProfile.password.error', default: 'ERROR! While updating your password.')
                    redirect uri: "/profilePassword"
                }
            }
        }
    }

    /**
     * It renders the not found message if the user instance was not found.
     */
    protected void notFoundPassword() {
        log.debug("CustomTasksFrontEndController():updateProfile:notFoundPassword():CurrentUser:${springSecurityService.currentUser.username}")

        request.withFormat {
            form multipartForm {
                flash.userProfilePasswordErrorMessage = g.message(code: 'default.not.found.userProfile.message', default:'It has not been able to locate the user. Please. if the problem continues you contact us through the contact form.')
                redirect action: "profilePassword", method: "GET"
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