package Test

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * Class that represents to the question controller.
 */
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /**
     * It lists the main data of all question of the database.
     *
     * @param max Maximum number of question to list.
     * @return Question Question list with their information and number of question in the database.
     */
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Question.list(params), model: [questionInstanceCount: Question.count()]
    }

    /**
     * It shows the information of a question instance.
     *
     * @param questionInstance It represents the question to show.
     * @return questionInstance Data of the question instance.
     */
    def show(Question questionInstance) {
        respond questionInstance
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

        questionInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
                redirect questionInstance
            }
            '*' { respond questionInstance, [status: CREATED] }
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

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'edit'
            return
        }

        questionInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
                redirect questionInstance
            }
            '*' { respond questionInstance, [status: OK] }
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

        questionInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the question instance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
