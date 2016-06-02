<%@ page import="User.User" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
	<title><g:message code="layouts.main_auth_admin.head.title.user" default="STT | Users management"/></title>

	<!-- LOAD CSS -->
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'datatables.css')}" type="text/css"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'datatables.bootstrap.css')}" type="text/css"/>

	<script>
		// Handler auto close alert
		function createAutoClosingAlert(selector) {
			var alert = $(selector);
			window.setTimeout(function () {
				alert.slideUp(1000, function () {
					$(this).remove();
				});
			}, 5000);
		}
	</script>
</head>

<body>

    <!-- Search request from department -->
    <g:if test="${params.departmentSearch}">
        <script type="text/javascript">
            var _textSearch = '${params.departmentSearch}'
        </script>
    </g:if>
    <g:elseif test="${params.quickSearch}"> <!-- Search request from quick search -->
        <script type="text/javascript">
            var _textSearch = '${params.quickSearch}'
        </script>
    </g:elseif>
    <g:elseif test="${params.userAccessSearch}"> <!-- Search request from test -->
        <script type="text/javascript">
            var _textSearch = '${params.userAccessSearch}'
        </script>
    </g:elseif>
    <g:else>
        <script type="text/javascript">
            var _textSearch = ''
        </script>
    </g:else>

    <script type="text/javascript">

        // Variables to use in javascript
        var _print = '${g.message(code:'layouts.main_auth_admin.content.print', default:'Print')}';
        var _copy = '${g.message(code: "layouts.main_auth_admin.content.copy", default: "Copy")}';
        var _pdf = '${g.message(code: "layouts.main_auth_admin.content.pdf", default: "PDF")}';
        var _csv = '${g.message(code: "layouts.main_auth_admin.content.csv", default: "CSV")}';
        var _columns = '${g.message(code: "layouts.main_auth_admin.content.columns", default: "Columns")}';
        var _restore = '${g.message(code: "layouts.main_auth_admin.content.restore", default: "Restore")}';
        var _userFile = '${g.message(code: "layouts.main_auth_admin.content.user.file", default: "STT_Users")}';
        var _userTableTitle = '${g.message(code: "layouts.main_auth_admin.content.user.tableTitle", default: "SMART TESTING TOOL - Users management")}';
        var _search = '${g.message(code: "layouts.main_auth_admin.content.search", default: "Search:")}';
        var _sortAscending = '${g.message(code: "layouts.main_auth_admin.content.sortAscending", default: ": activate to sort column ascending")}';
        var _sortDescending = '${g.message(code: "layouts.main_auth_admin.content.sortDescending", default: ": activate to sort column descending")}';
        var _emptyTable = '${g.message(code: "layouts.main_auth_admin.content.emptyTable", default: "No data available in table")}';
        var _zeroRecords = '${g.message(code: "layouts.main_auth_admin.content.zeroRecords", default: "No matching records found")}';
        var _processing = '${g.message(code: "layouts.main_auth_admin.content.processing", default: "Processing...")}';
        var _infoThousands = '${g.message(code: "layouts.main_auth_admin.content.infoThousands", default: ",")}';
        var _loadingRecords = '${g.message(code: "layouts.main_auth_admin.content.loadingRecords", default: "Loading...")}';
        var _first = '${g.message(code: "layouts.main_auth_admin.content.pagination.first", default: "First")}';
        var _last = '${g.message(code: "layouts.main_auth_admin.content.pagination.last", default: "Last")}';
        var _next = '${g.message(code: "layouts.main_auth_admin.content.pagination.next", default: "Next")}';
        var _previous = '${g.message(code: "layouts.main_auth_admin.content.pagination.previous", default: "Previous")}';
        var _lengthMenu = '${g.message(code: "layouts.main_auth_admin.content.lengthMenu", default: "Show _MENU_ entries")}';
        var _info = '${g.message(code: "layouts.main_auth_admin.content.info", default: "Showing _START_ to _END_ of _TOTAL_ entries")}';
        var _infoEmpty = '${g.message(code: "layouts.main_auth_admin.content.infoEmpty", default: "No entries found")}';
        var _infoFiltered = '${g.message(code: "layouts.main_auth_admin.content.infoFiltered", default: "(filtered from _MAX_ total entries)")}';
        var _all = '${g.message(code: "layouts.main_auth_admin.content.all", default: "All")}';
        var _page = '${g.message(code: "layouts.main_auth_admin.content.bootstrap.page", default: "Page")}';
        var _pageOf = '${g.message(code: "layouts.main_auth_admin.content.bootstrap.pageOf", default: "of")}';
        var _clipboard = '${g.message(code: "layouts.main_auth_admin.content.clipboard", default: "Copy to clipboard")}';
        var _rows = '${g.message(code: "layouts.main_auth_admin.content.rows", default: "Copied %d rows to clipboard")}';
        var _row = '${g.message(code: "layouts.main_auth_admin.content.row", default: "Copied 1 row to clipboard")}';

    </script>

    <!-- Page-sidebar-wrapper -->
    <div class="page-sidebar-wrapper">
        <!-- Page-sidebar -->
        <div class="page-sidebar navbar-collapse collapse">
            <!-- Page-sidebar-menu -->
            <ul class="page-sidebar-menu page-header-fixed" data-keep-expanded="true" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 30px">

                <!-- Load search action -->
                <g:render template="/template/searchControlPanel"/>

                <li class="nav-item start">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="icon-home"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard" default="Dashboard"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item start">
                            <g:link controller="customTasksBackend" action="dashboard" class="nav-link">
                                <i class="icofont icofont-dashboard-web"></i>
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
                <li class="nav-item active open">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-user"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.normalUser" default="Normal user"/></span>
                        <span class="selected"></span>
                        <span class="arrow open"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="user" action="create" class="nav-link">
                                <i class="fa fa-user-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item active open">
                            <g:link uri="/user" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                                <span class="selected"></span>
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
                        <i class="icofont icofont-badge"></i>
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
                    <li class="iconBar-admin-container">
                        <i class="fa fa-home home-icon iconBar-admin"></i>
                        <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.user" default="Normal user"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/user"><g:message code="layouts.main_auth_admin.body.title.user" default="Users management"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.user" default="Users list"/></small>
            </h3>

            <!-- Contain page -->
            <div id="list-domain">

                <!-- Alerts -->
                <g:if test="${flash.userMessage}">
                    <div class='alert alert-info alert-info-custom-backend alert-dismissable alert-entity fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status"> ${raw(flash.userMessage)} </span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity');
                    </g:javascript>
                </g:if>

                <g:if test="${flash.userErrorMessage}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status"> ${raw(flash.userErrorMessage)} </span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity');
                    </g:javascript>
                </g:if>

                <div class="row">
                    <div class="col-md-12">
                        <!-- Portlet -->
                        <div class="portlet light bg-inverse bordered">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <div class="btn-group">
                                        <g:link uri="/user/create" class="btn green-dark icon-button-container">
                                            <i class="fa fa-plus icon-button"></i>
                                            <g:message code="layouts.main_auth_admin.body.content.user.new" default="New user"/>
                                        </g:link>
                                    </div>
                                </div>
                                <div class="tools"> </div>
                            </div>

                            <div class="portlet-body">
                                <table class="table table-striped table-bordered table-hover table-user" id="entity-table">
                                    <thead>
                                    <tr>
                                        <td><g:message code="user.avatar.label" default="Profile image"/></td>
                                        <td><g:message code="user.username.label" default="Username"/></td>
                                        <td><g:message code="user.email.label" default="Email"/></td>
                                        <td><g:message code="user.enabled.label" default="Enabled account"/></td>
                                        <td><g:message code="user.accountLocked.label" default="Locked account"/></td>
                                        <td><g:message code="user.accountExpired.label" default="Expired account"/></td>
                                        <td><g:message code="user.passwordExpired.label" default="Expired password"/></td>
                                        <td><g:message code="user.name.label" default="Name"/></td>
                                        <td><g:message code="user.surname.label" default="Surname"/></td>
                                        <td><g:message code="user.birthDate.label" default="Birthdate"/></td>
                                        <td><g:message code="user.address.label" default="Address"/></td>
                                        <td><g:message code="user.city.label" default="City"/></td>
                                        <td><g:message code="user.country.label" default="Country"/></td>
                                        <td><g:message code="user.phone.label" default="Phone"/></td>
                                        <td><g:message code="user.sex.label" default="Sex"/></td>
                                        <td><g:message code="user.evaluationCount.label" default="Number of evaluations"/></td>
                                        <td><g:message code="layouts.main_auth_admin.body.content.user.evaluation.display" default="Show evaluations"/></td>
                                        <td><g:message code="user.department.label" default="Department"/></td>
                                        <td><g:message code="user.accessTestsCount.label" default="Number of accessible test"/></td>
                                        <td><g:message code="layouts.main_auth_admin.body.content.user.accessTests.display" default="Show accessible test"/></td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${userInstanceList}" status="i" var="userInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td>
                                                    <g:if test="${userInstance.avatar}">
                                                        <g:link controller="user" action="editProfileImage" id="${userInstance.id}">
                                                            <img class="img-circle profileImage-view" alt="Profile image"  src="${createLink(controller:'customTasksBackend', action:'profileImage', id:userInstance.ident())}" />
                                                        </g:link>
                                                    </g:if>
                                                    <g:else>
                                                        <g:link controller="user" action="editProfileImage" id="${userInstance.id}">
                                                            <img class="img-circle profileImage-view" alt="Profile image" src="${resource(dir: 'img/profile', file: 'user_profile.png')}"/>
                                                        </g:link>
                                                    </g:else>
                                                </td>
                                                <td><g:link controller="user" action="edit" id="${userInstance.id}" class="break-word">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
                                                <td class="break-word">${fieldValue(bean: userInstance, field: "email")}</td>
                                                <td>
                                                    <g:if test="${userInstance.enabled}">
                                                        <span class="label label-sm label-success">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-info">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${userInstance.enabled}" true="${g.message(code: "default.enabled.label.true", default: "Confirmed")}" false="${g.message(code: "default.enabled.label.false", default: "Pending")}"/>
                                                </span>
                                                </td>
                                                <td>
                                                    <g:if test="${userInstance.accountLocked}">
                                                        <span class="label label-sm label-danger">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-success">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${userInstance.accountLocked}" true="${g.message(code: "default.locked.label.true", default: "Locked")}" false="${g.message(code: "default.expiredLocked.label.false", default: "Active")}"/>
                                                </span>
                                                </td>
                                                <td>
                                                    <g:if test="${userInstance.accountExpired}">
                                                        <span class="label label-sm label-warning">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-success">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${userInstance.accountExpired}" true="${g.message(code: "default.expired.label.true", default: "Expired")}" false="${g.message(code: "default.expiredLocked.label.false", default: "Active")}"/>
                                                </span>
                                                </td>
                                                <td>
                                                    <g:if test="${userInstance.passwordExpired}">
                                                        <span class="label label-sm label-warning">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-success">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${userInstance.passwordExpired}" true="${g.message(code: "default.expired.label.true", default: "Expired")}" false="${g.message(code: "default.expiredLocked.label.false", default: "Active")}"/>
                                                </span>
                                                </td>
                                                <td class="break-word">${fieldValue(bean: userInstance, field: "name")}</td>
                                                <td class="break-word">${fieldValue(bean: userInstance, field: "surname")}</td>
                                                <td class="space-date"><g:formatDate formatName="custom.date.birthdate.format" date="${userInstance?.birthDate}"/></td>
                                                <td class="break-word">${fieldValue(bean: userInstance, field: "address")}</td>
                                                <td class="break-word">${fieldValue(bean: userInstance, field: "city")}</td>
                                                <td class="break-word">${fieldValue(bean: userInstance, field: "country")}</td>
                                                <td class="break-word">${fieldValue(bean: userInstance, field: "phone")}</td>
                                                <td>${message(code:'enumerations.sex.'+fieldValue(bean: userInstance, field: "sex"))}</td>
                                                <td>${userInstance.evaluations?.size()}</td>
                                                <td><g:link uri="/evaluation" params="[userEvalSearch: userInstance.username]"><g:message code="user.evaluations.label" default="Evaluations"/></g:link></td>
                                                <td>
                                                    <g:link controller="department" action="edit" id="${userInstance.department.id}" class="show-entity-link">
                                                        <span class="label label-sm label-default show-entity">
                                                            ${fieldValue(bean: userInstance, field: "department.name")}
                                                        </span>
                                                    </g:link>
                                                </td>
                                                <td>${userInstance.accessTests?.size()}</td>
                                                <td>
                                                    <g:each in="${userInstance?.accessTests?}" var="test">
                                                        <g:link controller="test" action="edit" id="${test.id}" class="show-entity-link">
                                                            <span class="label label-sm label-default show-entity">
                                                                ${test.name?.encodeAsHTML()}
                                                            </span>
                                                        </g:link>
                                                    </g:each>
                                                </td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>
                            </div> <!-- /.Portlet-body -->
                        </div> <!-- /.Portlet -->
                    </div>
                </div>
            </div> <!-- /.Content page -->
        </div> <!-- /.Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="datatable/datatables.js"/>
    <g:javascript src="datatable/datatables.bootstrap.js"/>
    <g:javascript src="datatable/customUser-datatable.js"/>

</body>
</html>