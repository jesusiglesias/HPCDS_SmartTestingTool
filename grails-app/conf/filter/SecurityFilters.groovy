package filter

import XSS.MarkupUtils
import grails.util.Holders

/**
 * Filter to remove the text with xml format in each controller/action (before).
 */
class SecurityFilters {

    // Referer must match serverURL, optionally https
    static validRefererPrefix = "^${Holders.config.grails.serverURL}".replace("http", "https?")
    static validRefererPrefixHTTPS = "^${Holders.config.grails.serverURL}".replace("http", "https?").replace("8080", "8443")

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

                    return referer && (referer =~ validRefererPrefix || referer =~ validRefererPrefixHTTPS)
                }
            }
        }

        // It adds the HSTS header
        hsts(controller: '*', action: '*') {

            after = { Map model ->
                // It lets a web site tell browsers that it should only be communicated with using HTTPS, instead of using HTTP
                if ( request.isSecure() || request.getHeader('X-Forwarded-Proto')?.toLowerCase() == 'https' ) {
                    response.setHeader('Strict-Transport-Security', "max-age=2628000") // One month
                }

            }
        }

        // It adds the XSS-Protection header
        xssProtection(controller: '*', action: '*') {

            after = { Map model ->
                // It forces XSS protection (useful if XSS protection was disabled by the user)
                response.setHeader('X-XSS-Protection', "1; mode=block")
            }
        }

        // It adds the X-Content-Type-Options header
        contentType(controller: '*', action: '*') {

            after = { Map model ->
                // It prevents "mime" based attacks
                response.setHeader('X-Content-Type-Options', "nosniff")
            }
        }
    }
}