package GeneralTasks

import Security.SecUserSecRole
import User.User
import grails.transaction.Transactional

/**
 * Service that performs a custom delete.
 */
@Transactional
class CustomDeleteService {

    /**
     * It deletes the users associated to department.
     *
     * @param departmentInstance It represents to the department.
     * @return true If the action was completed successful.
     */
    def customDeleteDepartment (departmentInstance) {
        log.debug("CustomDeleteService:customDeleteDepartment()")

        // It searches all users
        def userDeleted = User.findAllByDepartment(departmentInstance)

        // Delete SecUserSecRole relations
        SecUserSecRole.findAllBySecUser(userDeleted)*.delete(flush: true, failOnError: true)
    }
}
