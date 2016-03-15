<%@ page import="Security.SecUser" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
	<title><g:message code="layouts.main_auth_admin.head.title.admin" default="STT | Administrator management"/></title>

    <!-- LOAD CSS -->
    <link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'datatables.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'datatables.bootstrap.css')}" type="text/css"/>
</head>

<body>

    <script type="text/javascript">

        // Variables to use in javascript
        var _print = '${g.message(code:'layouts.main_auth_admin.content.print', default:'Print')}';
        var _copy = '${g.message(code: "layouts.main_auth_admin.content.copy", default: "Copy")}';
        var _pdf = '${g.message(code: "layouts.main_auth_admin.content.pdf", default: "PDF")}';
        var _csv = '${g.message(code: "layouts.main_auth_admin.content.csv", default: "CSV")}';
        var _columns = '${g.message(code: "layouts.main_auth_admin.content.columns", default: "Columns")}';
        var _restore = '${g.message(code: "layouts.main_auth_admin.content.restore", default: "Restore")}';
        var _adminFile = '${g.message(code: "layouts.main_auth_admin.content.admin.file", default: "STT_Administrators")}';
        var _adminTableTitle = '${g.message(code: "layouts.main_auth_admin.content.admin.tableTitle", default: "SMART TESTING TOOL - Administrators management")}';
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

    </script>

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
						<span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.admin" default="Administrator user"/></span>
					</li>
				</ul>
			</div> <!-- /.Page-bar -->

			<!-- Page-title -->
			<h3 class="page-title">
				<g:link uri="/administrator"><g:message code="layouts.main_auth_admin.body.title.admin" default="Administrator management"/></g:link>
				<i class="icon-arrow-right icon-title-admin"></i>
				<small><g:message code="layouts.main_auth_admin.body.subtitle.admin" default="Administrator list"/></small>
			</h3>

			<!-- Contain page -->
            <div id="list-domain">

                <!-- TODO -->
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <div class="row">
                    <div class="col-md-12">
                        <!-- Portlet -->
                        <div class="portlet light bg-inverse bordered">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                   <!-- <i class="icon-settings font-green-dark"></i>
                                    <span class="caption-subject bold uppercase">Buttons</span>
-->
                                    <div class="btn-group">
                                        <g:link uri="/administrator/create" class="btn green-dark">
                                            <i class="fa fa-plus"></i>
                                            <g:message code="layouts.main_auth_admin.content.newAdmin" default="New admin"/>
                                        </g:link>
                                    </div>
                                </div>
                                <div class="tools"> </div>
                            </div>

                            <div class="portlet-body">
                                <table class="table table-striped table-bordered table-hover" id="entity-table">
                                    <thead>
                                        <tr>
                                            <td><g:message code="admin.username.label" default="Username"/></td>
                                            <td><g:message code="admin.email.label" default="Email"/></td>
                                            <td><g:message code="admin.enabled.label" default="Enabled account"/></td>
                                            <td><g:message code="admin.locked.label" default="Locked account"/></td>
                                            <td><g:message code="admin.expired.label" default="Expired account"/></td>
                                            <td><g:message code="admin.passwordExpired.label" default="Expired password"/></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${secUserInstanceList}" status="i" var="secUserInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td><g:link controller="secUser" action="edit" id="${secUserInstance.id}">${fieldValue(bean: secUserInstance, field: "username")}</g:link></td>
                                                <td>${fieldValue(bean: secUserInstance, field: "email")}</td>
                                                <td>
                                                    <g:if test="${secUserInstance.enabled}">
                                                        <span class="label label-sm label-success">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-info">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${secUserInstance.enabled}" true="${g.message(code: "admin.enabled.label.true", default: "Confirmed")}" false="${g.message(code: "admin.enabled.label.false", default: "Pending")}"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <g:if test="${secUserInstance.accountLocked}">
                                                        <span class="label label-sm label-danger">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-success">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${secUserInstance.accountLocked}" true="${g.message(code: "admin.locked.label.true", default: "Locked")}" false="${g.message(code: "admin.expiredLocked.label.false", default: "Active")}"/>
                                                </td>                                                    </span>
                                                <td>
                                                    <g:if test="${secUserInstance.accountExpired}">
                                                        <span class="label label-sm label-warning">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-success">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${secUserInstance.accountExpired}" true="${g.message(code: "admin.expired.label.true", default: "Expired")}" false="${g.message(code: "admin.expiredLocked.label.false", default: "Active")}"/>
                                                </td>
                                                <td>
                                                    <g:if test="${secUserInstance.passwordExpired}">
                                                        <span class="label label-sm label-warning">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-success">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${secUserInstance.passwordExpired}" true="${g.message(code: "admin.expired.label.true", default: "Expired")}" false="${g.message(code: "admin.expiredLocked.label.false", default: "Active")}"/>
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
    <g:javascript src="datatable/datatable.js"/>
    <g:javascript src="datatable/datatables.js"/>
    <g:javascript src="datatable/datatables.bootstrap.js"/>
    <g:javascript src="datatable/custom-datatable.js"/>

</body>
</html>