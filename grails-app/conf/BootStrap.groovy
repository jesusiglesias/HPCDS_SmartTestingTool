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
                    password: '7g4sOmmm',
                    email: 'admin_switch@stt.com',
                    name:   'Usuario',
                    surname: 'Conmutar',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('19-10-1991'),
                    sex: Sex.FEMALE,
                    department: idDepartment
            )

            def newUser = User.findByUsername('user_stt') ?: new User( // Normal user
                    username: 'user_stt',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt.com',
                    name: 'Usuario STT',
                    surname: 'Apellido STT',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('22-04-1994'),
                    sex: Sex.MALE,
                    department: idDepartment
            )

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

            /*-------------------------------------------------------------------------------------------*
             *                                          CATALOG                                          *
             *-------------------------------------------------------------------------------------------*/

            def englishCatalog = Catalog.findByName('Catálogo inglés') ?: new Catalog(
                    name: 'Catálogo inglés',
                    questions: []
            )

            def securityCatalog = Catalog.findByName('Catálogo seguridad') ?: new Catalog(
                    name: 'Catálogo seguridad',
                    questions: [se1Question, se2Question, se3Question]
            )

            /*-------------------------------------------------------------------------------------------*
             *                                          TOPIC                                            *
             *-------------------------------------------------------------------------------------------*/

            def languageTopic = Topic.findByName('Idiomas') ?: new Topic(
                    name: 'Idiomas',
                    description: 'Comprende test relacionados con competencias de idiomas.',
                    visibility: false
            )

            def securityTopic = Topic.findByName('Seguridad') ?: new Topic(
                    name: 'Seguridad',
                    description: 'Comprende todos aquellos test relacionados con la evaluación de las capacidades y conocimientos en seguridad del desarrollo de aplicaciones web.',
                    visibility: true
            )

            /*-------------------------------------------------------------------------------------------*
             *                                       EVALUATION                                          *
             *-------------------------------------------------------------------------------------------*/

            def evalUserSTT1 = new Evaluation(
                    testName: 'Seguridad I',
                    attemptNumber: 1,
                    maxAttempt: 2,
                    completenessDate: new SimpleDateFormat( 'dd-MM-yyyy HH:mm:ss' ).parse('03-05-2016 14:56:12'),
                    testScore: 7.55,
                    user: newUser,
            )

            def evalUserSwitchSTT1 = new Evaluation(
                    testName: 'Seguridad I',
                    attemptNumber: 1,
                    maxAttempt: 2,
                    completenessDate: new SimpleDateFormat( 'dd-MM-yyyy HH:mm:ss' ).parse('14-04-2016 20:18:45'),
                    testScore: 7.23,
                    user: newUserSwitch,
            )

            /*-------------------------------------------------------------------------------------------*
             *                                           TEST                                            *
             *-------------------------------------------------------------------------------------------*/
            def securityITest = Test.findByName('Seguridad I') ?: new Test(
                    name: 'Seguridad I',
                    description: 'Test de un solo intento correspondiente a la evaluación de los conceptos de seguridad. Está comprendido de x preguntas...',
                    active: true,
                    numberOfQuestions: 3,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 1,
                    lockTime: 0,
                    maxAttempts: 1,
                    evaluationsTest: [evalUserSTT1, evalUserSwitchSTT1],
                    topic: securityTopic,
                    catalog: securityCatalog,
            )

            def englishTest = Test.findByName('Inglés básico') ?: new Test(
                    name: 'Inglés básico',
                    description: 'Test de inglés básico...',
                    active: false,
                    numberOfQuestions: 0,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 5,
                    lockTime: 0,
                    maxAttempts: 1,
                    topic: languageTopic,
                    catalog: englishCatalog
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
            // Validation of answer
            def validR1_se1 = re1_1Answer.validate()
            def validR2_se1 = re2_1Answer.validate()
            def validR3_se1 = re3_1Answer.validate()
            def validR1_se2 = re1_2Answer.validate()
            // Validation of question
            def validSe1 = se1Question.validate()
            def validSe2 = se2Question.validate()
            def validSe3 = se3Question.validate()
            // Validation of catalog
            def validEnglishCatalog = englishCatalog.validate()
            def validSecurityCatalog = securityCatalog.validate()
            // Validation of topic
            def validLanguageTopic = languageTopic.validate()
            def validSecurityTopic = securityTopic.validate()
            // Validation of test
            def validSecurityITest = securityITest.validate()
            def validEnglishTest = englishTest.validate()
            // Validation of evaluation
            def validEvalUserSTT1 = evalUserSTT1.validate()
            def validEvalUserSwitchSTT1 = evalUserSwitchSTT1.validate()

            if (validAdmin & validAnother & validID & validRRHH & validSecurity & validSupport & validUserSwitch & validUser
                    & validR1_se1 & validR2_se1 & validR3_se1 & validR1_se2 & validSe1 & validSe2 & validSe3 & validEnglishCatalog
                    & validSecurityCatalog & validLanguageTopic & validSecurityTopic & validEvalUserSTT1 & validEvalUserSwitchSTT1 &
                    validSecurityITest & validEnglishTest) {

                // Saving roles
                adminRole.save(flush: true, failOnError: true)
                userRole.save(flush: true, failOnError: true)

                // Saving new admin
                newAdmin.save(flush: true, failOnError: true)

                // Saving departments
                idDepartment.save(flush: true, failOnError: true)
                securityDepartment.save(flush: true, failOnError: true)
                anotherDepartment.save(flush: true, failOnError: true)
                rrhhDepartment.save(flush: true, failOnError: true)
                supportDepartment.save(flush: true, failOnError: true)

                // Saving new users
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

                // Saving answers
                re1_1Answer.save(flush: true, failOnError: true)
                re2_1Answer.save(flush: true, failOnError: true)
                re3_1Answer.save(flush: true, failOnError: true)
                re1_2Answer.save(flush: true, failOnError: true)

                // Saving questions
                se1Question.save(flush: true, failOnError: true)
                se2Question.save(flush: true, failOnError: true)
                se3Question.save(flush: true, failOnError: true)

                // Saving catalogs
                englishCatalog.save(flush: true, failOnError: true)
                securityCatalog.save(flush: true, failOnError: true)

                // Saving topics
                languageTopic.save(flush: true, failOnError: true)
                securityTopic.save(flush: true, failOnError: true)

                // Saving evaluations
                evalUserSTT1.save(flush: true, failOnError: true)
                evalUserSwitchSTT1.save(flush: true, failOnError: true)

                // Saving test
                securityITest.save(flush: true, failOnError: true)
                englishTest.save(flush: true, failOnError: true)

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
                    password: '7g4sOmmm',
                    email: 'admin_switch@stt.com',
                    name:   'Usuario',
                    surname: 'Conmutar',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('19-10-1991'),
                    sex: Sex.FEMALE,
                    department: idDepartment
            )

            def newUser = User.findByUsername('user_stt') ?: new User( // Normal user
                    username: 'user_stt',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt.com',
                    name: 'Usuario STT',
                    surname: 'Apellido STT',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('22-04-1994'),
                    sex: Sex.MALE,
                    department: idDepartment
            )

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

            /*-------------------------------------------------------------------------------------------*
             *                                          CATALOG                                          *
             *-------------------------------------------------------------------------------------------*/

            def englishCatalog = Catalog.findByName('Catálogo inglés') ?: new Catalog(
                    name: 'Catálogo inglés',
                    questions: []
            )

            def securityCatalog = Catalog.findByName('Catálogo seguridad') ?: new Catalog(
                    name: 'Catálogo seguridad',
                    questions: [se1Question, se2Question, se3Question]
            )

            /*-------------------------------------------------------------------------------------------*
             *                                          TOPIC                                            *
             *-------------------------------------------------------------------------------------------*/

            def languageTopic = Topic.findByName('Idiomas') ?: new Topic(
                    name: 'Idiomas',
                    description: 'Comprende test relacionados con competencias de idiomas.',
                    visibility: false
            )

            def securityTopic = Topic.findByName('Seguridad') ?: new Topic(
                    name: 'Seguridad',
                    description: 'Comprende todos aquellos test relacionados con la evaluación de las capacidades y conocimientos en seguridad del desarrollo de aplicaciones web.',
                    visibility: true
            )

            /*-------------------------------------------------------------------------------------------*
             *                                       EVALUATION                                          *
             *-------------------------------------------------------------------------------------------*/

            /*def evalUserSTT1 = new Evaluation(
                    testName: 'Seguridad I',
                    attemptNumber: 1,
                    maxAttempt: 2,
                    completenessDate: new SimpleDateFormat( 'dd-MM-yyyy HH:mm:ss' ).parse('03-05-2016 14:56:12'),
                    testScore: 7.55,
                    user: newUser,
            )

            def evalUserSwitchSTT1 = new Evaluation(
                    testName: 'Seguridad I',
                    attemptNumber: 1,
                    maxAttempt: 2,
                    completenessDate: new SimpleDateFormat( 'dd-MM-yyyy HH:mm:ss' ).parse('14-04-2016 20:18:45'),
                    testScore: 7.23,
                    user: newUserSwitch,
            )*/

            /*-------------------------------------------------------------------------------------------*
             *                                           TEST                                            *
             *-------------------------------------------------------------------------------------------*/
            def securityITest = Test.findByName('Seguridad I') ?: new Test(
                    name: 'Seguridad I',
                    description: 'Test de un solo intento correspondiente a la evaluación de los conceptos de seguridad. Está comprendido de x preguntas...',
                    active: true,
                    numberOfQuestions: 3,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 1,
                    lockTime: 0,
                    maxAttempts: 1,
                    //evaluationsTest: [evalUserSTT1, evalUserSwitchSTT1],
                    topic: securityTopic,
                    catalog: securityCatalog,
            )

            def englishTest = Test.findByName('Inglés básico') ?: new Test(
                    name: 'Inglés básico',
                    description: 'Test de inglés básico...',
                    active: false,
                    numberOfQuestions: 0,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 5,
                    lockTime: 0,
                    maxAttempts: 1,
                    topic: languageTopic,
                    catalog: englishCatalog
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
            // Validation of answer
            def validR1_se1 = re1_1Answer.validate()
            def validR2_se1 = re2_1Answer.validate()
            def validR3_se1 = re3_1Answer.validate()
            def validR1_se2 = re1_2Answer.validate()
            // Validation of question
            def validSe1 = se1Question.validate()
            def validSe2 = se2Question.validate()
            def validSe3 = se3Question.validate()
            // Validation of catalog
            def validEnglishCatalog = englishCatalog.validate()
            def validSecurityCatalog = securityCatalog.validate()
            // Validation of topic
            def validLanguageTopic = languageTopic.validate()
            def validSecurityTopic = securityTopic.validate()
            // Validation of test
            def validSecurityITest = securityITest.validate()
            def validEnglishTest = englishTest.validate()
            // Validation of evaluation
            //def validEvalUserSTT1 = evalUserSTT1.validate()
            //def validEvalUserSwitchSTT1 = evalUserSwitchSTT1.validate()

            if (validAdmin & validAnother & validID & validRRHH & validSecurity & validSupport & validUserSwitch & validUser
                    & validR1_se1 & validR2_se1 & validR3_se1 & validR1_se2 & validSe1 & validSe2 & validSe3 & validEnglishCatalog
                    & validSecurityCatalog & validLanguageTopic & validSecurityTopic & /*validEvalUserSTT1 & validEvalUserSwitchSTT1 &*/
                    validSecurityITest & validEnglishTest) {

                // Saving roles
                adminRole.save(flush: true, failOnError: true)
                userRole.save(flush: true, failOnError: true)

                // Saving new admin
                newAdmin.save(flush: true, failOnError: true)

                // Saving departments
                idDepartment.save(flush: true, failOnError: true)
                securityDepartment.save(flush: true, failOnError: true)
                anotherDepartment.save(flush: true, failOnError: true)
                rrhhDepartment.save(flush: true, failOnError: true)
                supportDepartment.save(flush: true, failOnError: true)

                // Saving new users
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

                // Saving answers
                re1_1Answer.save(flush: true, failOnError: true)
                re2_1Answer.save(flush: true, failOnError: true)
                re3_1Answer.save(flush: true, failOnError: true)
                re1_2Answer.save(flush: true, failOnError: true)

                // Saving questions
                se1Question.save(flush: true, failOnError: true)
                se2Question.save(flush: true, failOnError: true)
                se3Question.save(flush: true, failOnError: true)

                // Saving catalogs
                englishCatalog.save(flush: true, failOnError: true)
                securityCatalog.save(flush: true, failOnError: true)

                // Saving topics
                languageTopic.save(flush: true, failOnError: true)
                securityTopic.save(flush: true, failOnError: true)

                // Saving evaluations
                //evalUserSTT1.save(flush: true, failOnError: true)
                //evalUserSwitchSTT1.save(flush: true, failOnError: true)

                // Saving test
                securityITest.save(flush: true, failOnError: true)
                englishTest.save(flush: true, failOnError: true)

            } else {
                log.error("BootStrap:init():Admin users have not been created. You verify that the initial data complies with the rules")
            }

        } else {
            log.error("BooStrap:init():Existing admin or role data. Initial data were not created")

        }
    }
}