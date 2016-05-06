<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.cookie" default="STT | Cookie policy"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/iconfont', file: 'icofont.css')}" type="text/css"/>
    <!-- Cookie message -->
    <g:javascript src="cookies/cookies.js"/>
</head>
<body>

    <sec:ifLoggedIn>
        <!-- Page-bar -->
        <div class="page-bar-user">
            <ul class="page-breadcrumb">
                <li>
                    <i class="icofont icofont-ui-home"></i>
                    <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                    <i class="fa fa-circle"></i>
                </li>
                <li>
                    <span><g:message code="layouts.main_auth_user.body.title.cookie" default="Cookie policy"/></span>
                </li>
            </ul>
        </div> <!-- /.Page-bar -->
    </sec:ifLoggedIn>

    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-cookie">
                <h3 class="page-title-user-cookie-title">
                    <g:message code="layouts.main_auth_user.body.title.cookie" default="Cookie policy"/>
                </h3>
                <p class="page-title-user-cookie-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.description", default:"This site, like most web sites, uses <i>cookies</i> to improve and optimize the user experience. Here, you can " +
                            "find detailed information about what are the <strong><i>cookies</i></strong>, what type this website uses, how can you disable them in your browser and how to specifically block the " +
                            "installation of third-party <i>cookies</i>. <br><br> <strong class='uppercase'>Smart testing tool</strong> uses own <i>cookies</i> and third parties to provide a better experience and service. " +
                            "When browsing or using the service, the user accepts the use we make of them. However, the user has the option of preventing the generation and disposal of them by selecting the appropriate " +
                            "option in his browser. If you block the use of <i>cookies</i> in your browser it is possible that some services or functionalities of the site are not available or present a malfunction."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Section: What is a cookie? -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-cookie-section">
                <h3 class="page-title-user-cookie-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.cookie.section.one.title" default="What is a cookie?"/>
                </h3>
                <p class="page-title-user-cookie-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:"<i>Cookies</i> are small files that some platforms, such as web pages, can install on your computer, mobile device" +
                            " (smathphone, tablet, etc.), to access them. Its functions can be varied, including: storing your browsing preferences, collect information about browsing habits of a user or your computer to the point of " +
                            "recognizing the user, according to the information they contain and how to use. <br><br> A <i>cookie</i> is stored on a computer to customize and facilitate user navigation. They take on a very important role" +
                            " to improve the experience of using the web. In other words, it is a piece of information sent by a web site and stored in the user's browser so that the website can consult the previous user activity."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Section: What cookies does smart testing tool use? -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-cookie-section">
                <h3 class="page-title-user-cookie-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.cookie.section.two.title" default="What cookies does smart testing tool use?"/>
                </h3>
                <p class="page-title-user-cookie-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.two.description", default:"<span class='sbold'>OWN COOKIES</span> <br> Those that allow the user to navigate through the platform and the use of different " +
                            "options or services that exist. For example, identify the automatic login, access to restricted parts, use security features while browsing, etc. <br><br> <span class='sbold'>SESSION COOKIES</span> <br> Those that are generated " +
                            "when an user is identified on the platform. They are used to identify its user account and its associated services, thereby facilitating their navigation. These <i>cookies</i> are maintained while user does not " +
                            "leave the account, close the browser or shut down the device. <br><br> <span class='sbold'>PERSISTENT COOKIES</span> <br> Those that persist in the device and can be accessed and treated for a defined time period. <br><br>" +
                            " <span class='sbold'>ANALYTICAL COOKIES</span> <br> Those that allow quantify and collect statistical information about the use of the platform by users in order to improve the user experience."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Section: Revocation and deleting cookies -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-cookie-section">
                <h3 class="page-title-user-cookie-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.cookie.section.three.title" default="Revocation and deleting cookies"/>
                </h3>
                <p class="page-title-user-cookie-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.three.description", default:"You may stop accepting browser cookies, or stop accepting cookies from a particular service by modifying your browser settings. " +
                            "These adjustments are normally found in the <i>Options</i> or <i>Preferences</i> tab in the main menu. The instructions for the major browsers are listed below: <br><br> <span class='sbold'>GOOGLE CHROME</span> <br> " +
                            "<a href='https://support.google.com/chrome/answer/95647?hl=es' class=\"break-word\">https://support.google.com/chrome/answer/95647?hl=es</a>.<br><br> <span class='sbold'>MOZILLA FIREFOX</span> <br>" +
                            " <a href='https://support.mozilla.org/es/kb/habilitar-y-deshabilitar-cookies-que-los-sitios-we' class=\"break-word\">https://support.mozilla.org/es/kb/habilitar-y-deshabilitar-cookies-que-los-sitios-we</a>.<br><br> <span class='sbold'>INTERNET EXPLORER</span> <br> " +
                            "<a href='http://windows.microsoft.com/es-es/internet-explorer/delete-manage-cookies' class=\"break-word\">http://windows.microsoft.com/es-es/internet-explorer/delete-manage-cookies</a>.<br><br> <span class='sbold'>SAFARI</span> <br> " +
                            "<a href='https://support.apple.com/es-es/HT201265' class=\"break-word\">https://support.apple.com/es-es/HT201265</a>.<br><br> <span class='sbold'>OPERA</span> <br> " +
                            "<a href='https://www.opera.com/help/tutorials/security/privacy/' class=\"break-word\">https://www.opera.com/help/tutorials/security/privacy/</a>.<br><br> For more information, you can consult your browser support or the company owning the browser."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Section: Acceptance of cookies policy -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-cookie-section">
                <h3 class="page-title-user-cookie-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.cookie.section.four.title" default="Acceptance of cookies policy"/>
                </h3>
                <p class="page-title-user-cookie-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.four.description", default:"<strong>If you continue browsing once informed about the cookies policy, we understand that you accept the use of cookies by the platform.</strong> However, you can change your " +
                            "cookie settings at any time, configuring your browser for acceptance or not. SMART TESTING TOOL thank you the acceptance of cookies because this helps us to obtain more precise data and improve the content and design of the platform to suit their preferences. <br><br>" +
                            "<strong>Update of the policy cookies?</strong> <br> This <i>cookies policy</i> can be modified depending on, regulations, or in order to adapt the policy to the instructions issued by the Spanish Data Protection Agency, so it is recommended that the users visit it " +
                            "periodically in order to be properly informed about how and why we use cookies. <br> <strong>Cookies policy was last updated date time [15 July 2016].</strong> If you have questions about this policy of cookies, you can contact with SMART TESTING TOOL at the " +
                            "following address: <a href=\"mailto:smartestingtool.info@gmail.com\" class=\"break-word\">smartestingtool.info@gmail.com</a>."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Cookie block - Template -->
    <g:render template="../template/cookieBanner"/>

</body>
</html>