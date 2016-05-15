<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.home" default="STT | Home page"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/iconfont', file: 'icofont.css')}" type="text/css"/>
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
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title TODO -->
    <h3 class="page-title-user">
        <g:message code="layouts.main_auth_user.body.title.home" default="Welcome to SMART TESTING TOOL"/>
    </h3>

</body>
</html>
