package Test

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import org.apache.tika.Tika
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Catalog controller.
 */
@Transactional(readOnly = true)
class CatalogController {

    def CustomDeleteService
    def CustomImportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", uploadFileCatalog: "POST"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all catalogs of the database.
     *
     * @param max Maximum number of catalogs to list.
     * @return Catalog Catalogs list with their information and number of catalogs in the database.
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

        respond Catalog.list(params)
    }

    /**
     * It creates a new catalog instance.
     *
     * @return return If the catalog instance is null or has errors.
     */
    def create() {
        respond new Catalog(params)
    }

    /**
     * It saves a catalog in database.
     *
     * @param catalogInstance It represents the catalog to save.
     * @return return If the catalog instance is null or has errors.
     */
    @Transactional
    def save(Catalog catalogInstance) {

        if (catalogInstance == null) {
            notFound()
            return
        }

        if (catalogInstance.hasErrors()) {
            respond catalogInstance.errors, view: 'create'
            return
        }

        try {
            // Save catalog data
            catalogInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.catalogMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    redirect view: 'index'
                }
                '*' { respond catalogInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("CatalogController():save():Exception:Catalog:${catalogInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.catalogErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    render view: "create", model: [catalogInstance: catalogInstance]
                }
            }
        }
    }

    /**
     * It edits a existing catalog with the new values of each field.
     *
     * @param catalogInstance It represents the catalog to edit.
     * @return catalogInstance It represents the catalog instance.
     */
    def edit(Catalog catalogInstance) {
        respond catalogInstance
    }

    /**
     * It updates a existing catalog in database.
     *
     * @param catalogInstance It represents the catalog information to update.
     * @return return If the catalog instance is null or has errors.
     */
    @Transactional
    def update(Catalog catalogInstance) {

        if (catalogInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (catalogInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                catalogInstance.clearErrors()
                catalogInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [catalogInstance.name] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond catalogInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!catalogInstance.validate()) {
            respond catalogInstance.errors, view:'edit'
            return
        }

        try {

            // Save catalog data
            catalogInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.catalogMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    redirect view: 'index'
                }
                '*' { respond catalogInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("CatalogController():update():Exception:Catalog:${catalogInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.catalogErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    render view: "edit", model: [catalogInstance: catalogInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing catalog in database.
     *
     * @param catalogInstance It represents the catalog information to delete.
     * @return return If the catalog instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Catalog catalogInstance) {

        if (catalogInstance == null) {
            notFound()
            return
        }

        try {

            // Delete the content associated (questions and answers) if checkbox is true
            if (params.delete_catalog) {
                customDeleteService.customDeleteCatalog(catalogInstance)
            }

            // Delete catalog
            catalogInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.catalogMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("CatalogController():delete():DataIntegrityViolationException:Catalog:${catalogInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.catalogErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the catalog instance was not found.
     */
    protected void notFound() {
        log.error("CatalogController():notFound():CatalogID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.catalogErrorMessage = g.message(code: 'default.not.found.catalog.message', default:'It has not been able to locate the catalog with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    /**
     * It checks the name availability.
     */
    def checkNameCatalogAvailibility () {

        def responseData

        if (Catalog.countByName(params.name)) { // Name found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'catalog.checkCatalogAvailibility.notAvailable', default:'Name of catalog is not available. Please, choose another one.')
            ]
        } else { // Name not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'catalog.checkCatalogAvailibility.available', default:'Name of catalog available.')
            ]
        }
        render responseData as JSON
    }

    /**
     * It shows the catalog import page.
     */
    def importCatalog () {
        log.debug("CatalogController():importCatalog()")

        render view: 'import'
    }

    /**
     * It processes the import functionality.
     */
    @Transactional
    def uploadFileCatalog () {
        log.debug("CatalogController():uploadFileCatalog()")

        // Record counter
        def lineCounter = 0
        def existingFieldsList = []
        def back = false

        // Obtaining number of fields in the entity - numberFields: TODO
        def numberFields = 0
        def totalNumberFields = 0
        grailsApplication.getDomainClass('Test.Catalog').persistentProperties.collect {
            numberFields ++
        }

        log.error(numberFields)

        // ID field (attribute) does not used TODO
        totalNumberFields = numberFields - 1
        log.debug("CatalogController():uploadFileCatalog():numberFieldsClass:${totalNumberFields}")

        // Obtain file
        def csvFileLoad = request.getFile("importFileCatalog")
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

        log.debug("CatalogController():uploadFileCatalog():contentTypeFile:${csvContentType}")

        // Check CSV type - Global
        if ((new Tika().detect(csvFilename) != grailsApplication.config.grails.mime.types.csv) || !(customImportService.checkExtension(csvFilename)))  {
            log.error("CatalogController():uploadFileCatalog():errorCSVContentType:contentType:${csvContentType}")

            flash.catalogImportErrorMessage = g.message(code: "default.import.error.csv", default: "<strong>{0}</strong> file has not the right format: <strong>.csv</strong>.", args: ["${csvFilename}"])
            redirect uri: '/catalog/import'
            return
        }

        // File empty
        if (csvFileLoad.isEmpty()) {
            log.error("CatalogController():uploadFileCatalog():csvFileLoad.isEmpty()")

            flash.catalogImportErrorMessage = g.message(code: "default.import.error.empty", default: "<strong>{0}</strong> file is empty.", args: ["${csvFilename}"])
            redirect uri: '/catalog/import'
            return
        }

        // Parse CSV file
        try {
            csvFileLoad.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8', 'skipLines': 1]).eachLine { tokens ->

                lineCounter++

                // Each row has 1 column (name). Length of the row
                if (tokens.length == totalNumberFields) {

                    // It checks the name because is an unique property TODO
                    if(Catalog.findByName(tokens[0].trim())){
                        log.error("CatalogController():uploadFileCatalog():toCsvReader():recordsExists")

                        existingFieldsList.push(lineCounter)

                    } else {
                        Catalog catalogInstance = new Catalog(
                                name: tokens[0].trim()
                        )

                        def instanceCSV = customImportService.saveRecordCSVCatalog(catalogInstance) // It saves the record

                        // Error in save record CSV
                        if (!instanceCSV) {
                            log.error("CatalogController():uploadFileCatalog():errorSave:!instanceCSV")

                            transactionStatus.setRollbackOnly()

                            if (catalogInstance?.hasErrors()) {
                                log.error("CatalogController():uploadFileCatalog():catalogInstanceCSV.hasErrors():validation")

                                flash.catalogImportErrorMessage = g.message(code: 'default.import.hasErrors', default: 'Error in the validation of the record <strong>{0}</strong>. Check the validation rules of the entity.', args: ["${lineCounter+1}"])

                            } else {
                                log.error("CatalogController():uploadFileCatalog():catalogInstanceCSV:notSaved")

                                flash.catalogImportErrorMessage = g.message(code: 'default.import.error.general', default: 'Error importing the <strong>{0}</strong> file.', args: ["${csvFilename}"])
                            }
                            back = true
                        }
                    }

                } else {
                    log.error("CatalogController():uploadFileCatalog():recordCSV!=numberColumns")

                    transactionStatus.setRollbackOnly()

                    flash.catalogImportErrorMessage = g.message(code: 'default.import.error.format', default: 'The file <strong>{0}</strong> contains records that has not the right format (number of columns).', args: ["${csvFilename}"])
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
            redirect uri: '/catalog/import'
            return
        }

        // Single header file
        if (lineCounter == 0) {
            log.error("CatalogController():uploadFileCatalog():lineCounter==0")

            flash.catalogImportErrorMessage = g.message(code: "default.import.error.lineCounter", default: "<strong>{0}</strong> file does not contain any record. It only contains the header.", args: ["${csvFilename}"])
            redirect uri: '/catalog/import'

        } else {

            if (existingFieldsList.size() == 0) { // Any previously existing record
                log.debug("CatalogController():uploadFileCatalog():lineCounter!=0:${lineCounter}recordsImported")

                flash.catalogImportMessage = g.message(code: "default.import.success", default: "<strong>{0}</strong> file has been imported correctly - Records imported: <strong>{1}</strong>.", args: ["${csvFilename}", "${lineCounter}"])

            } else if (lineCounter - existingFieldsList.size() == 0){ // Any record imported
                log.debug("CatalogController():uploadFileCatalog():lineCounter!=0:anyRecordImported")

                flash.catalogImportMessage = g.message(code: 'default.import.success.allRecords.exist', default: '<strong>{0}</strong> file has been processed correctly. However it has not imported any records because all previously ' +
                        'existed in the system. Total number of records in the file: <strong>{1}</strong>.', args: ["${csvFilename}", "${lineCounter}"])

            } else { // Some previously existing records
                log.debug("CatalogController():uploadFileCatalog():lineCounter!=0:${lineCounter}:numberExistingFields:${existingFieldsList.size()}")

                flash.catalogImportMessage = g.message(code: 'default.import.success.someRecords.exist', default: '<strong>{0}</strong> file has been imported correctly.<br/><ul><li><strong>Total number of records:</strong> {1}.</li>' +
                        '<li><strong>Number of imported records:</strong> {2}.</li><li><strong>Number of existing records:</strong> {3}.</li></ul>', args: ["${csvFilename}", "${lineCounter}", "${lineCounter - existingFieldsList.size()}", "${existingFieldsList.size()}"])
            }
            redirect uri: '/catalog/import'
        }
    }
}