package CustomTasksUser

import grails.util.Environment
import grails.util.Holders
import org.codehaus.groovy.grails.plugins.log4j.Log4jConfig

/**
 * It contains the habitual custom tasks of the user.
 */
class CustomTasksUserController {

    //to store the hash of external config files
    private static Map<String, Integer> fileHashMap = [:]

    /**
     * It creates a flash message about a invalid session of the user with user role.
     *
     * @return invalidSession Message to show to the user.
     */
    def invalidSession() {
        log.debug("CustomTasksUserController:invalidSession()")

        // TODO Add default
        flash.invalidSession =  g.message(code: "customTasksUser.login.invalidSession")
        redirect (controller: 'login', action: 'auth', params: params)
    }

    /**
     * It reloads automatically the changes done in Log4j external file.
     */
    def reloadLogConfig () {
        log.debug("CustomTasksUserController:reloadConfig()")

        // External files of properties
        ConfigObject config = Holders.config
        List locations = config.grails.config.locations

        int hashCode
        String text

        // It finds all the external file locations with contains a pattern
        locations.findAll {
            // It checks only in classpath and Log4j file
            return (it instanceof String || it instanceof GString) && (it.toString().contains("classpath:") && it.toString().contains("LogConfig"))
            // return (it instanceof String || it instanceof GString) && (it.toString().contains("classpath:LogConfig") || it.toString().contains("file:LogConfig"))

        }.each { String filePath ->
            try {
                // It reads the contents of file
                text = Holders.applicationContext.getResource(filePath)?.file?.text
            } catch (FileNotFoundException e) {
                // Ignore the exception if file not found on specified path
                log.error("CustomTasksUserController:reloadConfig():File not found: ${e.message}")

                // TODO Add default
                flash.reloadConfig = g.message(code:"customTasksUser.reloadConfig.notFound", default: "")
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

                    log.debug("CustomTasksUserController:reloadConfig():Configuration updated successfully")

                    // TODO Add default
                    flash.reloadConfig = g.message(code: "customTasksUser.reloadConfig.success", default: "")

                }
                log.debug("CustomTasksUserController:reloadConfig():No changes")

                // TODO Add default
                flash.reloadConfig = g.message(code: "customTasksUser.reloadConfig.noChanges" , default: "")
            }
        }
        redirect(uri: '/')
    }
}
