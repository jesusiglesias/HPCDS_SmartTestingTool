package User

import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Evaluation controller.
 */
@Transactional(readOnly = true)
class EvaluationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all evaluations of the database.
     *
     * @param max Maximum number of evaluations to list.
     * @return Evaluation Evaluations list with their information and number of evaluations in the database.
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

        respond Evaluation.list(params)
    }

    /**
     * It shows the information of a evaluation instance. TODO
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

        try {
            // Save evaluation data
            evaluationInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.evaluationMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                    redirect view: 'index'
                }
                '*' { respond evaluationInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("EvaluationController():save():Exception:Evaluation:${evaluationInstance.id}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.evaluationErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                    render view: "create", model: [evaluationInstance: evaluationInstance]
                }
            }
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

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (evaluationInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                evaluationInstance.clearErrors()
                evaluationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [evaluationInstance.id] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond evaluationInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!evaluationInstance.validate()) {
            respond evaluationInstance.errors, view:'edit'
            return
        }

        try {

            // Save evaluation data
            evaluationInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.evaluationMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                    redirect view: 'index'
                }
                '*' { respond evaluationInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("EvaluationController():update():Exception:Evaluation:${evaluationInstance.id}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.evaluationErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                    render view: "edit", model: [evaluationInstance: evaluationInstance]
                }
            }
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

        try {

            // Delete evaluation
            evaluationInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.evaluationMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("EvaluationController():delete():DataIntegrityViolationException:Evaluation:${evaluationInstance.id}:${exception}")

            request.withFormat {
                form multipartForm {
                    flash.evaluationErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'evaluation.label', default: 'Evaluation'), evaluationInstance.id])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the evaluation instance was not found.
     */
    protected void notFound() {
        log.error("EvaluationController():notFound():EvaluationID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.evaluationErrorMessage = g.message(code: 'default.not.found.evaluation.message', default:'It has not been able to locate the evaluation with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}