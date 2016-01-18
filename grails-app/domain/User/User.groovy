package User

// Imports
import Enumerations.Sex

/**
 * It represents the general user information
 */
class User {

    String address
    Date birthDate
    String country
    String phone
    Sex sex
    String urlProfileImage
    Integer zipCode

    static constraints = {
    }
}
