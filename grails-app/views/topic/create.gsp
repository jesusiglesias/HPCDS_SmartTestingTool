<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.topic" default="STT | Topics management"/></title>
	<link rel="stylesheet" href="${resource(dir: 'css/iCheck', file: 'green.css')}" type="text/css"/>

	<script>
		// Variables to use in script TODO
		var _weak = '${g.message(code:'default.password.strength.weak', default:'Weak')}';
		var _normal = '${g.message(code:'default.password.strength.normal', default:'Normal')}';
		var _medium = '${g.message(code:'default.password.strength.medium', default:'Medium')}';
		var _strong = '${g.message(code:'default.password.strength.strong', default:'Strong')}';
		var _veryStrong = '${g.message(code:'default.password.strength.veryStrong', default:'Very strong')}';
		var _checkerUsernameBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.admin.create.checker.block.info.username', default:'Type a username and check its availability.')}';
		var _checkUsernameAvailibility = '${g.createLink(controller: "secUser", action: 'checkUsernameAvailibility')}';
		var _checkerEmailBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.admin.create.checker.block.info.email', default:'Type an email and check its availability.')}';
		var _checkEmailAvailibility = '${g.createLink(controller: "secUser", action: 'checkEmailAvailibility')}';
		var _requiredField = '${g.message(code:'default.validation.required', default:'This filed is required.')}';
		var _emailField = '${g.message(code:'default.validation.email', default:'Please, enter a valid email address.')}';
		var _equalPassword = '${raw(g.message(code:'default.password.notsame', default:'<strong>Password</strong> and <strong>Confirm password</strong> fields must match.'))}';

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
                    <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.topic" default="Topic"/></span>
                </li>
            </ul>
        </div> <!-- /.Page-bar -->

	    <!-- Page-title -->
		<h3 class="page-title">
			<g:link uri="/administrator"><g:message code="layouts.main_auth_admin.body.title.admin" default="Administrators management"/></g:link>
			<i class="icon-arrow-right icon-title-admin"></i>
			<small><g:message code="layouts.main_auth_admin.body.subtitle.topic.create" default="Create topic"/></small>
		</h3>

		<!-- Contain page -->
		<div id="create-domain">

		    <!-- Alerts -->
			<g:if test="${flash.topicErrorMessage}">
				<div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
					<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
					<span role="status"> ${raw(flash.topicErrorMessage)} </span>
				</div>

				<g:javascript>
					createAutoClosingAlert('.alert-entity-error');
				</g:javascript>
			</g:if>

		    <!-- Error in validation -->
			<g:hasErrors bean="${topicInstance}">
				<div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
					<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
					<g:eachError bean="${topicInstance}" var="error">
						<p role="status" <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
					</g:eachError>
				</div>

				<g:javascript>
					createAutoClosingAlert('.alert-entity-error');
				</g:javascript>
			</g:hasErrors>

		    <!-- Creation form -->
			<g:form url="[resource:topicInstance, action:'save']" autocomplete="on" class="horizontal-form admin-form">
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>

				<div class="domain-button-group">
					<!-- Cancel button -->
					<g:link type="button" uri="/topic" class="btn grey-mint"><g:message code="default.button.cancel.label" default="Cancel"/></g:link>
					<button type="submit" class="btn green-dark" name="create">
						<i class="fa fa-check"></i>
						<g:message code="default.button.create.label" default="Create"/>
					</button>
				</div>
			</g:form>
		</div> <!-- /.Content page -->
	</div> <!-- /.Page-content -->
</div> <!-- /. Page-content-wrapper -->

<!-- LOAD JAVASCRIPT -->
<g:javascript src="iCheck/icheck.min.js"/>
<g:javascript src="password/custom-password.js"/>
<g:javascript src="password/pwstrength-bootstrap.min.js"/>
<g:javascript src="domain-validation/admin-validation.js"/>

</body>
</html>
