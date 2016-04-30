package filter

import XSS.MarkupUtils

/**
 * Filter to remove the text with xml format in each controller/action (before).
 */
class SecurityFilters {

    def filters = {
        // Filter applied to the entire system
        xss(controller:'*', action:'*') {

            // Before the controller action
            before = {

                if(true || request.method == 'GET'){

                    params.each { entry ->
                        if(entry.value instanceof String){
                            // Remove the character with xml format
                            params[entry.key] = MarkupUtils.removeMarkup(entry.value)
                        }
                    }
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}

