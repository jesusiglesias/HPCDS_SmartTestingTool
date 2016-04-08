package GeneralTasks

import Security.SecUserSecRole
import Test.Answer
import Test.Catalog
import Test.Question
import User.User
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

        // It searches all users
        def userDeleted = User.findAllByDepartment(departmentInstance)

        // Delete SecUserSecRole relations
        SecUserSecRole.findAllBySecUser(userDeleted)*.delete(flush: true, failOnError: true)
    }

    /**
     * It deletes the answer even if it is associated with a question.
     *
     * @param answerInstance It represents to the answer.
     * @return true If the action was completed successful.
     */
    def customDeleteAnswer (answerInstance) {
        log.debug("CustomDeleteService:customDeleteAnswer()")

        // Remove each relation of the answer with the question
        def questions = [] + answerInstance.questionsAnswer ?: []
        questions.each { Question question ->
            question.removeFromAnswers(answerInstance)
        }
    }

    /**
     * It deletes the relation with the catalogs.
     *
     * @param questionInstance It represents to the question.
     * @return true If the action was completed successful.
     */
    def customDeleteQuestion (questionInstance) {
        log.debug("CustomDeleteService:customDeleteQuestion()")

        // Remove each relation of the question with the catalog
        def catalogs = [] + questionInstance.catalogs ?: []
        catalogs.each { Catalog catalog ->
            catalog.removeFromQuestions(questionInstance)
        }
    }

    /**
     * It deletes the answer or answers associated to the question.
     *
     * @param questionInstance It represents to the question.
     * @return true If the action was completed successful.
     */
    def customDeleteQuestionAnswer (questionInstance) {
        log.debug("CustomDeleteService:customDeleteQuestionAnswer()")

        // Remove each relation of the question with the catalog
        def catalogs = [] + questionInstance.catalogs ?: []
        catalogs.each { Catalog catalog ->
            catalog.removeFromQuestions(questionInstance)
        }
        // Remove each relation of the answer with the question
        def answers = [] + questionInstance.answers ?: []
        answers.each { Answer answer ->
            answer.removeFromQuestionsAnswer(questionInstance)
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
}
