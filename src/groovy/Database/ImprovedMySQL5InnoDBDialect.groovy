package Database

import org.hibernate.dialect.MySQL5InnoDBDialect;

/**
 * It fixes an error/warn with create-drop option in the database when any table exists: Unsuccessful: alter table.
 * This appears because Hibernate tries to delete the tables when these don't exist.
 */
public class ImprovedMySQL5InnoDBDialect extends MySQL5InnoDBDialect {

    /**
     * It obtains the table to drop.
     *
     * @param sequenceName Name of the sequence.
     * @return message Message.
     */
    @Override
    public String getDropSequenceString(String sequenceName) {
        // Adding the "if exists" clause to avoid warnings
        return "Drop sequence if exists " + sequenceName;
    }

    /**
     * It indicates the constraints in deletion.
     *
     * @return false It indicate not to drop constraints.
     */
    @Override
    public boolean dropConstraints() {
        // We don't need to drop constraints before dropping tables, that just leads to error
        // messages about missing tables when we don't have a schema in the database
        return false;
    }
}