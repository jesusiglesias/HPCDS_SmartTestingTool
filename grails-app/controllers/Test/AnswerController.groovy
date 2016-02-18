package Test

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the answer controller.
 */
@Transactional(readOnly = true)
class AnswerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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

        respond Answer.list(params), model: [answerInstanceCount: Answer.count()]
    }

    /**
     * It shows the information of a answer instance.
     *
     * @param answerInstance It represents the Answer to show.
     * @return answerInstance Data of the answer instance.
     */
    def show(Answer answerInstance) {
        respond answerInstance
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

        if (answerInstance.hasErrors()) {
            respond answerInstance.errors, view: 'create'
            return
        }

        answerInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
                redirect answerInstance
            }
            '*' { respond answerInstance, [status: CREATED] }
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

        if (answerInstance.hasErrors()) {
            respond answerInstance.errors, view: 'edit'
            return
        }

        answerInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
                redirect answerInstance
            }
            '*' { respond answerInstance, [status: OK] }
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

        answerInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'answer.label', default: 'Answer'), answerInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the answer instance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'answer.label', default: 'Answer'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
