package User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

/**
 * Class that represents to the evaluation controller.
 */
@Transactional(readOnly = true)
class EvaluationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /**
     * It lists the main data of all evaluation of the database.
     *
     * @param max Maximum number of evaluation to list.
     * @return Evaluation Evaluation list with their information and number of evaluation in the database.
     */
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Evaluation.list(params), model: [evaluationInstanceCount: Evaluation.count()]
    }

    /**
     * It shows the information of a evaluation instance.
     *
     * @param evaluationInstance It represents the evaluation to show.
     * @return evaluationInstance Data of the evaluation instance.
     */
    def show(Evaluation evaluationInstance) {
        respond evaluationInstance
    }

    /**
     * It creates a new evaluation instance.
     *
     * @return return If the evaluation instance is null or has errors.
     */
    def create() {
        respond new Evaluation(params)
    }

    /**
     * It saves a evaluation in database.
     *
     * @param evaluationInstance It represents the evaluation to save.
     * @return return If the evaluation instance is null or has errors.
     */
    @Transactional
    def save(Evaluation evaluationInstance) {
        if (evaluationInstance == null) {
            notFound()
            return
        }

        if (evaluationInstance.hasErrors()) {
            respond evaluationInstance.errors, view: 'create'
            return
        }

        evaluationInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                redirect evaluationInstance
            }
            '*' { respond evaluationInstance, [status: CREATED] }
        }
    }

    /**
     * It edits a existing evaluation with the new values of each field.
     *
     * @param evaluationInstance It represents the evaluation to edit.
     * @return evaluationInstance It represents the evaluation instance.
     */
    def edit(Evaluation evaluationInstance) {
        respond evaluationInstance
    }

    /**
     * It updates a existing evaluation in database.
     *
     * @param evaluationInstance It represents the evaluation information to update.
     * @return return If the evaluation instance is null or has errors.
     */
    @Transactional
    def update(Evaluation evaluationInstance) {
        if (evaluationInstance == null) {
            notFound()
            return
        }

        if (evaluationInstance.hasErrors()) {
            respond evaluationInstance.errors, view: 'edit'
            return
        }

        evaluationInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                redirect evaluationInstance
            }
            '*' { respond evaluationInstance, [status: OK] }
        }
    }

    /**
     * It deletes a existing evaluation in database.
     *
     * @param evaluationInstance It represents the evaluation information to delete.
     * @return return If the evaluation instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Evaluation evaluationInstance) {

        if (evaluationInstance == null) {
            notFound()
            return
        }

        evaluationInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the evaluation instance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'evaluation.label', default: 'Evaluation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
