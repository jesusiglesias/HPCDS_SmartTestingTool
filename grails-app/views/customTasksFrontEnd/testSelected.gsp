<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.testSelected" default="STT | Test selected"/></title>
</head>
<body>

    <!-- Horizontal menu -->
    <content tag="horizontalMenu">
        <div class="hor-menu hidden-sm hidden-xs">
            <ul class="nav navbar-nav">
                <li>
                    <g:link uri="/faq"><g:message code="layout.main_auth_user.horizontal.menu.faq" default="Help"/></g:link>
                </li>
                <li>
                    <g:link uri="/contact"><g:message code="layout.main_auth_user.horizontal.menu.contact" default="Contact"/></g:link>
                </li>
                <li>
                    <g:link uri="/cookiesPolicy"><g:message code="layout.main_auth_user.horizontal.menu.cookie" default="Cookies policy"/></g:link>
                </li>
            </ul>
        </div>
    </content>

    <!-- Responsive horizontal menu -->
    <content tag="responsiveHorizontalMenu">
        <li class="nav-item">
            <g:link uri="/faq" class="nav-link">
                <i class="icofont icofont-info"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.faq" default="Help"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
        <li class="nav-item">
            <g:link uri="/contact" class="nav-link">
                <i class="icofont icofont-speech-comments"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.contact" default="Contact"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
        <li class="nav-item">
            <g:link uri="/cookiesPolicy" class="nav-link">
                <i class="icofont icofont-file-text"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.cookie" default="Cookies policy"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
    </content>

    <!-- Page-bar -->
    <div class="page-bar-user">
        <ul class="page-breadcrumb">
            <li>
                <i class="icofont icofont-ui-home"></i>
                <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span><g:message code="layouts.main_auth_user.body.title.testSelected" default="Test selected"/></span>
            </li>
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-topicSelected">
                <h3 class="page-title-user-topicSelected-title">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.topicSelected.title", default:"Available test"))}
                </h3>
                <p class="page-title-user-topicSelected-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.topicSelected.description", default:"Complete the test to score your knowledge in different topics."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Topics -->
    <div class="row row-userLayoutTitle-topicSelected">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-test-section">
                <h3 class="page-title-user-test-section-title hvr-bubble-float-bottom">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.topicSelected.topic", default:"<span class='thin text-lowercase'>{0}</span> topic", args:["${topicName}"]))}
                </h3>
                <p class="page-title-user-test-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.topicSelected.topic.description", default:"Select a test from the available to access evaluation. <strong>Note:</strong> the test may have an activation in a certain date range, a \
    limit time for its realization or maximum number of attempts. <br><br> <strong>Read the description carefully before accessing it.</strong>"))}
                </p>
            </div>
        </div>
    </div>

</body>
</html>
