package Test

import grails.converters.JSON
import org.apache.tika.Tika
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Question controller.
 */
@Transactional(readOnly = true)
class QuestionController {

    def CustomDeleteService
    def CustomImportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", uploadFileQuestion: "POST"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all questions of the database.
     *
     * @param max Maximum number of questions to list.
     * @return Question Questions list with their information and number of questions in the database.
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

        respond Question.list(params)
    }

    /**
     * It creates a new question instance.
     *
     * @return return If the question instance is null or has errors.
     */
    def create() {
        respond new Question(params)
    }

    /**
     * It saves a question in database.
     *
     * @param questionInstance It represents the question to save.
     * @return return If the question instance is null or has errors.
     */
    @Transactional
    def save(Question questionInstance) {

        if (questionInstance == null) {
            notFound()
            return
        }

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'create'
            return
        }

        try {
            // Save question data
            questionInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.questionMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'question.label', default: 'Question'), questionInstance.titleQuestionKey])
                    redirect view: 'index'
                }
                '*' { respond questionInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("QuestionController():save():Exception:Question:${questionInstance.titleQuestionKey}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.questionErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'question.label', default: 'Question'), questionInstance.titleQuestionKey])
                    render view: "create", model: [questionInstance: questionInstance]
                }
            }
        }
    }

    /**
     * It edits a existing question with the new values of each field.
     *
     * @param questionInstance It represents the question to edit.
     * @return questionInstance It represents the question instance.
     */
    def edit(Question questionInstance) {
        respond questionInstance
    }

    /**
     * It updates a existing question in database.
     *
     * @param questionInstance It represents the question information to update.
     * @return return If the question instance is null or has errors.
     */
    @Transactional
    def update(Question questionInstance) {

        if (questionInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (questionInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                questionInstance.clearErrors()
                questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [questionInstance.titleQuestionKey] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond questionInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!questionInstance.validate()) {
            respond questionInstance.errors, view:'edit'
            return
        }

        try {

            // Save question data
            questionInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.questionMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'question.label', default: 'Question'), questionInstance.titleQuestionKey])
                    redirect view: 'index'
                }
                '*' { respond questionInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("QuestionController():update():Exception:Question:${questionInstance.titleQuestionKey}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.questionErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'question.label', default: 'Question'), questionInstance.titleQuestionKey])
                    render view: "edit", model: [questionInstance: questionInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing question in database.
     *
     * @param questionInstance It represents the question information to delete.
     * @return return If the question instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Question questionInstance) {

        if (questionInstance == null) {
            notFound()
            return
        }

        try {

            // Delete the relation with catalog if checkbox is true
            if (params.delete_question) {
                customDeleteService.customDeleteQuestion(questionInstance)
            }

            // Delete question or questions if checkbox is true
            if (params.delete_question_answer) {
                customDeleteService.customDeleteQuestionAnswer(questionInstance)
            }

            // Delete question
            questionInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.questionMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'question.label', default: 'Question'), questionInstance.titleQuestionKey])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("QuestionController():delete():DataIntegrityViolationException:Question:${questionInstance.titleQuestionKey}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.questionErrorMessage = g.message(code: 'default.not.deleted.message.question', default: 'ERROR! {0} <strong>{1}</strong> was not deleted. First, you must delete the catalog or catalogs associated with the question. ' +
                            '', args: [message(code: 'question.label', default: 'Question'), questionInstance.titleQuestionKey])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the question instance was not found.
     */
    protected void notFound() {
        log.error("QuestionController():notFound():QuestionID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.questionErrorMessage = g.message(code: 'default.not.found.question.message', default:'It has not been able to locate the question with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    /**
     * It checks the question key availability.
     */
    def checkKeyQuestionAvailibility () {

        def responseData

        if (Question.countBytitleQuestionKey(params.questionKey)) { // Key found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'question.checkKeyAvailibility.notAvailable', default:'Key of question is not available. Please, choose another one.')
            ]
        } else { // Key not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'question.checkKeyAvailibility.available', default:'Key of question available.')
            ]
        }
        render responseData as JSON
    }

    /**
     * It shows the question import page.
     */
    def importQuestion () {
        log.debug("QuestionController():importQuestion()")

        render view: 'import'
    }

    /**
     * It processes the import functionality.
     */
    @Transactional
    def uploadFileQuestion () {
        log.debug("QuestionController():uploadFileQuestion()")

        // Record counter
        def lineCounter = 0
        def existingFieldsList = []
        def back = false

        // Obtaining number of fields in the entity - numberFields: TODO
        def numberFields = 0
        def totalNumberFields = 0
        grailsApplication.getDomainClass('Test.Question').persistentProperties.collect {
            numberFields ++
        }

        log.error(numberFields)

        // ID field (attribute) does not used TODO
        totalNumberFields = numberFields - 1
        log.debug("QuestionController():uploadFileQuestion():numberFieldsClass:${totalNumberFields}")

        // Obtain file
        def csvFileLoad = request.getFile("importFileQuestion")
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

        log.debug("QuestionController():uploadFileQuestion():contentTypeFile:${csvContentType}")

        // Check CSV type - Global
        if ((new Tika().detect(csvFilename) != grailsApplication.config.grails.mime.types.csv) || !(customImportService.checkExtension(csvFilename)))  {
            log.error("QuestionController():uploadFileQuestion():errorCSVContentType:contentType:${csvContentType}")

            flash.questionImportErrorMessage = g.message(code: "default.import.error.csv", default: "<strong>{0}</strong> file has not the right format: <strong>.csv</strong>.", args: ["${csvFilename}"])
            redirect uri: '/question/import'
            return
        }

        // File empty
        if (csvFileLoad.isEmpty()) {
            log.error("QuestionController():uploadFileQuestion():csvFileLoad.isEmpty()")

            flash.questionImportErrorMessage = g.message(code: "default.import.error.empty", default: "<strong>{0}</strong> file is empty.", args: ["${csvFilename}"])
            redirect uri: '/question/import'
            return
        }

        // Parse CSV file
        try {
            csvFileLoad.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8', 'skipLines': 1]).eachLine { tokens ->

                lineCounter++

                // Each row has 1 column (name). Length of the row
                if (tokens.length == totalNumberFields) {

                    // It checks the name because is an unique property TODO
                    if(Question.findByName(tokens[0].trim())){
                        log.error("QuestionController():uploadFileQuestion():toCsvReader():recordsExists")

                        existingFieldsList.push(lineCounter)

                    } else {
                        Test questionInstance = new Question(
                                name: tokens[0].trim()
                        )

                        def instanceCSV = customImportService.saveRecordCSVQuestion(questionInstance) // It saves the record

                        // Error in save record CSV
                        if (!instanceCSV) {
                            log.error("QuestionController():uploadFileQuestion():errorSave:!instanceCSV")

                            transactionStatus.setRollbackOnly()

                            if (questionInstance?.hasErrors()) {
                                log.error("QuestionController():uploadFileQuestion():testInstanceCSV.hasErrors():validation")

                                flash.questionImportErrorMessage = g.message(code: 'default.import.hasErrors', default: 'Error in the validation of the record <strong>{0}</strong>. Check the validation rules of the entity.', args: ["${lineCounter+1}"])

                            } else {
                                log.error("QuestionController():uploadFileQuestion():testInstanceCSV:notSaved")

                                flash.questionImportErrorMessage = g.message(code: 'default.import.error.general', default: 'Error importing the <strong>{0}</strong> file.', args: ["${csvFilename}"])
                            }
                            back = true
                        }
                    }

                } else {
                    log.error("QuestionController():uploadFileQuestion():recordCSV!=numberColumns")

                    transactionStatus.setRollbackOnly()

                    flash.questionImportErrorMessage = g.message(code: 'default.import.error.format', default: 'The file <strong>{0}</strong> contains records that has not the right format (number of columns).', args: ["${csvFilename}"])
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
            redirect uri: '/question/import'
            return
        }

        // Single header file
        if (lineCounter == 0) {
            log.error("QuestionController():uploadFileQuestion():lineCounter==0")

            flash.questionImportErrorMessage = g.message(code: "default.import.error.lineCounter", default: "<strong>{0}</strong> file does not contain any record. It only contains the header.", args: ["${csvFilename}"])
            redirect uri: '/question/import'

        } else {

            if (existingFieldsList.size() == 0) { // Any previously existing record
                log.debug("QuestionController():uploadFileQuestion():lineCounter!=0:${lineCounter}recordsImported")

                flash.questionImportMessage = g.message(code: "default.import.success", default: "<strong>{0}</strong> file has been imported correctly - Records imported: <strong>{1}</strong>.", args: ["${csvFilename}", "${lineCounter}"])

            } else if (lineCounter - existingFieldsList.size() == 0){ // Any record imported
                log.debug("QuestionController():uploadFileQuestion():lineCounter!=0:anyRecordImported")

                flash.questionImportMessage = g.message(code: 'default.import.success.allRecords.exist', default: '<strong>{0}</strong> file has been processed correctly. However it has not imported any records because all previously ' +
                        'existed in the system. Total number of records in the file: <strong>{1}</strong>.', args: ["${csvFilename}", "${lineCounter}"])

            } else { // Some previously existing records
                log.debug("QuestionController():uploadFileQuestion():lineCounter!=0:${lineCounter}:numberExistingFields:${existingFieldsList.size()}")

                flash.questionImportMessage = g.message(code: 'default.import.success.someRecords.exist', default: '<strong>{0}</strong> file has been imported correctly.<br/><ul><li><strong>Total number of records:</strong> {1}.</li>' +
                        '<li><strong>Number of imported records:</strong> {2}.</li><li><strong>Number of existing records:</strong> {3}.</li></ul>', args: ["${csvFilename}", "${lineCounter}", "${lineCounter - existingFieldsList.size()}", "${existingFieldsList.size()}"])
            }
            redirect uri: '/question/import'
        }
    }
}