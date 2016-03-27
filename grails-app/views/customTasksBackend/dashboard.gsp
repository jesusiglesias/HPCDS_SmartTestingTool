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
                <i class="icon-arrow-right icon-title-domain"></i>
                <small class="subtitle-inlinePage"><g:message code="layouts.main_auth_admin.body.subtitle.controlPanel" default="Statistics"/></small>
            </h3>

            <!-- Widget -->
            <div class="row widget-row">
                <div class="col-md-4">
                    <!-- Widget thumb -->
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                        <h4 class="widget-thumb-heading"><g:message code="layouts.main_auth_admin.body.widget.user" default="Normal users"/></h4>
                    <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-green icon-user"></i>
                            <div class="widget-thumb-body">
                                <span class="widget-thumb-subtitle"><g:message code="layouts.main_auth_admin.body.widget.total" default="Total"/></span>
                                <span class="widget-thumb-body-stat" data-counter="counterup" data-value="${normalUsers}">${normalUsers}</span>
                            </div>
                        </div>
                    </div> <!-- /.Widget thumb -->
                </div>
                <div class="col-md-4">
                    <!-- Widget thumb -->
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                        <h4 class="widget-thumb-heading">Weekly Sales</h4>
                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-red icon-layers"></i>
                            <div class="widget-thumb-body">
                                <span class="widget-thumb-subtitle">USD</span>
                                <span class="widget-thumb-body-stat" data-counter="counterup" data-value="1,293">0</span>
                            </div>
                        </div>
                    </div> <!-- /.Widget thumb -->
                </div>
                <div class="col-md-4">
                    <!-- Widget thumb -->
                    <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                        <h4 class="widget-thumb-heading">Biggest Purchase</h4>
                        <div class="widget-thumb-wrap">
                            <i class="widget-thumb-icon bg-purple icon-screen-desktop"></i>
                            <div class="widget-thumb-body">
                                <span class="widget-thumb-subtitle">USD</span>
                                <span class="widget-thumb-body-stat" data-counter="counterup" data-value="815">0</span>
                            </div>
                        </div>
                    </div> <!-- /.Widget thumb -->
                </div>
            </div> <!-- /.Widget -->

        </div> <!-- Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <g:javascript src="counter/jquery.counterup.min.js"/>

</body>
</html>
