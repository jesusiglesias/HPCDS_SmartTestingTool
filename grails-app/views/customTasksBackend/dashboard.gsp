<%@ page import="Test.Test" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title" default="STT | Administration panel"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'bootstrap-select.min.css')}" type="text/css"/>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script>

        var _SRTitle = '${g.message(code: "layouts.main_auth_admin.body.portlet.range.scores.title", default: "Score")}';
        var _SRSubtitle = '${g.message(code: "layouts.main_auth_admin.body.portlet.range.scores.subtitle", default: "Total of scores")}';
        var _SRSuspense = '${g.message(code: "layouts.main_auth_admin.body.portlet.range.scores.suspense", default: "Score: < 5")}';
        var _SRApproved = '${g.message(code: "layouts.main_auth_admin.body.portlet.range.scores.approved", default: "Score: >= 5 y <7")}';
        var _SRRemarkable = '${g.message(code: "layouts.main_auth_admin.body.portlet.range.scores.remarkable", default: "Score: >= 7 y < 9")}';
        var _SROutstanding = '${g.message(code: "layouts.main_auth_admin.body.portlet.range.scores.outstanding", default: "Score: >= 9")}';
        var _AVSTitle = '${g.message(code: "layouts.main_auth_admin.body.portlet.score.sex.average", default: "Average score")}';
        var _AVSMale = '${g.message(code: "layouts.main_auth_admin.body.portlet.score.sex.male", default: "Male sex")}';
        var _AVSFemale = '${g.message(code: "layouts.main_auth_admin.body.portlet.score.sex.female", default: "Female sex")}';
        var _TSZero = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.zero", default: "Score [0-1)")}';
        var _TSOne = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.one", default: "Score [1-2)")}';
        var _TSTwo = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.two", default: "Score [2-3)")}';
        var _TSThree = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.three", default: "Score [3-4)")}';
        var _TSFour = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.four", default: "Score [4-5)")}';
        var _TSFive = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.five", default: "Score [5-6)")}';
        var _TSSix = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.six", default: "Score [6-7)")}';
        var _TSSeven = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.seven", default: "Score [7-8)")}';
        var _TSEight = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.eight", default: "Score [8-9)")}';
        var _TSNine = '${g.message(code: "layouts.main_auth_admin.body.portlet.scores.test.score.nine", default: "Score [9-10]")}';

        // Load the Visualization API and the piechart package.
        google.charts.load("current", {packages:['corechart']});
        // Set a callback to run when the Google Visualization API is loaded.
        google.setOnLoadCallback(drawVisualization);

        var dataJSONUD, dataJSONSR, dataJSONAVS, dataJSONTS;

        // Auto close alert
        function createAutoClosingAlert(selector) {
            var messageAlert = $(selector);

            window.setTimeout(function() {
                messageAlert.slideUp(1000, function(){
                    $(this).remove();
                });
            }, 5000);
        }

        function drawVisualization() {
            drawChart();
            drawChartScoresRank();
            drawChartAVScoreSex();
        }

        // It draws the chart pie when the window resizes
        function drawChartResize() {

            // Create the data table out of JSON data loaded from server
            var dataUDResize = new google.visualization.DataTable(dataJSONUD);

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

        // It draws the chart pie when the window resizes
        function drawChartResizeSR() {

            // Create the data table out of JSON data loaded from server
            var dataSRResize = google.visualization.arrayToDataTable([
                [_SRTitle, _SRSubtitle, { role: "style" } ],
                [_SRSuspense, dataJSONSR.suspense, "#C16868"],
                [_SRApproved, dataJSONSR.approved, "#D6B42F"],
                [_SRRemarkable, dataJSONSR.remarkable, "#4DB3A2"],
                [_SROutstanding, dataJSONSR.outstanding, "#0E5E3C"]
            ]);

            var chartHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
            var chartWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) + 'px';

            var viewSRResize = new google.visualization.DataView(dataSRResize);
            viewSRResize.setColumns([0, 1,
                { calc: "stringify",
                    sourceColumn: 1,
                    type: "string",
                    role: "annotation" },
                2]);

            var options = {
                fontName: "Open Sans",
                chartArea: {width: '75%', height: '75%'},
                legend: "none",
                height: chartHeight,
                width: chartWidth,
                backgroundColor: {fill: "transparent"}
            };

            // Instantiate and draw the chart, passing in some options
            var chartSRResize =  new google.visualization.ColumnChart(document.getElementById('chart_SR'));
            chartSRResize.draw(viewSRResize, options);
        }

        // It draws the chart pie when the window resizes
        function drawChartResizeAVS() {

            // Create the data table out of JSON data loaded from server
            var dataAVSResize = google.visualization.arrayToDataTable([
                [_AVSTitle, _AVSTitle, { role: "style" } ],
                [_AVSMale, dataJSONAVS.averageMale, "#245B9C"],
                [_AVSFemale, dataJSONAVS.averageFemale, "#B161B1"]
            ]);

            var chartHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
            var chartWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) + 'px';

            var viewAVSResize = new google.visualization.DataView(dataAVSResize);
            viewAVSResize.setColumns([0, 1,
                { calc: "stringify",
                    sourceColumn: 1,
                    type: "string",
                    role: "annotation" },
                2]);

            var options = {
                fontName: "Open Sans",
                chartArea: {width: '75%', height: '75%'},
                legend: "none",
                height: chartHeight,
                width: chartWidth,
                backgroundColor: {fill: "transparent"},
                vAxis: {
                    minValue: 0,
                    maxValue: 10,
                    gridlines:{count:6},
                    format:'0'
                }
            };

            // Instantiate and draw the chart, passing in some options
            var chartAVSResize =  new google.visualization.ColumnChart(document.getElementById('chart_AVS'));
            chartAVSResize.draw(viewAVSResize, options);
        }

        // It draws the chart pie when the window resizes
        function drawChartResizeTS() {

            if (dataJSONTS != null) {

                // Create the data table out of JSON data loaded from server
                var dataResizeTS = google.visualization.arrayToDataTable([
                    [_SRTitle, _SRSubtitle, { role: "style" } ],
                    [_TSZero, dataJSONTS.zero, "#4DB3A2"],
                    [_TSOne, dataJSONTS.one, "#4DB3A2"],
                    [_TSTwo, dataJSONTS.two, "#4DB3A2"],
                    [_TSThree, dataJSONTS.three, "#4DB3A2"],
                    [_TSFour, dataJSONTS.four, "#4DB3A2"],
                    [_TSFive, dataJSONTS.five, "#4DB3A2"],
                    [_TSSix, dataJSONTS.six, "#4DB3A2"],
                    [_TSSeven, dataJSONTS.seven, "#4DB3A2"],
                    [_TSEight, dataJSONTS.eight, "#4DB3A2"],
                    [_TSNine, dataJSONTS.nine, "#4DB3A2"]
                ]);

                var chartHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
                var chartWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) + 'px';

                var viewTSResize = new google.visualization.DataView(dataResizeTS);
                viewTSResize.setColumns([0, 1,
                    { calc: "stringify",
                        sourceColumn: 1,
                        type: "string",
                        role: "annotation" },
                    2]);

                var options = {
                    fontName: "Open Sans",
                    chartArea: {width: '90%', height: '75%'},
                    legend: "none",
                    height: chartHeight,
                    width: chartWidth,
                    backgroundColor: {fill: "transparent"},
                    vAxis: {
                        minValue: 0,
                        maxValue: 10,
                        gridlines:{count:6},
                        format:'0'
                    }
                };

                // Instantiate and draw the chart, passing in some options
                var chartTSResize =  new google.visualization.ColumnChart(document.getElementById('chart_TS'));
                chartTSResize.draw(viewTSResize, options);
            }
        }

        // It draws the chart pie (user in each department)
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
                success: function (jsonDataUD) {

                    // It uses to resize
                    dataJSONUD = jsonDataUD;

                    // Create the data table out of JSON data loaded from server
                    var dataUD = new google.visualization.DataTable(jsonDataUD);

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

        // It draws the column chart (scores by rank)
        function drawChartScoresRank() {

            var contentChartSR = $('.portlet-scoresRank');

            $.ajax({
                url: "${createLink(controller:'customTasksBackend', action:'scoresRank')}",
                dataType: "json",
                beforeSend: function () {

                    contentChartSR.LoadingOverlay("show", {
                        image: "",
                        fontawesome: "fa fa-spinner fa-spin"
                    });
                },
                success: function (jsonDataSR) {

                    // It uses to resize
                    dataJSONSR = jsonDataSR;
                    
                    // Create the data table out of JSON data loaded from server
                    var dataSR = google.visualization.arrayToDataTable([
                        [_SRTitle, _SRSubtitle, { role: "style" } ],
                        [_SRSuspense, jsonDataSR.suspense, "#C16868"],
                        [_SRApproved, jsonDataSR.approved, "#D6B42F"],
                        [_SRRemarkable, jsonDataSR.remarkable, "#4DB3A2"],
                        [_SROutstanding, jsonDataSR.outstanding, "#0E5E3C"]
                    ]);

                    var chartHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
                    var chartWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) + 'px';

                    var viewSR = new google.visualization.DataView(dataSR);
                    viewSR.setColumns([0, 1,
                        { calc: "stringify",
                            sourceColumn: 1,
                            type: "string",
                            role: "annotation" },
                        2]);

                    var options = {
                        fontName: "Open Sans",
                        chartArea: {width: '75%', height: '75%'},
                        legend: "none",
                        height: chartHeight,
                        width: chartWidth,
                        backgroundColor: {fill: "transparent"},
                        vAxis: {
                            logScale: true, scaleType:"mirrorLog"
                        }
                    };

                    // Instantiate and draw the chart, passing in some options
                    var chartSR =  new google.visualization.ColumnChart(document.getElementById('chart_SR'));
                    chartSR.draw(viewSR, options);
                },
                error: function () {

                    var listMessageSR = $('.list-messageSR');

                    // Avoid duplicates
                    if (listMessageSR.length) {
                        listMessageSR.remove();
                    }

                    // Message
                    $('#chart_SR').prepend("<ul class='list-group list-messageSR'><li class='list-group-item bg-red-intense bg-font-red-intense' style='margin-right: -12px'>" + reloadAjaxError + "</li></ul>");

                    createAutoClosingAlert('.list-messageSR');
                },
                complete: function () {
                    setTimeout(function () {
                        contentChartSR.LoadingOverlay("hide");
                    }, 500);
                }
            });
        }

        // It draws the column chart (average score by sex)
        function drawChartAVScoreSex() {

            var contentChartAVS = $('.portlet-scoreSex');

            $.ajax({
                url: "${createLink(controller:'customTasksBackend', action:'averageScoreSex')}",
                dataType: "json",
                beforeSend: function () {

                    contentChartAVS.LoadingOverlay("show", {
                        image: "",
                        fontawesome: "fa fa-spinner fa-spin"
                    });
                },
                success: function (jsonDataAVS) {

                    // It uses to resize
                    dataJSONAVS = jsonDataAVS;

                    // Create the data table out of JSON data loaded from server
                    var dataAVS = google.visualization.arrayToDataTable([
                        [_AVSTitle, _AVSTitle, { role: "style" } ],
                        [_AVSMale, jsonDataAVS.averageMale, "#245B9C"],
                        [_AVSFemale, jsonDataAVS.averageFemale, "#B161B1"]
                    ]);

                    var chartHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
                    var chartWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) + 'px';

                    var viewAVS = new google.visualization.DataView(dataAVS);
                    viewAVS.setColumns([0, 1,
                        { calc: "stringify",
                            sourceColumn: 1,
                            type: "string",
                            role: "annotation" },
                        2]);

                    var options = {
                        fontName: "Open Sans",
                        chartArea: {width: '75%', height: '75%'},
                        legend: "none",
                        height: chartHeight,
                        width: chartWidth,
                        backgroundColor: {fill: "transparent"},
                        vAxis: {
                            minValue: 0,
                            maxValue: 10,
                            gridlines:{count:6},
                            format:'0'
                        }
                    };

                    // Instantiate and draw the chart, passing in some options
                    var chartAVS =  new google.visualization.ColumnChart(document.getElementById('chart_AVS'));
                    chartAVS.draw(viewAVS, options);
                },
                error: function () {

                    var listMessageAVS = $('.list-messageAVS');

                    // Avoid duplicates
                    if (listMessageAVS.length) {
                        listMessageAVS.remove();
                    }

                    // Message
                    $('#chart_AVS').prepend("<ul class='list-group list-messageAVS'><li class='list-group-item bg-red-intense bg-font-red-intense' style='margin-right: -12px'>" + reloadAjaxError + "</li></ul>");

                    createAutoClosingAlert('.list-messageAVS');
                },
                complete: function () {
                    setTimeout(function () {
                        contentChartAVS.LoadingOverlay("hide");
                    }, 500);
                }
            });
        }

        // It draws the column chart (score by test)
        function drawChartTScore(testID) {

            var contentChartTS = $('.portlet-scoresTest');

            $.ajax({
                url: "${createLink(controller:'customTasksBackend', action:'scoresTest')}",
                data: { test: testID },
                dataType: "json",
                beforeSend: function () {

                    contentChartTS.LoadingOverlay("show", {
                        image: "",
                        fontawesome: "fa fa-spinner fa-spin"
                    });
                },
                success: function (jsonDataTS) {

                    // It uses to resize
                    dataJSONTS = jsonDataTS;

                    // Create the data table out of JSON data loaded from server
                    var dataTS = google.visualization.arrayToDataTable([
                        [_SRTitle, _SRSubtitle, { role: "style" } ],
                        [_TSZero, jsonDataTS.zero, "#4DB3A2"],
                        [_TSOne, jsonDataTS.one, "#4DB3A2"],
                        [_TSTwo, jsonDataTS.two, "#4DB3A2"],
                        [_TSThree, jsonDataTS.three, "#4DB3A2"],
                        [_TSFour, jsonDataTS.four, "#4DB3A2"],
                        [_TSFive, jsonDataTS.five, "#4DB3A2"],
                        [_TSSix, jsonDataTS.six, "#4DB3A2"],
                        [_TSSeven, jsonDataTS.seven, "#4DB3A2"],
                        [_TSEight, jsonDataTS.eight, "#4DB3A2"],
                        [_TSNine, jsonDataTS.nine, "#4DB3A2"]
                    ]);

                    var chartHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) + 'px';
                    var chartWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) + 'px';

                    var viewTS = new google.visualization.DataView(dataTS);
                    viewTS.setColumns([0, 1,
                        { calc: "stringify",
                            sourceColumn: 1,
                            type: "string",
                            role: "annotation" },
                        2]);

                    var options = {
                        fontName: "Open Sans",
                        chartArea: {width: '90%', height: '75%'},
                        legend: "none",
                        height: chartHeight,
                        width: chartWidth,
                        backgroundColor: {fill: "transparent"},
                        vAxis: {
                            minValue: 0,
                            maxValue: 10,
                            gridlines:{count:6},
                            format:'0'
                        }
                    };

                    // Instantiate and draw the chart, passing in some options
                    var chartTS =  new google.visualization.ColumnChart(document.getElementById('chart_TS'));
                    chartTS.draw(viewTS, options);
                },
                error: function () {

                    var listMessageTS = $('.list-messageTS');

                    // Avoid duplicates
                    if (listMessageTS.length) {
                        listMessageTS.remove();
                    }

                    // Message
                    $('#chart_TS').prepend("<ul class='list-group list-messageAVS'><li class='list-group-item bg-red-intense bg-font-red-intense' style='margin: 20px -12px 0 0'>" + reloadAjaxError + "</li></ul>");

                    createAutoClosingAlert('.list-messageTS');
                },
                complete: function () {
                    setTimeout(function () {
                        contentChartTS.LoadingOverlay("hide");
                    }, 500);
                }
            });
        }

        jQuery(document).ready(function() {

            // Resizing the chart pie UD
            $(window).resize(function(){
                drawChartResize();
                drawChartResizeSR();
                drawChartResizeAVS();
                drawChartResizeTS();
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
                                <i class="icofont icofont-dashboard-web"></i>
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
                        <li class="nav-item">
                            <g:link uri="/administrator/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
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
                        <li class="nav-item">
                            <g:link uri="/user/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
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
                        <li class="nav-item">
                            <g:link uri="/department/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
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
                        <li class="nav-item">
                            <g:link uri="/topic/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
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
                        <li class="nav-item">
                            <g:link uri="/catalog/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
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
                        <li class="nav-item">
                            <g:link uri="/question/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Answer -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-pencil"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.answer" default="Answer"/></span>
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
                        <li class="nav-item">
                            <g:link uri="/answer/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
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
                        <li class="nav-item">
                            <g:link uri="/test/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
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
                                    <span class="widget-thumb-body-stat counterTest" data-counter="counterup" data-value="${numberTest}">${numberTest}</span>
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

                <div class="row">
                    <!-- Range of scores -->
                    <div class="col-md-6">
                        <!-- Portlet -->
                        <div class="portlet light bg-inverse portlet-scoresRank">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <i class="fa fa-bar-chart font-green-dark"></i>
                                    <span class="caption-subject sbold uppercase"><g:message code="layouts.main_auth_admin.body.portlet.range.scores" default="Scores by rank"/></span>
                                </div>
                                <div class="tools">
                                    <i class="fa fa-refresh reloadGraph reloadScoresRank" onclick="drawChartScoresRank()"></i>
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="remove"> </a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="scroller" style="height:505px" data-rail-visible="1" data-rail-color="#105d41" data-handle-color="#4A9F60">
                                    <div id="chart_SR" style="width:100%; height:100%"></div>
                                </div>
                            </div>
                        </div> <!-- /.Portlet -->
                    </div>

                    <!-- Average scores according to sex -->
                    <div class="col-md-6">
                        <!-- Portlet -->
                        <div class="portlet light bg-inverse portlet-scoreSex">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <i class="icofont icofont-bars font-green-dark"></i>
                                    <span class="caption-subject sbold uppercase"><g:message code="layouts.main_auth_admin.body.portlet.score.sex" default="Average score by sex"/></span>
                                </div>
                                <div class="tools">
                                    <i class="fa fa-refresh reloadGraph reloadAVScoreSex" onclick="drawChartAVScoreSex()"></i>
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="remove"> </a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="scroller" style="height:505px" data-rail-visible="1" data-rail-color="#105d41" data-handle-color="#4A9F60">
                                    <div id="chart_AVS" style="width:100%; height:100%"></div>
                                </div>
                            </div>
                        </div> <!-- /.Portlet -->
                    </div>
                </div>

                <div class="row">
                    <!-- Scores in each test -->
                    <div class="col-md-12">
                        <!-- Portlet -->
                        <div class="portlet light bg-inverse portlet-scoresTest">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <i class="fa fa-line-chart font-green-dark"></i>
                                    <span class="caption-subject sbold uppercase"><g:message code="layouts.main_auth_admin.body.portlet.scores.test.title" default="Score by test"/></span>
                                </div>
                                <div class="tools">
                                    <i class="fa fa-refresh reloadGraph reloadScoresTest" onclick="drawChartTScore($('#test').val())"></i>
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="remove"> </a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <g:select name="test"
                                          from="${Test.list()}"
                                          optionKey="name"
                                          optionValue="name"
                                          noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.portlet.scores.test.select', default: 'Select a test')}"]}"
                                          class="bs-select form-control" data-style="blue-soft"
                                          data-live-search="true"
                                          onchange="drawChartTScore(this.value)"/>
                                <div class="scroller" style="height:505px;" data-rail-visible="1" data-rail-color="#105d41" data-handle-color="#4A9F60">
                                    <div id="chart_TS" style="width:100%; height:100%"></div>
                                </div>
                            </div>
                        </div> <!-- /.Portlet -->
                    </div>
                </div>
            </div>
        </div> <!-- Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="select/bootstrap-select.min.js"/>
    <g:javascript src="select/boostrap-select_i18n/defaults-es_CL.min.js"/>
    <g:javascript src="custom/dashboard.js"/>
    <script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <g:javascript src="counter/jquery.counterup.min.js"/>
    <g:javascript src="overlay/loadingoverlay.min.js"/>

</body>
</html>
