package Test

import grails.converters.JSON
import org.apache.tika.Tika
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

    def CustomImportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", uploadFileTest: "POST"]

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

            // Roll back in database
            transactionStatus.setRollbackOnly()

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

            // Roll back in database
            transactionStatus.setRollbackOnly()

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

            // Roll back in database
            transactionStatus.setRollbackOnly()

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

    /**
     * It shows the test import page.
     */
    def importTest () {
        log.debug("TestController():importTest()")

        render view: 'import'
    }

    /**
     * It processes the import functionality.
     */
    @Transactional
    def uploadFileTest () {
        log.debug("TestController():uploadFileTest()")

        // Record counter
        def lineCounter = 0
        def existingFieldsList = []
        def back = false
        def initDateValid = false, endDateValid = false, topicValid = false, catalogValid = false
        def initDateInstance, endDateInstance

        // Obtaining number of fields in the entity - numberFields: 11
        def numberFields = 0
        def totalNumberFields = 0
        grailsApplication.getDomainClass('Test.Test').persistentProperties.collect {
            numberFields ++
        }

        // ID field (attribute) does not used
        totalNumberFields = numberFields - 1
        log.debug("TestController():uploadFileTest():numberFieldsClass:${totalNumberFields}")

        // Obtain file
        def csvFileLoad = request.getFile("importFileTest")
        // File name and content type
        def csvFilename = csvFileLoad.originalFilename
        def csvContentType = csvFileLoad.contentType

        // getFile() fields
        /*
        csvFileLoad.contentType
        csvFileLoad.originalFilename
        csvFileLoad.name
        csvFileLoad.size
        csvFileLoad.bytes
        csvFileLoad.isEmpty()
        csvFileLoad.inputStream
        csvFileLoad.storageDescription
        */

        log.debug("TestController():uploadFileTest():contentTypeFile:${csvContentType}")

        // Check CSV type - Global
        if ((new Tika().detect(csvFilename) != grailsApplication.config.grails.mime.types.csv) || !(customImportService.checkExtension(csvFilename)))  {
            log.error("TestController():uploadFileTest():errorCSVContentType:contentType:${csvContentType}")

            flash.testImportErrorMessage = g.message(code: "default.import.error.csv", default: "<strong>{0}</strong> file has not the right format: <strong>.csv</strong>.", args: ["${csvFilename}"])
            redirect uri: '/test/import'
            return
        }

        // File empty
        if (csvFileLoad.isEmpty()) {
            log.error("TestController():uploadFileTest():csvFileLoad.isEmpty()")

            flash.testImportErrorMessage = g.message(code: "default.import.error.empty", default: "<strong>{0}</strong> file is empty.", args: ["${csvFilename}"])
            redirect uri: '/test/import'
            return
        }

        // Parse CSV file
        try {
            csvFileLoad.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8', 'skipLines': 1]).eachLine { tokens ->

                lineCounter++

                // Each row has 1 column (name). Length of the row
                if (tokens.length == totalNumberFields) {

                    // It checks the name because is an unique property
                    if(Test.findByName(tokens[0].trim())){
                        log.error("TestController():uploadFileTest():toCsvReader():recordsExists")

                        existingFieldsList.push(lineCounter)

                    } else {

                        // Parsing initial date field
                        try {
                            initDateInstance = new SimpleDateFormat('dd-MM-yyyy').parse(tokens[4].trim())

                            initDateValid = true

                        } catch (Exception e) {
                            log.error("TestController():uploadFileTest():initialDate:formatInvalid:${tokens[4].trim()}")

                            initDateValid = false
                            back = true

                            transactionStatus.setRollbackOnly()

                            flash.testImportErrorMessage = g.message(code: 'default.import.error.test.initialDate.invalid', default: 'The record <strong>{0}</strong> of the file <strong>{1}</strong> has not the rigth format in the <strong>Initial date</strong> field.', args: ["${lineCounter+1}", "${csvFilename}"])
                        }

                        // Parsing end date field
                        try {
                            endDateInstance = new SimpleDateFormat('dd-MM-yyyy').parse(tokens[5].trim())

                            endDateValid = true

                        } catch (Exception e) {
                            log.error("TestController():uploadFileTest():endDate:formatInvalid:${tokens[5].trim()}")

                            endDateValid = false
                            back = true

                            transactionStatus.setRollbackOnly()

                            flash.testImportErrorMessage = g.message(code: 'default.import.error.test.endDate.invalid', default: 'The record <strong>{0}</strong> of the file <strong>{1}</strong> has not the rigth format in the <strong>End date</strong> field.', args: ["${lineCounter+1}", "${csvFilename}"])
                        }

                        // Obtaining topic
                        def topicInstance = Topic.findByName(tokens[8].trim())

                        // Checking the topic
                        if (topicInstance == null) {
                            log.error("TestController():uploadFileTest():topicInvalid:${tokens[8].trim()}")

                            topicValid = false
                            back = true

                            transactionStatus.setRollbackOnly()

                            flash.testImportErrorMessage = g.message(code: 'default.import.error.test.topic.invalid', default: 'The record <strong>{0}</strong> of the file <strong>{1}</strong> has not the rigth value ' +
                                    'in the <strong>Topic</strong> field.', args: ["${lineCounter+1}", "${csvFilename}"])
                        } else {
                            topicValid = true
                        }

                        // Obtaining catalog
                        def catalogInstance = Catalog.findByName(tokens[9].trim())

                        // Checking the catalog
                        if (catalogInstance == null) {
                            log.error("TestController():uploadFileTest():catalogInvalid:${tokens[9].trim()}")

                            catalogValid = false
                            back = true

                            transactionStatus.setRollbackOnly()

                            flash.testImportErrorMessage = g.message(code: 'default.import.error.test.catalog.invalid', default: 'The record <strong>{0}</strong> of the file <strong>{1}</strong> has not the rigth value ' +
                                    'in the <strong>Catalog</strong> field.', args: ["${lineCounter+1}", "${csvFilename}"])
                        } else {
                            catalogValid = true
                        }

                        if (topicValid && catalogValid && initDateValid && endDateValid) {

                            Test testInstance = new Test(
                                    name: tokens[0].trim(),
                                    description: tokens[1].trim(),
                                    active: tokens[2].trim(),
                                    numberOfQuestions: tokens[3].trim(),
                                    initDate: initDateInstance,
                                    endDate: endDateInstance,
                                    lockTime: tokens[6].trim(),
                                    maxAttempts: tokens[7].trim(),
                                    topic: topicInstance,
                                    catalog: catalogInstance,
                            )

                            def instanceCSV = customImportService.saveRecordCSVTest(testInstance) // It saves the record

                            // Error in save record CSV
                            if (!instanceCSV) {
                                log.error("TestController():uploadFileTest():errorSave:!instanceCSV")

                                transactionStatus.setRollbackOnly()

                                if (testInstance?.hasErrors()) {
                                    log.error("TestController():uploadFileTest():testInstanceCSV.hasErrors():validation")

                                    flash.testImportErrorMessage = g.message(code: 'default.import.hasErrors', default: 'Error in the validation of the record <strong>{0}</strong>. Check the validation rules of the entity.', args: ["${lineCounter + 1}"])

                                } else {
                                    log.error("TestController():uploadFileTest():testInstanceCSV:notSaved")

                                    flash.testImportErrorMessage = g.message(code: 'default.import.error.general', default: 'Error importing the <strong>{0}</strong> file.', args: ["${csvFilename}"])
                                }
                                back = true
                            }
                        }
                    }

                } else {
                    log.error("TestController():uploadFileTest():recordCSV!=numberColumns")

                    transactionStatus.setRollbackOnly()

                    flash.testImportErrorMessage = g.message(code: 'default.import.error.format', default: 'The file <strong>{0}</strong> contains records that has not the right format (number of columns).', args: ["${csvFilename}"])
                    back = true
                }

                if (back) {
                    throw new Exception()
                }
            } // Finish CsvReader

        } catch (Exception e) {
        }

        // Stop the last line with error
        if (back) {
            redirect uri: '/test/import'
            return
        }

        // Single header file
        if (lineCounter == 0) {
            log.error("TestController():uploadFileTest():lineCounter==0")

            flash.testImportErrorMessage = g.message(code: "default.import.error.lineCounter", default: "<strong>{0}</strong> file does not contain any record. It only contains the header.", args: ["${csvFilename}"])
            redirect uri: '/test/import'

        } else {

            if (existingFieldsList.size() == 0) { // Any previously existing record
                log.debug("TestController():uploadFileTest():lineCounter!=0:${lineCounter}recordsImported")

                flash.testImportMessage = g.message(code: "default.import.success", default: "<strong>{0}</strong> file has been imported correctly - Records imported: <strong>{1}</strong>.", args: ["${csvFilename}", "${lineCounter}"])

            } else if (lineCounter - existingFieldsList.size() == 0){ // Any record imported
                log.debug("TestController():uploadFileTest():lineCounter!=0:anyRecordImported")

                flash.testImportMessage = g.message(code: 'default.import.success.allRecords.exist', default: '<strong>{0}</strong> file has been processed correctly. However it has not imported any records because all previously ' +
                        'existed in the system. Total number of records in the file: <strong>{1}</strong>.', args: ["${csvFilename}", "${lineCounter}"])

            } else { // Some previously existing records
                log.debug("TestController():uploadFileTest():lineCounter!=0:${lineCounter}:numberExistingFields:${existingFieldsList.size()}")

                flash.testImportMessage = g.message(code: 'default.import.success.someRecords.exist', default: '<strong>{0}</strong> file has been imported correctly.<br/><ul><li><strong>Total number of records:</strong> {1}.</li>' +
                        '<li><strong>Number of imported records:</strong> {2}.</li><li><strong>Number of existing records:</strong> {3}.</li></ul>', args: ["${csvFilename}", "${lineCounter}", "${lineCounter - existingFieldsList.size()}", "${existingFieldsList.size()}"])
            }
            redirect uri: '/test/import'
        }
    }
}
