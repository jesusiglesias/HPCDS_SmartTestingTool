package Test

/**
 * It represents the general topic information.
 */
class Topic {

    UUID id
    // Attributes
    String description
    String name
    boolean visibility = true

    // Restrictions on the attributes of the entity
    static constraints = {
        name blank: false, unique: true, maxSize: 50
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}

