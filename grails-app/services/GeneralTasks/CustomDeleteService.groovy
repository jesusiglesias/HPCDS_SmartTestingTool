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

        // It searches all users
        def userDeleted = User.findAllByDepartment(departmentInstance)

        // Delete SecUserSecRole relations
        userDeleted.each { User user ->

            // It deletes the relation with evaluation and evaluation
            user.evaluations.each { evaluation ->

                // Test relation
                def test = Test.findByName(evaluation.testName)
                if (test != null) {
                    test.removeFromEvaluationsTest(evaluation)
                }

                // Evaluation relation
                user.removeFromEvaluations(evaluation)
                evaluation.delete(flush: true, failOnError: true)
            }

            SecUserSecRole.findAllBySecUser(user)*.delete(flush: true, failOnError: true)
        }
    }

    /**
     * It deletes the test even if it is associated with a user.
     *
     * @param testInstance It represents to the test.
     * @return true If the action was completed successful.
     */
    def customDeleteTest (testInstance) {
        log.debug("CustomDeleteService:customDeleteTest()")

        // Remove each relation of the test with the user
        def users = [] + testInstance.allowedUsers ?: []

        // Delete relations
        users.each { User user ->
            user.removeFromAccessTests(testInstance)
        }
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

        // Delete relations
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

        // Delete relations - Asynchronous/Multi-thread
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
        def catalogs = [] + questionInstance?.catalogs ?: []

        // Delete relations - Asynchronous/Multi-thread
        catalogs.each { Catalog catalog ->
            catalog.removeFromQuestions(questionInstance)
        }

        // Remove each relation of the answer with the question
        def answers = [] + questionInstance?.answers ?: []

        // Delete relations
        answers.each { Answer answer ->
            answer.removeFromQuestionsAnswer(questionInstance)

            // Remove each relation of the answer with the others questions
            def answerQuestions = [] + answer?.questionsAnswer ?: []

            answerQuestions.each { Question question ->
                question.removeFromAnswers(answer)
            }

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

            // Remove each relation of the question with the others catalogs
            def questionCatalogs = [] + question?.catalogs ?: []

            questionCatalogs.each { Catalog catalog ->
                catalog.removeFromQuestions(question)
            }

            // It searches each relation of the answer with question
            def answers = [] + question.answers ?: []

            answers.each { Answer answer ->
                answer.removeFromQuestionsAnswer(question)

                // Remove each relation of the answer with the others questions
                def answerQuestions = [] + answer?.questionsAnswer ?: []

                answerQuestions.each { Question questionInstance ->
                    questionInstance.removeFromAnswers(answer)
                }

                // It deletes the answer
                answer.delete(flush: true, failOnError: true)
            }
            // It deletes the question
            question.delete(flush: true, failOnError: true)
        }
    }

    /**
     * It deletes the relation of user with accessible test.
     *
     * @param catalogInstance It represents to the catalog.
     * @return true If the action was completed successful.
     */
    def customDeleteCatalogUsersTest (catalogInstance) {
        log.debug("CustomDeleteService:customDeleteCatalogUsersTest()")

        // It searches each relation with test
        def test = [] + catalogInstance.testCatalogs ?: []

        // Delete relations
        test.each { Test testInstance ->

            // It searches each relation of the test with user
            def usersAssigned = [] + testInstance.allowedUsers ?: []

            usersAssigned.each { User user ->
                user.removeFromAccessTests(testInstance)
            }
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

    /**
     * It deletes the relation of user with accessible test.
     *
     * @param topicInstance It represents to the topic.
     * @return true If the action was completed successful.
     */
    def customDeleteTopicUsersTest (topicInstance) {
        log.debug("CustomDeleteService:customDeleteTopicUsersTest()")

        // It searches each relation with test
        def test = [] + topicInstance.tests ?: []

        // Delete relations
        test.each { Test testInstance ->

            // It searches each relation of the test with user
            def usersAssigned = [] + testInstance.allowedUsers ?: []

            usersAssigned.each { User user ->
                user.removeFromAccessTests(testInstance)
            }
        }
    }
}
