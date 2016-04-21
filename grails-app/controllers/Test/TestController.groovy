package Test

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Test controller.
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

        respond Test.list(params)
    }

    /**
     * It creates a new testInstance.
     *
     * @return return If the testInstance is null or has errors.
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

        if (params.initDate != "" && params.endDate != "") {

            // Parse initDate from textField
            def initDateFormat = new SimpleDateFormat('dd-MM-yyyy').parse(params.initDate)
            testInstance.initDate = initDateFormat

            // Parse endDate from textField
            def endDateFormat = new SimpleDateFormat('dd-MM-yyyy').parse(params.endDate)
            testInstance.endDate = endDateFormat
        }

        if (testInstance == null) {
            notFound()
            return
        }

        // It checks if catalog is null
        if (testInstance.catalog == null) {
            flash.testErrorMessage = g.message(code: 'layouts.main_auth_admin.body.content.test.catalog.null', default: '<strong>Catalog</strong> field cannot be null.')
            render view: "create", model: [testInstance: testInstance]
            return
        }

        if (testInstance.hasErrors()) {
            respond testInstance.errors, view: 'create'
            return
        }

        try {
            // Save test data
            testInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.testMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'test.label', default: 'Test'), testInstance.name])
                    redirect view: 'index'
                }
                '*' { respond testInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("TestController():save():Exception:Test:${testInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.testErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'test.label', default: 'Test'), testInstance.name])
                    render view: "create", model: [testInstance: testInstance]
                }
            }
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

        if (params.initDate != "" && params.endDate != "") {

            // Parse initDate from textField
            def initDateFormat = new SimpleDateFormat('dd-MM-yyyy').parse(params.initDate)
            testInstance.initDate = initDateFormat

            // Parse endDate from textField
            def endDateFormat = new SimpleDateFormat('dd-MM-yyyy').parse(params.endDate)
            testInstance.endDate = endDateFormat
        }

        if (testInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (testInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                testInstance.clearErrors()
                testInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [testInstance.name] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond testInstance.errors, view:'edit'
                return
            }
        }

        // It checks if catalog is null
        if (testInstance.catalog == null) {
            // Roll back in database
            transactionStatus.setRollbackOnly()

            flash.testErrorMessage = g.message(code: 'layouts.main_auth_admin.body.content.test.catalog.null', default: '<strong>Catalog</strong> field cannot be null.')
            render view: "create", model: [testInstance: testInstance]
            return
        }

        // Validate the instance
        if (!testInstance.validate()) {
            respond testInstance.errors, view:'edit'
            return
        }

        try {

            // Save test data
            testInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.testMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'test.label', default: 'Test'), testInstance.name])
                    redirect view: 'index'
                }
                '*' { respond testInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("TestController():update():Exception:Test:${testInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.testErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'test.label', default: 'Test'), testInstance.name])
                    render view: "edit", model: [testInstance: testInstance]
                }
            }
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

        try {

            // Delete test
            testInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.testMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'test.label', default: 'Test'), testInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("TestController():delete():DataIntegrityViolationException:Test:${testInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.testErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'test.label', default: 'Test'), testInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the test instance was not found.
     */
    protected void notFound() {
        log.error("TestController():notFound():TestID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.testErrorMessage = g.message(code: 'default.not.found.test.message', default:'It has not been able to locate the test with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    /**
     * It checks the name availability.
     */
    def checkNameTestAvailibility () {

        def responseData

        if (Test.countByName(params.testName)) { // Name found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'test.checkNameAvailibility.notAvailable', default:'Name of test is not available. Please, choose another one.')
            ]
        } else { // Name not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'test.checkNameAvailibility.available', default:'Name of test available..')
            ]
        }
        render responseData as JSON
    }
}
