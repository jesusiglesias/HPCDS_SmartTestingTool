package CustomTasksUser

import Security.SecRole
import Security.SecUser
import Security.SecUserSecRole
import Test.Test
import User.Department
import User.Evaluation
import grails.converters.JSON
import grails.util.Environment
import grails.util.Holders
import org.codehaus.groovy.grails.core.io.ResourceLocator
import org.springframework.core.io.Resource
import org.codehaus.groovy.grails.plugins.log4j.Log4jConfig

/**
 * It contains the habitual custom tasks of the admin (back-end).
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

        // Obtaining number of test in system
        def test = Test.findAll().size()

        // Obtaining number of test in system
        def evaluations = Evaluation.findAll().size()
        
        // Obtaining the lastest 10 registered users
        def lastUsers = SecUser.executeQuery("from SecUser where id in (select secUser.id from SecUserSecRole where secRole.id = :roleId) order by dateCreated desc", [roleId: roleUser.id], [max: 10])

        render view: 'dashboard', model: [normalUsers: normalUsers.size(), test: test, evaluations: evaluations, lastUsers: lastUsers]
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
     * It obtains the number of test from the AJAX call.
     */
    def reloadTest() {
        log.debug("CustomTasksBackendController:reloadTest()")

        // Obtaining number of test in system
        def test = Test.findAll().size()

        render test
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
     * It obtains the lastest 10 registered users from the AJAX call. TODO
     */
    def reloadLastUsers() {
        log.debug("CustomTasksBackendController:reloadLastUsers()")

        def roleUser = SecRole.findByAuthority("ROLE_USER")

        // Obtaining the lastest 10 registered users
        def lastUsers = SecUser.executeQuery("from SecUser where id in (select secUser.id from SecUserSecRole where secRole.id = :roleId) order by dateCreated desc", [roleId: roleUser.id], [max: 10])

        render lastUsers as JSON
    }

    /**
     * It obtains the number of users in each department.
     */
    def userEachDepartment() {
        log.debug("CustomTasksBackendController:userEachDepartment()")

        // Obtaining all departments
        def departments = Department.list()

        // Columnes
        def cols = [
                [label: g.message(code: "user.label", default: 'User'), type:"string"],
                [label: g.message(code: 'department.label', default: 'Department'), type:"number"]
        ]

        // Rows
        def rows = []
        def addRow = { name, value ->
            rows << [c: [[v: name], [v: value]]]
        }

        departments.each { department ->
            addRow(department.name, department.users.size())
        }

        def UDData = [cols: cols, rows: rows]

        render UDData as JSON
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
