package CustomTasksUser

import Security.SecRole
import Security.SecUser
import Security.SecUserSecRole
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
    def dashboard (){
        log.debug("CustomTasksBackendController:dashboard()")

        // Obtain number of normal users
        def role = SecRole.findByAuthority("ROLE_USER")
        def normalUsers = SecUserSecRole.findAllBySecRole(role).secUser

        render view: 'dashboard', model: [normalUsers: normalUsers.size()]
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
    def reloadLogConfig () {
        log.debug("CustomTasksBackendController:reloadLogConfig()")

        render view: 'reloadLogConfig'
    }

    /**
     * It reloads automatically the changes done in Log4j external file by means of AJAX.
     */
    def reloadLogConfigAJAX () {
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
