<%=packageName ? "package ${packageName}\n\n" : ''%>
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the ${className} controller.
 */
@Transactional(readOnly = true)
class ${className}Controller {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    // TODO Add dollar symbol
    @Value('{paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all ${className} of the database.
     *
     * @param max Maximum number of ${className} to list.
     * @return ${className} ${className} list with their information and number of ${className} in the database.
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

        respond ${className}.list(params), model:[${propertyName}Count: ${className}.count()]
    }

    /**
     * It shows the information of a ${propertyName}.
     *
     * @param ${propertyName} It represents the ${className} to show.
     * @return ${propertyName} Data of the ${propertyName}.
     */
    def show(${className} ${propertyName}) {
        respond ${propertyName}
    }

    /**
     * It creates a new ${propertyName}.
     *
     * @return return If the ${propertyName} is null or has errors.
     */
    def create() {
        respond new ${className}(params)
    }

    /**
     * It saves a ${className} in database.
     *
     * @param ${propertyName} It represents the ${className} to save.
     * @return return If the ${className} instance is null or has errors.
     */
    @Transactional
    def save(${className} ${propertyName}) {
        if (${propertyName} == null) {
            notFound()
            return
        }

        if (${propertyName}.hasErrors()) {
            respond ${propertyName}.errors, view:'create'
            return
        }

        ${propertyName}.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
                redirect ${propertyName}
            }
            '*' { respond ${propertyName}, [status: CREATED] }
        }
    }

    /**
     * It edits a existing ${className} with the new values of each field.
     *
     * @param ${propertyName} It represents the ${className} to edit.
     * @return ${propertyName} It represents the ${propertyName}.
     */
    def edit(${className} ${propertyName}) {
        respond ${propertyName}
    }

    /**
     * It updates a existing ${className} in database.
     *
     * @param ${propertyName} It represents the ${className} information to update.
     * @return return If the ${className} instance is null or has errors.
     */
    @Transactional
    def update(${className} ${propertyName}) {
        if (${propertyName} == null) {
            notFound()
            return
        }

        if (${propertyName}.hasErrors()) {
            respond ${propertyName}.errors, view:'edit'
            return
        }

        ${propertyName}.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: '${className}.label', default: '${className}'), ${propertyName}.id])
                redirect ${propertyName}
            }
            '*'{ respond ${propertyName}, [status: OK] }
        }
    }

    /**
     * It deletes a existing ${className} in database.
     *
     * @param ${propertyName} It represents the ${className} information to delete.
     * @return return If the ${propertyName} is null, the notFound function is called.
     */
    @Transactional
    def delete(${className} ${propertyName}) {

        if (${propertyName} == null) {
            notFound()
            return
        }

        ${propertyName}.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: '${className}.label', default: '${className}'), ${propertyName}.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the ${propertyName} was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
