<%@ page import="Test.Question" %>
<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.question" default="STT | Questions management"/></title>
	<link rel="stylesheet" href="${resource(dir: 'css/iCheck', file: 'green.css')}" type="text/css"/>

	<script>
		// Variables to use in script TODO
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
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.question" default="Question"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/question"><g:message code="layouts.main_auth_admin.body.title.question" default="Questions management"/></g:link>
                <i class="icon-arrow-right icon-title-admin"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.question.edit" default="Edit question"/></small>
            </h3>

            <!-- Contain page -->
            <div id="edit-domain">

                <!-- Alerts -->
                <g:if test="${flash.questionErrorMessage}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span role="status"> ${raw(flash.questionErrorMessage)} </span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity-error');
                    </g:javascript>
                </g:if>

                <!-- Error in validation -->
                <g:hasErrors bean="${questionInstance}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <g:eachError bean="${questionInstance}" var="error">
                            <p role="status" <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
                        </g:eachError>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity-error');
                    </g:javascript>
                </g:hasErrors>

                <!-- Delete button -->
                <g:form url="[resource:questionInstance, controller:'question', action:'delete']" method="DELETE" class="form-delete">
                    <div class="btn-group">
                        <button class="btn red-soft btn-block" id="delete-confirm-popover" data-toggle="confirmation" data-placement="top" data-popout="true" data-singleton="true"
                                data-original-title="${message(code: 'layouts.main_auth_admin.content.delete.confirm.message', default: 'Are you sure?')}"
                                data-btn-ok-label="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                data-btn-cancel-label="${message(code: 'default.button.cancel.label', default: 'Cancel')}"
                                data-btnOkIcon="glyphicon glyphicon-ok" data-btnOkClass="btn btn-sm btn-success"
                                data-btnCancelIcon="glyphicon glyphicon-remove" data-btnCancelClass="btn btn-sm btn-danger">
                            <i class="fa fa-trash"></i>
                            <g:message code="layouts.main_auth_admin.body.content.question.delete" default="Delete question"/>
                        </button>
                    </div>
                </g:form>

                <!-- Edit form -->
                <g:form url="[resource:questionInstance, action:'update']" method="PUT" autocomplete="on" class="horizontal-form admin-form">
                    <g:hiddenField name="version" value="${questionInstance?.version}" />
                    <fieldset class="form">
                        <g:render template="form"/>
                    </fieldset>
                    <div class="domain-button-group">
                        <!-- Cancel button -->
                        <g:link type="button" uri="/question" class="btn grey-mint"><g:message code="default.button.cancel.label" default="Cancel"/></g:link>
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
<%--
    <g:javascript src="domain-validation/admin-validation.js"/>
--%>
</body>
</html>
