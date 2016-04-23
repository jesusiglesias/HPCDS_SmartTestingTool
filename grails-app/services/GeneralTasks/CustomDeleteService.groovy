package GeneralTasks

import Security.SecUser
import Security.SecUserSecRole
import Test.Answer
import Test.Catalog
import Test.Question
import Test.Test
import User.User
import static grails.async.Promises.*
import grails.transaction.Transactional

/**
 * Service that performs a custom delete.
 */
@Transactional
class CustomDeleteService {

    /**
     * It deletes the users associated to department.
     *
     * @param departmentInstance It represents to the department.
     * @return true If the action was completed successful.
     */
    def customDeleteDepartment (departmentInstance) {
        log.debug("CustomDeleteService:customDeleteDepartment()")

        List queriesDepartmentToExecute = []

        // It searches all users
        def userDeleted = User.findAllByDepartment(departmentInstance)

        // Delete SecUserSecRole relations - Asynchronous/Multi-thread
        userDeleted.each { SecUser user ->
            def userTask = SecUserSecRole.async.task {
                withTransaction {
                    SecUserSecRole.findAllBySecUser(user)*.delete(flush: true, failOnError: true)
                }
            }
            queriesDepartmentToExecute << userTask
        }
        waitAll(queriesDepartmentToExecute)
    }

    /**
     * It deletes the answer even if it is associated with a question.
     *
     * @param answerInstance It represents to the answer.
     * @return true If the action was completed successful.
     */
    def customDeleteAnswer (answerInstance) {
        log.debug("CustomDeleteService:customDeleteAnswer()")

        List queriesAnswerToExecute = []

        // Remove each relation of the answer with the question
        def questions = [] + answerInstance.questionsAnswer ?: []

        // Delete relations - Asynchronous/Multi-thread
        questions.each { Question question ->
            def questionTask = tasks {
                question.removeFromAnswers(answerInstance)
            }
            queriesAnswerToExecute << questionTask
        }
        waitAll(queriesAnswerToExecute)
    }

    /**
     * It deletes the relation with the catalogs.
     *
     * @param questionInstance It represents to the question.
     * @return true If the action was completed successful.
     */
    def customDeleteQuestion (questionInstance) {
        log.debug("CustomDeleteService:customDeleteQuestion()")

        List queriesQuestionToExecute = []

        // Remove each relation of the question with the catalog
        def catalogs = [] + questionInstance.catalogs ?: []

        // Delete relations - Asynchronous/Multi-thread
        catalogs.each { Catalog catalog ->
            def catalogTask = tasks {
                catalog.removeFromQuestions(questionInstance)
            }
            queriesQuestionToExecute << catalogTask
        }
        waitAll(queriesQuestionToExecute)
    }

    /**
     * It deletes the answer or answers associated to the question.
     *
     * @param questionInstance It represents to the question.
     * @return true If the action was completed successful.
     */
    def customDeleteQuestionAnswer (questionInstance) {
        log.debug("CustomDeleteService:customDeleteQuestionAnswer()")

        List queriesCatalogToExecute = []
        List queriesQuestionAnswerToExecute = []

        // Remove each relation of the question with the catalog
        def catalogs = [] + questionInstance.catalogs ?: []

        // Delete relations - Asynchronous/Multi-thread
        catalogs.each { Catalog catalog ->
            def catalogTask = tasks {
                catalog.removeFromQuestions(questionInstance)
            }
            queriesCatalogToExecute << catalogTask
        }
        waitAll(queriesCatalogToExecute)

        // Remove each relation of the answer with the question
        def answers = [] + questionInstance.answers ?: []

        // Delete relations - Asynchronous/Multi-thread
        answers.each { Answer answer ->
            def answerQuestionTask = tasks {
                answer.removeFromQuestionsAnswer(questionInstance)
            }
            queriesQuestionAnswerToExecute << answerQuestionTask
        }
        waitAll(queriesQuestionAnswerToExecute)

        // Delete answer
        answers.each { Answer answer ->
            // It deletes the answer
            answer.delete(flush: true, failOnError: true)
        }
    }

    /**
     * It deletes the content associated to the catalog.
     *
     * @param catalogInstance It represents to the catalog.
     * @return true If the action was completed successful.
     */
    def customDeleteCatalog (catalogInstance) {
        log.debug("CustomDeleteService:customDeleteCatalog()")

        // It searches each relation with question
        def questions = [] + catalogInstance.questions ?: []

        // Delete relations
        questions.each { Question question ->

            question.removeFromCatalogs(catalogInstance)

            // It searches each relation of the answer with question
            def answers = [] + question.answers ?: []

            answers.each { Answer answer ->
                answer.removeFromQuestionsAnswer(question)

                // It deletes the answer
                answer.delete(flush: true, failOnError: true)
            }
            // It deletes the question
            question.delete(flush: true, failOnError: true)
        }
    }

    /**
     * It deletes the content associated to the topic.
     *
     * @param topicInstance It represents to the topic.
     * @return true If the action was completed successful.
     */
    def customDeleteTopic (topicInstance) {
        log.debug("CustomDeleteService:customDeleteTopic()")

        // It searches each relation with tests
        def tests = [] + topicInstance.tests ?: []

        // Delete relations
        tests.each { Test test ->

            // It searches each relation of the test with catalog
            def catalogInstance = test.catalog

            // It searches each relation with question
            def questions = [] + catalogInstance.questions ?: []

            questions.each { Question question ->

                question.removeFromCatalogs(catalogInstance)

                // It searches each relation of the answer with question
                def answers = [] + question.answers ?: []

                answers.each { Answer answer ->
                    answer.removeFromQuestionsAnswer(question)
                    // It deletes the answer
                    answer.delete(flush: true, failOnError: true)
                }

                // It deletes the question
                question.delete(flush: true, failOnError: true)
            }

            topicInstance.delete(flush:true, failOnError: true)
            catalogInstance.removeFromTestCatalogs(test)
            catalogInstance.delete(flush: true, failOnError: true)
        }
    }
}
