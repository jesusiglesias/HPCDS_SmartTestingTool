package filter

import XSS.MarkupUtils
import grails.util.Holders

/**
 * Filter to remove the text with xml format in each controller/action (before).
 */
class SecurityFilters {

    // Referer must match serverURL, optionally https
    static validRefererPrefix = "^${Holders.config.grails.serverURL}".replace("http", "https?")

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

        // It checks the referer in POST request. Requests must be from the application
        checkReferer(controller: '*', action: '*') {

            // Before the controller action
            before = {

                if (request.method.toUpperCase() == "POST" || request.method.toUpperCase() == "PUT") {
                    def referer = request.getHeader('Referer')

                    return referer && referer =~ validRefererPrefix
                }
            }
        }
    }
}