package Test

/**
 * It represents the general answer information.
 */
class Answer {

    // Attributes
    boolean correct
    String description
    Integer score

    // Relations
    static hasMany = [questions:Question]
    static belongsTo = Question

    // Restrictions on the attributes of the entity
    static constraints = {
    }
}
