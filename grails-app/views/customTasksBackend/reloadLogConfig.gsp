<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.logConfiguration" default="STT | Log configuration"/></title>

    <script type="text/javascript">

        // Variables to use in javascript 
        var fullscreenTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.fullscreen', default:'Fullscreen!')}';
        var removeTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.remove', default:'Remove')}';
        var collapseTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.collapse', default:'Collapse/Expand')}';
        var logConfigUrl = '${g.createLink(controller: "customTasksBackend", action: 'reloadLogConfigAJAX')}';

        // Handler tooltips
        jQuery(document).ready(function() {

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


            // Auto close alert */
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

                $.ajax({
                    url: logConfigUrl,
                    beforeSend: function(){
                        logConfigButton.attr('disabled', true);
                        logConfigButton.val('${message(code: "layouts.main_auth_admin.body.content.logConfiguration.portlet.button.updating", default: "Uploading configuration...")}');
                        refreshIcon.removeClass('refresh-icon-stop');
                        refreshIcon.addClass('refresh-icon');
                    },
                    success: function(data) {

                        // Configuration successfully updated
                        if (data == "logSuccess") {

                            if (!$('.alert-log-success').length) {

                                $(".logConfig-portlet").before(
                                        "<div class='alert alert-success alert-success-custom-backend alert-dismissable alert-log-success fade in'>" +
                                        "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                        "<span> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.success', default:'New configuration log updated correctly.'))} </span>" +
                                        "</div>");

                                createAutoClosingAlert('.alert-log-success');
                            }

                        // Configuration without changes
                        } else if (data == "logNoChanges"){

                            if (!$('.alert-log-noChanges').length) {

                                $(".logConfig-portlet").before(
                                        "<div class='alert alert-info alert-info-custom-backend alert-dismissable alert-log-noChanges fade in'>" +
                                        "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                        "<span> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.noChanges', default:'Configuration not updated. There are no changes in log file.'))} </span>" +
                                        "</div>");

                                createAutoClosingAlert('.alert-log-noChanges');
                            }

                            // Error updating
                        } else if (data = "logError") {

                            if (!$('.alert-log-error').length) {

                                $(".logConfig-portlet").before(
                                        "<div class='alert alert-danger alert-danger-custom-backend alert-dismissable alert-log-error fade in'>" +
                                        "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                        "<span> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.error', default:'<strong>Error!</strong> Log file not located. Please, you check the instructions.'))} </span>" +
                                        "</div>");

                                createAutoClosingAlert('.alert-log-error');
                            }
                        }
                    },
                    error: function(){
                      console.log("error");

                      if (!$('.alert-log-internalError').length) {

                          $(".logConfig-portlet").before(
                                  "<div class='alert alert-danger alert-danger-custom-backend alert-dismissable alert-log-internalError fade in'>" +
                                  "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>" +
                                  "<span> ${raw(g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.alert.internalError', default:'<strong>Error!</strong> An internal error has occurred during updating the configuration.'))} </span>" +
                                  "</div>");

                          createAutoClosingAlert('.alert-log-internalError');
                      }
                    },
                    complete: function(){
                        logConfigButton.removeAttr('disabled');
                        logConfigButton.val('${message(code: "layouts.main_auth_admin.body.content.logConfiguration.portlet.button", default: "Upload configuration")}');
                        refreshIcon.removeClass('refresh-icon');
                        refreshIcon.addClass('refresh-icon-stop');
                    }
                });
            });
        });
    </script>
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
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.logConfiguration" default="Log configuration"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link controller="customTasksBackend" action="reloadLogConfig"><g:message code="layouts.main_auth_admin.body.title.logConfiguration" default="Configuration"/></g:link>
                <i class="icon-arrow-right icon-title-admin"></i>
                <small class="subtitle-logPage"><g:message code="layouts.main_auth_admin.body.subtitle.logConfiguration" default="Reload log"/></small>
            </h3>

            <!-- Contain page -->
            <div class="row">
                <div class="col-md-12 col-lg-10 col-lg-offset-1">

                    <!-- Alerts -->

                    <!-- Portlet -->
                    <div class="portlet light bg-inverse logConfig-portlet">
                        <div class="portlet-title">
                            <div class="caption font-green-dark">
                                <i class="icon-speech font-green-dark"></i>
                                <span class="caption-subject bold uppercase"><g:message code="layouts.main_auth_admin.body.content.logConfiguration.portlet.subject" default="Important information"/></span>
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
                            <g:message code="layouts.main_auth_admin.body.content.logConfiguration.portlet.button" default="Upload configuration"/>
                        </button>
                    </div>

                </div> <!-- /.Col -->
            </div> <!-- /.Row -->
        </div> <!-- Page-content -->
    </div> <!-- /. Page-content-wrapper -->
</body>
</html>