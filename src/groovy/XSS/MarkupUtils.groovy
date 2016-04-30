package XSS

/**
 * It avoids XSS attacks in the web inputs.
 */
class MarkupUtils {

    /**
     *  It receives a string and deletes the fragments that have xml format.
     *
     * @param original Original text.
     * @return result Text filtered.
     */
    static String removeMarkup (String original) {

        def regex = "</?\\w+((\\s+\\w+(\\s*=\\s*(?:\".*?\"|'.*?'|[^\'\">\\s]+))?)+\\s*|\\s*)/?>"

        def matcher = original =~ regex;
        def result = matcher.replaceAll("");

        return result;
    }
}