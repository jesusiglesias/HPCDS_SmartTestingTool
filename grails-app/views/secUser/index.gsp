<%@ page import="Security.SecUser" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
	<title><g:message code="layouts.main_auth_admin.head.title.admin" default="STT | Administrator management"/></title>

    <!-- LOAD CSS -->
    <link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'datatables.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'datatables.bootstrap.css')}" type="text/css"/>


    <style> /* TODO */
    .pagination a,
    .pagination .currentStep {
        color: #666666;
        display: inline-block;
        margin: 0 0.1em;
        padding: 0.25em 0.7em;
        text-decoration: none;
        -moz-border-radius: 0.3em;
        -webkit-border-radius: 0.3em;
        border-radius: 0.3em;
    }

    .pagination a:hover, .pagination a:focus,
    .pagination .currentStep {
        background-color: #999999;
        color: #ffffff;
        outline: none;
        text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.8);
    }

    .no-borderradius .pagination a:hover, .no-borderradius .pagination a:focus,
    .no-borderradius .pagination .currentStep {
        background-color: transparent;
        color: #444444;
        text-decoration: underline;
    }
    </style>
</head>

<body>

    <script type="text/javascript">

        // Variables to use in javascript
        var _print = '${g.message(code:'layouts.main_auth_admin.content.print', default:'Print')}';
        var _copy = '${g.message(code: "layouts.main_auth_admin.content.copy", default: "Copy")}';
        var _pdf = '${g.message(code: "layouts.main_auth_admin.content.pdf", default: "PDF")}';
        var _excel = '${g.message(code: "layouts.main_auth_admin.content.excel", default: "EXCEL")}';
        var _csv = '${g.message(code: "layouts.main_auth_admin.content.csv", default: "CSV")}';
        var _columns = '${g.message(code: "layouts.main_auth_admin.content.columns", default: "Columns")}';
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

			<!-- Contain page  TODO-->
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
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${secUserInstanceList}" status="i" var="secUserInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td><g:link controller="secUser" action="edit" id="${secUserInstance.id}">${fieldValue(bean: secUserInstance, field: "username")}</g:link></td>
                                                <td>${fieldValue(bean: secUserInstance, field: "email")}</td>
                                                <td><g:formatBoolean boolean="${secUserInstance.enabled}" /></td>
                                                <td><g:formatBoolean boolean="${secUserInstance.accountLocked}" /></td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>
                            </div> <!-- /.Portlet-body -->
                        </div> <!-- /.Portlet -->
                    <%-- TODO    <div class="pagination">
                            <g:paginate total="${secUserInstanceCount ?: 0}" />
                        </div> --%>
			        </div>
                </div>
            </div> <!-- /.Content page -->
        </div> <!-- /.Page-content -->
	</div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="datatable/datatable.js"/>
    <script type="text/javascript" src="https://cdn.datatables.net/t/dt/pdfmake-0.1.18,dt-1.10.11,af-2.1.1,b-1.1.2,b-colvis-1.1.2,b-flash-1.1.2,b-html5-1.1.2,b-print-1.1.2,cr-1.3.1,fc-3.2.1,fh-3.1.1,kt-2.1.1,r-2.0.2,rr-1.1.1,sc-1.4.1,se-1.1.2/datatables.min.js"></script>
    <g:javascript src="datatable/datatables.bootstrap.js"/>
    <g:javascript src="datatable/custom-datatable.js"/>

</body>
</html>
