package CustomTasksUser

import User.User
import Test.Test
import Test.Question
import Test.Topic
import Test.Answer
import User.Evaluation
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
    def passwordEncoder

    static allowedMethods = [updatePersonalInfo: "PUT", updateAvatar: "POST", updatePassword: "PUT", calculateEvaluation: "POST"]

    /**
     * It shows the home page of the user.
     */
    def home() {
        log.debug("CustomTasksFrontEndController():home()")

        def visibleTopics
        def numberActiveTest = []

        // It obtains the current user
        def currentUser = User.get(springSecurityService.currentUser?.id)

        // Avoid error if user has not associated test
        if (currentUser.accessTests.size() == 0) {
            visibleTopics = []

        } else{

            // It obtains the visible topics with accessible test by user
            visibleTopics = Topic.createCriteria().listDistinct {
                createAlias('tests', 't',)
                'in'('t.id', currentUser.accessTests*.id)
                eq 'visibility', true
                order("name", "asc")
            }

            // It obtains the number of active test for each topic
            visibleTopics.each { topic ->

                def result = Test.createCriteria().list() {
                    createAlias('allowedUsers', 'u',)
                    eq 'u.id', currentUser.id
                    eq 'topic', topic
                    eq 'active', true
                    order("name", "asc")
                }

                numberActiveTest.push(result.size())
            }
        }

        render view: 'home', model: [visibleTopics: visibleTopics, numberActiveTest: numberActiveTest]
    }

    /**
     * It shows the topic page with test to the user.
     */
    def topicSelected() {
        log.debug("CustomTasksFrontEndController():topicSelected()")

        def allowedDate = []
        def allowedAttempt = []

        // Security in topic
        if (params.id != null) {

            // It checks if params.id is an UUID type
            try{
                UUID uuidTopic = UUID.fromString(params.id);

                def topicInstance = Topic.findById(uuidTopic)

                if (topicInstance != null) {

                    // It obtains the current user
                    def currentUser = User.get(springSecurityService.currentUser?.id)

                    def topicInstanceActiveTest = Test.createCriteria().list() {
                        createAlias('allowedUsers', 'u',)
                        eq 'u.id', currentUser.id
                        eq 'topic', topicInstance
                        eq 'active', true
                        order("name", "asc")
                    }

                    // URL maliciously introduced because the topic is not visible
                    if (!topicInstance.visibility || topicInstanceActiveTest.size() == 0) {
                        response.sendError(404)
                    } else {

                        // Today
                        def todayDate = new Date().clearTime()

                        // It checks if each test is accessible by date
                        topicInstanceActiveTest.each { test ->

                            use(TimeCategory) {

                                if (todayDate >= test.initDate && todayDate <= test.endDate) {
                                    allowedDate.push(true)
                                } else {
                                    allowedDate.push(false)
                                }
                            }
                        }

                        // It checks if each test is accessible by number of attempt
                        topicInstanceActiveTest.each { test ->

                            def userAttempt = Evaluation.findByUserNameAndTestName(currentUser.username, test.name)?.attemptNumber

                            // It obtains the current attempt of user
                            if (userAttempt == null) {
                                userAttempt = 0
                            }

                            // It checks if each test is accessible by maximum number of attemtps
                            if (userAttempt < test.maxAttempts) {
                                allowedAttempt.push(true)
                            } else {
                                allowedAttempt.push(false)
                            }
                        }

                        // Tooltip messages
                        def accessible = g.message(code: "layouts.main_auth_user.body.topicSelected.tooltip.accessible", default: "Accessible test")
                        def inaccessible = g.message(code: "layouts.main_auth_user.body.topicSelected.tooltip.inaccessible", default: "Inaccessible test")

                        render view: 'topicSelected', model: [topicName: topicInstance.name, availableTotalTest: topicInstanceActiveTest, allowedAttempt: allowedAttempt, allowedDate: allowedDate, accessible: accessible, inaccessible: inaccessible]
                    }
                } else {
                    log.error("CustomTasksFrontEndController():topicSelected():Exception:paramsTopic:notExist")

                    response.sendError(404)
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
    @Transactional
    def testSelected() {
        log.debug("CustomTasksFrontEndController():testSelected()")

        def allowedDateTest = false
        def attemptUserTest
        def totalPossibleScore = 0

        // Security in test
        if (params.id != null) {

            // It checks if params.id is an UUID type
            try{
                UUID uuidTest = UUID.fromString(params.id);

                def testInstance = Test.findById(uuidTest)

                if (testInstance != null) {

                    // Today
                    def todayDate = new Date().clearTime()

                    // It checks if test is accessible by date
                    use(TimeCategory) {
                        allowedDateTest = todayDate >= testInstance.initDate && todayDate <= testInstance.endDate
                    }

                    // It obtains the current user
                    def currentUserToTest = User.get(springSecurityService.currentUser?.id)

                    // It checks if each test is accessible by number of attempt
                    def currentEvaluation = Evaluation.findByUserNameAndTestName(currentUserToTest.username, testInstance.name)

                    // It obtains the current attempt of user
                    if (currentEvaluation?.attemptNumber == null) {
                        attemptUserTest = 0
                    } else {
                        attemptUserTest = currentEvaluation.attemptNumber
                    }
                    
                    // It checks if test is active and is accessible by user, date, number of attempts and number of questions
                    if (!testInstance.active || !currentUserToTest.accessTests*.id.contains(testInstance.id) || !allowedDateTest || attemptUserTest >= testInstance.maxAttempts || testInstance.numberOfQuestions == 0) {
                        response.sendError(404)

                    } else {

                        // It obtains random questions from catalog with maximum limit
                        def questions =  Question.createCriteria().list() {
                            createAlias('catalogs', 'c', )
                            eq 'c.name', testInstance.catalog.name
                            sqlRestriction " 1=1 order by rand()"
                            maxResults(testInstance.numberOfQuestions)
                        }

                        // It checks that database has questions
                        if (questions.size() > 0 && questions.size() >= testInstance.numberOfQuestions) {

                            // It calculates the total possible score of the test in each user
                            questions.each { question ->
                                question.answers.each { answer ->
                                    if (answer.correct == true) {
                                        totalPossibleScore += answer.score
                                    }
                                }
                            }

                            if (currentEvaluation == null) {

                                // It creates new evaluation of the user
                                def newEvaluation = new Evaluation(
                                        testName: testInstance.name,
                                        attemptNumber: 1,
                                        initDate: new Date(),
                                        maxAttempt: testInstance.maxAttempts,
                                        maxPossibleScore: totalPossibleScore,
                                        userName: currentUserToTest.username,
                                )

                                def validNewEvaluation = newEvaluation.validate()

                                if (validNewEvaluation) {

                                    try {
                                        // It associates the evaluation to user
                                        currentUserToTest.addToEvaluations(newEvaluation)

                                        // It associates the evaluation to test
                                        testInstance.addToEvaluationsTest(newEvaluation)
                                        newEvaluation.save(flush: true, failOnError: true)

                                    } catch (Exception exception) {
                                        log.error("CustomTasksFrontEndController():testSelected():Exception:newEvaluation:${currentUserToTest.username}-${testInstance.name}:${exception}")

                                        // Roll back in database
                                        transactionStatus.setRollbackOnly()
                                        response.sendError(404)
                                    }

                                } else {
                                    log.error("CustomTasksFrontEndController():testSelected():Exception:notValid:newEvaluation:user:${currentUserToTest.username}:errors:${newEvaluation.errors}")

                                    response.sendError(404)
                                }
                            } else {

                                // It increases the number of attempt of the user in the evaluation
                                currentEvaluation.attemptNumber += 1
                                currentEvaluation.completenessDate = null
                                currentEvaluation.maxPossibleScore = totalPossibleScore
                                currentEvaluation.initDate = new Date()

                                def validExistEvaluation = currentEvaluation.validate()

                                if (validExistEvaluation) {

                                    try {
                                        currentEvaluation.save(flush: true, failOnError: true)

                                    } catch (Exception exception) {
                                        log.error("CustomTasksFrontEndController():testSelected():Exception:updatingEvaluation:${currentUserToTest.username}-${testInstance.name}:${exception}")

                                        // Roll back in database
                                        transactionStatus.setRollbackOnly()
                                        response.sendError(404)
                                    }

                                } else {
                                    log.error("CustomTasksFrontEndController():testSelected():Exception:notValid:existingEvaluation:user:${currentUserToTest.username}:errors:${currentEvaluation.errors}")

                                    response.sendError(404)
                                }
                            }
                            render view: 'testSelected', model: [testID: testInstance.id, testName: testInstance.name, attemptNumber: currentEvaluation?.attemptNumber?:1, topicID: testInstance.topic.id, maximumTime: testInstance.lockTime, questions: questions]
                        } else {

                            flash.errorTestSelected =  g.message(code: "layouts.main_auth_user.body.topicSelected.error.question", default: 'Number of questions associated with the <strong>{0}</strong> test insufficient. Please, if the problem persists please contact us.', args: ["${testInstance.name}"])

                            redirect controller: 'customTasksFrontEnd', action: 'topicSelected', id: testInstance.topic.id
                        }
                    }

                } else {
                    log.error("CustomTasksFrontEndController():testSelected():Exception:paramsTest:notExist")

                    response.sendError(404)
                }
            } catch (IllegalArgumentException exception){ // Params.id is not valid UUID
                log.error("CustomTasksFrontEndController():testSelected():Exception:paramsTest:notUUID:${exception}")

                response.sendError(404)
            }
        } else {
            response.sendError(404)
        }
    }

    /**
     * It calculates the scores of the user when finishes the test.
     */
    @Transactional
    def calculateEvaluation() {
        log.debug("CustomTasksFrontEndController():calculateEvaluation()")

        Float totalScore = 0
        Float finalScore = 0
        def incorrectAnswers = 0
        def rightAnswers = 0
        def enter = false

        // It obtains the current user
        def currentUserEvaluation = User.get(springSecurityService.currentUser?.id)

        // It obtains the user evaluation
        def userEvaluation = Evaluation.findByUserNameAndTestName(currentUserEvaluation.username, params.testName)

        // It obtains the test
        def testInstance = Test.findByName(params.testName)

        if (testInstance.lockTime > 0) {

            use(TimeCategory) {

                enter = new Date() <= (userEvaluation.initDate + testInstance.lockTime.minutes) + 10.seconds
            }

        } else {
            enter = true
        }

        if (enter) {

            // It iterates through all parameters
            params.eachWithIndex { param, it ->

                // Only the parameters referring to answers
                if (params."question${it}") {

                    // Not null
                    if (params."question${it}" != null) {

                        try {

                            UUID uuidAnswer = UUID.fromString(params."question${it}");

                            def answerInstance = Answer.findById(uuidAnswer)

                            // It exists
                            if (answerInstance != null) {

                                if (answerInstance.score == 0) {
                                    incorrectAnswers ++
                                } else {
                                    rightAnswers ++
                                    totalScore += answerInstance.score
                                }
                            }

                        } catch (Exception exception) {
                            log.error("CustomTasksFrontEndController():calculateEvaluation():Exception:radioButton:valueFieldModified:user:${currentUserEvaluation.username}:${exception}")
                        }
                    }
                }
            }

            // Test without questions or any question is correct
            if (userEvaluation.maxPossibleScore > 0) {

                if (userEvaluation.testScore == null && userEvaluation.attemptNumber == 1) {

                    // It calculates the final score in the first attempt
                    finalScore = (totalScore * 10) / userEvaluation.maxPossibleScore

                } else { // Penalty for each additional attempt

                    // It calculates the final score in the x attempt
                    finalScore = (totalScore * 10) / userEvaluation.maxPossibleScore

                    // It calculate the average score
                    if (userEvaluation.testScore != null) {
                        finalScore = (finalScore + userEvaluation?.testScore) / 2
                    } else {
                        finalScore = finalScore / 2
                    }

                    // It calculates the final score with penalty (Default value: 10%)
                    def penalty = (finalScore * testInstance.penalty) / 100

                    finalScore = finalScore - penalty
                }

                // Test with incorrect answers penalized
                if (testInstance.incorrectDiscount && testInstance.numberOfQuestions > 0) {

                    // Average score of all question
                    def averageScore = userEvaluation.maxPossibleScore / testInstance.numberOfQuestions
                    def penaltyAnswers = (incorrectAnswers * averageScore) / 3

                    finalScore = finalScore - penaltyAnswers
                }

            } else {
                log.error("CustomTasksFrontEndController():calculateEvaluation():Error:Evaluation:maxPossibleScore:0:${currentUserEvaluation.username}-${params.testName}")
            }

            userEvaluation.completenessDate = new Date()

            // Avoid errors with negative scores
            if (finalScore < 0) {
                userEvaluation.testScore = 0
            } else {
                userEvaluation.testScore = finalScore
            }

            userEvaluation.rightQuestions = rightAnswers
            userEvaluation.failedQuestions = incorrectAnswers

            // Avoid error - Rejected value < 0
            if ((testInstance.numberOfQuestions - (rightAnswers + incorrectAnswers)) < 0 ) {
                userEvaluation.questionsUnanswered = 0
            } else{
                userEvaluation.questionsUnanswered = testInstance.numberOfQuestions - (rightAnswers + incorrectAnswers)
            }

            userEvaluation.maxPossibleScore = null

            def validUserEvaluation = userEvaluation.validate()

            if (validUserEvaluation) {

                try {
                    userEvaluation.save(flush: true, failOnError: true)

                    flash.testName = g.message(code: "layouts.main_auth_user.body.title.testFinished", default: '<span class="text-lowercase">{0}</span> test finished', args: [params.testName])
                    flash.scoreDescription = g.message(code: "layouts.main_auth_user.body.testFinished.description", default: 'His final score after completing the <span class="bold">{0}</span> test in your attempt number <span class="sbold">{1}</span> on a maximum score of 10 points is:', args: [params.testName, userEvaluation.attemptNumber])

                    // Avoid errors with negative scores
                    if (finalScore < 0) {
                        flash.finalScore = 0
                    } else {
                        flash.finalScore = finalScore.round(2)
                    }

                    flash.rightQuestions = rightAnswers
                    flash.failedQuestions = incorrectAnswers

                    if ((testInstance.numberOfQuestions - (rightAnswers + incorrectAnswers)) < 0 ) {
                        flash.questionsUnanswered = 0
                    } else{
                        flash.questionsUnanswered = testInstance.numberOfQuestions - (rightAnswers + incorrectAnswers)
                    }

                    flash.homepage = g.message(code: "layouts.main_auth_user.body.testFinished.button.homepage", default: 'Homepage')

                    // User has more attemtps
                    if (userEvaluation.attemptNumber < userEvaluation.maxAttempt) {
                        flash.tryAgain = g.message(code: "layouts.main_auth_user.body.testFinished.button.tryAgain", default: 'Try again')
                        flash.testID = testInstance.id
                    }

                    redirect uri: '/scoreObtained'

                } catch (Exception exception) {
                    log.error("CustomTasksFrontEndController():calculateEvaluation():Exception:calculatingScoring:${currentUserEvaluation.username}-${params.testName}:${exception}")

                    // Roll back in database
                    transactionStatus.setRollbackOnly()
                    response.sendError(404)
                }

            } else {
                log.error("CustomTasksFrontEndController():calculateEvaluation():Exception:notValid:calculatingScoring:user:${currentUserEvaluation.username}:errors:${userEvaluation.errors}")

                response.sendError(404)
            }
        } else {
            log.error("CustomTasksFrontEndController():calculateEvaluation():Error:MAximumTimeModifiedByUser:user:${currentUserEvaluation.username}:test:${testInstance.name}")

            flash.errorTestSelected =  g.message(code: "layouts.main_auth_user.body.topicSelected.error.testDone.time", default: 'The maximum time allowed for the test <strong>{0}</strong> has been intentionally modified by the user. The score has not been stored. Please, if you believe that it is a problem contact us.', args: ["${testInstance.name}"])
            redirect controller: 'customTasksFrontEnd', action: 'topicSelected', id: testInstance.topic.id
        }
    }

    /**
     * It shows the final score to the user.
     */
    def scoreObtained() {
        log.debug("CustomTasksFrontEndController():scoreObtained()")

        render view: 'scoreObtained'
    }

    /**
     * It shows the profile of the current user.
     */
    def profile() {
        log.debug("CustomTasksFrontEndController():profile()")

        def userStatsList

        // ID of current user
        def currentUser = User.get(springSecurityService.currentUser?.id)

        userStatsList = testStats(currentUser)

        render view: 'profile', model: [infoCurrentUser: currentUser, currentUser: currentUser, completedTest: userStatsList[1], numberActiveTest: userStatsList[0], numberApprovedTest: userStatsList[3], numberUnapprovedTest: userStatsList[2]]
    }

    /**
     * It obtains the test statistics.
     */
    def private testStats(currentUser) {

        def statsList = []

        // Evaluations of the user
        def completedTest = Evaluation.findAllByUserName(currentUser.username).size()

        // Obtaining number of accessible test in system by user
        def numberActiveTest = Test.createCriteria().list() {
            createAlias('allowedUsers', 'u',)
            eq 'u.id', currentUser.id
            eq 'active', true
        }

        // Obtaining test approved and unapproved - Asynchronous/Multi-thread
        def suspensePromise = Evaluation.async.findAllByUserNameAndTestScoreLessThan(currentUser.username, 5)
        def approvedPromise = Evaluation.async.findAllByUserNameAndTestScoreGreaterThanEquals(currentUser.username, 5)

        // Wait all promises
        def results = waitAll(suspensePromise, approvedPromise)

        def numberUnapprovedTest = results[0].size()
        def numberApprovedTest = results[1].size()

        statsList.push(numberActiveTest.size())
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
        User currentUserInstance = User.get(springSecurityService.currentUser?.id)
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
                infoCurrentUser = User.get(springSecurityService.currentUser?.id)
                // Avoid lazy load - without session; stats section (department)
                User.get(springSecurityService.currentUser.id).department
            }

            // Avoid lazy load - without session; list of department in _personalData (when user chooses several departments)
            currentUserInstance.department = User.get(springSecurityService.currentUser?.id).department

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
        log.debug("CustomTasksFrontEndController():updateProfile:notFound():CurrentUser:${springSecurityService.currentUser?.username}")

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
        def currentUser = User.get(springSecurityService.currentUser?.id)

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
        User currentUserInstance = User.get(springSecurityService.currentUser?.id)

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
     * It renders the not found message if the user instance was not found.?
     */
    protected void notFoundAvatar() {
        log.debug("CustomTasksFrontEndController():updateProfile:notFoundAvatar():CurrentUser:${springSecurityService.currentUser?.username}")

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
        def currentUser = User.get(springSecurityService.currentUser?.id)

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
        User currentUserInstance = User.get(springSecurityService.currentUser?.id)

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
        log.debug("CustomTasksFrontEndController():updateProfile:notFoundPassword():CurrentUser:${springSecurityService.currentUser?.username}")

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
        def currentUser = User.get(springSecurityService.currentUser?.id)
        def evaluations = Evaluation.findAllByUserName(currentUser.username)

        render view: 'scores', model: [evaluations: evaluations]
    }
}