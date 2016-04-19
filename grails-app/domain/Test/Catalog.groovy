package Test

/**
 * It represents the general catalog information.
 */
class Catalog {

    UUID id
    // Attributes
    String name

    // Relations
    static hasMany = [testCatalogs:Test, questions:Question]
    
    // Restrictions on the attributes of the entity
    static constraints = {
        name blank: false, unique: true, maxSize: 60
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}