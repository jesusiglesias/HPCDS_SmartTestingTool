package Test

import org.springframework.dao.DataIntegrityViolationException

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the Topic controller.
 */
@Transactional(readOnly = true)
class TopicController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    // Default value of pagination
    @Value('${paginate.defaultValue:10}')
    def defaultPag

    /**
     * It lists the main data of all topics of the database.
     *
     * @param max Maximum number of topics to list.
     * @return Topic Topics list with their information and number of topics in the database.
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

        respond Topic.list(params)
    }

    /**
     * It creates a new topic instance.
     *
     * @return return If the topic instance is null or has errors.
     */
    def create() {
        respond new Topic(params)
    }

    /**
     * It saves a topic in database.
     *
     * @param topicInstance It represents the topic to save.
     * @return return If the topic instance is null or has errors.
     */
    @Transactional
    def save(Topic topicInstance) {

        if (topicInstance == null) {
            notFound()
            return
        }

        if (topicInstance.hasErrors()) {
            respond topicInstance.errors, view:'create'
            return
        }

        try {
            // Save topic data
            topicInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.topicMessage = g.message(code: 'default.created.message', default: '{0} <strong>{1}</strong> created successful.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    redirect view: 'index'
                }
                '*' { respond topicInstance, [status: CREATED] }
            }
        } catch (Exception exception) {
            log.error("TopicController():save():Exception:Topic:${topicInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.topicErrorMessage = g.message(code: 'default.not.created.message', default: 'ERROR! {0} <strong>{1}</strong> was not created.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    render view: "create", model: [topicInstance: topicInstance]
                }
            }
        }
    }

    /**
     * It edits a existing topic with the new values of each field.
     *
     * @param topicInstance It represents the topic to edit.
     * @return topicInstance It represents the topic instance.
     */
    def edit(Topic topicInstance) {
        respond topicInstance
    }

    /**
     * It updates a existing topic in database.
     *
     * @param topicInstance It represents the topic information to update.
     * @return return If the topic instance is null or has errors.
     */
    @Transactional
    def update(Topic topicInstance) {

        if (topicInstance == null) {
            notFound()
            return
        }

        // It checks concurrent updates
        if (params.version) {
            def version = params.version.toLong()

            if (topicInstance.version > version) {

                // Roll back in database
                transactionStatus.setRollbackOnly()

                // Clear the list of errors
                topicInstance.clearErrors()
                topicInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [topicInstance.name] as Object[], "Another user has updated the <strong>{0}</strong> instance while you were editing.")

                respond topicInstance.errors, view:'edit'
                return
            }
        }

        // Validate the instance
        if (!topicInstance.validate()) {
            respond topicInstance.errors, view:'edit'
            return
        }

        try {

            // Save topic data
            topicInstance.save(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.topicMessage = g.message(code: 'default.updated.message', default: '{0} <strong>{1}</strong> updated successful.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    redirect view: 'index'
                }
                '*' { respond topicInstance, [status: OK] }
            }
        } catch (Exception exception) {
            log.error("TopicController():update():Exception:Topic:${topicInstance.name}:${exception}")

            // Roll back in database
            transactionStatus.setRollbackOnly()

            request.withFormat {
                form multipartForm {
                    flash.topicErrorMessage = g.message(code: 'default.not.updated.message', default: 'ERROR! {0} <strong>{1}</strong> was not updated.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    render view: "edit", model: [topicInstance: topicInstance]
                }
            }
        }
    }

    /**
     * It deletes a existing topic in database.
     *
     * @param topicInstance It represents the topic information to delete.
     * @return return If the topic instance is null, the notFound function is called.
     */
    @Transactional
    def delete(Topic topicInstance) {

        if (topicInstance == null) {
            notFound()
            return
        }

        try {
            // Delete topic
            topicInstance.delete(flush:true, failOnError: true)

            request.withFormat {
                form multipartForm {
                    flash.topicMessage = g.message(code: 'default.deleted.message', default: '{0} <strong>{1}</strong> deleted successful.', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        } catch (DataIntegrityViolationException exception) {
            log.error("TopicController():delete():DataIntegrityViolationException:Topic:${topicInstance.name}:${exception}")

            request.withFormat {
                form multipartForm {
                    flash.topicErrorMessage = g.message(code: 'default.not.deleted.message', default: 'ERROR! {0} <strong>{1}</strong> was not deleted.', args: [message(code: 'admin.label', default: 'Administrator'), topicInstance.name])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    /**
     * It renders the not found message if the topic instance was not found.
     */
    protected void notFound() {
        log.error("TopicController():notFound():TopicID:${params.id}")

        request.withFormat {
            form multipartForm {
                flash.topicErrorMessage = g.message(code: 'default.not.found.topic.message', default:'It has not been able to locate the topic with id: <strong>{0}</strong>.', args: [params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
