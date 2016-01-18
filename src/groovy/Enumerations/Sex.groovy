package Enumerations

/**
 * Sex enumeration
 */
public enum Sex {

    // Enumeration values
    MALE('enumerations.sex.MALE'),
    FEMALE('enumerations.sex.FEMALE')

    String gender

    // Constructor
    public Sex(String gender) {
        this.gender = gender
    }
}

