package CustomTasksUser

import Enumerations.Sex
import Security.SecRole
import Security.SecUser
import Security.SecUserSecRole
import Test.Test
import User.*
import grails.converters.JSON
import grails.util.Environment
import grails.util.Holders
import org.codehaus.groovy.grails.core.io.ResourceLocator
import org.springframework.core.io.Resource
import org.codehaus.groovy.grails.plugins.log4j.Log4jConfig
import static grails.async.Promises.*
import static groovyx.gpars.GParsPool.withPool

/**
 * It contains the habitual custom tasks of the admin (control panel).
 */
class CustomTasksBackendController {

    def springSecurityService
    ResourceLocator grailsResourceLocator

    // Store the hash of external config files
    private static Map<String, Integer> fileHashMap = [:]

    /**
     * It shows the main page of the admin user.
     */
    def dashboard() {
        log.debug("CustomTasksBackendController:dashboard()")

        // Obtaining number of normal users
        def roleUser = SecRole.findByAuthority("ROLE_USER")
        def normalUsers = SecUserSecRole.findAllBySecRole(roleUser).secUser

        // Obtaining number of active test in system - Asynchronous/Multi-thread
        def testPromise = Test.async.findAllByActive(true)

        // Obtaining number of registered test in system - Asynchronous/Multi-thread
        def testRegisteredPromise = Test.async.findAll()

        // Obtaining number of evaluations in system - Asynchronous/Multi-thread
        def evaluationsPromise = Evaluation.async.findAll()

        // Wait all promises
        def results = waitAll(testPromise, testRegisteredPromise, evaluationsPromise)

        def numberActiveTest = results[0].size()
        def numberRegisteredTest = results[1].size()
        def evaluations = results[2].size()

        // Obtaining the lastest 10 registered users
        def lastUsers = SecUser.executeQuery("from SecUser where id in (select secUser.id from SecUserSecRole where secRole.id = :roleId) order by dateCreated desc", [roleId: roleUser.id], [max: 10])

        render view: 'dashboard', model: [normalUsers: normalUsers.async.size(), numberActiveTest: numberActiveTest, numberRegisteredTest:numberRegisteredTest, evaluations: evaluations, lastUsers: lastUsers]
    }

    /**
     * It obtains the number of users from the AJAX call.
     */
    def reloadUsers() {
        log.debug("CustomTasksBackendController:reloadUsers()")

        // Obtaining number of normal users
        def roleUser = SecRole.findByAuthority("ROLE_USER")
        def normalUsers = SecUserSecRole.findAllBySecRole(roleUser).secUser

        render normalUsers.size()
    }

    /**
     * It obtains the number of registered test from the AJAX call.
     */
    def reloadRegisteredTest() {
        log.debug("CustomTasksBackendController:reloadRegisteredTest()")

        // Obtaining number of registered test in system
        def registeredTest = Test.findAll().size()

        render registeredTest
    }

    /**
     * It obtains the number of active test from the AJAX call.
     */
    def reloadTest() {
        log.debug("CustomTasksBackendController:reloadTest()")

        // Obtaining number of active test in system
        def activeTest = Test.findAllByActive(true).size()

        render activeTest
    }

    /**
     * It obtains the number of evaluations from the AJAX call.
     */
    def reloadEvaluations() {
        log.debug("CustomTasksBackendController:reloadEvaluations()")

        // Obtaining number of test in system
        def evaluations = Evaluation.findAll().size()

        render evaluations
    }

    /**
     * It obtains the lastest 10 registered users from the AJAX call.
     */
    def reloadLastUsers() {
        log.debug("CustomTasksBackendController:reloadLastUsers()")

        def roleUser = SecRole.findByAuthority("ROLE_USER")

        // Obtaining the lastest 10 registered users
        def lastUsers = SecUser.executeQuery("from SecUser where id in (select secUser.id from SecUserSecRole where secRole.id = :roleId) order by dateCreated desc", [roleId: roleUser.id], [max: 10])

        render(template:'lastUsers', model: [lastUsers: lastUsers])
    }

    /**
     * It obtains the number of users in each department.
     */
    def userEachDepartment() {
        log.debug("CustomTasksBackendController:userEachDepartment()")

        // Obtaining all departments
        def departments = Department.list()

        // Columns
        def cols = [
                [label: g.message(code: "user.label", default: 'User'), type:"string"],
                [label: g.message(code: 'department.label', default: 'Department'), type:"number"]
        ]

        // Rows
        def rows = []

        withPool {
             // Add departments
             rows = departments.collectParallel { department ->
                 [c: [[v: department.name], [v:department.users.size()]]]
             }
         }

         def UDData = [cols: cols, rows: rows]

         // Avoid undefined function (Google chart)
         sleep(90)

         render UDData as JSON
     }

     /**
      * It obtains the number of users in each rank of score.
      */
    def scoresRank() {
        log.debug("CustomTasksBackendController:scoresRank()")

        // Obtaining all scores - Asynchronous/Multi-thread
        def suspensePromise = Evaluation.async.findAllByTestScoreLessThan(5)
        def approvedPromise = Evaluation.async.findAllByTestScoreGreaterThanEqualsAndTestScoreLessThan(5,7)
        def remarkablePromise = Evaluation.async.findAllByTestScoreGreaterThanEqualsAndTestScoreLessThan(7, 9)
        def outstandingPromise = Evaluation.async.findAllByTestScoreGreaterThanEquals(9)

        // Wait all promises
        def results = waitAll(suspensePromise, approvedPromise, remarkablePromise, outstandingPromise)

        def suspense = results[0].size()
        def approved = results[1].size()
        def remarkable = results[2].size()
        def outstanding = results[3].size()

        def dataSR = [
                'suspense': suspense,
                'approved': approved,
                'remarkable': remarkable,
                'outstanding': outstanding
        ]

        // Avoid undefined function (Google chart)
        sleep(100)

        render dataSR as JSON
    }

    /**
     * It obtains the average scores group by sex.
     */
    def averageScoreSex() {
        log.debug("CustomTasksBackendController:averageScoreSex()")

        // Obtaining all male evaluations (average scores)
        def criteriaMale =  User.createCriteria().list() {
            createAlias('evaluations', 'e')
            eq 'sex', Sex.MALE
            projections {
                avg('e.testScore')
            }
        }

        // Obtaining all female evaluations (average scores)
        def criteriaFemale =  User.createCriteria().list() {
            createAlias('evaluations', 'e')
            eq 'sex', Sex.FEMALE
            projections {
                avg('e.testScore')
            }
        }

        // It obtains result of the criteria
        def numberAverageMale = criteriaMale.getAt(0)
        def numberAverageFemale = criteriaFemale.getAt(0)

        if (numberAverageMale == null ) {
            numberAverageMale = 0
        }

        if (numberAverageFemale == null ) {
            numberAverageFemale = 0
        }

        def dataAVS = [
                'averageMale': numberAverageMale,
                'averageFemale': numberAverageFemale
        ]

        // Avoid undefined function (Google chart)
        sleep(110)

        render dataAVS as JSON
    }

    /**
     * It obtains the number of evaluations of each test.
     */
    def scoresTest() {
        log.debug("CustomTasksBackendController:scoresTest()")

        // Obtaining number of scores of test - [0-1)
        def criteriaZero = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 0 as Float)
                lt("testScore", 1 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultZero = criteriaZero.get()
        def zero = resultZero.getAt(0)

        // Obtaining number of scores of test - [1-2)
        def criteriaOne = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 1 as Float)
                lt("testScore", 2 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultOne = criteriaOne.get()
        def one = resultOne.getAt(0)

        // Obtaining number of scores of test - [2-3)
        def criteriaTwo = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 2 as Float)
                lt("testScore", 3 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultTwo = criteriaTwo.get()
        def two = resultTwo.getAt(0)

        // Obtaining number of scores of test - [3-4)
        def criteriaThree = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 3 as Float)
                lt("testScore", 4 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultThree = criteriaThree.get()
        def three = resultThree.getAt(0)

        // Obtaining number of scores of test - [4-5)
        def criteriaFour = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 4 as Float)
                lt("testScore", 5 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultFour = criteriaFour.get()
        def four = resultFour.getAt(0)

        // Obtaining number of scores of test - [5-6)
        def criteriaFive = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 5 as Float)
                lt("testScore", 6 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultFive = criteriaFive.get()
        def five = resultFive.getAt(0)

        // Obtaining number of scores of test - [6-7)
        def criteriaSix = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 6 as Float)
                lt("testScore", 7 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultSix = criteriaSix.get()
        def six = resultSix.getAt(0)

        // Obtaining number of scores of test - [7-8)
        def criteriaSeven = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 7 as Float)
                lt("testScore", 8 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultSeven = criteriaSeven.get()
        def seven = resultSeven.getAt(0)

        // Obtaining number of scores of test - [8-9)
        def criteriaEight = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 8 as Float)
                lt("testScore", 9 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultEight = criteriaEight.get()
        def eight = resultEight.getAt(0)

        // Obtaining number of scores of test - [9-10]
        def criteriaNine = Test.async.withCriteria() {
            eq 'name', params.test
            evaluationsTest {
                ge("testScore", 9 as Float)
                le("testScore", 10 as Float)
            }
            projections {
                count()
            }
        }
        // It obtains result of promise
        def resultNine = criteriaNine.get()
        def nine = resultNine.getAt(0)

        def dataTS = [
                'zero':  zero,
                'one':   one,
                'two':   two,
                'three': three,
                'four':  four,
                'five':  five,
                'six':   six,
                'seven': seven,
                'eight': eight,
                'nine':  nine,
        ]

        render dataTS as JSON
    }

    /**
     * It obtains the profile image.
     *
     * @return out Profile image of the user.
     */
    def profileImage() {
        log.debug("CustomTasksBackendController:profileImage()")

        def currentUser

        if (params.id) { // Index view
            currentUser = SecUser.get(params.id)

        } else { // Menu
            currentUser = SecUser.get(springSecurityService.currentUser.id)
        }

        if (!currentUser || !currentUser.avatar || !currentUser.avatarType) {

            final Resource image = grailsResourceLocator.findResourceForURI('/img/profile/user_profile.png')

            def file = new File(image.getURL().getFile())
            def img = file.bytes
            response.contentType = 'image/png'
            response.contentLength = file.size()
            response.outputStream << img
            response.outputStream.flush()

        } else {

            response.contentType = currentUser.avatarType
            response.contentLength = currentUser.avatar.size()
            OutputStream out = response.outputStream
            out.write(currentUser.avatar)
            out.close()
        }
    }

    /**
     * It shows the reload log configuration page.
     */
    def reloadLogConfig() {
        log.debug("CustomTasksBackendController:reloadLogConfig()")

        render view: 'reloadLogConfig'
    }

    /**
     * It reloads automatically the changes done in Log4j external file by means of AJAX.
     */
    def reloadLogConfigAJAX() {
        log.debug("CustomTasksBackendController:reloadLogConfigAJAX()")

        // External files of properties
        ConfigObject config = Holders.config
        List locations = config.grails.config.locations

        int hashCode
        String text

        // It finds all the external file locations with contains a pattern
        locations.findAll {
            // It checks only in classpath and Log4j file
            return (it instanceof String || it instanceof GString) && (it.toString().contains("classpath:") && it.toString().contains("LogConfig"))

        }.each { String filePath ->
            try {
                // It reads the contents of file
                text = Holders.applicationContext.getResource(filePath)?.file?.text
            } catch (FileNotFoundException e) {
                // Ignore the exception if file not found on specified path
                log.error("CustomTasksBackendController:reloadLogConfigAJAX():File not found: ${e.message}")

                render("logError")
            }

            // If file have data
            if (text) {
                // Calculate hashCode of text
                hashCode = text.hashCode()
                if (!fileHashMap.containsKey(filePath) || fileHashMap.get(filePath) != hashCode) {
                    // Merge existing config with the text of file
                    config = config.merge(new ConfigSlurper(Environment.current.name).parse(text))

                    // Reconfigure log4j
                    Log4jConfig.initialize(config)

                    fileHashMap.put(filePath, hashCode)

                    log.debug("CustomTasksBackendController:reloadLogConfigAJAX():success")

                    render("logSuccess")

                } else {
                    log.debug("CustomTasksBackendController:reloadLogConfigAJAX():noChanges")

                    render("logNoChanges")
                }
            }
        }
    }
}
