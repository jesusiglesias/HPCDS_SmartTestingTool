<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.topic" default="STT | Topics management"/></title>

	<script>
		// Variables to use in script
		var _checkerNameBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.topic.create.checker.block.info.name', default:'Type a name of topic and check its availability.')}';
		var _checkNameTopicAvailibility = '${g.createLink(controller: "topic", action: 'checkNameTopicAvailibility')}';
		var _requiredField = '${g.message(code:'default.validation.required', default:'This filed is required.')}';
		var _maxlengthField = '${g.message(code:'default.validation.maxlength', default:'Please, enter less than {0} characters.')}';

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
				<i class="icon-arrow-right icon-title-domain"></i>
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
				<g:form url="[resource:topicInstance, action:'save']" autocomplete="on" class="horizontal-form topic-form">
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
	<g:javascript src="domain-validation/topic-validation.js"/>

</body>
</html>
