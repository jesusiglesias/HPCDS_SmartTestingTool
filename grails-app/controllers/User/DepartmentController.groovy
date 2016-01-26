package User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the department controller.
 */
@Transactional(readOnly = true)
class DepartmentController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all department of the database.
     *
     * @param max Maximum number of department to list.
     * @return Department Department list with their information and number of department in the database.
     */
    def index(Integer max) {
        //params.max = Math.min(max ?: 10, 100)

        // Protecting against attack when max is a negative number. If is 0, max = defaultPag
        max = max ?: defaultPag.toInteger()
        // If max < 0, return all records (This is dangerous)
        if (max < 0) {
            max = defaultPag.toInteger()
        }
        params.max = Math.min(max, 100)

        respond Department.list(params), model: [departmentInstanceCount: Department.count()]
    }

    /**
     * It shows the information of a department instance.
     *
     * @param departmentInstance It represents the department to show.
     * @return departmentInstance Data of the department instance.
     */
    def show(Department departmentInstance) {
        respond departmentInstance
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

        departmentInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])
                redirect departmentInstance
            }
            '*' { respond departmentInstance, [status: CREATED] }
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

        if (departmentInstance.hasErrors()) {
            respond departmentInstance.errors, view: 'edit'
            return
        }

        departmentInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])
                redirect departmentInstance
            }
            '*' { respond departmentInstance, [status: OK] }
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

        departmentInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the department instance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
