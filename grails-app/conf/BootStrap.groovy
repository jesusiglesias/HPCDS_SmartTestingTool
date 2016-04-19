/*-------------------------------------------------------------------------------------------*
 *                                         BOOTSTRAP                                         *
 *-------------------------------------------------------------------------------------------*/

import Enumerations.DifficultyLevel
import Enumerations.Sex
import Security.*
import Test.*
import User.*
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.SecurityFilterPosition
import grails.util.Environment
import java.text.SimpleDateFormat

/**
 * Configuration during application startup and destruction.
 */
class BootStrap {

    def authenticationProcessingFilter
    def concurrentSessionControlStrategy
    def springSecurityService

    /**
     * Initial operations when application start.
     */
    def init = { servletContext ->

        // It establishes the sessionAuthenticationStrategy, hence, it is enforced at authentication time various rules about concurrent sessions
        // The filter calls the SessionRegistry for the given session id. If there is a session information and it is marked as expired, it forces a redirect to the provided 'expiredUrl'
        SpringSecurityUtils.clientRegisterFilter('concurrencyFilter', SecurityFilterPosition.CONCURRENT_SESSION_FILTER)
        authenticationProcessingFilter.sessionAuthenticationStrategy = concurrentSessionControlStrategy

        // Database populating depending on the environment
        switch (Environment.current) {
            case Environment.DEVELOPMENT:
                createInitialUsersDevTest()
                break;
            case Environment.TEST:
                createInitialUsersDevTest()
                break;
            case Environment.PRODUCTION:
                createInitialUsersProd()
                break;
        }
    }

    /**
     * Final operations when application finishes.
     */
    def destroy = {
    }

    /**
     * Populating the database in development or test environments.
     */
    void createInitialUsersDevTest() {
        log.debug("BootStrap:init():createInitialDataDevTest")

        // It checks data existence
        if (!SecUser.count() && !SecRole.count()) {

            /*-------------------------------------------------------------------------------------------*
             *                                        ADMIN AND ROLE                                         *
             *-------------------------------------------------------------------------------------------*/

            // Role
            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN')
            def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER')

            // Administrator
            def newAdmin = SecUser.findByUsername('admin_stt') ?: new SecUser( // Admin
                    username: 'admin_stt',
                    password: '7g4sOmmm',
                    email: 'info.smartestingtool@gmail.com')

            /*-------------------------------------------------------------------------------------------*
             *                                        DEPARTMENT                                         *
             *-------------------------------------------------------------------------------------------*/

            def anotherDepartment = Department.findByName('Otro') ?: new Department(
                    name: 'Otro'
            )

            def idDepartment = Department.findByName('Investigación + Desarrollo') ?: new Department(
                    name: 'Investigación + Desarrollo'
            )

            def rrhhDepartment = Department.findByName('Recursos humanos') ?: new Department(
                    name: 'Recursos humanos'
            )

            def securityDepartment = Department.findByName('Seguridad') ?: new Department(
                    name: 'Seguridad'
            )

            def supportDepartment = Department.findByName('Soporte técnico') ?: new Department(
                    name: 'Soporte técnico'
            )

            /*-------------------------------------------------------------------------------------------*
             *                                          USER                                             *
             *-------------------------------------------------------------------------------------------*/

            def newUserSwitch = User.findByUsername('admin_switch') ?: new User( // Normal user to switch
                    username: 'admin_switch',
                    password: springSecurityService.encodePassword('7g4sOmmm'),
                    email: 'admin_switch@stt.com',
                    name:   'Usuario',
                    surname: 'Conmutar',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('19-10-1991'),
                    sex: Sex.MALE,
                    department: idDepartment
            )

            def newUser = User.findByUsername('user_stt') ?: new User( // Normal user
                    username: 'user_stt',
                    password: springSecurityService.encodePassword('7g4sOmmm'),
                    email: 'user_stt@stt.com',
                    name: 'Usuario STT',
                    surname: 'Apellido STT',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('22-04-1994'),
                    sex: Sex.MALE,
                    department: idDepartment
            )

            /*-------------------------------------------------------------------------------------------*
             *                                          CATALOG                                          *
             *-------------------------------------------------------------------------------------------*/

            def iDcatalog = Catalog.findByName('Catálogo I+D') ?: new Catalog(
                    name: 'Catálogo I+D'
            )

            def securityCatalog = Catalog.findByName('Seguridad inicial') ?: new Catalog(
                    name: 'Seguridad inicial'
            )

            /*-------------------------------------------------------------------------------------------*
             *                                          TOPIC                                            *
             *-------------------------------------------------------------------------------------------*/

            def englishTopic = Topic.findByName('Inglés') ?: new Topic(
                    name: 'Inglés',
                    description: 'Descripción 1'
            )

            def arquitecturaComputadoresTopic = Topic.findByName('Arquitectura de computadores') ?: new Topic(
                    name: 'Arquitectura de computadores',
                    description: 'Descripción 2'
            )

            /*-------------------------------------------------------------------------------------------*
             *                                          TEST                                             *
             *-------------------------------------------------------------------------------------------*/

        /*    def englishTest = Test.findByName('Test de inglés') ?: new Test(
                    name: 'Test de inglés',
                    description: 'Descripción del test de inglés....',
                    initDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('19-05-2016'),
                    endDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('19-06-2016'),
                    lockTime: 0,
                    maxAttempts: 1,
                    numberOfQuestions: 0,
            ) */

            /*-------------------------------------------------------------------------------------------*
             *                                       EVALUATION                                          *
             *-------------------------------------------------------------------------------------------*/

         /*   def evalUserSTT1 = Evaluation.findByUsernameEvalAndTestName('user_stt', 'Test de inglés') ?: new Evaluation(
                    usernameEval: 'user_stt',
                    testName: 'Test de inglés',
                    attemptNumber: 1,
                    testScore: 8,
            )*/

            /*-------------------------------------------------------------------------------------------*
             *                                         ANSWER                                            *
             *-------------------------------------------------------------------------------------------*/

            def re1_1Answer = Answer.findByTitleAnswerKey('RE1-1') ?: new Answer(
                    titleAnswerKey: 'RE1-1',
                    description: 'Degradar el servicio mediante etiquetas iframe.',
                    correct: true,
                    score: 1
            )

            def re2_1Answer = Answer.findByTitleAnswerKey('RE2-1') ?: new Answer(
                    titleAnswerKey: 'RE2-1',
                    description: 'Bloquear el sistema del usuario.',
                    correct: false,
                    score: 0
            )

            def re3_1Answer = Answer.findByTitleAnswerKey('RE3-1') ?: new Answer(
                    titleAnswerKey: 'RE3-1',
                    description: 'Obtener información del usuario',
                    correct: false,
                    score: 0
            )

            def re1_2Answer = Answer.findByTitleAnswerKey('RE1-2') ?: new Answer(
                    titleAnswerKey: 'RE1-2',
                    description: 'Heartbleed',
                    correct: true,
                    score: 2
            )

            /*-------------------------------------------------------------------------------------------*
             *                                        QUESTION                                           *
             *-------------------------------------------------------------------------------------------*/

            def se1Question = Question.findByTitleQuestionKey('SE-1') ?: new Question(
                    titleQuestionKey: 'SE-1',
                    description: '¿Cuál es la finalidad del ataque -Clickjacking-?',
                    difficultyLevel: DifficultyLevel.MEDIUM,
                    answers: [re1_1Answer, re2_1Answer, re3_1Answer]
            )

            def se2Question = Question.findByTitleQuestionKey('SE-2') ?: new Question(
                    titleQuestionKey: 'SE-2',
                    description: '¿Cuál es la vulnerabilidad más peligrosa del protocolo TLS?',
                    difficultyLevel: DifficultyLevel.DIFFICULT,
                    answers: [re1_2Answer]
            )

            def se3Question = Question.findByTitleQuestionKey('SE-3') ?: new Question(
                    titleQuestionKey: 'SE-3',
                    description: '¿Qué es un ataque de fuerza bruta?',
                    difficultyLevel: DifficultyLevel.EASY,
            )

            // Validation of admin
            def validAdmin = newAdmin.validate()
            // Validation of department
            def validAnother = anotherDepartment.validate()
            def validID = idDepartment.validate()
            def validRRHH = rrhhDepartment.validate()
            def validSecurity = securityDepartment.validate()
            def validSupport = supportDepartment.validate()
            // Validation of user
            def validUserSwitch = newUserSwitch.validate()
            def validUser = newUser.validate()
            // Validation of catalog
            // Validation of topic
            // Validation of test
            //def validEnglishTest = englishTest.validate()
            // Validation of evaluation
            //def validEvalUserSTT1 = evalUserSTT1.validate()
            // Validation of answer
            def validR1_se1 = re1_1Answer.validate()
            def validR2_se1 = re2_1Answer.validate()
            def validR3_se1 = re3_1Answer.validate()
            def validR1_se2 = re1_2Answer.validate()
            // Validation of question
            def validSe1 = se1Question.validate()
            def validSe2 = se2Question.validate()
            def validSe3 = se3Question.validate()

            if (validAdmin & validUserSwitch & validUser & validAnother & validID & validRRHH & validSecurity & validSupport
                    & validSe1 & validSe2 & validSe3 & validR1_se1 & validR2_se1 & validR3_se1 & validR1_se2) {

                // Saving roles
                adminRole.save(flush: true, failOnError: true)
                userRole.save(flush: true, failOnError: true)

                // Saving departments
                idDepartment.save(flush: true, failOnError: true)
                securityDepartment.save(flush: true, failOnError: true)
                anotherDepartment.save(flush: true, failOnError: true)
                rrhhDepartment.save(flush: true, failOnError: true)
                supportDepartment.save(flush: true, failOnError: true)

                // Saving new users
                newAdmin.save(flush: true, failOnError: true)
                newUserSwitch.save(flush: true, failOnError: true)
                newUser.save(flush: true, failOnError: true)

                // Assign user to role
                if (!newAdmin.authorities.contains(adminRole)) { // Admin
                    SecUserSecRole.create newAdmin, adminRole, true
                }
                if (!newUserSwitch.authorities.contains(userRole)) { // Normal user to switch
                    SecUserSecRole.create newUserSwitch, userRole, true
                }
                if (!newUser.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUser, userRole, true
                }

                // Saving catalogs
                iDcatalog.save(flush: true, failOnError: true)
                securityCatalog.save(flush: true, failOnError: true)

                // Saving topics
                arquitecturaComputadoresTopic.save(flush: true, failOnError: true)
                englishTopic.save(flush: true, failOnError: true)

                // Saving answers
                re1_1Answer.save(flush: true, failOnError: true)
                re2_1Answer.save(flush: true, failOnError: true)
                re3_1Answer.save(flush: true, failOnError: true)
                re1_2Answer.save(flush: true, failOnError: true)

                // Saving questions
                se1Question.save(flush: true, failOnError: true)
                se2Question.save(flush: true, failOnError: true)
                se3Question.save(flush: true, failOnError: true)

                // Saving test
              //  englishTest.save(flush: true, failOnError: true)

                // Saving evaluations
              //  evalUserSTT1.save(flush: true, failOnError: true)




                log.debug("BootStrap:init():Initial data have been created")
                log.info("Special config create for development or test - Users: admin_stt/7g4sOmmm (Admin), admin_switch/7g4sOmmm (User) and user_stt/7g4sOmmm (User)")
            } else {
                log.error("BootStrap:init():Initial data have not been created. You verify that the initial data complies with the rules")
            }
        } else {
            log.warn("BooStrap:init():Initial data existing")
        }
    }

    /**
     * Populating the database in production environment.
     */
    void createInitialUsersProd() {

        // It checks data existence
        if (!SecUser.count() && !SecRole.count()) {

            // Creating roles
            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN')
            def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER')

            // Creating new users
            def newAdmin = SecUser.findByUsername('admin_stt') ?: new SecUser( // Admin
                    username: 'admin_stt',
                    password: '7g4sOmmm',
                    email: 'info.smartestingtool@gmail.com')

            def newAdminUser = SecUser.findByUsername('admin_switch') ?: new SecUser( // Normal user to switch
                    username: 'admin_switch',
                    password: '7g4sOmmm',
                    email: 'admin_switch_prod@stt.com')

            //----------TEST TODO
            def newUser = SecUser.findByUsername('user_stt') ?: new SecUser( // Normal user
                    username: 'user_stt',
                    password: '7g4sOmmm',
                    email: 'user_stt_prod@stt.com')

            // Validation of new user
            def validAdmin = newAdmin.validate()
            def validAdminUser = newAdminUser.validate()
            // TODO
            def validUser = newUser.validate()
            // TODO
            if (validAdmin & validAdminUser & validUser) {
                // Saving roles
                adminRole.save(flush: true, failOnError: true)
                userRole.save(flush: true, failOnError: true)

                // Saving new users
                newAdmin.save(flush: true, failOnError: true)
                newAdminUser.save(flush: true, failOnError: true)

                //----------TEST TODO
                newUser.save(flush: true, failOnError: true)

                // Assign user to role
                if (!newAdmin.authorities.contains(adminRole)) { // Admin
                    SecUserSecRole.create newAdmin, adminRole, true
                }
                if (!newAdminUser.authorities.contains(userRole)) { // Normal user to switch
                    SecUserSecRole.create newAdminUser, userRole, true
                }

                //----------TEST TODO
                if (!newUser.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUser, userRole, true
                }

            } else {
                log.error("BootStrap:init():Admin users have not been created. You verify that the initial data complies with the rules")

            }
        } else {
            log.error("BooStrap:init():Existing admin or role data. Initial data were not created")
        }
    }

}