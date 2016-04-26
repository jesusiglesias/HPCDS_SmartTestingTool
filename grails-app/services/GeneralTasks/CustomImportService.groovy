package GeneralTasks

import Security.SecRole
import Security.SecUser
import Security.SecUserSecRole
import Test.Answer
import Test.Catalog
import Test.Question
import Test.Test
import Test.Topic
import User.Department
import User.User
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

    /*-------------------------------------------------------------------------------------------*
     *                                       ADMINISTRATOR                                       *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It validates the instance.
     *
     * @param adminValidation It represents the administrator instance to save.
     * @return true If instance is valid.
     */
    def validateAdmin (SecUser adminValidation) {
        log.debug("CustomImportService():validateAdmin()")

        // Admin is null, has errors or isn't valid
        if (adminValidation == null || adminValidation.hasErrors() || !adminValidation.validate()) {
            return false
        }
        return true
    }

    /**
     * It saves an administrator in database from record of CSV file.
     *
     * @param administrator It represents the administrator instance to save.
     * @return return If the administrator instance is null or has errors.
     */
    def saveRecordCSVAdmin (SecUser admin) {
        log.debug("CustomImportService():saveRecordCSVAdmin()")

        if (validateAdmin(admin)) {
            try { // Save
                admin.save(flush: true, failOnError: true)

                // Save relation with admin role
                def adminRole = SecRole.findByAuthority('ROLE_ADMIN')

                // Save relation with admin role
                SecUserSecRole.create admin, adminRole, true

                return true
            } catch (Exception e) {
                return false
            }
        }
        return false // Administrator isn't valid
    }

    /*-------------------------------------------------------------------------------------------*
     *                                          DEPARTMENT                                       *
     *-------------------------------------------------------------------------------------------*/

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
    def saveRecordCSVDepartment (Department department) {
        log.debug("CustomImportService():saveRecordCSVDepartment()")

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

    /*-------------------------------------------------------------------------------------------*
     *                                           USER                                            *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It validates the instance.
     *
     * @param userValidation It represents the user instance to save.
     * @return true If instance is valid.
     */
    def validateUser (User userValidation) {
        log.debug("CustomImportService():validateUser()")

        // User is null, has errors or isn't valid
        if (userValidation == null || userValidation.hasErrors() || !userValidation.validate()) {
            return false
        }
        return true
    }

    /**
     * It saves an user in database from record of CSV file.
     *
     * @param user It represents the user instance to save.
     * @return return If the user instance is null or has errors.
     */
    def saveRecordCSVUser (User user) {
        log.debug("CustomImportService():saveRecordCSVUser()")

        if (validateUser(user)) {
            try { // Save
                user.save(flush: true, failOnError: true)

                // Save relation with user role
                def normalRole = SecRole.findByAuthority('ROLE_USER')

                SecUserSecRole.create user, normalRole, true

                return true
            } catch (Exception e) {
                return false
            }
        }
        return false // User isn't valid
    }

    /*-------------------------------------------------------------------------------------------*
     *                                          ANSWER                                           *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It validates the instance.
     *
     * @param answerValidation It represents the answer instance to save.
     * @return true If instance is valid.
     */
    def validateAnswer (Answer answerValidation) {
        log.debug("CustomImportService():validateAnswer()")

        // Answer is null, has errors or isn't valid
        if (answerValidation == null || answerValidation.hasErrors() || !answerValidation.validate()) {
            return false
        }
        return true
    }

    /**
     * It saves a answer in database from record of CSV file.
     *
     * @param answer It represents the answer instance to save.
     * @return return If the answer instance is null or has errors.
     */
    def saveRecordCSVAnswer (Answer answer) {
        log.debug("CustomImportService():saveRecordCSVAnswer()")

        if (validateAnswer(answer)) {
            try { // Save
                answer.save(flush: true, failOnError: true)
                return true
            } catch (Exception e) {
                return false
            }
        }
        return false // Answer isn't valid
    }

    /*-------------------------------------------------------------------------------------------*
     *                                         QUESTION                                          *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It validates the instance.
     *
     * @param questionValidation It represents the question instance to save.
     * @return true If instance is valid.
     */
    def validateQuestion (Question questionValidation) {
        log.debug("CustomImportService():validateQuestion()")

        // Question is null, has errors or isn't valid
        if (questionValidation == null || questionValidation.hasErrors() || !questionValidation.validate()) {
            return false
        }
        return true
    }

    /**
     * It saves a question in database from record of CSV file.
     *
     * @param question It represents the question instance to save.
     * @return return If the question instance is null or has errors.
     */
    def saveRecordCSVQuestion (Question question) {
        log.debug("CustomImportService():saveRecordCSVQuestion()")

        if (validateQuestion(question)) {
            try { // Save
                question.save(flush: true, failOnError: true)
                return true
            } catch (Exception e) {
                return false
            }
        }
        return false // Question isn't valid
    }

    /*-------------------------------------------------------------------------------------------*
     *                                         CATALOG                                          *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It validates the instance.
     *
     * @param catalogValidation It represents the catalog instance to save.
     * @return true If instance is valid.
     */
    def validateCatalog (Catalog catalogValidation) {
        log.debug("CustomImportService():validateCatalog()")

        // Catalog is null, has errors or isn't valid
        if (catalogValidation == null || catalogValidation.hasErrors() || !catalogValidation.validate()) {
            return false
        }
        return true
    }

    /**
     * It saves a catalog in database from record of CSV file.
     *
     * @param catalog It represents the catalog instance to save.
     * @return return If the catalog instance is null or has errors.
     */
    def saveRecordCSVCatalog (Catalog catalog) {
        log.debug("CustomImportService():saveRecordCSVCatalog()")

        if (validateCatalog(catalog)) {
            try { // Save
                catalog.save(flush: true, failOnError: true)
                return true
            } catch (Exception e) {
                return false
            }
        }
        return false // Catalog isn't valid
    }

    /*-------------------------------------------------------------------------------------------*
     *                                            TOPIC                                          *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It validates the instance.
     *
     * @param topicValidation It represents the topic instance to save.
     * @return true If instance is valid.
     */
    def validateTopic (Topic topicValidation) {
        log.debug("CustomImportService():validateTopic()")

        // Topic is null, has errors or isn't valid
        if (topicValidation == null || topicValidation.hasErrors() || !topicValidation.validate()) {
            return false
        }
        return true
    }

    /**
     * It saves a topic in database from record of CSV file.
     *
     * @param topic It represents the topic instance to save.
     * @return return If the topic instance is null or has errors.
     */
    def saveRecordCSVTopic (Topic topic) {
        log.debug("CustomImportService():saveRecordCSVTopic()")

        if (validateTopic(topic)) {
            try { // Save
                topic.save(flush: true, failOnError: true)
                return true
            } catch (Exception e) {
                return false
            }
        }
        return false // Topic isn't valid
    }

    /*-------------------------------------------------------------------------------------------*
     *                                            TEST                                          *
     *-------------------------------------------------------------------------------------------*/

    /**
     * It validates the instance.
     *
     * @param testValidation It represents the test instance to save.
     * @return true If instance is valid.
     */
    def validateTest (Test testValidation) {
        log.debug("CustomImportService():validateTest()")

        // Test is null, has errors or isn't valid
        if (testValidation == null || testValidation.hasErrors() || !testValidation.validate()) {
            return false
        }
        return true
    }

    /**
     * It saves a test in database from record of CSV file.
     *
     * @param test It represents the test instance to save.
     * @return return If the test instance is null or has errors.
     */
    def saveRecordCSVTest (Test test) {
        log.debug("CustomImportService():saveRecordCSVTest()")

        if (validateTest(test)) {
            try { // Save
                test.save(flush: true, failOnError: true)
                return true
            } catch (Exception e) {
                return false
            }
        }
        return false // Test isn't valid
    }
}
