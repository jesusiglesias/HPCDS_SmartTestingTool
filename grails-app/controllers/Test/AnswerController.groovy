package Test

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import org.apache.tika.Tika
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Answer controller.
 */
@Transactional(readOnly = true)
class AnswerController {

    def CustomDeleteService
    def CustomImportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", uploadFileAnswer: "POST"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all answers of the database.
     *
     * @param max Maximum number of answers to list.
     * @return Answer Answers list with their information and number of answers in the database.
     */
    def index(Integer max) {
        //params.max = Math.min(max ?: 10, 100)

        // Protecting againsts attack when max is a negative number. If is 0, max = defaultPag
        max = max ?: defaultPag.toInteger()
        // If max < 0, return all records (This is dangerous)
        if (max < 0) {
            max = defaultPag.toInteger()
        }
        params.max = Math.min(max, 100)

        respond Answer.list(params)
    }

    /**
     * It creates a new answer instance.
     *
     * @return return If the answer instance is null or has errors.
     */
    def create() {
        respond new Answer(params)
    }

    /**
     * It saves a answer in database.
     *
     * @param answerInstance It represents the answer to save.
     * @return return If the answer instance is null or has errors.
     */
    @Transactional
    def save(Answer answerInstance) {

        if (answerInstance == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFound()
            return
        }

        // If answer is incorrect, the score is 0
        if (!answerInstance.correct) {
            answerInstance.score = 0;
            answerInstance.save()
        }

        if (answerInstance.hasErrors()) {
            respond answerInstance.errors, view: 'create'
            return
        }

        try {
            // Save answer data
            answerInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.answerMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.titleAnswerKey])
                    redirect view: 'index'
                }
                '*' { respond answerInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("AnswerController():save():Exception:Answer:${answerInstance.titleAnswerKey}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.answerErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.titleAnswerKey])
                    render view: "create", model: [answerInstance: answerInstance]
                }
            }
        }
    }

    /**
     * It edits a existing answer with the new values of each field.
     *
     * @param answerInstance It represents the answer to edit.
     * @return answerInstance It represents the answer instance.
     */
    def edit(Answer answerInstance) {
        respond answerInstance
    }

    /**
     * It updates a existing answer in database.
     *
     * @param answerInstance It represents the answer information to update.
     * @return return If the answer instance is null or has errors.
     */
    @Transactional
    def update(Answer answerInstance) {

        if (answerInstance == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFound()
            return
        }

        // If answer is incorrect, the score is 0
        if (!answerInstance.correct) {
            answerInstance.score = 0;
            answerInstance.save()
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (answerInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                answerInstance.clearErrors()
                answerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [answerInstance.titleAnswerKey] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond answerInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!answerInstance.validate()) {
            respond answerInstance.errors, view:'edit'
            return
        }

        try {

            // Save answer data
            answerInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.answerMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.titleAnswerKey])
                    redirect view: 'index'
                }
                '*' { respond answerInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("AnswerController():update():Exception:Answer:${answerInstance.titleAnswerKey}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.answerErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.titleAnswerKey])
                    render view: "edit", model: [answerInstance: answerInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing answer in database.
     *
     * @param answerInstance It represents the answer information to delete.
     * @return return If the answer instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Answer answerInstance) {

        if (answerInstance == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFound()
            return
        }

        try {

            // Delete question or questions if checkbox is true
            if (params.delete_answer) {
                customDeleteService.customDeleteAnswer(answerInstance)
            }

            // Delete answer
            answerInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.answerMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.titleAnswerKey])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("AnswerController():delete():DataIntegrityViolationException:Answer:${answerInstance.titleAnswerKey}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.answerErrorMessage = g.message(code: 'default.not.deleted.message.answer', default: 'ERROR! {0} <strong>{1}</strong> was not deleted. First, you must delete or disassociate the question/s associated with the answer.', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.titleAnswerKey])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the answer instance was not found.
     */
    protected void notFound() {
        log.error("AnswerController():notFound():AnswerID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.answerErrorMessage = g.message(code: 'default.not.found.answer.message', default:'It has not been able to locate the answer with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    /**
     * It checks the answer key availability.
     */
    def checkKeyAnswerAvailibility () {

        def responseData

        if (Answer.countByTitleAnswerKey(params.answerKey)) { // Key found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'answer.checkKeyAvailibility.notAvailable', default:'Key of answer is not available. Please, choose another one.')
            ]
        } else { // Key not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'answer.checkKeyAvailibility.available', default:'Key of answer available.')
            ]
        }
        render responseData as JSON
    }

    /**
     * It shows the answer import page.
     */
    def importAnswer () {
        log.debug("AnswerController():importAnswer()")

        render view: 'import'
    }

    /**
     * It processes the import functionality.
     */
    @Transactional
    def uploadFileAnswer () {
        log.debug("AnswerController():uploadFileAnswer()")

        // Record counter
        def lineCounter = 0
        def existingFieldsList = []
        def back = false
        def score = 0

        // Obtaining number of fields in the entity - numberFields: 5
        def numberFields = 0
        def totalNumberFields = 0
        grailsApplication.getDomainClass('Test.Answer').persistentProperties.collect {
            numberFields ++
        }

        // ID field (attribute) does not used
        totalNumberFields = numberFields - 1
        log.debug("AnswerController():uploadFileAnswer():numberFieldsClass:${totalNumberFields}")

        // Obtain file
        def csvFileLoad = request.getFile("importFileAnswer")
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

        log.debug("AnswerController():uploadFileAnswer():contentTypeFile:${csvContentType}")

        // Check CSV type - Global
        if ((new Tika().detect(csvFilename) != grailsApplication.config.grails.mime.types.csv) || !(customImportService.checkExtension(csvFilename)))  {
            log.error("AnswerController():uploadFileAnswer():errorCSVContentType:contentType:${csvContentType}")

            flash.answerImportErrorMessage = g.message(code: "default.import.error.csv", default: "<strong>{0}</strong> file has not the right format: <strong>.csv</strong>.", args: ["${csvFilename}"])
            redirect uri: '/answer/import'
            return
        }

        // File empty
        if (csvFileLoad.isEmpty()) {
            log.error("AnswerController():uploadFileAnswer():csvFileLoad.isEmpty()")

            flash.answerImportErrorMessage = g.message(code: "default.import.error.empty", default: "<strong>{0}</strong> file is empty.", args: ["${csvFilename}"])
            redirect uri: '/answer/import'
            return
        }

        // Parse CSV file
        try {
            csvFileLoad.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8', 'skipLines': 1]).eachLine { tokens ->

                lineCounter++

                // Each row has 4 columns. Length of the row
                if (tokens.length == totalNumberFields) {

                    // It checks the name because is an unique property
                    if(Answer.findByTitleAnswerKey(tokens[0].trim())){
                        log.error("AnswerController():uploadFileAnswer():toCsvReader():recordsExists")

                        existingFieldsList.push(lineCounter)

                    } else {

                        // It checks if answer is correct or incorrect
                        if (tokens[2].trim() == 'true') {
                            score = tokens[3].trim()
                        } else {
                            score = 0
                        }

                        Answer answerInstance = new Answer(
                                titleAnswerKey: tokens[0].trim(),
                                description: tokens[1].trim(),
                                correct: tokens[2].trim(),
                                score: score
                        )

                        def instanceCSV = customImportService.saveRecordCSVAnswer(answerInstance) // It saves the record

                        // Error in save record CSV
                        if (!instanceCSV) {
                            log.error("AnswerController():uploadFileAnswer():errorSave:!instanceCSV")

                            transactionStatus.setRollbackOnly()

                            if (answerInstance?.hasErrors()) {
                                log.error("AnswerController():uploadFileAnswer():answerInstanceCSV.hasErrors():validation")

                                flash.answerImportErrorMessage = g.message(code: 'default.import.hasErrors', default: 'Error in the validation of the record <strong>{0}</strong>. Check the validation rules of the entity.', args: ["${lineCounter+1}"])

                            } else {
                                log.error("AnswerController():uploadFileAnswer():answerInstanceCSV:notSaved")

                                flash.answerImportErrorMessage = g.message(code: 'default.import.error.general', default: 'Error importing the <strong>{0}</strong> file.', args: ["${csvFilename}"])
                            }
                            back = true
                        }
                    }

                } else {
                    log.error("AnswerController():uploadFileAnswer():recordCSV!=numberColumns")

                    transactionStatus.setRollbackOnly()

                    flash.answerImportErrorMessage = g.message(code: 'default.import.error.format', default: 'The file <strong>{0}</strong> contains records that has not the right format (number of columns).', args: ["${csvFilename}"])
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
            redirect uri: '/answer/import'
            return
        }

        // Single header file
        if (lineCounter == 0) {
            log.error("AnswerController():uploadFileAnswer():lineCounter==0")

            flash.answerImportErrorMessage = g.message(code: "default.import.error.lineCounter", default: "<strong>{0}</strong> file does not contain any record. It only contains the header.", args: ["${csvFilename}"])
            redirect uri: '/answer/import'

        } else {

            if (existingFieldsList.size() == 0) { // Any previously existing record
                log.debug("AnswerController():uploadFileAnswer():lineCounter!=0:${lineCounter}recordsImported")

                flash.answerImportMessage = g.message(code: "default.import.success", default: "<strong>{0}</strong> file has been imported correctly - Records imported: <strong>{1}</strong>.", args: ["${csvFilename}", "${lineCounter}"])

            } else if (lineCounter - existingFieldsList.size() == 0){ // Any record imported
                log.debug("AnswerController():uploadFileAnswer():lineCounter!=0:anyRecordImported")

                flash.answerImportMessage = g.message(code: 'default.import.success.allRecords.exist', default: '<strong>{0}</strong> file has been processed correctly. However it has not imported any records because all previously ' +
                        'existed in the system. Total number of records in the file: <strong>{1}</strong>.', args: ["${csvFilename}", "${lineCounter}"])

            } else { // Some previously existing records
                log.debug("AnswerController():uploadFileAnswer():lineCounter!=0:${lineCounter}:numberExistingFields:${existingFieldsList.size()}")

                flash.answerImportMessage = g.message(code: 'default.import.success.someRecords.exist', default: '<strong>{0}</strong> file has been imported correctly.<br/><ul><li><strong>Total number of records:</strong> {1}.</li>' +
                        '<li><strong>Number of imported records:</strong> {2}.</li><li><strong>Number of existing records:</strong> {3}.</li></ul>', args: ["${csvFilename}", "${lineCounter}", "${lineCounter - existingFieldsList.size()}", "${existingFieldsList.size()}"])
            }
            redirect uri: '/answer/import'
        }
    }
}

