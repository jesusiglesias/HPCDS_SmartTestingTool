package User

// Imports
import Enumerations.Sex

/**
 * It represents the general user information.
 */
class User {

    String address
    String avatar
    Date birthDate
    String city
    String country
    String name
    String phone
    Sex sex
    String surname
    Integer zipCode

    static constraints = {
    }
}
