package GeneralTasks

import User.Department
import grails.transaction.Transactional

/**
 * Service that performs the import process.
 */
@Transactional
class CustomImportService {

    /**
     * It checks the file extension.
     *
     * @param filename File to import the data.
     * @return true If the extension is .csv.
     */
    def checkExtension (filename) {
        log.debug("CustomImportService():checkExtension()")

        // Obtain number of characteres in the name file
        def charNumber = filename.lastIndexOf(".");

        // Obtain extension
        def extensionFilename = filename.substring(charNumber);

        // Extension List
        ArrayList<String> extensionList = new ArrayList<String>();
        extensionList.add(".csv");

        // Check extension
        return extensionList.contains(extensionFilename)
    }

    /**
     * It validates the instance.
     *
     * @param departmentValidation It represents the department instance to save.
     * @return true If instance is valid.
     */
    def validateDepartment (Department departmentValidation) {
        log.debug("CustomImportService():validateDepartment()")

        // Department is null, has errors or isn't valid
        if (departmentValidation == null || departmentValidation.hasErrors() || !departmentValidation.validate()) {
            return false
        }
        return true
    }

    /**
     * It saves a department in database from record of CSV file.
     *
     * @param department It represents the department instance to save.
     * @return return If the department instance is null or has errors.
     */
    def saveRecordCSV (Department department) {
        log.debug("CustomImportService():saveRecordCSV()")

        if (validateDepartment(department)) {
            try { // Save
                department.save(flush: true, failOnError: true)
                return true
            } catch (Exception e) {
                return false
            }
        }
        return false // Department isn't valid
    }
}
