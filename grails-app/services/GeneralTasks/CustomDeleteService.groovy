package GeneralTasks

import Security.SecUserSecRole
import Test.Answer
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
        log.error(questions)
        questions.each { Question question ->
            question.removeFromAnswers(answerInstance)
        }
    }

    /**
     * It deletes the answer or answers associated to question.
     *
     * @param questionInstance It represents to the question.
     * @return true If the action was completed successful.
     */
    def customDeleteQuestion (questionInstance) {
        log.debug("CustomDeleteService:customDeleteQuestion()")

        // Remove each relation of the answer with the question
        def answers = [] + questionInstance.answers ?: []
        log.error(answers)
        answers.each { Answer answer ->
            answer.removeFromQuestionsAnswer(questionInstance)
            answer.delete(flush: true, failOnError: true)
        }
    }
}
