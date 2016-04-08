package User

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the department controller.
 */
@Transactional(readOnly = true)
class DepartmentController {

    def CustomDeleteService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all departments of the database.
     *
     * @param max Maximum number of departments to list.
     * @return Department Departments list with their information and number of departments in the database.
     */
    def index(Integer max) {
        //params.max = Math.min(max ?: 10, 100)

        // Protecting against attacks when max is a negative number. If is 0, max = defaultPag
        max = max ?: defaultPag.toInteger()
        // If max < 0, return all records (This is dangerous)
        if (max < 0) {
            max = defaultPag.toInteger()
        }
        params.max = Math.min(max, 100)

        respond Department.list(params)
    }

    /**
     * It creates a new department instance.
     *
     * @return return If the department instance is null or has errors.
     */
    def create() {
        respond new Department(params)
    }

    /**
     * It saves a department in database.
     *
     * @param departmentInstance It represents the department to save.
     * @return return If the department instance is null or has errors.
     */
    @Transactional
    def save(Department departmentInstance) {

        if (departmentInstance == null) {
            notFound()
            return
        }

        if (departmentInstance.hasErrors()) {
            respond departmentInstance.errors, view: 'create'
            return
        }

        try {
            // Save department
            departmentInstance.save(flush: true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.departmentMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'department.label', default: 'Department'), departmentInstance.name])
                    redirect view: 'index'
                }
                '*' { respond departmentInstance, [status: CREATED] }
            }

        } catch (Exception exception) {
            log.error("DepartmentController():save():Exception:Department:${departmentInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.departmentErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'department.label', default: 'Department'), departmentInstance.name])
                    render view: "create", model: [departmentInstance: departmentInstance]
                }
            }
        }
    }

    /**
     * It edits a existing department with the new values of each field.
     *
     * @param departmentInstance It represents the department to edit.
     * @return departmentInstance It represents the department instance.
     */
    def edit(Department departmentInstance) {
        respond departmentInstance
    }

    /**
     * It updates a existing department in database.
     *
     * @param departmentInstance It represents the department information to update.
     * @return return If the department instance is null or has errors.
     */
    @Transactional
    def update(Department departmentInstance) {

        if (departmentInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (departmentInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                departmentInstance.clearErrors()
                departmentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [departmentInstance.name] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond departmentInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!departmentInstance.validate()) {
            respond departmentInstance.errors, view:'edit'
            return
        }

        try {

            // Save department
            departmentInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.departmentMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'department.label', default: 'Department'), departmentInstance.name])
                    redirect view: 'index'
                }
                '*' { respond departmentInstance, [status: OK] }
            }

        } catch (Exception exception) {
            log.error("DepartmentController():update():Exception:Department:${departmentInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.departmentErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'department.label', default: 'Department'), departmentInstance.name])
                    render view: "edit", model: [departmentInstance: departmentInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing department in database.
     *
     * @param departmentInstance It represents the department information to delete.
     * @return return If the department instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Department departmentInstance) {

        if (departmentInstance == null) {
            notFound()
            return
        }

        try {

            // Delete users if checkbox is true
            if (params.delete_department) {
                customDeleteService.customDeleteDepartment(departmentInstance)
            }

            // Delete department
            departmentInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.departmentMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'department.label', default: 'Department'), departmentInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("DepartmentController():delete():DataIntegrityViolationException:Department:${departmentInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.departmentErrorMessage = g.message(code: 'default.not.deleted.message.department', default: 'ERROR! {0} <strong>{1}</strong> was not deleted. First, you must delete the user or users associated with the department.', args: [message(code: 'department.label', default: 'Department'), departmentInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the department instance was not found.
     */
    protected void notFound() {
        log.error("DepartmentController():notFound():DepartmentID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.departmentErrorMessage = message(code: 'default.not.found.department.message', default:'It has not been able to locate the department with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    /**
     * It checks the name availability.
     */
    def checkNameAvailibility () {

        def responseData

        if (Department.countByName(params.name)) { // Name found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'department.checkDepartmentAvailibility.notAvailable', default:'Name of department is not available. Please, choose another one.')
            ]
        } else { // Name not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'department.checkDepartmentAvailibility.available', default:'Name of department available.')
            ]
        }
        render responseData as JSON
    }
}
