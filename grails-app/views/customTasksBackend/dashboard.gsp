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
        // TODO
        var reloadLastUsers = '${g.createLink(controller: "customTasksBackend", action: 'reloadLastUsers')}';

    </script>

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
                                   <%-- TODO <i class="fa fa-refresh reloadLastUsers" onclick="${remoteFunction(controller: 'customTasksBackend', action: 'reloadLastUsers', update:'content-users')}"></i> --%>
                                    <i class="fa fa-refresh reloadGraph reloadLastUsers"></i>
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="remove"> </a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="scroller" style="height:505px" data-rail-visible="1" data-rail-color="#105d41" data-handle-color="#4A9F60">
                                    <!-- User registered: 10 -->
                                    <g:each in="${lastUsers}" var="user">
                                        <div class="mt-comments">
                                            <div class="mt-comment">
                                                <div class="mt-comment-img">
                                                    <g:if test="${user?.avatar}">
                                                        <img class="img-circle recentUser-image" alt="Profile image"  src="${createLink(controller:'customTasksBackend', action:'profileImage', id: user?.id)}" />
                                                    </g:if>
                                                    <g:else>
                                                        <img class="img-circle recentUser-image" alt="Profile image" src="${resource(dir: 'img/profile', file: 'user_profile.png')}"/>
                                                    </g:else>
                                                </div>
                                                <div class="mt-comment-body">
                                                    <div class="mt-comment-info">
                                                        <span class="mt-comment-author">${user?.username}</span>
                                                        <span class="mt-comment-date"><g:formatDate formatName="custom.date.format" date="${user?.dateCreated}" class="format-date"/></span>
                                                    </div>
                                                    <div class="mt-comment-text">${user?.email}</div>
                                                    <div class="mt-comment-details">
                                                        <g:if test="${user?.enabled}">
                                                            <span class="mt-comment-status label label-sm label-success circle">
                                                        </g:if>
                                                        <g:else>
                                                            <span class="mt-comment-status label label-sm label-info circle">
                                                        </g:else>
                                                        <g:formatBoolean boolean="${user?.enabled}" true="${g.message(code: "default.enabled.label.true", default: "Confirmed")}" false="${g.message(code: "default.enabled.label.false", default: "Pending")}"/>
                                                    </span>
                                                        <ul class="mt-comment-actions">
                                                            <li>
                                                                <g:link controller="user" action="edit" id="${user?.id}" class="btn blue-soft"><g:message code="default.button.edit.label" default="Edit"/></g:link>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </g:each>
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
