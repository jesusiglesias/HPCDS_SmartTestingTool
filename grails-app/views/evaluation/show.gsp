<%@ page import="User.Evaluation" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.evaluation" default="STT | Evaluations management"/></title>
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
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.evaluation" default="Evaluation"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/evaluation"><g:message code="layouts.main_auth_admin.body.title.evaluation" default="Evaluations management"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.evaluation.show" default="Shoe evaluation"/></small>
            </h3>

            <!-- Contain page -->
            <div id="edit-domain">

                <!-- Delete button -->
                <g:form url="[resource:evaluationInstance, controller:'evaluation', action:'delete']" method="DELETE" class="form-delete">
                    <div class="btn-group">
                        <button class="btn red-soft btn-block" id="delete-confirm-popover" data-toggle="confirmation" data-placement="top" data-popout="true" data-singleton="true"
                                data-original-title="${message(code: 'layouts.main_auth_admin.content.delete.confirm.message', default: 'Are you sure?')}"
                                data-btn-ok-label="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                data-btn-cancel-label="${message(code: 'default.button.cancel.label', default: 'Cancel')}"
                                data-btnOkIcon="glyphicon glyphicon-ok" data-btnOkClass="btn btn-sm btn-success"
                                data-btnCancelIcon="glyphicon glyphicon-remove" data-btnCancelClass="btn btn-sm btn-danger">
                            <i class="fa fa-trash"></i>
                            <g:message code="layouts.main_auth_admin.body.content.evaluation.delete" default="Delete evaluation"/>
                        </button>
                    </div>
                </g:form>
                <fieldset class="form">
                    <g:render template="form"/>
                </fieldset>
            </div> <!-- /.Content page -->
        </div> <!-- /.Page-content -->
    </div> <!-- /. Page-content-wrapper -->

</body>
</html>


