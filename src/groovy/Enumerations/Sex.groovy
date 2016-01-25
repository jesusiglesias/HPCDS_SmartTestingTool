package Enumerations

/**
 * Sex enumeration.
 */
public enum Sex {

    // Enumeration values
    MALE('enumerations.sex.MALE'),
    FEMALE('enumerations.sex.FEMALE')

    String gender

    /**
     * It establishes the gender of an user.
     *
     * @param gender String that represents the gender.
     */
    public Sex(String gender) {
        this.gender = gender
    }
}

