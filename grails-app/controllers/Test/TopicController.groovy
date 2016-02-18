package Test

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

/**
 * Class that represents to the topic controller.
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

        respond Topic.list(params), model:[topicInstanceCount: Topic.count()]
    }

    /**
     * It shows the information of a topic instance.
     *
     * @param topicInstance It represents the topic to show.
     * @return topicInstance Data of the topic instance.
     */
    def show(Topic topicInstance) {
        respond topicInstance
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

        topicInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.id])
                redirect topicInstance
            }
            '*' { respond topicInstance, [status: CREATED] }
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

        if (topicInstance.hasErrors()) {
            respond topicInstance.errors, view:'edit'
            return
        }

        topicInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.id])
                redirect topicInstance
            }
            '*'{ respond topicInstance, [status: OK] }
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

        topicInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'topic.label', default: 'Topic'), topicInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    /**
     * Its redirects to not found page if the topic instance was not found.
     */
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'topic.label', default: 'Topic'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
