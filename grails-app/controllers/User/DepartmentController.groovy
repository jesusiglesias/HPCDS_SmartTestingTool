package User

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import org.apache.tika.Tika
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the department controller.
 */
@Transactional(readOnly = true)
class DepartmentController {

    def CustomDeleteService
    def CustomImportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", uploadFileDepartment: "POST"]

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

    /**
     * It shows the department import page.
     */
    def importDepartment () {
        log.debug("DepartmentController():importDepartment()")

        render view: 'import'
    }

    /**
     * It processes the import functionality.
     */
    @Transactional
    def uploadFileDepartment () {
        log.debug("DepartmentController():uploadFileDepartment()")

        // Record counter
        def lineCounter = 0
        def existingFieldsList = []
        def back = false

        // Obtaining number of fields in the entity
        def numberFields = 0
        def totalNumberFields = 0
        grailsApplication.getDomainClass('User.Department').persistentProperties.collect {
            numberFields ++
        }

        // ID fields (attribute) does not used
        totalNumberFields = numberFields - 1
        log.debug("DepartmentController():uploadFileDepartment():numberFieldsClass:${totalNumberFields}")

        // Obtain file
        def csvFileLoad = request.getFile("importFileDepartment")
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

        log.debug("DepartmentController():uploadFileDepartment():contentTypeFile:${csvContentType}")

        // Check CSV type - Global
        if ((new Tika().detect(csvFilename) != grailsApplication.config.grails.mime.types.csv) || !(customImportService.checkExtension(csvFilename)))  {
            log.error("DepartmentController():uploadFileDepartment():csvContentType!=CSV&&checkExtension!=CSV")

            flash.departmentImportErrorMessage = g.message(code: "default.import.error.csv", default: "<strong>{0}</strong> file has not the right format: <strong>\".csv\"</strong>.", args: ["${csvFilename}"])
            redirect uri: '/department/import'
            return
        }

        // File empty
        if (csvFileLoad.isEmpty()) {
            log.error("DepartmentController():uploadFileDepartment():csvFileLoad.isEmpty()")

            flash.departmentImportErrorMessage = g.message(code: "default.import.error.empty", default: "<strong>{0}</strong> file is empty.", args: ["${csvFilename}"])
            redirect uri: '/department/import'
            return
        }

        // Parse CSV file
        try {
            csvFileLoad.inputStream.text.toCsvReader(['separatorChar': ';', 'chartset': 'UTF-8', 'skipLines': 1]).eachLine { tokens ->

                lineCounter++

                // Each row has 1 column (name). Length of the row
                if (tokens.length == totalNumberFields) {

                    // It checks name because is unique
                    if(Department.findByName(tokens[0].trim())){
                        log.error("DepartmentController():uploadFileDepartment():toCsvReader():recordsExists")

                        existingFieldsList.push(lineCounter)

                    } else {
                        Department departmentInstace = new Department(
                                name: tokens[0].trim()
                        )

                        def instanceCSV = customImportService.saveRecordCSV(departmentInstace) // Assign "saveCSV" method to variable

                        // Error in save record CSV
                        if (!instanceCSV) {
                            log.error("DepartmentController():uploadFileDepartment():errorSave:!instanceCSV")

                            transactionStatus.setRollbackOnly()

                            if (departmentInstace?.hasErrors()) {
                                log.error("DepartmentController():uploadFileDepartment():!contactCSV.hasErrors():Validation")

                                flash.departmentImportErrorMessage = g.message(code: 'default.import.hasErrors', default: 'Error in the validation of the record <strong>{0}</strong>. Check the validation rules of the entity.', args: ["${lineCounter+1}"])

                            } else {
                                log.error("DepartmentController():uploadFileDepartment():!contactCSV.Error:NotSaved")

                                flash.departmentImportErrorMessage = g.message(code: 'default.import.error.general', default: 'Error importing the <strong>{0}</strong> file.', args: ["${csvFilename}"])
                            }
                            back = true
                        }
                    }

                } else {
                    log.error("DepartmentController():uploadFileDepartment():recordCSV!=totalNumberFields")

                    transactionStatus.setRollbackOnly()

                    flash.departmentImportErrorMessage = g.message(code: 'default.import.error.format', default: 'The file <strong>{0}</strong> contains records that has not the right format (number of columns).', args: ["${csvFilename}"])
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
            redirect uri: '/department/import'
            return
        }

        // Single header file
        if (lineCounter == 0) {
            log.error("DepartmentController():uploadFileDepartment():lineCounter==0")

            flash.departmentImportErrorMessage = g.message(code: "default.import.error.lineCounter", default: "<strong>{0}</strong> file does not contain any record. It only contains the header.", args: ["${csvFilename}"])
            redirect uri: '/department/import'

        } else {

            if (existingFieldsList.size() == 0) { // Any previously existing record
                log.debug("DepartmentController():uploadFileDepartment():lineCounter!=0:${lineCounter}recordsImported")

                flash.departmentImportMessage = g.message(code: "default.import.success", default: "<strong>{0}</strong> file has been imported correctly - Records imported: <strong>{1}</strong>.", args: ["${csvFilename}", "${lineCounter}"])

            } else if (lineCounter - existingFieldsList.size() == 0){ // Any record imported
                log.debug("DepartmentController():uploadFileDepartment():lineCounter!=0:anyRecordImported")

                flash.departmentImportMessage = g.message(code: 'default.import.success.allRecords.exist', default: '<strong>{0}</strong> file has been processed correctly. However it has not imported any records because all previously ' +
                        'existed in the system. Total number of records in the file: <strong>{1}</strong>.', args: ["${csvFilename}", "${lineCounter}"])

            } else { // Some previously existing records
                log.debug("DepartmentController():uploadFileDepartment():lineCounter!=0:${lineCounter}:numberExistingFields:${existingFieldsList.size()}")

                flash.departmentImportMessage = g.message(code: 'default.import.success.someRecords.exist', default: '<strong>{0}</strong> file has been imported correctly.<br/><ul><li><strong>Total number of records:</strong> {1}.</li>' +
                        '<li><strong>Number of imported records:</strong> {2}.</li><li><strong>Number of existing records:</strong> {3}.</li></ul>', args: ["${csvFilename}", "${lineCounter}", "${lineCounter - existingFieldsList.size()}", "${existingFieldsList.size()}"])
            }
            redirect uri: '/department/import'
        }
    }
}
