<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title" default="STT | Administration panel"/></title>
</head>

<body>
    <!-- Page-content-wrapper -->
    <div class="page-content-wrapper">
        <!-- Page-content -->
        <div class="page-content">
            <!-- Page-bar -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.dashboard" default="Dashboard & Statistics"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link controller="customTasksBackend" action="dashboard"><g:message code="layouts.main_auth_admin.body.title.controlPanel" default="Control panel"/></g:link>
                <i class="icon-arrow-right icon-title-admin"></i>
                <small class="subtitle-logPage"><g:message code="layouts.main_auth_admin.body.subtitle.controlPanel" default="Statistics"/></small>
            </h3>

        </div> <!-- Page-content -->
    </div> <!-- /. Page-content-wrapper -->
</body>
</html>
