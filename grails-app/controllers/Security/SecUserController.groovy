package Security


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the SecUser controller.
 */
@Transactional(readOnly = true)
class SecUserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    // TODO Add dollar symbol
    @Value('{paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all SecUser of the database.
     *
     * @param max Maximum number of SecUser to list.
     * @return SecUser SecUser list with their information and number of SecUser in the database.
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

        respond SecUser.list(params), model:[secUserInstanceCount: SecUser.count()]
    }

    /**
     * It shows the information of a secUserInstance.
     *
     * @param secUserInstance It represents the SecUser to show.
     * @return secUserInstance Data of the secUserInstance.
     */
    def show(SecUser secUserInstance) {
        respond secUserInstance
    }

    /**
     * It creates a new secUserInstance.
     *
     * @return return If the secUserInstance is null or has errors.
     */
    def create() {
        respond new SecUser(params)
    }

    /**
     * It saves a SecUser in database.
     *
     * @param secUserInstance It represents the SecUser to save.
     * @return return If the SecUser instance is null or has errors.
     */
    @Transactional
    def save(SecUser secUserInstance) {
        if (secUserInstance == null) {
            notFound()
            return
        }

        if (secUserInstance.hasErrors()) {
            respond secUserInstance.errors, view:'create'
            return
        }

        secUserInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'secUser.label', default: 'SecUser'), secUserInstance.id])
                redirect secUserInstance
            }
            '*' { respond secUserInstance, [status: CREATED] }
        }
    }

    /**
     * It edits a existing SecUser with the new values of each field.
     *
     * @param secUserInstance It represents the SecUser to edit.
     * @return secUserInstance It represents the secUserInstance.
     */
    def edit(SecUser secUserInstance) {
        respond secUserInstance
    }

    /**
     * It updates a existing SecUser in database.
     *
     * @param secUserInstance It represents the SecUser information to update.
     * @return return If the SecUser instance is null or has errors.
     */
    @Transactional
    def update(SecUser secUserInstance) {
        if (secUserInstance == null) {
            notFound()
            return
        }

        if (secUserInstance.hasErrors()) {
            respond secUserInstance.errors, view:'edit'
            return
        }

        secUserInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SecUser.label', default: 'SecUser'), secUserInstance.id])
                redirect secUserInstance
            }
            '*'{ respond secUserInstance, [status: OK] }
        }
    }

    /**
     * It deletes a existing SecUser in database.
     *
     * @param secUserInstance It represents the SecUser information to delete.
     * @return return If the secUserInstance is null, the notFound function is called.
     */
    @Transactional
    def delete(SecUser secUserInstance) {

        if (secUserInstance == null) {
            notFound()
            return
        }

        secUserInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SecUser.label', default: 'SecUser'), secUserInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the secUserInstance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'secUser.label', default: 'SecUser'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
