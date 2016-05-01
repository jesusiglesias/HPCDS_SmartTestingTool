package CustomTasksUser

/**
 * It contains the habitual custom tasks of the normal user (front-end).
 */
class CustomTasksFrontEndController {

    /**
     * It shows the home page of user.
     */
    def home() {
        log.debug("CustomTasksFrontEndController():home()")

        render view: 'home'
    }
}
