<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
	<title><g:message code="layouts.main_auth_admin.head.title.evaluation" default="STT | Evaluations management"/></title>
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
				<i class="icon-arrow-right icon-title-admin"></i>
				<!-- TODO -->
				<small><g:message code="" default="Creación"/></small>
			</h3>

			<!-- Contain page -->
			<div id="create-domain">

				<!-- Alerts -->
				<g:if test="${flash.evaluationErrorMessage}">
					<div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
						<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
						<span class="xthin" role="status"> ${raw(flash.evaluationErrorMessage)} </span>
					</div>

					<g:javascript>
						createAutoClosingAlert('.alert-entity-error');
					</g:javascript>
				</g:if>

				<!-- Error in validation -->
				<g:hasErrors bean="${evaluationInstance}">
					<div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
						<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
						<g:eachError bean="${evaluationInstance}" var="error">
							<p role="status" class="xthin" <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
						</g:eachError>
					</div>

					<g:javascript>
						createAutoClosingAlert('.alert-entity-error');
					</g:javascript>
				</g:hasErrors>

				<!-- Creation form -->
				<g:form url="[resource:evaluationInstance, action:'save']" autocomplete="on" class="horizontal-form admin-form">
					<fieldset class="form">
						<g:render template="form"/>
					</fieldset>

					<div class="domain-button-group">
						<!-- Cancel button -->
						<g:link type="button" uri="/evaluation" class="btn grey-mint"><g:message code="default.button.cancel.label" default="Cancel"/></g:link>
						<button type="submit" class="btn green-dark" name="create">
							<i class="fa fa-check"></i>
							<g:message code="default.button.create.label" default="Create"/>
						</button>
					</div>
				</g:form>
			</div> <!-- /.Content page -->
		</div> <!-- /.Page-content -->
	</div> <!-- /. Page-content-wrapper -->

	<!-- LOAD JAVASCRIPT TODO -->
	<g:javascript src="iCheck/icheck.min.js"/>
	<g:javascript src="password/custom-password.js"/>
	<g:javascript src="password/pwstrength-bootstrap.min.js"/>
	<%--<g:javascript src="domain-validation/admin-validation.js"/> --%>

</body>
</html>
