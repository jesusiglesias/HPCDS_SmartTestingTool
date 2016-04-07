package GeneralTasks

import User.Department
import grails.transaction.Transactional

/**
 * Service that performs the count of the field or fields of an entity.
 */
@Transactional
class CustomCountService {

    /*-------------------------------------------------------------------------------------------*
     *                                        DEPARTMENT                                         *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It increases the count when an user is saved.
     *
     * @param userInstance It represents to the user to save.
     * @return true If the action was completed successful.
     */
    def customUserCount(userInstance) {
        log.debug("CustomCountService:customUserCount()")

        // It obtains department associated to user
        def departmentUpdated = Department.withCriteria {
            users {
                eq('username', userInstance.username)
            }
        }

        def departmentInstance = Department.get(departmentUpdated.id)
        def newCount = departmentInstance.users?.size()

        log.debug("CustomCountService:customUserCount():newCount:${newCount}")

        departmentInstance.userCount = newCount
        departmentInstance.save(flush: true, failOnError: true)
    }

    /**
     * It decreases the count when an user is updated (old department).
     *
     * @param userInstance It represents to the user to update.
     * @return true If the action was completed successful.
     */
    def customUserCountUpdatedBefore(newDepartment, oldDepartment) {
        log.debug("CustomCountService:customUserCountUpdatedBefore()")

        def oldDepartmentInstance = Department.findByName(oldDepartment)

        if (oldDepartmentInstance.id != newDepartment) {
            def oldNewCount = oldDepartmentInstance.users?.size() - 1

            log.debug("CustomCountService:customUserCountUpdatedBefore():newCount:${oldNewCount}")

            oldDepartmentInstance.userCount = oldNewCount
            oldDepartmentInstance.save(flush: true, failOnError: true)
        }
    }

    /**
     * It increases the count when an user is updated.
     *
     * @param userInstance It represents to the user to update.
     * @return true If the action was completed successful.
     */
    def customUserCountUpdated(userInstance) {
        log.debug("CustomCountService:customUserCountUpdated()")

        // It obtains department associated to user
        def departmentUpdated = Department.withCriteria {
            users {
                eq('username', userInstance.username)
            }
        }

        def departmentInstance = Department.get(departmentUpdated.id)

        def newCount = departmentInstance.users?.size()

        log.debug("CustomCountService:customUserCountUpdated():newCount:${newCount}")

        departmentInstance.userCount = newCount
        departmentInstance.save(flush: true, failOnError: true)
    }

    /**
     * It decreases the count when an user is deleted.
     *
     * @param userInstance It represents to the user to delete.
     * @return true If the action was completed successful.
     */
    def customUserCountDeleted(userInstance) {
        log.debug("CustomCountService:customUserCountDeleted()")

        // It obtains department associated to user
        def departmentUpdated = Department.withCriteria {
            users {
                eq('username', userInstance.username)
            }
        }

        userInstance.delete(flush: true, failOnError: true)

        def departmentInstance = Department.get(departmentUpdated.id)
        def newCount = departmentInstance.users?.size() - 1

        log.debug("CustomCountService:customUserCountDeleted():newCount:${newCount}")

        departmentInstance.userCount = newCount
        departmentInstance.save(flush: true, failOnError: true)
    }
}
