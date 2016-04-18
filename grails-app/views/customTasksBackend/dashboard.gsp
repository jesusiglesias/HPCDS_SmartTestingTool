<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title" default="STT | Administration panel"/></title>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <script>

        // Load the Visualization API and the piechart package.
        google.load('visualization', '1.1', {'packages': ['corechart']});

        var dataJSON;

        // Auto close alert
        function createAutoClosingAlert(selector) {
            var messageAlert = $(selector);

            window.setTimeout(function() {
                messageAlert.slideUp(1000, function(){
                    $(this).remove();
                });
            }, 5000);
        }

        // It draws the chart pie when the window resizes
        function drawChartResize() {

            // Create the data table out of JSON data loaded from server
            var dataUDResize = new google.visualization.DataTable(dataJSON);

            var chartHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
            var chartWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) + 'px';

            var options = {
                fontName: "Open Sans",
                chartArea: {width: '75%', height: '75%'},
                legend: "none",
                is3D: true,
                height: chartHeight,
                width: chartWidth,
                backgroundColor: {fill: "transparent"}
            };

            // Instantiate and draw the chart, passing in some options
            var chartUDResize = new google.visualization.PieChart(document.getElementById('chart_UD'));
            chartUDResize.draw(dataUDResize, options);
        }

        // Set a callback to run when the Google Visualization API is loaded.
        google.setOnLoadCallback(drawChart);

        // It draws the chart pie
        function drawChart() {

            var contentChartUD = $('.portlet-graphUD');

            $.ajax({
                url: "${createLink(controller:'customTasksBackend', action:'userEachDepartment')}",
                dataType: "json",
                beforeSend: function () {

                    contentChartUD.LoadingOverlay("show", {
                        image: "",
                        fontawesome: "fa fa-spinner fa-spin"
                    });
                },
                success: function (jsonData) {

                    dataJSON = jsonData;

                    // Create the data table out of JSON data loaded from server
                    var dataUD = new google.visualization.DataTable(jsonData);

                    var chartHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
                    var chartWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) + 'px';

                    var options = {
                        fontName: "Open Sans",
                        chartArea: {width: '75%', height: '75%'},
                        legend: "none",
                        is3D: true,
                        height: chartHeight,
                        width: chartWidth,
                        backgroundColor: {fill: "transparent"}
                    };

                    // Instantiate and draw the chart, passing in some options
                    var chartUD = new google.visualization.PieChart(document.getElementById('chart_UD'));
                    chartUD.draw(dataUD, options);
                },
                error: function () {

                    var listMessageUD = $('.list-messageUD');

                    // Avoid duplicates
                    if (listMessageUD.length) {
                        listMessageUD.remove();
                    }

                    // Message
                    $('#chart_UD').prepend("<ul class='list-group list-messageUD'><li class='list-group-item bg-red-intense bg-font-red-intense' style='margin-right: -12px'>" + reloadAjaxError + "</li></ul>");

                    createAutoClosingAlert('.list-messageUD');
                },
                complete: function () {
                    setTimeout(function () {
                        contentChartUD.LoadingOverlay("hide");
                    }, 500);
                }
            });
        }

        jQuery(document).ready(function() {

            // Resizing the chart pie UD
            $(window).resize(function(){
                drawChartResize();
            });
        });
    </script>
</head>

<body>

    <script type="text/javascript">

        // Variables to use in javascript
        var fullscreenTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.fullscreen', default:'Fullscreen!')}';
        var removeTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.remove', default:'Remove')}';
        var collapseTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.collapse', default:'Collapse/Expand')}';
        var reloadTooltip = '${g.message(code:'default.button.reload.tooltip', default:'Reload')}';
        var reloadAjaxError = '${g.message(code:'default.ajax.error', default:'Error on reloading the content. Please, you try again later.')}';
        var reloadUsersURL = '${g.createLink(controller: "customTasksBackend", action: 'reloadUsers')}';
        var reloadTestURL = '${g.createLink(controller: "customTasksBackend", action: 'reloadTest')}';
        var reloadEvaluationsURL = '${g.createLink(controller: "customTasksBackend", action: 'reloadEvaluations')}';

    </script>

    <!-- Page-sidebar-wrapper -->
    <div class="page-sidebar-wrapper">
        <!-- Page-sidebar -->
        <div class="page-sidebar navbar-collapse collapse">
            <!-- Page-sidebar-menu -->
            <ul class="page-sidebar-menu page-header-fixed" data-keep-expanded="true" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 30px">
                <li class="sidebar-search-wrapper">
                    <g:form class="sidebar-search" controller="user" action="index">
                        <a href="javascript:;" class="remove">
                            <i class="icon-close"></i>
                        </a>
                        <div class="input-group">
                            <!-- ie8, ie9 does not support html5 placeholder, so it just shows field title for that-->
                            <label class="control-label visible-ie8 visible-ie9" for="quickSearch"><g:message code="layouts.main_auth_admin.sidebar.search" default="Search..."/></label>
                            <g:textField name="quickSearch" class="form-control placeholder-no-fix quickSearch-input backend-input" placeholder="${message(code:'layouts.main_auth_admin.sidebar.search', default:'Search...')}" autocomplete="on"/>
                            <i class="fa fa-times i-delete-quickSearch"></i> <!-- Delete text icon -->
                            <span class="input-group-btn">
                                <a href="javascript:;" class="btn submit">
                                    <i class="icon-magnifier"></i>
                                </a>
                            </span>
                        </div>
                    </g:form>
                </li> <!-- /.Search form -->

                <li class="nav-item start active open">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="icon-home"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard" default="Dashboard"/></span>
                        <span class="selected"></span>
                        <span class="arrow open"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item start active open">
                            <g:link controller="customTasksBackend" action="dashboard" class="nav-link">
                                <i class="fa fa-bar-chart"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard.statistics" default="Statistics"/></span>
                                <span class="selected"></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- USERS -->
                <li class="heading">
                    <h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.users" default="Users"/></h3>
                </li>

                <!-- Admin user -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-user-secret"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.admin" default="Admin user"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link uri="/administrator/create" class="nav-link">
                                <i class="fa fa-user-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/administrator" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Normal user -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-user"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.normalUser" default="Normal user"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="user" action="create" class="nav-link">
                                <i class="fa fa-user-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/user" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>
                <!-- /.USERS -->

                <!-- GENERAL -->
                <li class="heading">
                    <h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.general" default="General"/></h3>
                </li>

                <!-- Department -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-building"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.department" default="Department"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="department" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/department" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Topic -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-briefcase"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.topic" default="Topic"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="topic" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/topic" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Catalog -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-folder-open"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.catalog" default="Catalog"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="catalog" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/catalog" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Question -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-question"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.question" default="Question"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="question" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/question" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Answer -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-pencil"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.answer" default="Answer"/></span>
                        <span class="selected"></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="answer" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/answer" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>
                <!-- /.GENERAL -->

                <!-- EVALUATION PROCESS -->
                <li class="heading">
                    <h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.evaluationProcess" default="Evaluation process"/></h3>
                </li>

                <!-- Test -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-file-text"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.test" default="Test"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="test" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/test" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Evaluation -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-graduation-cap"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.evaluation" default="Evaluation"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link uri="/evaluation" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>
                <!-- /.TEST -->

                <!-- CONFIGURATION -->
                <li class="heading">
                    <h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.configuration" default="Configurations"/></h3>
                </li>
                <li class="nav-item">
                    <g:link controller="customTasksBackend" action="reloadLogConfig" class="nav-link">
                        <i class="icon-settings"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.logConfiguration" default="Log configuration"/></span>
                        <span class="arrow"></span>
                    </g:link>
                </li>
                <!-- /.CONFIGURATION -->
            </ul> <!-- /.Page-sidebar-menu -->
        </div> <!-- Page-sidebar -->
    </div> <!-- Page-sidebar-wrapper -->

    <!-- Page-content-wrapper -->
    <div class="page-content-wrapper">
        <!-- Page-content -->
        <div class="page-content">
            <!-- Page-bar -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <i class="fa fa-home home-icon"></i>
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

            <!-- Contain page -->
            <div id="list-panel">

                <!-- Widget -->
                <div class="row panel-row">
                    <div class="col-md-4">
                        <!-- Widget thumb -->
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered widget-users">
                            <h4 class="widget-thumb-heading"><g:message code="layouts.main_auth_admin.body.widget.user" default="Normal users"/></h4>
                            <i class="fa fa-refresh iconReload reloadUsers"></i>
                        <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon bg-green-dark icon-user"></i>
                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle"><g:message code="layouts.main_auth_admin.body.widget.total" default="Total"/></span>
                                    <span class="widget-thumb-body-stat counterUsers" data-counter="counterup" data-value="${normalUsers}">${normalUsers}</span>
                                </div>
                            </div>
                        </div> <!-- /.Widget thumb -->
                    </div>
                    <div class="col-md-4">
                        <!-- Widget thumb -->
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered widget-test">
                            <h4 class="widget-thumb-heading"><g:message code="layouts.main_auth_admin.body.widget.test" default="Active test"/></h4>
                            <i class="fa fa-refresh iconReload reloadTest"></i>
                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon bg-red icon-note"></i>
                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle"><g:message code="layouts.main_auth_admin.body.widget.total" default="Total"/></span>
                                    <span class="widget-thumb-body-stat counterTest" data-counter="counterup" data-value="${test}">${test}</span>
                                </div>
                            </div>
                        </div> <!-- /.Widget thumb -->
                    </div>
                    <div class="col-md-4">
                        <!-- Widget thumb -->
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered widget-evaluations">
                            <h4 class="widget-thumb-heading"><g:message code="layouts.main_auth_admin.body.widget.evaluation" default="Qualified evaluations"/></h4>
                            <i class="fa fa-refresh iconReload reloadEvaluations"></i>
                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon bg-yellow-saffron icon-star"></i>
                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle"><g:message code="layouts.main_auth_admin.body.widget.total" default="Total"/></span>
                                    <span class="widget-thumb-body-stat counterEvaluations" data-counter="counterup" data-value="${evaluations}">${evaluations}</span>
                                </div>
                            </div>
                        </div> <!-- /.Widget thumb -->
                    </div>
                </div> <!-- /.Widget -->

                <!-- Graphs -->
                <div class="row">

                    <!-- Last 10 users registered -->
                    <div class="col-md-6">
                        <!-- Portlet -->
                        <div class="portlet light bg-inverse portlet-users">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <i class="icon-people font-green-dark"></i>
                                    <span class="caption-subject sbold uppercase"><g:message code="layouts.main_auth_admin.body.portlet.recentUsers" default="Recent users"/></span>
                                </div>
                                <div class="tools">
                                    <i class="fa fa-refresh reloadGraph reloadLastUsers"></i>
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="remove"> </a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="scroller" style="height:505px" data-rail-visible="1" data-rail-color="#105d41" data-handle-color="#4A9F60">
                                    <div class="content-lastUsers">
                                        <g:render template="lastUsers"  model="['lastUsers':lastUsers]"/>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- /.Portlet -->
                    </div>

                    <!-- Users in each department -->
                    <div class="col-md-6">
                        <!-- Portlet -->
                        <div class="portlet light bg-inverse portlet-graphUD">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <i class="fa fa-pie-chart font-green-dark"></i>
                                    <span class="caption-subject sbold uppercase"><g:message code="layouts.main_auth_admin.body.portlet.users.departments" default="Users in each department"/></span>
                                </div>
                                <div class="tools">
                                    <i class="fa fa-refresh reloadGraph reloadUsersDepartment" onclick="drawChart()"></i>
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="remove"> </a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="scroller" style="height:505px" data-rail-visible="1" data-rail-color="#105d41" data-handle-color="#4A9F60">
                                    <div id="chart_UD" style="width:100%; height:100%"></div>
                                </div>
                            </div>
                        </div> <!-- /.Portlet -->
                    </div>
                </div> <!-- /.Graphs -->
            </div>
        </div> <!-- Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="custom/dashboard.js"/>
    <script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <g:javascript src="counter/jquery.counterup.min.js"/>
    <g:javascript src="overlay/loadingoverlay.min.js"/>

</body>
</html>
