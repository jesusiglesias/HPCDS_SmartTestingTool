package User

import Security.SecRole
import Security.SecUserSecRole
import org.springframework.dao.DataIntegrityViolationException
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
     * It lists the main data of all normal users of the database.
     *
     * @param max Maximum number of normal users to list.
     * @return Users Users list with their information and number of normal users in the database.
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

        // Obtain user role
        def role = SecRole.findByAuthority("ROLE_USER")

        // Obtain users with admin role
        def normalUsers = SecUserSecRole.findAllBySecRole(role).secUser

        respond normalUsers
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
     * It saves a normal user in database.
     *
     * @param userInstance It represents the normal user to save.
     * @return return If the user instance is null or has errors.
     */
    @Transactional
    def save(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view: 'create'
            return
        }

        // Check if password and confirm password fields are same
        if (userInstance.password != userInstance.confirmPassword) {
            flash.userErrorMessage = g.message(code: 'default.password.notsame', default: 'Password and confirm password fields must match.')
            render view: "create", model: [userInstance: userInstance]
            return
        }

        try {
            // Save user data
            userInstance.save(flush: true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    redirect view: 'index'
                }
                '*' { respond userInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("UserController():save():Exception:NormalUser:${userInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    render view: "create", model: [userInstance: userInstance]
                }
            }
        }
    }

    /**
     * It edits a existing normal user with the new values of each field.
     *
     * @param userInstance It represents the normal user to edit.
     * @return userInstance It represents the user instance.
     */
    def edit(User userInstance) {
        respond userInstance
    }

    /**
     * It updates a existing normal user in database.
     *
     * @param userInstance It represents the normal user information to update.
     * @return return If the user instance is null or has errors.
     */
    @Transactional
    def update(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (userInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // clear the list of errors
                userInstance.clearErrors()
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [userInstance.username] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond userInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!userInstance.validate()) {
            respond userInstance.errors, view:'edit'
            return
        }

        // Check if password and confirm password fields are same
        if (userInstance.password != userInstance.confirmPassword) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            flash.userErrorMessage = g.message(code: 'default.password.notsame', default: 'Password and confirm password fields must match.')
            render view: "edit", model: [userInstance: userInstance]
            return
        }

        try {

            // Save user data TODO
            uuserInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    redirect view: 'index'
                }
                '*' { respond userInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("UserController():update():Exception:NormalUser:${userInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.userErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                    render view: "edit", model: [userInstance: userInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing normal user in database.
     *
     * @param userInstance It represents the normal user information to delete.
     * @return return If the user instance is null, the notFound function is called.
     */
    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        try {

            // Delete normal user
            userInstance.delete(flush: true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.userMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'admin.label', default: 'Administrator'), userInstance.username])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("UserController():delete():DataIntegrityViolationException:NormalUser:${userInstance.username}:${exception}")

            request.withFormat {
                form multipartForm {
                    flash.userErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'admin.label', default: 'Administrator'), userInstance.username])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * Its redirects to not found page if the user instance was not found.
     */
    protected void notFound() {
        log.error("UserController():notFound():NormalUserID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.userErrorMessage = g.message(code: 'default.not.found.user.message', default:'It has not been able to locate the user with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}