package Security

/**
 * It represents the general token information.
 */
class Token {

    // Attributes
    String token // Encrypted string
    String tokenType
    String tokenStatus
    Date dateCreated

    // Restrictions on the attributes of the entity
    static constraints = {
        tokenType inList: ['restore', 'newAccount']
        tokenStatus defaultValue:false
        dateCreated blank:false
    }
}
