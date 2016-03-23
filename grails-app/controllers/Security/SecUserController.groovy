package Security

import grails.converters.JSON
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
     * It lists the main data of all administrators of the database.
     *
     * @param max Maximum number of administrators to list.
     * @return SecUser SecUser list with their information and number of administrators in the database.
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
     * It creates a new secUser instance.
     *
     * @return return If the secUser instance is null or has errors.
     */
    def create() {
        respond new SecUser(params)
    }

    /**
     * It saves an administrator in database.
     *
     * @param secUserInstance It represents the administrator to save.
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

        // Check if password and confirm password fields are same
        if (secUserInstance.password != secUserInstance.confirmPassword) {
            flash.secUserErrorMessage = g.message(code: 'default.password.notsame', default: 'Password and confirm password fields must match.')
            render view: "create", model: [secUserInstance: secUserInstance]
            return
        }

        try {
              // Save admin data
              secUserInstance.save(flush:true, failOnError: true)

              // Save relation with admin role
              def adminRole = SecRole.findByAuthority('ROLE_ADMIN')
              SecUserSecRole.create secUserInstance, adminRole, true

              request.withFormat {
                  form multipartForm {
                      flash.secUserMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.username])
                      redirect view: 'index'
                  }
                  '*' { respond secUserInstance, [status: CREATED] }
              }
          } catch (Exception exception) {
              log.error("SecUserController():save():Exception:Administrator:${secUserInstance.username}:${exception}")

              // Roll back in database
              transactionStatus.setRollbackOnly()

              request.withFormat {
                  form multipartForm {
                      flash.secUserErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.username])
                      render view: "create", model: [secUserInstance: secUserInstance]
                  }
              }
          }
    }

    /**
     * It edits a existing administrator with the new values of each field.
     *
     * @param secUserInstance It represents the administrator to edit.
     * @return secUserInstance It represents the secUser instance.
     */
    def edit(SecUser secUserInstance) {
        respond secUserInstance
    }

    /**
     * It updates a existing administrator in database.
     *
     * @param secUserInstance It represents the administrator information to update.
     * @return return If the secUser instance is null or has errors.
     */
    @Transactional
    def update(SecUser secUserInstance) {

        if (secUserInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (secUserInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // clear the list of errors
                secUserInstance.clearErrors()
                secUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [secUserInstance.username] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond secUserInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!secUserInstance.validate()) {
            respond secUserInstance.errors, view:'edit'
            return
        }

        // Check if password and confirm password fields are same
        if (secUserInstance.password != secUserInstance.confirmPassword) {

            // Roll back in database
            transactionStatus.setRollbackOnly()

            flash.secUserErrorMessage = g.message(code: 'default.password.notsame', default: 'Password and confirm password fields must match.')
            render view: "edit", model: [secUserInstance: secUserInstance]
            return
        }

        try {

            // Save admin data
            secUserInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.secUserMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.username])
                    redirect view: 'index'
                }
                '*' { respond secUserInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("SecUserController():update():Exception:Administrator:${secUserInstance.username}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.secUserErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.username])
                    render view: "edit", model: [secUserInstance: secUserInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing administrator in database.
     *
     * @param secUserInstance It represents the administrator information to delete.
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

            // Delete administrator
            secUserInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.secUserMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.username])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("SecUserController():delete():DataIntegrityViolationException:Administrator:${secUserInstance.username}:${exception}")

            request.withFormat {
                form multipartForm {
                    flash.secUserErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'admin.label', default: 'Administrator'), secUserInstance.username])
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
                flash.secUserErrorMessage = g.message(code: 'default.not.found.admin.message', default:'It has not been able to locate the administrator with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    /**
     * It checks the username availability.
     */
    def checkUsernameAvailibility () {

        def responseData

        if (SecUser.countByUsername(params.username)) { // Username found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'secUser.checkUsernameAvailibility.notAvailable', default:'Username is not available. Please choose another one.')
            ]
        } else { // Username not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'secUser.checkUsernameAvailibility.available', default:'Username available.')
            ]
        }
        render responseData as JSON
    }

    /**
     * It checks the email availability.
     */
    def checkEmailAvailibility () {

        def responseData

        if (SecUser.countByEmail(params.email)) { // Email found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'secUser.checkEmailAvailibility.notAvailable', default:'Email is not available. Please choose another one.')
            ]
        } else { // Email not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'secUser.checkEmailAvailibility.available', default:'Email available.')
            ]
        }
        render responseData as JSON
    }
}
