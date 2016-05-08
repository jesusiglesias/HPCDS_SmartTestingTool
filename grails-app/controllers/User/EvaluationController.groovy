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

    static allowedMethods = [delete: "DELETE"]

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
     * It shows the information of a evaluation instance.
     *
     * @param evaluationInstance It represents the evaluation to show.
     * @return evaluationInstance Data of the evaluation instance.
     */
    def show(Evaluation evaluationInstance) {
        respond evaluationInstance
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

            // Roll back in database
            transactionStatus.setRollbackOnly()

            notFound()
            return
        }

        try {

            // Delete evaluation
            evaluationInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.evaluationMessage = g.message(code: 'default.deleted.message.evaluation', default: '{0} <strong>{1}-{2}</strong> deleted successful.', args: [message(code: 'evaluation.label', default: 'Evaluation'),
                                                                                                                                                         evaluationInstance.usernameEval, evaluationInstance.testName])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("EvaluationController():delete():DataIntegrityViolationException:Evaluation:${evaluationInstance.id}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.evaluationErrorMessage = g.message(code: 'default.not.deleted.message.evaluation', default: 'ERROR! {0} <strong>{1}-{2}</strong> was not deleted.', args: [message(code: 'evaluation.label', default: 'Evaluation'),
                                                                                                                                                                                     evaluationInstance.usernameEval, evaluationInstance.testName])
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
