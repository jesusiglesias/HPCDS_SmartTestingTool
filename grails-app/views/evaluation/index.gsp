<%@ page import="User.Evaluation" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
	<title><g:message code="layouts.main_auth_admin.head.title.evaluation" default="STT | Evaluations management"/></title>

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

    <!-- Search request from user -->
    <g:if test="${params.userEvalSearch}">
        <script type="text/javascript">
            var _textSearch = '${params.userEvalSearch}'
        </script>
    </g:if>
    <g:elseif test="${params.testEvalSearch}"> <!-- Search request from test -->
        <script type="text/javascript">
            var _textSearch = '${params.testEvalSearch}'
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
        var _evaluationFile = '${g.message(code: "layouts.main_auth_admin.content.evaluation.file", default: "STT_Evaluations")}';
        var _evaluationTableTitle = '${g.message(code: "layouts.main_auth_admin.content.evaluation.tableTitle", default: "SMART TESTING TOOL - Evaluations management")}';
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
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.evaluation" default="Evaluation"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/evaluation"><g:message code="layouts.main_auth_admin.body.title.evaluation" default="Evaluations management"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.evaluation" default="Evaluations list"/></small>
            </h3>

            <!-- Contain page -->
            <div id="list-domain">

                <!-- Alerts -->
                <g:if test="${flash.evaluationMessage}">
                    <div class='alert alert-info alert-info-custom-backend alert-dismissable alert-entity fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status"> ${raw(flash.evaluationMessage)} </span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity');
                    </g:javascript>
                </g:if>

                <g:if test="${flash.evaluationErrorMessage}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status"> ${raw(flash.evaluationErrorMessage)} </span>
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
                                <div class="tools"> </div>
                            </div>

                            <div class="portlet-body">
                                <table class="table table-striped table-bordered table-hover" id="entity-table">
                                    <thead>
                                    <tr>
                                        <td><g:message code="evaluation.usernameEval.label" default="User"/></td>
                                        <td><g:message code="evaluation.testName.label" default="Test"/></td>
                                        <td><g:message code="evaluation.testScore.label" default="Final score"/></td>
                                        <td><g:message code="evaluation.attemptNumber.label" default="Number of attempt"/></td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${evaluationInstanceList}" status="i" var="evaluationInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td><g:link controller="evaluation" action="show" id="${evaluationInstance.id}" class="break-word">${fieldValue(bean: evaluationInstance, field: "usernameEval")}</g:link></td>
                                                <td class="break-word">${fieldValue(bean: evaluationInstance, field: "testName")}</td>
                                                <td>
                                                    <g:if test="${evaluationInstance.testScore >= 7}">
                                                        <span class="label label-sm label-success">
                                                    </g:if>
                                                    <g:elseif test="${evaluationInstance.testScore >= 5 && evaluationInstance.testScore < 7}">
                                                        <span class="label label-sm label-warning">
                                                    </g:elseif>
                                                    <g:elseif test="${evaluationInstance.testScore < 5}">
                                                        <span class="label label-sm label-danger">
                                                    </g:elseif>
                                                        ${fieldValue(bean: evaluationInstance, field: "testScore")}
                                                        </span>
                                                </td>
                                                <td>
                                                    <span class="label label-sm label-default show-entity">
                                                        ${fieldValue(bean: evaluationInstance, field: "attemptNumber")}
                                                    </span>
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
    <g:javascript src="datatable/customEvaluation-datatable.js"/>

</body>
</html>