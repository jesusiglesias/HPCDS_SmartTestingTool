package Test

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Catalog controller.
 */
@Transactional(readOnly = true)
class CatalogController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all catalogs of the database.
     *
     * @param max Maximum number of catalogs to list.
     * @return Catalog Catalogs list with their information and number of catalogs in the database.
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

        respond Catalog.list(params)
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

        try {
            // Save catalog data
            catalogInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.catalogMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    redirect view: 'index'
                }
                '*' { respond catalogInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("CatalogController():save():Exception:Catalog:${catalogInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.catalogErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    render view: "create", model: [catalogInstance: catalogInstance]
                }
            }
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

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (catalogInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                catalogInstance.clearErrors()
                catalogInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [catalogInstance.name] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond catalogInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!catalogInstance.validate()) {
            respond catalogInstance.errors, view:'edit'
            return
        }

        try {

            // Save catalog data
            catalogInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.catalogMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    redirect view: 'index'
                }
                '*' { respond catalogInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("CatalogController():update():Exception:Catalog:${catalogInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.catalogErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    render view: "edit", model: [catalogInstance: catalogInstance]
                }
            }
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

        try {

            // Delete catalog
            catalogInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.catalogMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("CatalogController():delete():DataIntegrityViolationException:Catalog:${catalogInstance.name}:${exception}")

            request.withFormat {
                form multipartForm {
                    flash.catalogErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'catalog.label', default: 'Catalog'), catalogInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the catalog instance was not found.
     */
    protected void notFound() {
        log.error("CatalogController():notFound():CatalogID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.catalogErrorMessage = g.message(code: 'default.not.found.catalog.message', default:'It has not been able to locate the catalog with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    /**
     * It checks the name availability.
     */
    def checkNameCatalogAvailibility () {

        def responseData

        if (Catalog.countByName(params.name)) { // Name found
            responseData = [
                    'status': "ERROR",
                    'message': g.message(code: 'catalog.checkCatalogAvailibility.notAvailable', default:'Name of catalog is not available. Please, choose another one.')
            ]
        } else { // Name not found
            responseData = [
                    'status': "OK",
                    'message':g.message(code: 'catalog.checkCatalogAvailibility.available', default:'Name of catalog available.')
            ]
        }
        render responseData as JSON
    }
}