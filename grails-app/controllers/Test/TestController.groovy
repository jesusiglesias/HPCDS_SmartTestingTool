package Test

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the test controller.
 */
@Transactional(readOnly = true)
class TestController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all test of the database.
     *
     * @param max Maximum number of test to list.
     * @return Test Test list with their information and number of test in the database.
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

        respond Test.list(params), model: [testInstanceCount: Test.count()]
    }

    /**
     * It shows the information of a test instance.
     *
     * @param testInstance It represents the test to show.
     * @return testInstance Data of the test instance.
     */
    def show(Test testInstance) {
        respond testInstance
    }

    /**
     * It creates a new test instance.
     *
     * @return return If the test instance is null or has errors.
     */
    def create() {
        respond new Test(params)
    }

    /**
     * It saves a test in database.
     *
     * @param testInstance It represents the test to save.
     * @return return If the test instance is null or has errors.
     */
    @Transactional
    def save(Test testInstance) {
        if (testInstance == null) {
            notFound()
            return
        }

        if (testInstance.hasErrors()) {
            respond testInstance.errors, view: 'create'
            return
        }

        testInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'test.label', default: 'Test'), testInstance.id])
                redirect testInstance
            }
            '*' { respond testInstance, [status: CREATED] }
        }
    }

    /**
     * It edits a existing test with the new values of each field.
     *
     * @param testInstance It represents the test to edit.
     * @return testInstance It represents the test instance.
     */
    def edit(Test testInstance) {
        respond testInstance
    }

    /**
     * It updates a existing test in database.
     *
     * @param testInstance It represents the test information to update.
     * @return return If the test instance is null or has errors.
     */
    @Transactional
    def update(Test testInstance) {
        if (testInstance == null) {
            notFound()
            return
        }

        if (testInstance.hasErrors()) {
            respond testInstance.errors, view: 'edit'
            return
        }

        testInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'test.label', default: 'Test'), testInstance.id])
                redirect testInstance
            }
            '*' { respond testInstance, [status: OK] }
        }
    }

    /**
     * It deletes a existing test in database.
     *
     * @param testInstance It represents the test information to delete.
     * @return return If the test instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Test testInstance) {

        if (testInstance == null) {
            notFound()
            return
        }

        testInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'test.label', default: 'Test'), testInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the test instance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'test.label', default: 'Test'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
