package User

import Enumerations.Sex
import Security.SecRole
import Security.SecUserSecRole
import org.apache.tika.Tika
import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import static org.springframework.http.HttpStatus.*
import static grails.async.Promises.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the User controller.
 */
@Transactional(readOnly = true)
class UserController {

    def CustomImportService

    static allowedMethods = [save: "POST", update: "PUT", updateProfileImage: 'POST', delete: "DELETE", uploadFileUser: "POST"]

    // Mime-types allowed in image
    private static final contentsType = ['image/png', 'image/jpeg', 'image/gif']

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all normal users of the database.
     *
     * @param max Maximum number of normal users to list.
     * @return Users Users list with their information and number of normal users in the database.
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

        respond User.list(params)
    }

    /**
     * It creates a new user instance.
     *
     * @return return If the user instance is null or has errors.
     */
    def create() {
        respond new User(params)
    }

    /**
     * It saves a normal user in database.
     *
     * @param userInstance It represents the normal user to save.
     * @return return If the user instance is null or has errors.
     */
    @Transactional
    def save(User userInstance) {

        if (params.birthDate != "") {

            // Parse birthDate from textField
            def birthDateFormat = new SimpleDateFormat('dd-MM-yyyy').parse(params.birthDate)
            userInstance.birthDate = birthDateFormat
        }

        if (userInstance == null) {
            notFound()
            return
        }

        // Get the avatar file from the multi-part request
        def filename = request.getFile('avatar')

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view: 'create'
            return
        }

        // Check if password and confirm password fields are same
        if (userInstance.password != userInstance.confirmPassword) {
            flash.userErrorMessage = g.message(code: 'default.password.notsame', default: '<strong>Password</strong> and <strong>Confirm password</strong> fields must match.')
            render view: "create", model: [userInstance: userInstance]
            return
        }

        // Check if password and username are same
        if (userInstance.password.toLowerCase() == userInstance.username.toLowerCase()) {
            flash.userErrorMessage = g.message(code: 'default.password.username', default: '<strong>Password</strong> field must not be equal to username.')
            render view: "create", model: [userInstance: userInstance]
            return
        }

        // It checks that mime-types is correct: ['image/png', 'image/jpeg', 'image/gif']
        if (!filename.empty && !contentsType.contains(filename.getContentType())) {
            flash.userErrorMessage = g.message(code: 'default.validation.mimeType.image', default: 'The profile image must be of type: <strong>.png</strong>, <strong>.jpeg</strong> or <strong>.gif</strong>.')
            render  view: "create", model: [userInstance: userInstance]
            return
        }

        try {

            // Save the image and mime type
            if (!filename.empty) {
                log.debug("SecUserController():save():ImageProfileUploaded:${filename.name}")

                userInstance.avatar = filename.bytes
                userInstance.avatarType = filename.contentType
            } else {
                userInstance.avatar = null
                userInstance.avatarType = null
            }

            // Save user data
            userInstance.save(flush: true, failOnError: true)

            // Obtain user role - Asynchronous/Multi-thread
            def normalRole = SecRole.async.findByAuthority("ROLE_USER")

            def resultRole = waitAll(normalRole)

            // Save relation with normal user role
            SecUserSecRole.create userInstance, resultRole.getAt(0), true

            request.withFormat {
                form multipartForm {
                    flash.userMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    redirect view: 'index'
                }
                '*' { respond userInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("UserController():save():Exception:NormalUser:${userInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    render view: "create", model: [userInstance: userInstance]
                }
            }
        }
    }

    /**
     * It edits a existing normal user with the new values of each field.
     *
     * @param userInstance It represents the normal user to edit.
     * @return userInstance It represents the user instance.
     */
    def edit(User userInstance) {
        respond userInstance
    }

    /**
     * It updates a existing normal user in database.
     *
     * @param userInstance It represents the normal user information to update.
     * @return return If the user instance is null or has errors.
     */
    @Transactional
    def update(User userInstance) {

        if (params.birthDate != "") {

            // Parse birthDate from textField
            def birthDateFormat = new SimpleDateFormat('dd-MM-yyyy').parse(params.birthDate)
            userInstance.birthDate = birthDateFormat
        }

        if (userInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (userInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                userInstance.clearErrors()
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [userInstance.username] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond userInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!userInstance.validate()) {
            respond userInstance.errors, view:'edit'
            return
        }

        try {

            // Save user data
            userInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    redirect view: 'index'
                }
                '*' { respond userInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("UserController():update():Exception:NormalUser:${userInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    render view: "edit", model: [userInstance: userInstance]
                }
            }
        }
    }

    /**
     * It edits the profile image of an existing normal user.
     *
     * @param userInstance It represents the normal user to edit.
     * @return userInstance It represents the user instance.
     */
    def editProfileImage(User userInstance) {
        respond userInstance
    }

    /**
     * It updates the profile image of an existing normal user in database.
     *
     * @param userInstance It represents the normal user information to update.
     * @return return If the user instance is null or has errors.
     */
    @Transactional
    def updateProfileImage(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (userInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                userInstance.clearErrors()
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [userInstance.username] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond userInstance.errors, view:'editProfileImage'
                return
            }
        }

        // Get the avatar file from the multi-part request
        def filename = request.getFile('avatar')

        // Validate the instance
        if (!userInstance.validate()) {
            respond userInstance.errors, view:'editProfileImage'
            return
        }

        // It checks that mime-types is correct: ['image/png', 'image/jpeg', 'image/gif']
        if (!filename.empty && !contentsType.contains(filename.getContentType())) {
            flash.userErrorMessage = g.message(code: 'default.validation.mimeType.image', default: 'The profile image must be of type: <strong>.png</strong>, <strong>.jpeg</strong> or <strong>.gif</strong>.')
            render  view: "editProfileImage", model: [userInstance: userInstance]
            return
        }

        try {

            // Update the image and mime type
            userInstance.avatar = filename.bytes
            userInstance.avatarType = filename.contentType

            // Update data
            userInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    redirect view: 'index'
                }
                '*' { respond userInstance, [status: OK] }
            }

        } catch (Exception exception) {
            log.error("UserController():update():Exception:NormalUser:${userInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    render view: "editProfileImage", model: [userInstance: userInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing normal user in database.
     *
     * @param userInstance It represents the normal user information to delete.
     * @return return If the user instance is null, the notFound function is called.
     */
    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        try {

            // Delete SecUserSecRole relations
            SecUserSecRole.findAllBySecUser(userInstance)*.delete(flush: true, failOnError: true)

            // Delete user
            userInstance.delete(flush: true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("UserController():delete():DataIntegrityViolationException:NormalUser:${userInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the user instance was not found.
     */
    protected void notFound() {
        log.error("UserController():notFound():NormalUserID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.userErrorMessage = g.message(code: 'default.not.found.user.message', default:'It has not been able to locate the user with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    /**
     * It shows the user import page.
     */
    def importUser () {
        log.debug("UserController():importUser()")

        render view: 'import'
    }

    /**
     * It processes the import functionality.
     */
    @Transactional
    def uploadFileUser () {
        log.debug("UserController():uploadFileUser()")

        // Record counter
        def lineCounter = 0
        def existingFieldsList = []
        def back = false
        def sexValue, sexValid = false, birthDateValid = false, departmentValid = false
        def birthDateInstance

        // Obtaining number of fields in the entity - numberFields: 20
        def numberFields = 0
        def totalNumberFields = 0
        grailsApplication.getDomainClass('User.User').persistentProperties.collect {
            numberFields ++
        }

        // Several fields (attributes) does not used
        totalNumberFields = numberFields - 4
        log.debug("UserController():uploadFileUser():numberFieldsClass:${totalNumberFields}")

        // Obtain file
        def csvFileLoad = request.getFile("importFileUser")
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

        log.debug("UserController():uploadFileUser():contentTypeFile:${csvContentType}")

        // Check CSV type - Global
        if ((new Tika().detect(csvFilename) != grailsApplication.config.grails.mime.types.csv) || !(customImportService.checkExtension(csvFilename)))  {
            log.error("UserController():uploadFileUser():errorCSVContentType:contentType:${csvContentType}")

            flash.userImportErrorMessage = g.message(code: "default.import.error.csv", default: "<strong>{0}</strong> file has not the right format: <strong>.csv</strong>.", args: ["${csvFilename}"])
            redirect uri: '/user/import'
            return
        }

        // File empty
        if (csvFileLoad.isEmpty()) {
            log.error("UserController():uploadFileUser():csvFileLoad.isEmpty()")

            flash.userImportErrorMessage = g.message(code: "default.import.error.empty", default: "<strong>{0}</strong> file is empty.", args: ["${csvFilename}"])
            redirect uri: '/user/import'
            return
        }

        // Parse CSV file
        try {
            csvFileLoad.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8', 'skipLines': 1]).eachLine { tokens ->

                lineCounter++

                // Each row has 1 column (name). Length of the row
                if (tokens.length == totalNumberFields) {

                    // It checks the username and email because are unique properties
                    if(User.findByUsernameOrEmail(tokens[0].trim(), tokens[1].trim())) {
                        log.error("UserController():uploadFileUser():toCsvReader():recordsExists")

                        existingFieldsList.push(lineCounter)

                    } else {

                        // Parsing birthdate field
                        try {
                            birthDateInstance = new SimpleDateFormat('dd-MM-yyyy').parse(tokens[9].trim())

                            birthDateValid = true

                        } catch (Exception e) {
                            log.error("UserController():uploadFileUser():birthdate:formatInvalid:${tokens[9].trim()}")

                            birthDateValid = false
                            back = true

                            transactionStatus.setRollbackOnly()

                            flash.userImportErrorMessage = g.message(code: 'default.import.error.user.birthdate.invalid', default: 'The record <strong>{0}</strong> of the file <strong>{1}</strong> has not the rigth format in the <strong>Birthdate</strong> field.', args: ["${lineCounter+1}", "${csvFilename}"])
                        }

                        // Parsing the sex field
                        if (tokens[14].trim() == 'Masculino' || tokens[14].trim() == 'Male') {
                            sexValue = Sex.MALE
                            sexValid = true
                        } else if (tokens[14].trim() == 'Femenino' || tokens[14].trim() == 'Female') {
                            sexValue = Sex.FEMALE
                            sexValid = true
                        } else { // Sex value invalid
                            log.error("UserController():uploadFileUser():sexInvalid:${tokens[14].trim()}")

                            sexValid = false
                            back = true

                            transactionStatus.setRollbackOnly()

                            flash.userImportErrorMessage = g.message(code: 'default.import.error.user.sex.invalid', default: 'The record <strong>{0}</strong> of the file <strong>{1}</strong> has not the rigth value in the <strong>Sex</strong> field.', args: ["${lineCounter+1}", "${csvFilename}"])
                        }

                        // Obtaining department
                        def departmentInstance = Department.findByName(tokens[15].trim())

                        // Checking the department
                        if (departmentInstance == null) {
                            log.error("UserController():uploadFileUser():departmentInvalid:${tokens[15].trim()}")

                            departmentValid = false
                            back = true

                            transactionStatus.setRollbackOnly()

                            flash.userImportErrorMessage = g.message(code: 'default.import.error.user.department.invalid', default: 'The record <strong>{0}</strong> of the file <strong>{1}</strong> has not the rigth value ' +
                                    'in the <strong>Department</strong> field.', args: ["${lineCounter+1}", "${csvFilename}"])
                        } else {
                            departmentValid = true
                        }

                        if (sexValid && birthDateValid && departmentValid) {

                            User userInstance = new User(
                                    username: tokens[0].trim(),
                                    email: tokens[1].trim(),
                                    password: tokens[2].trim(),
                                    enabled: tokens[3].trim(),
                                    accountLocked: tokens[4].trim(),
                                    accountExpired: tokens[5].trim(),
                                    passwordExpired: tokens[6].trim(),
                                    name: tokens[7].trim(),
                                    surname: tokens[8].trim(),
                                    birthDate: birthDateInstance,
                                    address: tokens[10].trim(),
                                    city: tokens[11].trim(),
                                    country: tokens[12].trim(),
                                    phone: tokens[13].trim(),
                                    sex: sexValue,
                                    department: departmentInstance,
                            )


                            def instanceCSV = customImportService.saveRecordCSVUser(userInstance) // It saves the record

                            // Error in save record CSV
                            if (!instanceCSV) {
                                log.error("UserController():uploadFileUser():errorSave:!instanceCSV")

                                transactionStatus.setRollbackOnly()

                                if (userInstance?.hasErrors()) {
                                    log.error("UserController():uploadFileUser():userInstanceCSV.hasErrors():validation")

                                    flash.userImportErrorMessage = g.message(code: 'default.import.hasErrors', default: 'Error in the validation of the record <strong>{0}</strong>. Check the validation rules of the entity.', args: ["${lineCounter+1}"])

                                } else {
                                    log.error("UserController():uploadFileUser():userInstanceCSV:notSaved")

                                    flash.userImportErrorMessage = g.message(code: 'default.import.error.general', default: 'Error importing the <strong>{0}</strong> file.', args: ["${csvFilename}"])
                                }
                                back = true
                            }
                        }
                    }

                } else {
                    log.error("UserController():uploadFileUser():recordCSV!=numberColumns")

                    transactionStatus.setRollbackOnly()

                    flash.userImportErrorMessage = g.message(code: 'default.import.error.format', default: 'The file <strong>{0}</strong> contains records that has not the right format (number of columns).', args: ["${csvFilename}"])
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
            redirect uri: '/user/import'
            return
        }

        // Single header file
        if (lineCounter == 0) {
            log.error("UserController():uploadFileUser():lineCounter==0")

            flash.userImportErrorMessage = g.message(code: "default.import.error.lineCounter", default: "<strong>{0}</strong> file does not contain any record. It only contains the header.", args: ["${csvFilename}"])
            redirect uri: '/user/import'

        } else {

            if (existingFieldsList.size() == 0) { // Any previously existing record
                log.debug("UserController():uploadFileUser():lineCounter!=0:${lineCounter}recordsImported")

                flash.userImportMessage = g.message(code: "default.import.success", default: "<strong>{0}</strong> file has been imported correctly - Records imported: <strong>{1}</strong>.", args: ["${csvFilename}", "${lineCounter}"])

            } else if (lineCounter - existingFieldsList.size() == 0){ // Any record imported
                log.debug("UserController():uploadFileUser():lineCounter!=0:anyRecordImported")

                flash.userImportMessage = g.message(code: 'default.import.success.allRecords.exist', default: '<strong>{0}</strong> file has been processed correctly. However it has not imported any records because all previously ' +
                        'existed in the system. Total number of records in the file: <strong>{1}</strong>.', args: ["${csvFilename}", "${lineCounter}"])

            } else { // Some previously existing records
                log.debug("UserController():uploadFileUser():lineCounter!=0:${lineCounter}:numberExistingFields:${existingFieldsList.size()}")

                flash.userImportMessage = g.message(code: 'default.import.success.someRecords.exist', default: '<strong>{0}</strong> file has been imported correctly.<br/><ul><li><strong>Total number of records:</strong> {1}.</li>' +
                        '<li><strong>Number of imported records:</strong> {2}.</li><li><strong>Number of existing records:</strong> {3}.</li></ul>', args: ["${csvFilename}", "${lineCounter}", "${lineCounter - existingFieldsList.size()}", "${existingFieldsList.size()}"])
            }
            redirect uri: '/user/import'
        }
    }
}