<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title" default="STT | Administration panel"/></title>

    <script type="text/javascript">

        // Handler tooltips
        jQuery(document).ready(function() {

            // Variables to use in javascript
            var fullscreenTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.fullscreen', default:'Fullscreen!')}';
            var removeTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.remove', default:'Remove')}';
            var collapseTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.collapse', default:'Collapse/Expand')}';

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
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                            <h4 class="widget-thumb-heading"><g:message code="layouts.main_auth_admin.body.widget.user" default="Normal users"/></h4>
                        <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon bg-green-dark icon-user"></i>
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
                            <h4 class="widget-thumb-heading"><g:message code="layouts.main_auth_admin.body.widget.test" default="Active test"/></h4>
                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon bg-red icon-note"></i>
                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle"><g:message code="layouts.main_auth_admin.body.widget.total" default="Total"/></span>
                                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="${test}">${test}</span>
                                </div>
                            </div>
                        </div> <!-- /.Widget thumb -->
                    </div>
                    <div class="col-md-4">
                        <!-- Widget thumb -->
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                            <h4 class="widget-thumb-heading"><g:message code="layouts.main_auth_admin.body.widget.evaluation" default="Qualified evaluations"/></h4>
                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon bg-yellow-saffron icon-star"></i>
                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle"><g:message code="layouts.main_auth_admin.body.widget.total" default="Total"/></span>
                                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="${evaluations}">${evaluations}</span>
                                </div>
                            </div>
                        </div> <!-- /.Widget thumb -->
                    </div>
                </div> <!-- /.Widget -->

                <!-- Last users registered -->
                <div class="row">
                    <div class="col-md-6">
                        <!-- Portlet -->
                        <div class="portlet light bg-inverse portlet-users">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <i class="icon-people font-green-dark"></i>
                                    <span class="caption-subject sbold uppercase"><g:message code="layouts.main_auth_admin.body.portlet.recentUsers" default="Recent users"/></span>
                                </div>
                                <div class="tools">
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="fullscreen"> </a>
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
                                                        <span class="mt-comment-date"><g:formatDate formatName="custom.date.format" date="${user?.dateCreated}"/></span>
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
                                                                <g:link controller="user" action="edit" id="${user?.id}" class="btn grey-gallery"><g:message code="default.button.edit.label" default="Edit"/></g:link>
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
                </div> <!-- /.Last user registered -->
            </div>
        </div> <!-- Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <g:javascript src="counter/jquery.counterup.min.js"/>

</body>
</html>
