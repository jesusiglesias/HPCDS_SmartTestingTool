<%@ page import="User.Department" %>
<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.department" default="STT | Departments management"/></title>

    <script>
        // Variables to use in script
        var _requiredField = '${g.message(code:'default.validation.required', default:'This filed is required.')}';

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
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.department" default="Department"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/administrator"><g:message code="layouts.main_auth_admin.body.title.department" default="Departments management"/></g:link>
                <!-- TODO icon-title -->
                <i class="icon-arrow-right icon-title-admin"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.department.edit" default="Edit department"/></small>
            </h3>

            <!-- Contain page -->
            <div id="edit-domain">

                <!-- Alerts -->
                <g:if test="${flash.departmentErrorMessage}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span role="status">${raw(flash.departmentErrorMessage)}</span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity-error');
                    </g:javascript>
                </g:if>

                <!-- Error in validation -->
                <g:hasErrors bean="${departmentInstance}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <g:eachError bean="${departmentInstance}" var="error">
                            <p role="status"
                               <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                    error="${error}"/></p>
                        </g:eachError>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity-error');
                    </g:javascript>
                </g:hasErrors>

                <!-- Delete button -->
                <g:form url="[resource: departmentInstance, controller: 'department', action: 'delete']" method="DELETE" class="form-delete">
                    <div class="btn-group">
                        <button class="btn red-soft btn-block" id="delete-confirm-popover" data-toggle="confirmation"
                                data-placement="top" data-popout="true" data-singleton="true"
                                data-original-title="${message(code: 'layouts.main_auth_admin.content.delete.confirm.message', default: 'Are you sure?')}"
                                data-btn-ok-label="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                data-btn-cancel-label="${message(code: 'default.button.cancel.label', default: 'Cancel')}"
                                data-btnOkIcon="glyphicon glyphicon-ok" data-btnOkClass="btn btn-sm btn-success"
                                data-btnCancelIcon="glyphicon glyphicon-remove" data-btnCancelClass="btn btn-sm btn-danger">
                            <i class="fa fa-trash"></i>
                            <g:message code="layouts.main_auth_admin.body.content.department.delete" default="Delete department"/>
                        </button>
                    </div>
                </g:form>

                <!-- Edit form -->
                <g:form url="[resource: departmentInstance, action: 'update']" method="PUT" autocomplete="on" class="horizontal-form admin-form">
                    <g:hiddenField name="version" value="${departmentInstance?.version}"/>
                    <fieldset class="form">
                        <g:render template="form"/>
                    </fieldset>

                    <div class="domain-button-group">
                        <!-- Cancel button -->
                        <g:link type="button" uri="/department" class="btn grey-mint"><g:message code="default.button.cancel.label" default="Cancel"/></g:link>
                        <button type="submit" class="btn green-dark" name="update">
                            <i class="fa fa-check"></i>
                            <g:message code="default.button.update.label" default="Update"/>
                        </button>
                    </div>
                </g:form>
            </div> <!-- /.Content page -->
        </div> <!-- /.Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT TODO -->
    <g:javascript src="confirmation/bootstrap-confirmation.min.js"/>
    <g:javascript src="confirmation/custom-delete.js"/>
    <g:javascript src="iCheck/icheck.min.js"/>
    <g:javascript src="password/custom-password.js"/>
    <g:javascript src="password/pwstrength-bootstrap.min.js"/>
    <g:javascript src="domain-validation/admin-validation.js"/>

</body>
</html>
