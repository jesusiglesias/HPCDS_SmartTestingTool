package Enumerations

/**
 * Difficulty level enumeration.
 */
public enum DifficultyLevel {

    // Enumeration values
    EASY('enumerations.difficultyLevel.EASY'),
    MEDIUM('enumerations.difficultyLevel.MEDIUM'),
    DIFFICULT('enumerations.difficultyLevel.DIFFICULT')

    String level

    /**
     * It establishes the level of a test.
     *
     * @param level String that represents the level.
     */
    public DifficultyLevel(String level) {
        this.level = level
    }
}