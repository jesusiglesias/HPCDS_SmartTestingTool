package Test

/**
 * It represents the general catalog information.
 */
class Catalog {

    UUID id
    // Attributes
    String name

    // Restrictions on the attributes of the entity
    static constraints = {
        name blank: false, unique: true, maxSize: 50
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}
