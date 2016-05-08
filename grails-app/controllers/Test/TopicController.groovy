package Test

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import org.apache.tika.Tika
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Topic controller.
 */
@Transactional(readOnly = true)
class TopicController {

    def CustomDeleteService
    def CustomImportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", uploadFileTopic: "POST"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all topics of the database.
     *
     * @param max Maximum number of topics to list.
     * @return Topic Topics list with their information and number of topics in the database.
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

        respond Topic.list(params)
    }

    /**
     * It creates a new topic instance.
     *
     * @return return If the topic instance is null or has errors.
     */
    def create() {
        respond new Topic(params)
    }

    /**
     * It saves a topic in database.
     *
     * @param topicInstance It represents the topic to save.
     * @return return If the topic instance is null or has errors.
     */
    @Transactional
    def save(Topic topicInstance) {

        if (topicInstance == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFound()
            return
        }

        if (topicInstance.hasErrors()) {
            respond topicInstance.errors, view:'create'
            return
        }

        try {
            // Save topic data
            topicInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.topicMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    redirect view: 'index'
                }
                '*' { respond topicInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("TopicController():save():Exception:Topic:${topicInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.topicErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    render view: "create", model: [topicInstance: topicInstance]
                }
            }
        }
    }

    /**
     * It edits a existing topic with the new values of each field.
     *
     * @param topicInstance It represents the topic to edit.
     * @return topicInstance It represents the topic instance.
     */
    def edit(Topic topicInstance) {
        respond topicInstance
    }

    /**
     * It updates a existing topic in database.
     *
     * @param topicInstance It represents the topic information to update.
     * @return return If the topic instance is null or has errors.
     */
    @Transactional
    def update(Topic topicInstance) {

        if (topicInstance == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (topicInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                topicInstance.clearErrors()
                topicInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [topicInstance.name] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond topicInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!topicInstance.validate()) {
            respond topicInstance.errors, view:'edit'
            return
        }

        try {

            // Save topic data
            topicInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.topicMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    redirect view: 'index'
                }
                '*' { respond topicInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("TopicController():update():Exception:Topic:${topicInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.topicErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    render view: "edit", model: [topicInstance: topicInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing topic in database.
     *
     * @param topicInstance It represents the topic information to delete.
     * @return return If the topic instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Topic topicInstance) {

        if (topicInstance == null) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFound()
            return
        }

        try {

            // Delete the content associated (catalogs, questions and answers) if checkbox is true
            if (params.delete_topic) {
                customDeleteService.customDeleteTopic(topicInstance)
            } else {
                // Delete topic
                topicInstance.delete(flush:true, failOnError: true)
            }

            request.withFormat {
                form multipartForm {
                    flash.topicMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("TopicController():delete():DataIntegrityViolationException:Topic:${topicInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.topicErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'admin.label', default: 'Administrator'), topicInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the topic instance was not found.
     */
    protected void notFound() {
        log.error("TopicController():notFound():TopicID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.topicErrorMessage = g.message(code: 'default.not.found.topic.message', default:'It has not been able to locate the topic with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    /**
     * It checks the name availability.
     */
    def checkNameTopicAvailibility () {

        def responseData

        if (Topic.countByName(params.name)) { // Name found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'department.checkTopicAvailibility.notAvailable', default:'Name of topic is not available. Please, choose another one.')
            ]
        } else { // Name not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'department.checkTopicAvailibility.available', default:'Name of topic available.')
            ]
        }
        render responseData as JSON
    }

    /**
     * It shows the topic import page.
     */
    def importTopic () {
        log.debug("TopicController():importTopic()")

        render view: 'import'
    }

    /**
     * It processes the import functionality.
     */
    @Transactional
    def uploadFileTopic () {
        log.debug("TopicController():uploadFileTopic()")

        // Record counter
        def lineCounter = 0
        def existingFieldsList = []
        def back = false

        // Obtaining number of fields in the entity - numberFields: 4
        def numberFields = 0
        def totalNumberFields = 0
        grailsApplication.getDomainClass('Test.Topic').persistentProperties.collect {
            numberFields ++
        }

        // ID field (attribute) does not used
        totalNumberFields = numberFields - 1
        log.debug("TopicController():uploadFileTopic():numberFieldsClass:${totalNumberFields}")

        // Obtain file
        def csvFileLoad = request.getFile("importFileTopic")
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

        log.debug("TopicController():uploadFileTopic():contentTypeFile:${csvContentType}")

        // Check CSV type - Global
        if ((new Tika().detect(csvFilename) != grailsApplication.config.grails.mime.types.csv) || !(customImportService.checkExtension(csvFilename)))  {
            log.error("TopicController():uploadFileTopic():errorCSVContentType:contentType:${csvContentType}")

            flash.topicImportErrorMessage = g.message(code: "default.import.error.csv", default: "<strong>{0}</strong> file has not the right format: <strong>.csv</strong>.", args: ["${csvFilename}"])
            redirect uri: '/topic/import'
            return
        }

        // File empty
        if (csvFileLoad.isEmpty()) {
            log.error("TopicController():uploadFileTopic():csvFileLoad.isEmpty()")

            flash.topicImportErrorMessage = g.message(code: "default.import.error.empty", default: "<strong>{0}</strong> file is empty.", args: ["${csvFilename}"])
            redirect uri: '/topic/import'
            return
        }

        // Parse CSV file
        try {
            csvFileLoad.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8', 'skipLines': 1]).eachLine { tokens ->

                lineCounter++

                // Each row has 3 columns (name, description and visibility). Length of the row
                if (tokens.length == totalNumberFields) {

                    // It checks the name because is an unique property
                    if(Topic.findByName(tokens[0].trim())){
                        log.error("TopicController():uploadFileTopic():toCsvReader():recordsExists")

                        existingFieldsList.push(lineCounter)

                    } else {
                        Topic topicInstance = new Topic(
                                name: tokens[0].trim(),
                                description: tokens[1].trim(),
                                visibility: tokens[2].trim()
                        )

                        def instanceCSV = customImportService.saveRecordCSVTopic(topicInstance) // It saves the record

                        // Error in save record CSV
                        if (!instanceCSV) {
                            log.error("TopicController():uploadFileTopic():errorSave:!instanceCSV")

                            transactionStatus.setRollbackOnly()

                            if (topicInstance?.hasErrors()) {
                                log.error("TopicController():uploadFileTopic():topicInstanceCSV.hasErrors():validation")

                                flash.topicImportErrorMessage = g.message(code: 'default.import.hasErrors', default: 'Error in the validation of the record <strong>{0}</strong>. Check the validation rules of the entity.', args: ["${lineCounter+1}"])

                            } else {
                                log.error("TopicController():uploadFileTopic():topicInstanceCSV:notSaved")

                                flash.topicImportErrorMessage = g.message(code: 'default.import.error.general', default: 'Error importing the <strong>{0}</strong> file.', args: ["${csvFilename}"])
                            }
                            back = true
                        }
                    }

                } else {
                    log.error("TopicController():uploadFileTopic():recordCSV!=numberColumns")

                    transactionStatus.setRollbackOnly()

                    flash.topicImportErrorMessage = g.message(code: 'default.import.error.format', default: 'The file <strong>{0}</strong> contains records that has not the right format (number of columns).', args: ["${csvFilename}"])
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
            redirect uri: '/topic/import'
            return
        }

        // Single header file
        if (lineCounter == 0) {
            log.error("TopicController():uploadFileTopic():lineCounter==0")

            flash.topicImportErrorMessage = g.message(code: "default.import.error.lineCounter", default: "<strong>{0}</strong> file does not contain any record. It only contains the header.", args: ["${csvFilename}"])
            redirect uri: '/topic/import'

        } else {

            if (existingFieldsList.size() == 0) { // Any previously existing record
                log.debug("TopicController():uploadFileTopic():lineCounter!=0:${lineCounter}recordsImported")

                flash.topicImportMessage = g.message(code: "default.import.success", default: "<strong>{0}</strong> file has been imported correctly - Records imported: <strong>{1}</strong>.", args: ["${csvFilename}", "${lineCounter}"])

            } else if (lineCounter - existingFieldsList.size() == 0){ // Any record imported
                log.debug("TopicController():uploadFileTopic():lineCounter!=0:anyRecordImported")

                flash.topicImportMessage = g.message(code: 'default.import.success.allRecords.exist', default: '<strong>{0}</strong> file has been processed correctly. However it has not imported any records because all previously ' +
                        'existed in the system. Total number of records in the file: <strong>{1}</strong>.', args: ["${csvFilename}", "${lineCounter}"])

            } else { // Some previously existing records
                log.debug("TopicController():uploadFileTopic():lineCounter!=0:${lineCounter}:numberExistingFields:${existingFieldsList.size()}")

                flash.topicImportMessage = g.message(code: 'default.import.success.someRecords.exist', default: '<strong>{0}</strong> file has been imported correctly.<br/><ul><li><strong>Total number of records:</strong> {1}.</li>' +
                        '<li><strong>Number of imported records:</strong> {2}.</li><li><strong>Number of existing records:</strong> {3}.</li></ul>', args: ["${csvFilename}", "${lineCounter}", "${lineCounter - existingFieldsList.size()}", "${existingFieldsList.size()}"])
            }
            redirect uri: '/topic/import'
        }
    }
}
