<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.scores" default="STT | Scores"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'datatables.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'datatables.bootstrap.css')}" type="text/css"/>

    <script type="text/javascript">

        // Variables to use in javascript
        var _print = '${g.message(code:'layouts.main_auth_admin.content.print', default:'Print')}';
        var _copy = '${g.message(code: "layouts.main_auth_admin.content.copy", default: "Copy")}';
        var _pdf = '${g.message(code: "layouts.main_auth_admin.content.pdf", default: "PDF")}';
        var _csv = '${g.message(code: "layouts.main_auth_admin.content.csv", default: "CSV")}';
        var _scoresFile = '${g.message(code: "layouts.main_auth_user.content.scores.file", default: "STT_Scores")}';
        var _scoresTableTitle = '${g.message(code: "layouts.main_auth_user.content.scores.tableTitle", default: "SMART TESTING TOOL - My scores")}';
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
</head>
<body>

    <!-- Page-bar -->
    <div class="page-bar-user">
        <ul class="page-breadcrumb">
            <li>
                <i class="icofont icofont-ui-home"></i>
                <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span><g:message code="layouts.main_auth_user.body.title.scores" default="Scores"/></span>
            </li>
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-scores">
                <h3 class="page-title-user-scores-title">
                    <g:message code="layouts.main_auth_user.body.title.scores" default="Scores"/>
                </h3>
                <p class="page-title-user-scores-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.scores.description", default:"In this section you can check your current scores obtained after completion of the various active test on the platform."))}
                </p>
            </div>
        </div>
    </div>

    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Portlet -->
            <div class="portlet light customColor bordered">
                <div class="portlet-title">
                    <div class="tools"> </div>
                </div>

                <div class="portlet-body">
                    <table class="table table-striped table-bordered table-hover" id="entity-table">
                        <thead>
                        <tr>
                            <td><g:message code="evaluation.testName.label" default="Test"/></td>
                            <td><g:message code="evaluation.show.score" default="Final score of 10"/></td>
                            <td><g:message code="evaluation.attemptNumber.label" default="Number of current attempt"/></td>
                            <td><g:message code="evaluation.maxAttempt.label" default="Maximum number of attempts"/></td>
                            <td><g:message code="evaluation.completenessDate.label" default="Completeness date"/></td>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${evaluations}" status="i" var="evaluationUser">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td class="break-word">${fieldValue(bean: evaluationUser, field: "testName")}</td>
                                <td>
                                    <g:if test="${evaluationUser.testScore >= 9}">
                                        <span class="label label-sm label-outstanding">
                                    </g:if>
                                    <g:elseif test="${evaluationUser.testScore >= 7 && evaluationUser.testScore < 9}">
                                        <span class="label label-sm label-success">
                                    </g:elseif>
                                    <g:elseif test="${evaluationUser.testScore >= 5 && evaluationUser.testScore < 7}">
                                        <span class="label label-sm label-warning">
                                    </g:elseif>
                                    <g:elseif test="${evaluationUser.testScore < 5}">
                                        <span class="label label-sm label-danger">
                                    </g:elseif>
                                    ${fieldValue(bean: evaluationUser, field: "testScore")}
                                    </span>
                                </td>
                                <td>
                                    <span class="label label-sm label-default show-entity-evaluation">
                                        ${fieldValue(bean: evaluationUser, field: "attemptNumber")}
                                    </span>
                                </td>
                                <td>
                                    <span class="label label-sm label-primary show-entity-evaluation">
                                        ${fieldValue(bean: evaluationUser, field: "maxAttempt")}
                                    </span>
                                </td>
                                <td class="space-date"><g:formatDate formatName="custom.date.evaluation.format" date="${evaluationUser?.completenessDate}"/></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div> <!-- /.Portlet-body -->
            </div> <!-- /.Portlet -->
        </div>
    </div>

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="datatable/datatables.js"/>
    <g:javascript src="datatable/datatables.bootstrap.js"/>
    <g:javascript src="datatable/scoresUser-datatable.js"/>

</body>
</html>
