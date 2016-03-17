package Security

import org.springframework.dao.DataIntegrityViolationException
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
    @Value('${paginate.defaultValue:10}')
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

        // Obtain admin role
        def role = SecRole.findByAuthority("ROLE_ADMIN")

        // Obtain users with admin role
        def administrators = SecUserSecRole.findAllBySecRole(role).secUser

        respond administrators
    }

    /**
     * It shows the information of a secUser instance.
     *
     * @param secUserInstance It represents the secUser to show.
     * @return secUserInstance Data of the secUser instance.
     */
    def show(SecUser secUserInstance) {
        respond secUserInstance
    }

    /**
     * It creates a new secUser instance.
     *
     * @return return If the secUser instance is null or has errors.
     */
    def create() {
        respond new SecUser(params)
    }

    /**
     * It saves a secUser in database.
     *
     * @param secUserInstance It represents the secUser to save.
     * @return return If the secUser instance is null or has errors.
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

        // Save data admin
        secUserInstance.save flush:true

        // Save relation with admin role
        def adminRole = SecRole.findByAuthority('ROLE_ADMIN')
        SecUserSecRole.create secUserInstance, adminRole, true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.id])
                //redirect secUserInstance
                redirect view: 'index'
            }
            '*' { respond secUserInstance, [status: CREATED] }
        }
    }

    /**
     * It edits a existing secUser with the new values of each field.
     *
     * @param secUserInstance It represents the secUser to edit.
     * @return secUserInstance It represents the secUser instance.
     */
    def edit(SecUser secUserInstance) {
        respond secUserInstance
    }

    /**
     * It updates a existing secUser in database.
     *
     * @param secUserInstance It represents the secUser information to update.
     * @return return If the secUser instance is null or has errors.
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
                flash.message = message(code: 'default.updated.message', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.id])
                redirect secUserInstance
            }
            '*'{ respond secUserInstance, [status: OK] }
        }
    }

    /**
     * It deletes a existing secUser in database.
     *
     * @param secUserInstance It represents the secUser information to delete.
     * @return return If the secUser instance is null, the notFound function is called.
     */
    @Transactional
    def delete(SecUser secUserInstance) {

        if (secUserInstance == null) {
            notFound()
            return
        }

        try {

            // Delete SecUserSecRole relations
            SecUserSecRole.findAllBySecUser(secUserInstance)*.delete(flush: true, failOnError: true)

            // Delete SecUser
            secUserInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.secUserMessage = message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.username])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("SecUserController():delete():DataIntegrityViolationException:Administrator:${secUserInstance.username}:${exception}")

            request.withFormat {
                form multipartForm {
                    flash.secUserErrorMessage = message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> did not deleted.', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.username])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }

        }
    }

    /**
     * Its redirects to not found page if the secUser instance was not found.
     */
    protected void notFound() {
        log.error("SecUserController():notFound():AdministratorID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.secUserErrorMessage = message(code: 'default.not.found.admin.message', default:'It has not been able to locate the administrator with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
