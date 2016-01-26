package User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the User controller.
 */
@Transactional(readOnly = true)
class UserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all users of the database.
     *
     * @param max Maximum number of users to list.
     * @return Users Users list with their information and number of users in the database.
     */
    def index(Integer max) {
        //params.max = Math.min(max ?: 10, 100)

        // Protecting against attack when max is a negative number. If is 0, max = defaultPag
        max = max ?: defaultPag.toInteger()
        // If max < 0, return all records (This is dangerous)
        if (max < 0) {
            max = defaultPag.toInteger()
        }
        params.max = Math.min(max, 100)

        respond User.list(params), model:[userInstanceCount: User.count()]
    }

    /**
     * It shows the information of a user instance.
     *
     * @param userInstance It represents the user to show.
     * @return userInstance Data of the user instance.
     */
    def show(User userInstance) {
        respond userInstance
    }

    /**
     * It creates a new user instance.
     *
     * @return return If the user instance is null or has errors.
     */
    def create() {
        //respond new User(params)

        log.error("crear usuario")
        log.warn("crear usuario")
        log.info("crear usuario")
        log.debug("crear usuario")

        respond new User(
                address: params.address,
                avatar: params.avatar,
                birthDate: params.birthDate,
                city: params.city,
                country: params.country,
                name: params.name,
                phone: params.phone,
                sex: params.sex,
                surname: params.surname,
                zipCode: params.zipCode
        )
    }

    /**
     * It saves a user in database.
     *
     * @param userInstance It represents the user to save.
     * @return return If the user instance is null or has errors.
     */
    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

    /**
     * It edits a existing user with the new values of each field.
     *
     * @param userInstance It represents the user to edit.
     * @return userInstance It represents the user instance.
     */
    def edit(User userInstance) {
        respond userInstance
    }

    /**
     * It updates a existing user in database.
     *
     * @param userInstance It represents the user information to update.
     * @return return If the user instance is null or has errors.
     */
    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'edit'
            return
        }

        // TODO
        uuserInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }

    /**
     * It deletes a existing user in database.
     *
     * @param userInstance It represents the user information to delete.
     * @return return If the user instance is null, the notFound function is called.
     */
    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        userInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the user instance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
