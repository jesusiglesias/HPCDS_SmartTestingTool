<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.logConfiguration" default="STT | Log configuration"/></title>

    <script type="text/javascript">

        // Handler tooltips
        jQuery(document).ready(function() {

            // Variables to use in javascript
            var fullscreenTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.fullscreen', default:'Fullscreen!')}';
            var removeTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.remove', default:'Remove')}';
            var collapseTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.collapse', default:'Collapse/Expand')}';
            var logConfigUrl = '${g.createLink(controller: "customTasksBackend", action: 'reloadLogConfigAJAX')}';

            // Global tooltips
            $('.tooltips').tooltip();

            // Portlet tooltips
            $('.portlet > .portlet-title .fullscreen').tooltip({
                container: 'body',
                title: fullscreenTooltip
            });

            $('.portlet > .portlet-title > .tools > .remove').tooltip({
                container: 'body',
                title: removeTooltip
            });
            $('.portlet > .portlet-title > .tools > .collapse, .portlet > .portlet-title > .tools > .expand').tooltip({
                container: 'body',
                title: collapseTooltip
            });


            // Auto close alert
            function createAutoClosingAlert(selector) {
                var alert = $(selector);

                window.setTimeout(function() {
                    alert.slideUp(1000, function(){
                        $(this).remove();
                    });
                }, 5000);
            }

            // Call AJAX to upload the log configuration
            $('#log-button').click(function() {

                var logConfigButton = $('#log-button');
                var refreshIcon = $('.refreshIcon');
                var portlet = $('.logConfig-portlet');

                $.ajax({
                    url: logConfigUrl,
                    beforeSend: function(){
                        logConfigButton.attr('disabled', true);
                        logConfigButton.find('span').text('${message(code: "layouts.main_auth_admin.body.content.logConfiguration.portlet.button.updating", default: "Uploading configuration...")}');
                        refreshIcon.removeClass('refresh-icon-stop');
                        refreshIcon.addClass('refresh-icon');
                    },
                    success: function(data) {

                        // Configuration successfully updated
                        if (data == "logSuccess") {

                            if (!$('.alert-log-success').length) {

                                if (portlet.length) {
                                    portlet.before(
                                            "<div class='alert alert-success alert-success-custom-backend alert-dismissable alert-log-success fade in'>" +
                                            "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                            "<span class='xthin'> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.success', default:'New configuration log updated correctly.'))} </span>" +
                                            "</div>");
                                } else {
                                    $(".logConfig-button").before(
                                            "<div class='alert alert-success alert-success-custom-backend alert-dismissable alert-log-success fade in'>" +
                                            "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                            "<span class='xthin'> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.success', default:'New configuration log updated correctly.'))} </span>" +
                                            "</div>");
                                }

                                createAutoClosingAlert('.alert-log-success');
                            }

                        // Configuration without changes
                        } else if (data == "logNoChanges"){

                            if (!$('.alert-log-noChanges').length) {

                                if (portlet.length) {
                                    portlet.before(
                                            "<div class='alert alert-info alert-info-custom-backend alert-dismissable alert-log-noChanges fade in'>" +
                                            "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                            "<span class='xthin'> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.noChanges', default:'Configuration not updated. There are no changes in log file.'))} </span>" +
                                            "</div>");
                                } else {
                                    $(".logConfig-button").before(
                                            "<div class='alert alert-info alert-info-custom-backend alert-dismissable alert-log-noChanges fade in'>" +
                                            "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                            "<span class='xthin'> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.noChanges', default:'Configuration not updated. There are no changes in log file.'))} </span>" +
                                            "</div>");
                                }

                                createAutoClosingAlert('.alert-log-noChanges');
                            }

                        // Error updating
                        } else if (data = "logError") {

                            if (!$('.alert-log-error').length) {

                                if (portlet.length) {
                                    portlet.before(
                                            "<div class='alert alert-danger alert-danger-custom-backend alert-dismissable alert-log-error fade in'>" +
                                            "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                            "<span class='xthin'> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.error', default:'<strong>Error!</strong> Log file not located. Please, you check the instructions.'))} </span>" +
                                            "</div>");
                                } else {
                                    $(".logConfig-button").before(
                                            "<div class='alert alert-danger alert-danger-custom-backend alert-dismissable alert-log-error fade in'>" +
                                            "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                            "<span class='xthin'> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.error', default:'<strong>Error!</strong> Log file not located. Please, you check the instructions.'))} </span>" +
                                            "</div>");
                                }

                                createAutoClosingAlert('.alert-log-error');
                            }
                        }
                    },
                    error: function(){
                      console.log("error");

                      if (!$('.alert-log-internalError').length) {

                          if (portlet.length) {
                              portlet.before(
                                      "<div class='alert alert-danger alert-danger-custom-backend alert-dismissable alert-log-internalError fade in'>" +
                                      "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                      "<span class='xthin'> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.internalError', default:'<strong>Error!</strong> An internal error has occurred during updating the configuration.'))} </span>" +
                                      "</div>");
                          } else {
                              $(".logConfig-button").before(
                                      "<div class='alert alert-danger alert-danger-custom-backend alert-dismissable alert-log-internalError fade in'>" +
                                      "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                      "<span class='xthin'> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.internalError', default:'<strong>Error!</strong> An internal error has occurred during updating the configuration.'))} </span>" +
                                      "</div>");
                          }
                          
                          createAutoClosingAlert('.alert-log-internalError');
                      }
                    },
                    complete: function(){

                        setTimeout(function(){
                            logConfigButton.removeAttr('disabled');
                            logConfigButton.find('span').text('${message(code: "layouts.main_auth_admin.body.content.logConfiguration.portlet.button", default: "Upload configuration")}');
                            refreshIcon.removeClass('refresh-icon');
                            refreshIcon.addClass('refresh-icon-stop');
                        }, 500);
                    }
                });
            });
        });
    </script>
</head>

<body>

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

                <li class="nav-item start">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="icon-home"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard" default="Dashboard"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item start">
                            <g:link controller="customTasksBackend" action="dashboard" class="nav-link">
                                <i class="fa fa-bar-chart"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard.statistics" default="Statistics"/></span>
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
                <li class="nav-item active">
                    <g:link controller="customTasksBackend" action="reloadLogConfig" class="nav-link">
                        <i class="icon-settings"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.logConfiguration" default="Log configuration"/></span>
                        <span class="selected"></span>
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
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.logConfiguration" default="Log configuration"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link controller="customTasksBackend" action="reloadLogConfig"><g:message code="layouts.main_auth_admin.body.title.logConfiguration" default="Configuration"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small class="subtitle-inlinePage"><g:message code="layouts.main_auth_admin.body.subtitle.logConfiguration" default="Reload log"/></small>
            </h3>

            <!-- Contain page -->
            <div id="list-panel">

                <div class="row panel-row">
                    <div class="col-md-12 col-lg-10 col-lg-offset-1">

                        <!-- Alerts -->

                        <!-- Portlet -->
                        <div class="portlet light bg-inverse logConfig-portlet">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <i class="icon-speech font-green-dark"></i>
                                    <span class="caption-subject sbold uppercase"><g:message code="layouts.main_auth_admin.body.content.logConfiguration.portlet.subject" default="Important information"/></span>
                                </div>
                                <div class="tools">
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="fullscreen"> </a>
                                    <a href="" class="remove"> </a>
                                </div>
                            </div>

                            <div class="portlet-body">
                                <div class="scroller" style="height:250px" data-rail-visible="1" data-rail-color="#105d41" data-handle-color="#4A9F60">
                                    <h4 class="log-portlet-h4 bold"><g:message code="layouts.main_auth_admin.body.content.logConfiguration.portlet.title" default="Log configuration"/></h4>
                                    <p>
                                        ${raw(g.message(code: 'layouts.main_auth_admin.body.content.logConfiguration.portlet.description', default: '<i>Log</i> refers to events happening in the system. Thanks to this feature you can update the log configuration without rebooting the system so just click on the button below. ' +
                                                'The system automatically performs other operations and you will be notified by an alert the final status of the operation.'))}
                                    </p>
                                    <p>
                                        ${raw(g.message(code: 'layouts.main_auth_admin.body.content.logConfiguration.portlet.subdescription', default: 'Log configuration file is located in <strong>external-config</strong> directory of the classpath with name: <strong>LogConfig.groovy</strong>. ' +
                                                'For example, in a Tomcat application container, the path is the following: <strong>/tomcatPath/web-apps/projectName/WEB-INF/classes/external-config/</strong>.'))}
                                    </p>
                                </div>
                            </div>
                        </div> <!-- /. Portlet -->

                        <!-- Update button -->
                        <div class="logConfig-button">
                            <button name="log-button" id="log-button" class="btn green-dark btn-block">
                                <i class="fa fa-refresh fa-lg refresh-icon-stop refreshIcon"></i>
                                <span><g:message code="layouts.main_auth_admin.body.content.logConfiguration.portlet.button" default="Upload configuration"/></span>
                            </button>
                        </div>

                    </div> <!-- /.Col -->
                </div> <!-- /.Row -->
            </div>
        </div> <!-- Page-content -->
    </div> <!-- /. Page-content-wrapper -->
</body>
</html>