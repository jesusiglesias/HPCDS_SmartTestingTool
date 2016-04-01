package Test

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Question controller.
 */
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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

            request.withFormat {
                form multipartForm {
                    flash.questionErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'question.label', default: 'Question'), questionInstance.titleQuestionKey])
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
}