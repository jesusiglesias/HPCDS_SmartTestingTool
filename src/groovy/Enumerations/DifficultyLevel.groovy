package Enumerations

/**
 * Difficulty level enumeration
 */
public enum DifficultyLevel {
    EASY('enumerations.difficultyLevel.EASY'),
    MEDIUM('enumerations.difficultyLevel.MEDIUM'),
    DIFFICULT('enumerations.difficultyLevel.DIFFICULT')

    String level

    // Constructor
    public DifficultyLevel(String level) {
        this.level = level
    }
}