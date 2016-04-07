<%@ page import="Test.Answer" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.answer" default="STT | Answers management"/></title>

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

    <!-- Search request from question -->
    <g:if test="${params.answerSearch}">
        <script type="text/javascript">
            var _textAnswerSearch = '${params.answerSearch}'
        </script>
    </g:if>
    <g:else>
        <script type="text/javascript">
            var _textAnswerSearch = ''
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
        var _answerFile = '${g.message(code: "layouts.main_auth_admin.content.answer.file", default: "STT_Answers")}';
        var _answerTableTitle = '${g.message(code: "layouts.main_auth_admin.content.answer.tableTitle", default: "SMART TESTING TOOL - Answers management")}';
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
                        <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.answer" default="Answer"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/answer"><g:message code="layouts.main_auth_admin.body.title.answer" default="Answers management"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.answer" default="Answers list"/></small>
            </h3>

            <!-- Contain page -->
            <div id="list-domain">

                <!-- Alerts -->
                <g:if test="${flash.answerMessage}">
                    <div class='alert alert-info alert-info-custom-backend alert-dismissable alert-entity fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status">${raw(flash.answerMessage)}</span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity');
                    </g:javascript>
                </g:if>

                <g:if test="${flash.answerErrorMessage}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status">${raw(flash.answerErrorMessage)}</span>
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
                                        <g:link uri="/answer/create" class="btn green-dark">
                                            <i class="fa fa-plus"></i>
                                            <g:message code="layouts.main_auth_admin.body.content.answer.new" default="New answer"/>
                                        </g:link>
                                    </div>
                                </div>
                                <div class="tools"></div>
                            </div>

                            <div class="portlet-body">
                                <table class="table table-striped table-bordered table-hover" id="entity-table">
                                    <thead>
                                        <tr>
                                            <td><g:message code="answer.titleAnswerKey.label" default="Key"/></td>
                                            <td><g:message code="answer.description.label" default="Description"/></td>
                                            <td><g:message code="answer.score.label" default="Score"/></td>
                                            <td><g:message code="answer.correctType.label" default="Answer type"/></td>
                                            <td><g:message code="answer.questionAnswerCount.label" default="Number of questions"/></td>
                                            <td><g:message code="layouts.main_auth_admin.body.content.answer.questionsAnswer.display" default="Show questions"/></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${answerInstanceList}" status="i" var="answerInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td><g:link controller="answer" action="edit" id="${answerInstance.id}" class="break-word">${fieldValue(bean: answerInstance, field: "titleAnswerKey")}</g:link></td>
                                                <td class="break-word">${fieldValue(bean: answerInstance, field: "description")}</td>
                                                <td>${fieldValue(bean: answerInstance, field: "score")}</td>
                                                <td>
                                                    <g:if test="${answerInstance.correct}">
                                                        <span class="label label-sm label-success">
                                                    </g:if>
                                                    <g:else>
                                                        <span class="label label-sm label-danger">
                                                    </g:else>
                                                    <g:formatBoolean boolean="${answerInstance.correct}" true="${g.message(code: "answer.correct.label.true", default: "Correct")}" false="${g.message(code: "answer.correct.label.false", default: "Incorrect")}"/>
                                                </span>
                                                <td>${answerInstance.questionsAnswer?.size()}</td>
                                                <td>
                                                    <g:each in="${answerInstance?.questionsAnswer?}" var="question">
                                                        <g:link controller="question" action="edit" id="${question.id}" class="show-entity-link">
                                                            <span class="label label-sm label-default show-entity">
                                                            ${question.titleQuestionKey?.encodeAsHTML()}
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
    <g:javascript src="datatable/customAnswer-datatable.js"/>

</body>
</html>