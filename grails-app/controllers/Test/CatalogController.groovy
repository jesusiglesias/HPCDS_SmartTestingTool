package Test

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the catalog controller.
 */
@Transactional(readOnly = true)
class CatalogController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all catalog of the database.
     *
     * @param max Maximum number of catalog to list.
     * @return Catalog Catalog list with their information and number of catalog in the database.
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

        respond Catalog.list(params), model: [catalogInstanceCount: Catalog.count()]
    }

    /**
     * It shows the information of a catalog instance.
     *
     * @param catalogInstance It represents the catalog to show.
     * @return catalogInstance Data of the catalog instance.
     */
    def show(Catalog catalogInstance) {
        respond catalogInstance
    }

    /**
     * It creates a new catalog instance.
     *
     * @return return If the catalog instance is null or has errors.
     */
    def create() {
        respond new Catalog(params)
    }

    /**
     * It saves a catalog in database.
     *
     * @param catalogInstance It represents the catalog to save.
     * @return return If the catalog instance is null or has errors.
     */
    @Transactional
    def save(Catalog catalogInstance) {
        if (catalogInstance == null) {
            notFound()
            return
        }

        if (catalogInstance.hasErrors()) {
            respond catalogInstance.errors, view: 'create'
            return
        }

        catalogInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.id])
                redirect catalogInstance
            }
            '*' { respond catalogInstance, [status: CREATED] }
        }
    }

    /**
     * It edits a existing catalog with the new values of each field.
     *
     * @param catalogInstance It represents the catalog to edit.
     * @return catalogInstance It represents the catalog instance.
     */
    def edit(Catalog catalogInstance) {
        respond catalogInstance
    }

    /**
     * It updates a existing catalog in database.
     *
     * @param catalogInstance It represents the catalog information to update.
     * @return return If the catalog instance is null or has errors.
     */
    @Transactional
    def update(Catalog catalogInstance) {
        if (catalogInstance == null) {
            notFound()
            return
        }

        if (catalogInstance.hasErrors()) {
            respond catalogInstance.errors, view: 'edit'
            return
        }

        catalogInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.id])
                redirect catalogInstance
            }
            '*' { respond catalogInstance, [status: OK] }
        }
    }

    /**
     * It deletes a existing catalog in database.
     *
     * @param catalogInstance It represents the catalog information to delete.
     * @return return If the catalog instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Catalog catalogInstance) {

        if (catalogInstance == null) {
            notFound()
            return
        }

        catalogInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the catalog instance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'catalog.label', default: 'Catalog'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
