package CustomConcurrentSessions

import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.web.authentication.session.ConcurrentSessionControlStrategy;
import org.springframework.security.core.Authentication;

/**
 * It permits to set the concurrent session control strategy for a user.
 */
class CustomConcurrentSessionControlStrategy extends ConcurrentSessionControlStrategy {

    /**
     * It updates the session registry.
     *
     * @param sessionRegistry Session id and principal of a user.
     */
    CustomConcurrentSessionControlStrategy(SessionRegistry sessionRegistry) {
        super(sessionRegistry)
    }

    /**
     * It sets the maximum number of concurrent sessions.
     *
     * @param authentication Information related to authentication of a user.
     * @return maximumSession Maximum concurrent sessions allowed for a user.
     */
    protected int getMaximumSessionsForThisUser(Authentication authentication) {

        // User role: 1
        Long maximumSession = 1

        // Admin role: endless sessions
        if ('ROLE_ADMIN' in authentication.authorities*.authority) {
            maximumSession = -1
        }
        return maximumSession;
    }
}

