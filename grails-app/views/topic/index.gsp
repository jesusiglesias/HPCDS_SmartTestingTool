<%@ page import="Test.Topic" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.topic" default="STT | Topics management"/></title>

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

    <script type="text/javascript">

        // Variables to use in javascript
        var _print = '${g.message(code:'layouts.main_auth_admin.content.print', default:'Print')}';
        var _copy = '${g.message(code: "layouts.main_auth_admin.content.copy", default: "Copy")}';
        var _pdf = '${g.message(code: "layouts.main_auth_admin.content.pdf", default: "PDF")}';
        var _csv = '${g.message(code: "layouts.main_auth_admin.content.csv", default: "CSV")}';
        var _columns = '${g.message(code: "layouts.main_auth_admin.content.columns", default: "Columns")}';
        var _restore = '${g.message(code: "layouts.main_auth_admin.content.restore", default: "Restore")}';
        var _topicFile = '${g.message(code: "layouts.main_auth_admin.content.topic.file", default: "STT_Topics")}';
        var _topicTableTitle = '${g.message(code: "layouts.main_auth_admin.content.topic.tableTitle", default: "SMART TESTING TOOL - Topics management")}';
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
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.topic" default="Topic"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/topic"><g:message code="layouts.main_auth_admin.body.title.topic" default="Topics management"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.topic" default="Topics list"/></small>
            </h3>

            <!-- Contain page -->
            <div id="list-domain">

                <!-- Alerts -->
                <g:if test="${flash.topicMessage}">
                    <div class='alert alert-info alert-info-custom-backend alert-dismissable alert-entity fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status">${raw(flash.topicMessage)}</span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity');
                    </g:javascript>
                </g:if>

                <g:if test="${flash.topicErrorMessage}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status">${raw(flash.topicErrorMessage)}</span>
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
                                        <g:link uri="/topic/create" class="btn green-dark">
                                            <i class="fa fa-plus"></i>
                                            <g:message code="layouts.main_auth_admin.body.content.topic.new" default="New topic"/>
                                        </g:link>
                                    </div>
                                </div>
                                <div class="tools"></div>
                            </div>

                            <div class="portlet-body">
                                <table class="table table-striped table-bordered table-hover" id="entity-table">
                                    <thead>
                                    <tr>
                                        <td><g:message code="topic.name.label" default="Name"/></td>
                                        <td><g:message code="topic.description.label" default="Description"/></td>
                                        <td><g:message code="topic.visibility.label" default="Visibility"/></td>
                                        <td><g:message code="topic.testCount.label" default="Number of test"/></td>
                                        <td><g:message code="layouts.main_auth_admin.body.content.topic.test.display" default="Show test"/></td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${topicInstanceList}" status="i" var="topicInstance">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td><g:link controller="topic" action="edit" id="${topicInstance.id}">${fieldValue(bean: topicInstance, field: "name")}</g:link></td>
                                            <td>${fieldValue(bean: topicInstance, field: "description")}</td>
                                            <td>
                                                <g:if test="${topicInstance.visibility}">
                                                    <span class="label label-sm label-success">
                                                </g:if>
                                                <g:else>
                                                    <span class="label label-sm label-danger">
                                                </g:else>
                                                <g:formatBoolean boolean="${topicInstance.visibility}" true="${g.message(code: "topic.visibility.label.true", default: "Visible")}" false="${g.message(code: "topic.visibility.label.false", default: "Not visible")}"/>
                                                    </span>
                                            </td>
                                            <td>${fieldValue(bean: topicInstance, field: "testCount")}</td>
                                            <td><g:link uri="/test" params="[topicSearch: topicInstance.name]"><g:message code="topic.tests.label" default="Test"/></g:link></td>
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
    <g:javascript src="datatable/customTopic-datatable.js"/>
</body>
</html>






