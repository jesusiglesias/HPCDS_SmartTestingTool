package Test

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Answer controller.
 */
@Transactional(readOnly = true)
class AnswerController {

    def CustomDeleteService

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
                    flash.answerErrorMessage = g.message(code: 'default.not.deleted.message.answer', default: 'ERROR! {0} <strong>{1}</strong> was not deleted. First, you must delete the question or questions associated with the answer.', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.titleAnswerKey])
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
        log.debug("CustomTasksBackendController:importAnswer()")

        render view: 'import'
    }

    /**
     * It processes the import functionality.
     */
    def uploadFileAnswer () {
        log.debug("CustomTasksBackendController:uploadFileAnswer()")

        sleep(10000)

    }
}

