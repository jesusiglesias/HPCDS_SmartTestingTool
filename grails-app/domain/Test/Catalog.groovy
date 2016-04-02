package Test

/**
 * It represents the general catalog information.
 */
class Catalog {

    UUID id
    // Attributes
    String name
    Integer testCatalogCount = 0
    Integer questionCount = 0

    // Relations
    static hasMany = [testCatalogs:Test, questions:Question]

    // It obtains the number of test that contains the catalog
    Integer getTestsCatalogCount () {
        testCatalogs?.size() ?: 0
    }

    // It obtains the number of questions that contains the catalog
    Integer getQuestionsCount () {
        questions?.size () ?: 0
    }

    def beforeInsert() {
        this.beforeUpdate()
    }

    def beforeUpdate () {
        testCatalogCount = getTestsCatalogCount()
        questionCount = getQuestionsCount()
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        name blank: false, unique: true, maxSize: 100
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}