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
             *                                        ADMIN AND ROLE                                     *
             *-------------------------------------------------------------------------------------------*/

            // Role
            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN')
            def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER')

            // Administrator
            def newAdmin = SecUser.findByUsername('jesus_admin') ?: new SecUser( // Admin
                    username: 'jesus_admin',
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
             *                                         ANSWER                                            *
             *-------------------------------------------------------------------------------------------*/

            def re1_1Answer = Answer.findByTitleAnswerKey('RE1-1') ?: new Answer(
                    titleAnswerKey: 'RE1-1',
                    description: 'Degradar el servicio mediante etiquetas iframe.',
                    correct: true,
                    score: 1
            )

            def re1_2Answer = Answer.findByTitleAnswerKey('RE1-2') ?: new Answer(
                    titleAnswerKey: 'RE1-2',
                    description: 'Bloquear el sistema del usuario.',
                    correct: false,
                    score: 0
            )

            def re1_3Answer = Answer.findByTitleAnswerKey('RE1-3') ?: new Answer(
                    titleAnswerKey: 'RE1-3',
                    description: 'Obtener información del usuario.',
                    correct: false,
                    score: 0
            )

            def re2_1Answer = Answer.findByTitleAnswerKey('RE2-1') ?: new Answer(
                    titleAnswerKey: 'RE2-1',
                    description: 'Heartbleed.',
                    correct: true,
                    score: 1
            )

            def re2_2Answer = Answer.findByTitleAnswerKey('RE2-2') ?: new Answer(
                    titleAnswerKey: 'RE2-2',
                    description: 'Ataque POODLE.',
                    correct: false,
                    score: 0
            )

            def re2_3Answer = Answer.findByTitleAnswerKey('RE2-3') ?: new Answer(
                    titleAnswerKey: 'RE2-3',
                    description: 'Logjam.',
                    correct: false,
                    score: 0
            )

            def re3_1Answer = Answer.findByTitleAnswerKey('RE3-1') ?: new Answer(
                    titleAnswerKey: 'RE3-1',
                    description: 'Un software para la protección de un equipo informático.',
                    correct: true,
                    score: 1
            )

            def re3_2Answer = Answer.findByTitleAnswerKey('RE3-2') ?: new Answer(
                    titleAnswerKey: 'RE3-2',
                    description: 'Un componente informático.',
                    correct: false,
                    score: 0
            )

            def re3_3Answer = Answer.findByTitleAnswerKey('RE3-3') ?: new Answer(
                    titleAnswerKey: 'RE3-3',
                    description: 'Un tipo de aplicación de ofimática.',
                    correct: false,
                    score: 0
            )

            def re4_1Answer = Answer.findByTitleAnswerKey('RE4-1') ?: new Answer(
                    titleAnswerKey: 'RE4-1',
                    description: 'Conjunto de acciones, herramientas y dispositivos cuyo objetivo es dotar a un sistema informatico de intergridad, confidencialidad y disponibilidad.',
                    correct: true,
                    score: 1
            )

            def re4_2Answer = Answer.findByTitleAnswerKey('RE4-2') ?: new Answer(
                    titleAnswerKey: 'RE4-2',
                    description: 'Conjunto de acciones para proteger a un sistema informático.',
                    correct: false,
                    score: 0
            )

            def re4_3Answer = Answer.findByTitleAnswerKey('RE4-3') ?: new Answer(
                    titleAnswerKey: 'RE4-3',
                    description: 'Conjunto de acciones referentes a la autenticación frente a un sistema informático.',
                    correct: false,
                    score: 0
            )

            def re5_1Answer = Answer.findByTitleAnswerKey('RE5-1') ?: new Answer(
                    titleAnswerKey: 'RE5-1',
                    description: 'Un tipo de software malicioso que se propaga infectando a otros ficheros.',
                    correct: true,
                    score: 1
            )

            def re5_2Answer = Answer.findByTitleAnswerKey('RE5-2') ?: new Answer(
                    titleAnswerKey: 'RE5-2',
                    description: 'Un tipo de software malicioso que parece un programa inofensivo pero que ocasiona daños cuando se ejecuta.',
                    correct: false,
                    score: 0
            )

            def re5_3Answer = Answer.findByTitleAnswerKey('RE5-3') ?: new Answer(
                    titleAnswerKey: 'RE5-3',
                    description: 'Un tipo de software malicioso que muestra a los usuarios publicidad de forma intrusiva.',
                    correct: false,
                    score: 0
            )

            def re6_1Answer = Answer.findByTitleAnswerKey('RE6-1') ?: new Answer(
                    titleAnswerKey: 'RE6-1',
                    description: 'Evitar la pérdida y modificación no autorizada de los datos personales.',
                    correct: true,
                    score: 1
            )

            def re6_2Answer = Answer.findByTitleAnswerKey('RE6-2') ?: new Answer(
                    titleAnswerKey: 'RE6-2',
                    description: 'Permitir a terceras personas acceder a los datos personales.',
                    correct: false,
                    score: 0
            )

            def re6_3Answer = Answer.findByTitleAnswerKey('RE6-3') ?: new Answer(
                    titleAnswerKey: 'RE6-3',
                    description: 'Mantener un registro de los datos personales de los usuarios.',
                    correct: false,
                    score: 0
            )

            def re7_1Answer = Answer.findByTitleAnswerKey('RE7-1') ?: new Answer(
                    titleAnswerKey: 'RE7-1',
                    description: 'Un hacker es la persona que posee conocimientos en seguridad informática para realizar acciones maliciosas mientras que un cracker utiliza sus conocimientos para realizar acciones beneficiosas.',
                    correct: false,
                    score: 0
            )

            def re7_2Answer = Answer.findByTitleAnswerKey('RE7-2') ?: new Answer(
                    titleAnswerKey: 'RE7-2',
                    description: 'Un hacker es la persona que posee conocimientos en seguridad informática para realizar acciones beneficiosas mientras que un cracker utiliza sus conocimientos para realizar acciones maliciosas.',
                    correct: true,
                    score: 1
            )

            def re7_3Answer = Answer.findByTitleAnswerKey('RE7-3') ?: new Answer(
                    titleAnswerKey: 'RE7-3',
                    description: 'Ambos conceptos definen el mismo tipo de persona.',
                    correct: false,
                    score: 0
            )

            def re8_1Answer = Answer.findByTitleAnswerKey('RE8-1') ?: new Answer(
                    titleAnswerKey: 'RE8-1',
                    description: 'Instalar software de fuentes conocidas.',
                    correct: false,
                    score: 0
            )

            def re8_2Answer = Answer.findByTitleAnswerKey('RE8-2') ?: new Answer(
                    titleAnswerKey: 'RE8-2',
                    description: 'Mecanismo de autenticación.',
                    correct: true,
                    score: 1
            )

            def re8_3Answer = Answer.findByTitleAnswerKey('RE8-3') ?: new Answer(
                    titleAnswerKey: 'RE8-3',
                    description: 'Navegar por sitios seguros.',
                    correct: false,
                    score: 0
            )

            def re9_1Answer = Answer.findByTitleAnswerKey('RE9-1') ?: new Answer(
                    titleAnswerKey: 'RE9-1',
                    description: 'Virus informático.',
                    correct: false,
                    score: 0
            )

            def re9_2Answer = Answer.findByTitleAnswerKey('RE9-2') ?: new Answer(
                    titleAnswerKey: 'RE9-2',
                    description: 'Adware.',
                    correct: true,
                    score: 1
            )

            def re9_3Answer = Answer.findByTitleAnswerKey('RE9-3') ?: new Answer(
                    titleAnswerKey: 'RE9-3',
                    description: 'Keylogger.',
                    correct: false,
                    score: 0
            )

            def re10_1Answer = Answer.findByTitleAnswerKey('RE10-1') ?: new Answer(
                    titleAnswerKey: 'RE10-1',
                    description: 'El sistema operativo no se actualiza periódicamente.',
                    correct: false,
                    score: 0
            )

            def re10_2Answer = Answer.findByTitleAnswerKey('RE10-2') ?: new Answer(
                    titleAnswerKey: 'RE10-2',
                    description: 'Todas las respuestas son correctas.',
                    correct: true,
                    score: 1
            )

            def re10_3Answer = Answer.findByTitleAnswerKey('RE10-3') ?: new Answer(
                    titleAnswerKey: 'RE10-3',
                    description: 'No se actualizan los programas que se instalan en él.',
                    correct: false,
                    score: 0
            )

            def re11_1Answer = Answer.findByTitleAnswerKey('RE11-1') ?: new Answer(
                    titleAnswerKey: 'RE11-1',
                    description: 'Un riesgo.',
                    correct: false,
                    score: 0
            )

            def re11_2Answer = Answer.findByTitleAnswerKey('RE11-2') ?: new Answer(
                    titleAnswerKey: 'RE11-2',
                    description: 'Una vulnerabilidad.',
                    correct: true,
                    score: 1
            )

            def re11_3Answer = Answer.findByTitleAnswerKey('RE11-3') ?: new Answer(
                    titleAnswerKey: 'RE11-3',
                    description: 'Una amenaza.',
                    correct: false,
                    score: 0
            )

            /*-------------------------------------------------------------------------------------------*
             *                                        QUESTION                                           *
             *-------------------------------------------------------------------------------------------*/

            def se1Question = Question.findByTitleQuestionKey('SE-1') ?: new Question(
                    titleQuestionKey: 'SE-1',
                    description: '¿Cuál es la finalidad del ataque clickjacking?',
                    difficultyLevel: DifficultyLevel.DIFFICULT,
                    answers: [re1_1Answer, re1_2Answer, re1_3Answer]
            )

            def se2Question = Question.findByTitleQuestionKey('SE-2') ?: new Question(
                    titleQuestionKey: 'SE-2',
                    description: '¿Cuál es la vulnerabilidad más peligrosa del protocolo TLS?',
                    difficultyLevel: DifficultyLevel.DIFFICULT,
                    answers: [re2_1Answer, re2_2Answer, re2_3Answer]
            )

            def se3Question = Question.findByTitleQuestionKey('SE-3') ?: new Question(
                    titleQuestionKey: 'SE-3',
                    description: '¿Qué es un antivirus?',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re3_1Answer, re3_2Answer, re3_3Answer]
            )

            def se4Question = Question.findByTitleQuestionKey('SE-4') ?: new Question(
                    titleQuestionKey: 'SE-4',
                    description: '¿Qué es la seguridad informática?',
                    difficultyLevel: DifficultyLevel.MEDIUM,
                    answers: [re4_1Answer, re4_2Answer, re4_3Answer]
            )

            def se5Question = Question.findByTitleQuestionKey('SE-5') ?: new Question(
                    titleQuestionKey: 'SE-5',
                    description: '¿Qué es un virus informático?',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re5_1Answer, re5_2Answer, re5_3Answer]
            )

            def se6Question = Question.findByTitleQuestionKey('SE-6') ?: new Question(
                    titleQuestionKey: 'SE-6',
                    description: '¿Cuál es el objetivo de la protección de datos?',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re6_1Answer, re6_2Answer, re6_3Answer]
            )

            def se7Question = Question.findByTitleQuestionKey('SE-7') ?: new Question(
                    titleQuestionKey: 'SE-7',
                    description: '¿Qué diferencia hay entre un hacker y un cracker?',
                    difficultyLevel: DifficultyLevel.MEDIUM,
                    answers: [re7_1Answer, re7_2Answer, re7_3Answer]
            )

            def se8Question = Question.findByTitleQuestionKey('SE-8') ?: new Question(
                    titleQuestionKey: 'SE-8',
                    description: '¿Cuál es uno de los aspectos principales de la seguridad?',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re8_1Answer, re8_2Answer, re8_3Answer]
            )

            def se9Question = Question.findByTitleQuestionKey('SE-9') ?: new Question(
                    titleQuestionKey: 'SE-9',
                    description: 'Si es un equipo aparece muchas ventanas de publicidad, ¿por qué variedad de software malicioso podemos deducir que se encuentra infectado?',
                    difficultyLevel: DifficultyLevel.MEDIUM,
                    answers: [re9_1Answer, re9_2Answer, re9_3Answer]
            )

            def se10Question = Question.findByTitleQuestionKey('SE-10') ?: new Question(
                    titleQuestionKey: 'SE-10',
                    description: 'Un equipo informático será más vulnerable si...',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re10_1Answer, re10_2Answer, re10_3Answer]
            )

            def se11Question = Question.findByTitleQuestionKey('SE-11') ?: new Question(
                    titleQuestionKey: 'SE-11',
                    description: 'El uso de contraseñas débiles se considera...',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re11_1Answer, re11_2Answer, re11_3Answer]
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
                    questions: [se1Question, se2Question, se3Question, se4Question, se5Question, se6Question, se7Question, se8Question, se9Question, se10Question, se11Question]
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
                    description: 'Comprende todos aquellos test relacionados con la evaluación de las capacidades y conocimientos en seguridad informática.',
                    visibility: true
            )

            /*-------------------------------------------------------------------------------------------*
            *                                           TEST                                            *
            *-------------------------------------------------------------------------------------------*/
            def securityTest = Test.findByName('Seguridad avanzado') ?: new Test(
                    name: 'Seguridad avanzado',
                    description: 'Conceptos avanzados relacionados con el mundo de la seguridad de la información y de la seguridad informática.',
                    active: true,
                    numberOfQuestions: 10,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 1,
                    lockTime: 0,
                    maxAttempts: 3,
                    topic: securityTopic,
                    catalog: securityCatalog
            )

            def securityIntroductionTest = Test.findByName('Introducción a la seguridad') ?: new Test(
                    name: 'Seguridad básico',
                    description: 'Conceptos introductorios sobre los aspectos más básicos de la seguridad informática.',
                    active: true,
                    numberOfQuestions: 8,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 1,
                    lockTime: 0,
                    maxAttempts: 1,
                    topic: securityTopic,
                    catalog: securityCatalog
            )

            def englishTest = Test.findByName('Inglés básico') ?: new Test(
                    name: 'Inglés básico',
                    description: 'Descripción del test inglés básico.',
                    active: false,
                    numberOfQuestions: 0,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 5,
                    lockTime: 0,
                    maxAttempts: 1,
                    penalty: 8,
                    incorrectDiscount: true,
                    topic: languageTopic,
                    catalog: englishCatalog
            )

            /*-------------------------------------------------------------------------------------------*
             *                                          USER                                             *
             *-------------------------------------------------------------------------------------------*/

            def newUserSwitch = User.findByUsername('admin_switch') ?: new User( // Normal user to switch
                    username: 'admin_switch',
                    password: '7g4sOmmm',
                    email: 'switch.smartestingtool@gmail.com',
                    name:   'David',
                    surname: 'Martínez',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('28-05-1970'),
                    sex: Sex.FEMALE,
                    department: idDepartment
            )

            def newUser = User.findByUsername('jesusiglesias') ?: new User( // Normal user
                    username: 'jesusiglesias',
                    password: '7g4sOmmm',
                    email: 'jesusiglesias.smartestingtool@gmail.com',
                    name: 'Jesús',
                    surname: 'Iglesias',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('22-12-1992'),
                    sex: Sex.MALE,
                    department: idDepartment,
                    accessTests: [securityTest, securityIntroductionTest, englishTest]

            )

            def newUserLaura = User.findByUsername('lauragarcia') ?: new User( // Normal user
                    username: 'lauragarcia',
                    password: '7g4sOmmm',
                    email: 'lauragarcia.smartestingtool@gmail.com',
                    name: 'Laura',
                    surname: 'García',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('12-05-1978'),
                    sex: Sex.FEMALE,
                    department: rrhhDepartment,
            )

            def newUserMaria = User.findByUsername('mariaperez') ?: new User( // Normal user
                    username: 'mariaperez',
                    password: '7g4sOmmm',
                    email: 'mariaperez.smartestingtool@hotmail.com',
                    name: 'María',
                    surname: 'Pérez',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('19-10-1986'),
                    sex: Sex.FEMALE,
                    department: supportDepartment,
            )

            /*-------------------------------------------------------------------------------------------*
             *                                       EVALUATION                                          *
             *-------------------------------------------------------------------------------------------*/

            def evalUserSTT1 = new Evaluation(
                    testName: securityTest.name,
                    attemptNumber: 1,
                    maxAttempt: securityTest.maxAttempts,
                    completenessDate: new Date() - 20,
                    testScore: 7.55,
                    rightQuestions: 8,
                    failedQuestions: 1,
                    questionsUnanswered: 1,
                    userName: newUser.username
            )

            def evalUserSTT2 = new Evaluation(
                    testName: securityIntroductionTest.name,
                    attemptNumber: 1,
                    maxAttempt: securityIntroductionTest.maxAttempts,
                    completenessDate: new Date() - 1,
                    testScore: 5.34,
                    rightQuestions: 6,
                    failedQuestions: 2,
                    questionsUnanswered: 0,
                    userName: newUser.username
            )

            def evalLauraSTT1 = new Evaluation(
                    testName: securityTest.name,
                    attemptNumber: 3,
                    maxAttempt: securityTest.maxAttempts,
                    completenessDate: new Date() - 15,
                    testScore: 9.87,
                    rightQuestions: 10,
                    failedQuestions: 0,
                    questionsUnanswered: 0,
                    userName: newUserLaura.username
            )

            def evalLauraSTT2 = new Evaluation(
                    testName: securityIntroductionTest.name,
                    attemptNumber: 1,
                    maxAttempt: securityIntroductionTest.maxAttempts,
                    completenessDate: new Date() - 4,
                    testScore: 3.60,
                    rightQuestions: 4,
                    failedQuestions: 1,
                    questionsUnanswered: 3,
                    userName: newUserLaura.username
            )

            def evalMariaSTT1 = new Evaluation(
                    testName: securityTest.name,
                    attemptNumber: 2,
                    maxAttempt: securityTest.maxAttempts,
                    completenessDate: new Date() - 2,
                    testScore: 7.23,
                    rightQuestions: 8,
                    failedQuestions: 1,
                    questionsUnanswered: 1,
                    userName: newUserMaria.username
            )

            def evalMariaSTT2 = new Evaluation(
                    testName: securityIntroductionTest.name,
                    attemptNumber: 1,
                    maxAttempt: securityIntroductionTest.maxAttempts,
                    completenessDate: new Date() - 1,
                    testScore: 6.66,
                    rightQuestions: 7,
                    failedQuestions: 1,
                    questionsUnanswered: 0,
                    userName: newUserMaria.username
            )

            // Validation of admin
            def validAdmin = newAdmin.validate()
            // Validation of department
            def validAnother = anotherDepartment.validate()
            def validID = idDepartment.validate()
            def validRRHH = rrhhDepartment.validate()
            def validSecurity = securityDepartment.validate()
            def validSupport = supportDepartment.validate()
            // Validation of answer
            def validR1_se1 = re1_1Answer.validate()
            def validR2_se1 = re1_2Answer.validate()
            def validR3_se1 = re1_3Answer.validate()
            def validR1_se2 = re2_1Answer.validate()
            def validR2_se2 = re2_2Answer.validate()
            def validR3_se2 = re2_3Answer.validate()
            def validR1_se3 = re3_1Answer.validate()
            def validR2_se3 = re3_2Answer.validate()
            def validR3_se3 = re3_3Answer.validate()
            def validR1_se4 = re4_1Answer.validate()
            def validR2_se4 = re4_2Answer.validate()
            def validR3_se4 = re4_3Answer.validate()
            def validR1_se5 = re5_1Answer.validate()
            def validR2_se5 = re5_2Answer.validate()
            def validR3_se5 = re5_3Answer.validate()
            def validR1_se6 = re6_1Answer.validate()
            def validR2_se6 = re6_2Answer.validate()
            def validR3_se6 = re6_3Answer.validate()
            def validR1_se7 = re7_1Answer.validate()
            def validR2_se7 = re7_2Answer.validate()
            def validR3_se7 = re7_3Answer.validate()
            def validR1_se8 = re8_1Answer.validate()
            def validR2_se8 = re8_2Answer.validate()
            def validR3_se8 = re8_3Answer.validate()
            def validR1_se9 = re9_1Answer.validate()
            def validR2_se9 = re9_2Answer.validate()
            def validR3_se9 = re9_3Answer.validate()
            def validR1_se10 = re10_1Answer.validate()
            def validR2_se10 = re10_2Answer.validate()
            def validR3_se10 = re10_3Answer.validate()
            def validR1_se11 = re11_1Answer.validate()
            def validR2_se11 = re11_2Answer.validate()
            def validR3_se11 = re11_3Answer.validate()
            // Validation of question
            def validSe1 = se1Question.validate()
            def validSe2 = se2Question.validate()
            def validSe3 = se3Question.validate()
            def validSe4 = se4Question.validate()
            def validSe5 = se5Question.validate()
            def validSe6 = se6Question.validate()
            def validSe7 = se7Question.validate()
            def validSe8 = se8Question.validate()
            def validSe9 = se9Question.validate()
            def validSe10 = se10Question.validate()
            def validSe11 = se11Question.validate()
            // Validation of catalog
            def validEnglishCatalog = englishCatalog.validate()
            def validSecurityCatalog = securityCatalog.validate()
            // Validation of topic
            def validLanguageTopic = languageTopic.validate()
            def validSecurityTopic = securityTopic.validate()
            // Validation of test
            def validSecurityIntroductionTest = securityIntroductionTest.validate()
            def validSecurityTest = securityTest.validate()
            def validEnglishTest = englishTest.validate()
            // Validation of user
            def validUserSwitch = newUserSwitch.validate()
            def validUser = newUser.validate()
            def validUserLaura = newUserLaura.validate()
            def validUserMaria = newUserMaria.validate()
            // Validation of evaluation
            def validEvalUserSTT1 = evalUserSTT1.validate()
            def validEvalUserSTT2 = evalUserSTT2.validate()
            def validEvalLauraSTT1 = evalLauraSTT1.validate()
            def validEvalLauraSTT2 = evalLauraSTT2.validate()
            def validEvalMariaSTT1 = evalMariaSTT1.validate()
            def validEvalMariaSTT2 = evalMariaSTT2.validate()

            if (validAdmin & validAnother & validID & validRRHH & validSecurity & validSupport
                    & validR1_se1 & validR2_se1 & validR3_se1 & validR1_se2 & validR2_se2 & validR3_se2
                    & validR1_se3 & validR2_se3 & validR3_se3 & validR1_se4 & validR2_se4 & validR3_se4
                    & validR1_se5 & validR2_se5 & validR3_se5 & validR1_se6 & validR2_se6 & validR3_se6
                    & validR1_se7 & validR2_se7 & validR3_se7 & validR1_se8 & validR2_se8 & validR3_se8
                    & validR1_se9 & validR2_se9 & validR3_se9 & validR1_se10 & validR2_se10 & validR3_se10 &
                    validR1_se11 & validR2_se11 & validR3_se11 &
                    validSe1 & validSe2 & validSe3 & validSe4 & validSe5 & validSe6 & validSe7 & validSe8 & validSe9 & validSe10 & validSe11 &
                    validEnglishCatalog & validSecurityCatalog & validLanguageTopic & validSecurityTopic &
                    validSecurityIntroductionTest & validSecurityTest & validEnglishTest &
                    validUserSwitch & validUser & validUserLaura & validUserMaria &
                    validEvalUserSTT1 & validEvalUserSTT2 & validEvalLauraSTT1 & validEvalLauraSTT2 & validEvalMariaSTT1 & validEvalMariaSTT2) {

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

                // Assign user to role
                if (!newAdmin.authorities.contains(adminRole)) { // Admin
                    SecUserSecRole.create newAdmin, adminRole, true
                }

                // Saving answers
                re1_1Answer.save(flush: true, failOnError: true)
                re1_2Answer.save(flush: true, failOnError: true)
                re1_3Answer.save(flush: true, failOnError: true)
                re2_1Answer.save(flush: true, failOnError: true)
                re2_2Answer.save(flush: true, failOnError: true)
                re2_3Answer.save(flush: true, failOnError: true)
                re3_1Answer.save(flush: true, failOnError: true)
                re3_2Answer.save(flush: true, failOnError: true)
                re3_3Answer.save(flush: true, failOnError: true)
                re4_1Answer.save(flush: true, failOnError: true)
                re4_2Answer.save(flush: true, failOnError: true)
                re4_3Answer.save(flush: true, failOnError: true)
                re5_1Answer.save(flush: true, failOnError: true)
                re5_2Answer.save(flush: true, failOnError: true)
                re5_3Answer.save(flush: true, failOnError: true)
                re6_1Answer.save(flush: true, failOnError: true)
                re6_2Answer.save(flush: true, failOnError: true)
                re6_3Answer.save(flush: true, failOnError: true)
                re7_1Answer.save(flush: true, failOnError: true)
                re7_2Answer.save(flush: true, failOnError: true)
                re7_3Answer.save(flush: true, failOnError: true)
                re8_1Answer.save(flush: true, failOnError: true)
                re8_2Answer.save(flush: true, failOnError: true)
                re8_3Answer.save(flush: true, failOnError: true)
                re9_1Answer.save(flush: true, failOnError: true)
                re9_2Answer.save(flush: true, failOnError: true)
                re9_3Answer.save(flush: true, failOnError: true)
                re10_1Answer.save(flush: true, failOnError: true)
                re10_2Answer.save(flush: true, failOnError: true)
                re10_3Answer.save(flush: true, failOnError: true)
                re11_1Answer.save(flush: true, failOnError: true)
                re11_2Answer.save(flush: true, failOnError: true)
                re11_3Answer.save(flush: true, failOnError: true)

                // Saving questions
                se1Question.save(flush: true, failOnError: true)
                se2Question.save(flush: true, failOnError: true)
                se3Question.save(flush: true, failOnError: true)
                se4Question.save(flush: true, failOnError: true)
                se5Question.save(flush: true, failOnError: true)
                se6Question.save(flush: true, failOnError: true)
                se7Question.save(flush: true, failOnError: true)
                se8Question.save(flush: true, failOnError: true)
                se9Question.save(flush: true, failOnError: true)
                se10Question.save(flush: true, failOnError: true)
                se11Question.save(flush: true, failOnError: true)

                // Saving catalogs
                englishCatalog.save(flush: true, failOnError: true)
                securityCatalog.save(flush: true, failOnError: true)

                // Saving topics
                languageTopic.save(flush: true, failOnError: true)
                securityTopic.save(flush: true, failOnError: true)

                // It assigns the evaluations
                securityTest.addToEvaluationsTest(evalUserSTT1)
                securityIntroductionTest.addToEvaluationsTest(evalUserSTT2)
                securityTest.addToEvaluationsTest(evalLauraSTT1)
                securityIntroductionTest.addToEvaluationsTest(evalLauraSTT2)
                securityTest.addToEvaluationsTest(evalMariaSTT1)
                securityIntroductionTest.addToEvaluationsTest(evalMariaSTT2)

                // Saving test
                securityIntroductionTest.save(flush: true, failOnError: true)
                securityTest.save(flush: true, failOnError: true)
                englishTest.save(flush: true, failOnError: true)

                // It assigns the evaluations
                newUser.addToEvaluations(evalUserSTT1)
                newUser.addToEvaluations(evalUserSTT2)
                newUserLaura.addToEvaluations(evalLauraSTT1)
                newUserLaura.addToEvaluations(evalLauraSTT2)
                newUserMaria.addToEvaluations(evalMariaSTT1)
                newUserMaria.addToEvaluations(evalMariaSTT2)

                // Saving new users
                newUserSwitch.save(flush: true, failOnError: true)
                newUser.save(flush: true, failOnError: true)
                newUserLaura.save(flush: true, failOnError: true)
                newUserMaria.save(flush: true, failOnError: true)

                if (!newUserSwitch.authorities.contains(userRole)) { // Normal user to switch
                    SecUserSecRole.create newUserSwitch, userRole, true
                }
                if (!newUser.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUser, userRole, true
                }
                if (!newUserLaura.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUserLaura, userRole, true
                }
                if (!newUserMaria.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUserMaria, userRole, true
                }

                // Saving evaluations
                evalUserSTT1.save(flush: true, failOnError: true)
                evalUserSTT2.save(flush: true, failOnError: true)
                evalLauraSTT1.save(flush: true, failOnError: true)
                evalLauraSTT2.save(flush: true, failOnError: true)
                evalMariaSTT1.save(flush: true, failOnError: true)
                evalMariaSTT2.save(flush: true, failOnError: true)

                log.debug("BootStrap:init():Initial data have been created")
                log.info("Special config create for development or test - Users: jesus_admin/7g4sOmmm (Admin), admin_switch/7g4sOmmm (User), jesusiglesias/7g4sOmmm (User), lauragarcia/7g4sOmmm (User) and mariaperez/7g4sOmmm (User)")
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
             *                                        ADMIN AND ROLE                                     *
             *-------------------------------------------------------------------------------------------*/

            // Role
            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN')
            def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER')

            // Administrator
            def newAdmin = SecUser.findByUsername('jesus_admin') ?: new SecUser( // Admin
                    username: 'jesus_admin',
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
             *                                         ANSWER                                            *
             *-------------------------------------------------------------------------------------------*/

            def re1_1Answer = Answer.findByTitleAnswerKey('RE1-1') ?: new Answer(
                    titleAnswerKey: 'RE1-1',
                    description: 'Degradar el servicio mediante etiquetas iframe.',
                    correct: true,
                    score: 1
            )

            def re1_2Answer = Answer.findByTitleAnswerKey('RE1-2') ?: new Answer(
                    titleAnswerKey: 'RE1-2',
                    description: 'Bloquear el sistema del usuario.',
                    correct: false,
                    score: 0
            )

            def re1_3Answer = Answer.findByTitleAnswerKey('RE1-3') ?: new Answer(
                    titleAnswerKey: 'RE1-3',
                    description: 'Obtener información del usuario.',
                    correct: false,
                    score: 0
            )

            def re2_1Answer = Answer.findByTitleAnswerKey('RE2-1') ?: new Answer(
                    titleAnswerKey: 'RE2-1',
                    description: 'Heartbleed.',
                    correct: true,
                    score: 1
            )

            def re2_2Answer = Answer.findByTitleAnswerKey('RE2-2') ?: new Answer(
                    titleAnswerKey: 'RE2-2',
                    description: 'Ataque POODLE.',
                    correct: false,
                    score: 0
            )

            def re2_3Answer = Answer.findByTitleAnswerKey('RE2-3') ?: new Answer(
                    titleAnswerKey: 'RE2-3',
                    description: 'Logjam.',
                    correct: false,
                    score: 0
            )

            def re3_1Answer = Answer.findByTitleAnswerKey('RE3-1') ?: new Answer(
                    titleAnswerKey: 'RE3-1',
                    description: 'Un software para la protección de un equipo informático.',
                    correct: true,
                    score: 1
            )

            def re3_2Answer = Answer.findByTitleAnswerKey('RE3-2') ?: new Answer(
                    titleAnswerKey: 'RE3-2',
                    description: 'Un componente informático.',
                    correct: false,
                    score: 0
            )

            def re3_3Answer = Answer.findByTitleAnswerKey('RE3-3') ?: new Answer(
                    titleAnswerKey: 'RE3-3',
                    description: 'Un tipo de aplicación de ofimática.',
                    correct: false,
                    score: 0
            )

            def re4_1Answer = Answer.findByTitleAnswerKey('RE4-1') ?: new Answer(
                    titleAnswerKey: 'RE4-1',
                    description: 'Conjunto de acciones, herramientas y dispositivos cuyo objetivo es dotar a un sistema informatico de intergridad, confidencialidad y disponibilidad.',
                    correct: true,
                    score: 1
            )

            def re4_2Answer = Answer.findByTitleAnswerKey('RE4-2') ?: new Answer(
                    titleAnswerKey: 'RE4-2',
                    description: 'Conjunto de acciones para proteger a un sistema informático.',
                    correct: false,
                    score: 0
            )

            def re4_3Answer = Answer.findByTitleAnswerKey('RE4-3') ?: new Answer(
                    titleAnswerKey: 'RE4-3',
                    description: 'Conjunto de acciones referentes a la autenticación frente a un sistema informático.',
                    correct: false,
                    score: 0
            )

            def re5_1Answer = Answer.findByTitleAnswerKey('RE5-1') ?: new Answer(
                    titleAnswerKey: 'RE5-1',
                    description: 'Un tipo de software malicioso que se propaga infectando a otros ficheros.',
                    correct: true,
                    score: 1
            )

            def re5_2Answer = Answer.findByTitleAnswerKey('RE5-2') ?: new Answer(
                    titleAnswerKey: 'RE5-2',
                    description: 'Un tipo de software malicioso que parece un programa inofensivo pero que ocasiona daños cuando se ejecuta.',
                    correct: false,
                    score: 0
            )

            def re5_3Answer = Answer.findByTitleAnswerKey('RE5-3') ?: new Answer(
                    titleAnswerKey: 'RE5-3',
                    description: 'Un tipo de software malicioso que muestra a los usuarios publicidad de forma intrusiva.',
                    correct: false,
                    score: 0
            )

            def re6_1Answer = Answer.findByTitleAnswerKey('RE6-1') ?: new Answer(
                    titleAnswerKey: 'RE6-1',
                    description: 'Evitar la pérdida y modificación no autorizada de los datos personales.',
                    correct: true,
                    score: 1
            )

            def re6_2Answer = Answer.findByTitleAnswerKey('RE6-2') ?: new Answer(
                    titleAnswerKey: 'RE6-2',
                    description: 'Permitir a terceras personas acceder a los datos personales.',
                    correct: false,
                    score: 0
            )

            def re6_3Answer = Answer.findByTitleAnswerKey('RE6-3') ?: new Answer(
                    titleAnswerKey: 'RE6-3',
                    description: 'Mantener un registro de los datos personales de los usuarios.',
                    correct: false,
                    score: 0
            )

            def re7_1Answer = Answer.findByTitleAnswerKey('RE7-1') ?: new Answer(
                    titleAnswerKey: 'RE7-1',
                    description: 'Un hacker es la persona que posee conocimientos en seguridad informática para realizar acciones maliciosas mientras que un cracker utiliza sus conocimientos para realizar acciones beneficiosas.',
                    correct: false,
                    score: 0
            )

            def re7_2Answer = Answer.findByTitleAnswerKey('RE7-2') ?: new Answer(
                    titleAnswerKey: 'RE7-2',
                    description: 'Un hacker es la persona que posee conocimientos en seguridad informática para realizar acciones beneficiosas mientras que un cracker utiliza sus conocimientos para realizar acciones maliciosas.',
                    correct: true,
                    score: 1
            )

            def re7_3Answer = Answer.findByTitleAnswerKey('RE7-3') ?: new Answer(
                    titleAnswerKey: 'RE7-3',
                    description: 'Ambos conceptos definen el mismo tipo de persona.',
                    correct: false,
                    score: 0
            )

            def re8_1Answer = Answer.findByTitleAnswerKey('RE8-1') ?: new Answer(
                    titleAnswerKey: 'RE8-1',
                    description: 'Instalar software de fuentes conocidas.',
                    correct: false,
                    score: 0
            )

            def re8_2Answer = Answer.findByTitleAnswerKey('RE8-2') ?: new Answer(
                    titleAnswerKey: 'RE8-2',
                    description: 'Mecanismo de autenticación.',
                    correct: true,
                    score: 1
            )

            def re8_3Answer = Answer.findByTitleAnswerKey('RE8-3') ?: new Answer(
                    titleAnswerKey: 'RE8-3',
                    description: 'Navegar por sitios seguros.',
                    correct: false,
                    score: 0
            )

            def re9_1Answer = Answer.findByTitleAnswerKey('RE9-1') ?: new Answer(
                    titleAnswerKey: 'RE9-1',
                    description: 'Virus informático.',
                    correct: false,
                    score: 0
            )

            def re9_2Answer = Answer.findByTitleAnswerKey('RE9-2') ?: new Answer(
                    titleAnswerKey: 'RE9-2',
                    description: 'Adware.',
                    correct: true,
                    score: 1
            )

            def re9_3Answer = Answer.findByTitleAnswerKey('RE9-3') ?: new Answer(
                    titleAnswerKey: 'RE9-3',
                    description: 'Keylogger.',
                    correct: false,
                    score: 0
            )

            def re10_1Answer = Answer.findByTitleAnswerKey('RE10-1') ?: new Answer(
                    titleAnswerKey: 'RE10-1',
                    description: 'El sistema operativo no se actualiza periódicamente.',
                    correct: false,
                    score: 0
            )

            def re10_2Answer = Answer.findByTitleAnswerKey('RE10-2') ?: new Answer(
                    titleAnswerKey: 'RE10-2',
                    description: 'Todas las respuestas son correctas.',
                    correct: true,
                    score: 1
            )

            def re10_3Answer = Answer.findByTitleAnswerKey('RE10-3') ?: new Answer(
                    titleAnswerKey: 'RE10-3',
                    description: 'No se actualizan los programas que se instalan en él.',
                    correct: false,
                    score: 0
            )

            def re11_1Answer = Answer.findByTitleAnswerKey('RE11-1') ?: new Answer(
                    titleAnswerKey: 'RE11-1',
                    description: 'Un riesgo.',
                    correct: false,
                    score: 0
            )

            def re11_2Answer = Answer.findByTitleAnswerKey('RE11-2') ?: new Answer(
                    titleAnswerKey: 'RE11-2',
                    description: 'Una vulnerabilidad.',
                    correct: true,
                    score: 1
            )

            def re11_3Answer = Answer.findByTitleAnswerKey('RE11-3') ?: new Answer(
                    titleAnswerKey: 'RE11-3',
                    description: 'Una amenaza.',
                    correct: false,
                    score: 0
            )

            /*-------------------------------------------------------------------------------------------*
             *                                        QUESTION                                           *
             *-------------------------------------------------------------------------------------------*/

            def se1Question = Question.findByTitleQuestionKey('SE-1') ?: new Question(
                    titleQuestionKey: 'SE-1',
                    description: '¿Cuál es la finalidad del ataque clickjacking?',
                    difficultyLevel: DifficultyLevel.DIFFICULT,
                    answers: [re1_1Answer, re1_2Answer, re1_3Answer]
            )

            def se2Question = Question.findByTitleQuestionKey('SE-2') ?: new Question(
                    titleQuestionKey: 'SE-2',
                    description: '¿Cuál es la vulnerabilidad más peligrosa del protocolo TLS?',
                    difficultyLevel: DifficultyLevel.DIFFICULT,
                    answers: [re2_1Answer, re2_2Answer, re2_3Answer]
            )

            def se3Question = Question.findByTitleQuestionKey('SE-3') ?: new Question(
                    titleQuestionKey: 'SE-3',
                    description: '¿Qué es un antivirus?',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re3_1Answer, re3_2Answer, re3_3Answer]
            )

            def se4Question = Question.findByTitleQuestionKey('SE-4') ?: new Question(
                    titleQuestionKey: 'SE-4',
                    description: '¿Qué es la seguridad informática?',
                    difficultyLevel: DifficultyLevel.MEDIUM,
                    answers: [re4_1Answer, re4_2Answer, re4_3Answer]
            )

            def se5Question = Question.findByTitleQuestionKey('SE-5') ?: new Question(
                    titleQuestionKey: 'SE-5',
                    description: '¿Qué es un virus informático?',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re5_1Answer, re5_2Answer, re5_3Answer]
            )

            def se6Question = Question.findByTitleQuestionKey('SE-6') ?: new Question(
                    titleQuestionKey: 'SE-6',
                    description: '¿Cuál es el objetivo de la protección de datos?',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re6_1Answer, re6_2Answer, re6_3Answer]
            )

            def se7Question = Question.findByTitleQuestionKey('SE-7') ?: new Question(
                    titleQuestionKey: 'SE-7',
                    description: '¿Qué diferencia hay entre un hacker y un cracker?',
                    difficultyLevel: DifficultyLevel.MEDIUM,
                    answers: [re7_1Answer, re7_2Answer, re7_3Answer]
            )

            def se8Question = Question.findByTitleQuestionKey('SE-8') ?: new Question(
                    titleQuestionKey: 'SE-8',
                    description: '¿Cuál es uno de los aspectos principales de la seguridad?',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re8_1Answer, re8_2Answer, re8_3Answer]
            )

            def se9Question = Question.findByTitleQuestionKey('SE-9') ?: new Question(
                    titleQuestionKey: 'SE-9',
                    description: 'Si es un equipo aparece muchas ventanas de publicidad, ¿por qué variedad de software malicioso podemos deducir que se encuentra infectado?',
                    difficultyLevel: DifficultyLevel.MEDIUM,
                    answers: [re9_1Answer, re9_2Answer, re9_3Answer]
            )

            def se10Question = Question.findByTitleQuestionKey('SE-10') ?: new Question(
                    titleQuestionKey: 'SE-10',
                    description: 'Un equipo informático será más vulnerable si...',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re10_1Answer, re10_2Answer, re10_3Answer]
            )

            def se11Question = Question.findByTitleQuestionKey('SE-11') ?: new Question(
                    titleQuestionKey: 'SE-11',
                    description: 'El uso de contraseñas débiles se considera...',
                    difficultyLevel: DifficultyLevel.EASY,
                    answers: [re11_1Answer, re11_2Answer, re11_3Answer]
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
                    questions: [se1Question, se2Question, se3Question, se4Question, se5Question, se6Question, se7Question, se8Question, se9Question, se10Question, se11Question]
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
                    description: 'Comprende todos aquellos test relacionados con la evaluación de las capacidades y conocimientos en seguridad informática.',
                    visibility: true
            )

            /*-------------------------------------------------------------------------------------------*
            *                                           TEST                                            *
            *-------------------------------------------------------------------------------------------*/
            def securityTest = Test.findByName('Seguridad avanzado') ?: new Test(
                    name: 'Seguridad avanzado',
                    description: 'Conceptos avanzados relacionados con el mundo de la seguridad de la información y de la seguridad informática.',
                    active: true,
                    numberOfQuestions: 10,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 1,
                    lockTime: 0,
                    maxAttempts: 3,
                    topic: securityTopic,
                    catalog: securityCatalog
            )

            def securityIntroductionTest = Test.findByName('Introducción a la seguridad') ?: new Test(
                    name: 'Seguridad básico',
                    description: 'Conceptos introductorios sobre los aspectos más básicos de la seguridad informática.',
                    active: true,
                    numberOfQuestions: 8,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 1,
                    lockTime: 0,
                    maxAttempts: 1,
                    topic: securityTopic,
                    catalog: securityCatalog
            )

            def englishTest = Test.findByName('Inglés básico') ?: new Test(
                    name: 'Inglés básico',
                    description: 'Descripción del test inglés básico.',
                    active: false,
                    numberOfQuestions: 0,
                    initDate: new Date().clearTime(),
                    endDate: new Date().clearTime() + 5,
                    lockTime: 0,
                    maxAttempts: 1,
                    penalty: 8,
                    incorrectDiscount: true,
                    topic: languageTopic,
                    catalog: englishCatalog
            )

            /*-------------------------------------------------------------------------------------------*
             *                                          USER                                             *
             *-------------------------------------------------------------------------------------------*/

            def newUserSwitch = User.findByUsername('admin_switch') ?: new User( // Normal user to switch
                    username: 'admin_switch',
                    password: '7g4sOmmm',
                    email: 'switch.smartestingtool@gmail.com',
                    name:   'David',
                    surname: 'Martínez',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('28-05-1970'),
                    sex: Sex.FEMALE,
                    department: idDepartment
            )

            def newUser = User.findByUsername('jesusiglesias') ?: new User( // Normal user
                    username: 'jesusiglesias',
                    password: '7g4sOmmm',
                    email: 'jesusiglesias.smartestingtool@gmail.com',
                    name: 'Jesús',
                    surname: 'Iglesias',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('22-12-1992'),
                    sex: Sex.MALE,
                    department: idDepartment,
                    accessTests: [securityTest, securityIntroductionTest, englishTest]

            )

            def newUserLaura = User.findByUsername('lauragarcia') ?: new User( // Normal user
                    username: 'lauragarcia',
                    password: '7g4sOmmm',
                    email: 'lauragarcia.smartestingtool@gmail.com',
                    name: 'Laura',
                    surname: 'García',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('12-05-1978'),
                    sex: Sex.FEMALE,
                    department: rrhhDepartment,
            )

            def newUserMaria = User.findByUsername('mariaperez') ?: new User( // Normal user
                    username: 'mariaperez',
                    password: '7g4sOmmm',
                    email: 'mariaperez.smartestingtool@hotmail.com',
                    name: 'María',
                    surname: 'Pérez',
                    birthDate: new SimpleDateFormat( 'dd-MM-yyyy' ).parse('19-10-1986'),
                    sex: Sex.FEMALE,
                    department: supportDepartment,
            )

            /*-------------------------------------------------------------------------------------------*
             *                                       EVALUATION                                          *
             *-------------------------------------------------------------------------------------------*/

            def evalUserSTT1 = new Evaluation(
                    testName: securityTest.name,
                    attemptNumber: 1,
                    maxAttempt: securityTest.maxAttempts,
                    completenessDate: new Date() - 20,
                    testScore: 7.55,
                    rightQuestions: 8,
                    failedQuestions: 1,
                    questionsUnanswered: 1,
                    userName: newUser.username
            )

            def evalUserSTT2 = new Evaluation(
                    testName: securityIntroductionTest.name,
                    attemptNumber: 1,
                    maxAttempt: securityIntroductionTest.maxAttempts,
                    completenessDate: new Date() - 1,
                    testScore: 5.34,
                    rightQuestions: 6,
                    failedQuestions: 2,
                    questionsUnanswered: 0,
                    userName: newUser.username
            )

            def evalLauraSTT1 = new Evaluation(
                    testName: securityTest.name,
                    attemptNumber: 3,
                    maxAttempt: securityTest.maxAttempts,
                    completenessDate: new Date() - 15,
                    testScore: 9.87,
                    rightQuestions: 10,
                    failedQuestions: 0,
                    questionsUnanswered: 0,
                    userName: newUserLaura.username
            )

            def evalLauraSTT2 = new Evaluation(
                    testName: securityIntroductionTest.name,
                    attemptNumber: 1,
                    maxAttempt: securityIntroductionTest.maxAttempts,
                    completenessDate: new Date() - 4,
                    testScore: 3.60,
                    rightQuestions: 4,
                    failedQuestions: 1,
                    questionsUnanswered: 3,
                    userName: newUserLaura.username
            )

            def evalMariaSTT1 = new Evaluation(
                    testName: securityTest.name,
                    attemptNumber: 2,
                    maxAttempt: securityTest.maxAttempts,
                    completenessDate: new Date() - 2,
                    testScore: 7.23,
                    rightQuestions: 8,
                    failedQuestions: 1,
                    questionsUnanswered: 1,
                    userName: newUserMaria.username
            )

            def evalMariaSTT2 = new Evaluation(
                    testName: securityIntroductionTest.name,
                    attemptNumber: 1,
                    maxAttempt: securityIntroductionTest.maxAttempts,
                    completenessDate: new Date() - 1,
                    testScore: 6.66,
                    rightQuestions: 7,
                    failedQuestions: 1,
                    questionsUnanswered: 0,
                    userName: newUserMaria.username
            )

            // Validation of admin
            def validAdmin = newAdmin.validate()
            // Validation of department
            def validAnother = anotherDepartment.validate()
            def validID = idDepartment.validate()
            def validRRHH = rrhhDepartment.validate()
            def validSecurity = securityDepartment.validate()
            def validSupport = supportDepartment.validate()
            // Validation of answer
            def validR1_se1 = re1_1Answer.validate()
            def validR2_se1 = re1_2Answer.validate()
            def validR3_se1 = re1_3Answer.validate()
            def validR1_se2 = re2_1Answer.validate()
            def validR2_se2 = re2_2Answer.validate()
            def validR3_se2 = re2_3Answer.validate()
            def validR1_se3 = re3_1Answer.validate()
            def validR2_se3 = re3_2Answer.validate()
            def validR3_se3 = re3_3Answer.validate()
            def validR1_se4 = re4_1Answer.validate()
            def validR2_se4 = re4_2Answer.validate()
            def validR3_se4 = re4_3Answer.validate()
            def validR1_se5 = re5_1Answer.validate()
            def validR2_se5 = re5_2Answer.validate()
            def validR3_se5 = re5_3Answer.validate()
            def validR1_se6 = re6_1Answer.validate()
            def validR2_se6 = re6_2Answer.validate()
            def validR3_se6 = re6_3Answer.validate()
            def validR1_se7 = re7_1Answer.validate()
            def validR2_se7 = re7_2Answer.validate()
            def validR3_se7 = re7_3Answer.validate()
            def validR1_se8 = re8_1Answer.validate()
            def validR2_se8 = re8_2Answer.validate()
            def validR3_se8 = re8_3Answer.validate()
            def validR1_se9 = re9_1Answer.validate()
            def validR2_se9 = re9_2Answer.validate()
            def validR3_se9 = re9_3Answer.validate()
            def validR1_se10 = re10_1Answer.validate()
            def validR2_se10 = re10_2Answer.validate()
            def validR3_se10 = re10_3Answer.validate()
            def validR1_se11 = re11_1Answer.validate()
            def validR2_se11 = re11_2Answer.validate()
            def validR3_se11 = re11_3Answer.validate()
            // Validation of question
            def validSe1 = se1Question.validate()
            def validSe2 = se2Question.validate()
            def validSe3 = se3Question.validate()
            def validSe4 = se4Question.validate()
            def validSe5 = se5Question.validate()
            def validSe6 = se6Question.validate()
            def validSe7 = se7Question.validate()
            def validSe8 = se8Question.validate()
            def validSe9 = se9Question.validate()
            def validSe10 = se10Question.validate()
            def validSe11 = se11Question.validate()
            // Validation of catalog
            def validEnglishCatalog = englishCatalog.validate()
            def validSecurityCatalog = securityCatalog.validate()
            // Validation of topic
            def validLanguageTopic = languageTopic.validate()
            def validSecurityTopic = securityTopic.validate()
            // Validation of test
            def validSecurityIntroductionTest = securityIntroductionTest.validate()
            def validSecurityTest = securityTest.validate()
            def validEnglishTest = englishTest.validate()
            // Validation of user
            def validUserSwitch = newUserSwitch.validate()
            def validUser = newUser.validate()
            def validUserLaura = newUserLaura.validate()
            def validUserMaria = newUserMaria.validate()
            // Validation of evaluation
            def validEvalUserSTT1 = evalUserSTT1.validate()
            def validEvalUserSTT2 = evalUserSTT2.validate()
            def validEvalLauraSTT1 = evalLauraSTT1.validate()
            def validEvalLauraSTT2 = evalLauraSTT2.validate()
            def validEvalMariaSTT1 = evalMariaSTT1.validate()
            def validEvalMariaSTT2 = evalMariaSTT2.validate()

            if (validAdmin & validAnother & validID & validRRHH & validSecurity & validSupport
                    & validR1_se1 & validR2_se1 & validR3_se1 & validR1_se2 & validR2_se2 & validR3_se2
                    & validR1_se3 & validR2_se3 & validR3_se3 & validR1_se4 & validR2_se4 & validR3_se4
                    & validR1_se5 & validR2_se5 & validR3_se5 & validR1_se6 & validR2_se6 & validR3_se6
                    & validR1_se7 & validR2_se7 & validR3_se7 & validR1_se8 & validR2_se8 & validR3_se8
                    & validR1_se9 & validR2_se9 & validR3_se9 & validR1_se10 & validR2_se10 & validR3_se10 &
                    validR1_se11 & validR2_se11 & validR3_se11 &
                    validSe1 & validSe2 & validSe3 & validSe4 & validSe5 & validSe6 & validSe7 & validSe8 & validSe9 & validSe10 & validSe11 &
                    validEnglishCatalog & validSecurityCatalog & validLanguageTopic & validSecurityTopic &
                    validSecurityIntroductionTest & validSecurityTest & validEnglishTest &
                    validUserSwitch & validUser & validUserLaura & validUserMaria &
                    validEvalUserSTT1 & validEvalUserSTT2 & validEvalLauraSTT1 & validEvalLauraSTT2 & validEvalMariaSTT1 & validEvalMariaSTT2) {

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

                // Assign user to role
                if (!newAdmin.authorities.contains(adminRole)) { // Admin
                    SecUserSecRole.create newAdmin, adminRole, true
                }

                // Saving answers
                re1_1Answer.save(flush: true, failOnError: true)
                re1_2Answer.save(flush: true, failOnError: true)
                re1_3Answer.save(flush: true, failOnError: true)
                re2_1Answer.save(flush: true, failOnError: true)
                re2_2Answer.save(flush: true, failOnError: true)
                re2_3Answer.save(flush: true, failOnError: true)
                re3_1Answer.save(flush: true, failOnError: true)
                re3_2Answer.save(flush: true, failOnError: true)
                re3_3Answer.save(flush: true, failOnError: true)
                re4_1Answer.save(flush: true, failOnError: true)
                re4_2Answer.save(flush: true, failOnError: true)
                re4_3Answer.save(flush: true, failOnError: true)
                re5_1Answer.save(flush: true, failOnError: true)
                re5_2Answer.save(flush: true, failOnError: true)
                re5_3Answer.save(flush: true, failOnError: true)
                re6_1Answer.save(flush: true, failOnError: true)
                re6_2Answer.save(flush: true, failOnError: true)
                re6_3Answer.save(flush: true, failOnError: true)
                re7_1Answer.save(flush: true, failOnError: true)
                re7_2Answer.save(flush: true, failOnError: true)
                re7_3Answer.save(flush: true, failOnError: true)
                re8_1Answer.save(flush: true, failOnError: true)
                re8_2Answer.save(flush: true, failOnError: true)
                re8_3Answer.save(flush: true, failOnError: true)
                re9_1Answer.save(flush: true, failOnError: true)
                re9_2Answer.save(flush: true, failOnError: true)
                re9_3Answer.save(flush: true, failOnError: true)
                re10_1Answer.save(flush: true, failOnError: true)
                re10_2Answer.save(flush: true, failOnError: true)
                re10_3Answer.save(flush: true, failOnError: true)
                re11_1Answer.save(flush: true, failOnError: true)
                re11_2Answer.save(flush: true, failOnError: true)
                re11_3Answer.save(flush: true, failOnError: true)

                // Saving questions
                se1Question.save(flush: true, failOnError: true)
                se2Question.save(flush: true, failOnError: true)
                se3Question.save(flush: true, failOnError: true)
                se4Question.save(flush: true, failOnError: true)
                se5Question.save(flush: true, failOnError: true)
                se6Question.save(flush: true, failOnError: true)
                se7Question.save(flush: true, failOnError: true)
                se8Question.save(flush: true, failOnError: true)
                se9Question.save(flush: true, failOnError: true)
                se10Question.save(flush: true, failOnError: true)
                se11Question.save(flush: true, failOnError: true)

                // Saving catalogs
                englishCatalog.save(flush: true, failOnError: true)
                securityCatalog.save(flush: true, failOnError: true)

                // Saving topics
                languageTopic.save(flush: true, failOnError: true)
                securityTopic.save(flush: true, failOnError: true)

                // It assigns the evaluations
                securityTest.addToEvaluationsTest(evalUserSTT1)
                securityIntroductionTest.addToEvaluationsTest(evalUserSTT2)
                securityTest.addToEvaluationsTest(evalLauraSTT1)
                securityIntroductionTest.addToEvaluationsTest(evalLauraSTT2)
                securityTest.addToEvaluationsTest(evalMariaSTT1)
                securityIntroductionTest.addToEvaluationsTest(evalMariaSTT2)

                // Saving test
                securityIntroductionTest.save(flush: true, failOnError: true)
                securityTest.save(flush: true, failOnError: true)
                englishTest.save(flush: true, failOnError: true)

                // It assigns the evaluations
                newUser.addToEvaluations(evalUserSTT1)
                newUser.addToEvaluations(evalUserSTT2)
                newUserLaura.addToEvaluations(evalLauraSTT1)
                newUserLaura.addToEvaluations(evalLauraSTT2)
                newUserMaria.addToEvaluations(evalMariaSTT1)
                newUserMaria.addToEvaluations(evalMariaSTT2)

                // Saving new users
                newUserSwitch.save(flush: true, failOnError: true)
                newUser.save(flush: true, failOnError: true)
                newUserLaura.save(flush: true, failOnError: true)
                newUserMaria.save(flush: true, failOnError: true)

                if (!newUserSwitch.authorities.contains(userRole)) { // Normal user to switch
                    SecUserSecRole.create newUserSwitch, userRole, true
                }
                if (!newUser.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUser, userRole, true
                }
                if (!newUserLaura.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUserLaura, userRole, true
                }
                if (!newUserMaria.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUserMaria, userRole, true
                }

                // Saving evaluations
                evalUserSTT1.save(flush: true, failOnError: true)
                evalUserSTT2.save(flush: true, failOnError: true)
                evalLauraSTT1.save(flush: true, failOnError: true)
                evalLauraSTT2.save(flush: true, failOnError: true)
                evalMariaSTT1.save(flush: true, failOnError: true)
                evalMariaSTT2.save(flush: true, failOnError: true)

            } else {
                log.error("BootStrap:init():Admin users have not been created. You verify that the initial data complies with the rules")
            }

        } else {
            log.error("BooStrap:init():Existing admin or role data. Initial data were not created")

        }
    }
}