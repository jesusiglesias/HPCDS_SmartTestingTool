package CustomTasksUser

/**
 * It contains the habitual custom tasks of the user.
 */
class CustomTasksUserController {

    /**
     * It creates a flash message about a invalid session of the user with user role.
     *
     * @return invalidSession Message to show to the user.
     */
    def invalidSession() {
        log.debug("CustomTasksUserController:invalidSession()")

        flash.invalidSession =  g.message(code: "customTasksUser.login.invalidSession")
        redirect (controller: 'login', action: 'auth', params: params)
    }
}
