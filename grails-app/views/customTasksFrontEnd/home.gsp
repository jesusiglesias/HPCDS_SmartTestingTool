<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.home" default="STT | Home page"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/iconfont', file: 'icofont.css')}" type="text/css"/>
</head>
<body>

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
