<%@ page import="Test.Answer" %>
<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.answer" default="STT | Answers management"/></title>
	<link rel="stylesheet" href="${resource(dir: 'css/iCheck', file: 'green.css')}" type="text/css"/>
	<link rel="stylesheet" href="${resource(dir: 'css/select', file: 'bootstrap-select.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'multi-select.css')}" type="text/css"/>

	<script>
		// Variables to use in script
		var _checkerAnswerKeyBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.answer.create.checker.block.info.key', default:'Type a key of answer and check its availability.')}';
		var _checkKeyAnswerAvailibility = '${g.createLink(controller: "answer", action: 'checkKeyAnswerAvailibility')}';
		var _requiredField = '${g.message(code:'default.validation.required', default:'This field is required.')}';
		var _maxlengthField = '${g.message(code:'default.validation.maxlength', default:'Please, enter less than {0} characters.')}';
        var _minField = '${g.message(code:'default.validation.min', default:'Please, enter a value greater or equal to {0}.')}';
        var _maxField = '${g.message(code:'default.validation.max', default:'Please, enter a value less than or equal to {0}.')}';
        var _point = '${g.message(code:'layouts.main_auth_admin.body.content.answer.subtext.point', default:'point')}';
        var _points = '${g.message(code:'layouts.main_auth_admin.body.content.answer.subtext.points', default:'points')}';

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
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.answer" default="Answer"/></span>
					</li>
				</ul>
			</div> <!-- /.Page-bar -->

			<!-- Page-title -->
			<h3 class="page-title">
                <g:link uri="/answer"><g:message code="layouts.main_auth_admin.body.title.answer" default="Answers management"/></g:link>
				<i class="icon-arrow-right icon-title-domain"></i>
				<small><g:message code="layouts.main_auth_admin.body.subtitle.answer.edit" default="Edit answer"/></small>
			</h3>

			<!-- Contain page -->
			<div id="edit-domain">

				<!-- Alerts -->
				<g:if test="${flash.answerErrorMessage}">
					<div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
						<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
						<span class="xthin" role="status"> ${raw(flash.answerErrorMessage)} </span>
					</div>

					<g:javascript>
						createAutoClosingAlert('.alert-entity-error');
					</g:javascript>
				</g:if>

				<!-- Error in validation -->
				<g:hasErrors bean="${answerInstance}">
					<div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
						<button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
						<g:eachError bean="${answerInstance}" var="error">
							<p role="status" class="xthin" <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
						</g:eachError>
					</div>

					<g:javascript>
						createAutoClosingAlert('.alert-entity-error');
					</g:javascript>
				</g:hasErrors>

				<!-- Delete button -->
				<g:form url="[resource:answerInstance, controller:'answer', action:'delete']" method="DELETE" class="form-delete">
					<div class="btn-group">
						<button class="btn red-soft btn-block" id="delete-confirm-popover" data-toggle="confirmation" data-placement="rigth" data-popout="true" data-singleton="true"
								data-original-title="${message(code: 'layouts.main_auth_admin.content.delete.confirm.message', default: 'Are you sure?')}"
								data-btn-ok-label="${message(code: 'default.button.delete.label', default: 'Delete')}"
								data-btn-cancel-label="${message(code: 'default.button.cancel.label', default: 'Cancel')}"
								data-btnOkIcon="glyphicon glyphicon-ok" data-btnOkClass="btn btn-sm btn-success"
								data-btnCancelIcon="glyphicon glyphicon-remove" data-btnCancelClass="btn btn-sm btn-danger">
							<i class="fa fa-trash"></i>
							<g:message code="layouts.main_auth_admin.body.content.answer.delete" default="Delete answer"/>
						</button>
					</div>
					<div class="has-error md-checkbox check-delete">
						<input type="checkbox" name='delete_answer' id='delete_answer' class="md-check"/>
						<label for="delete_answer" class="sbold">
							<span></span>
							<span class="check"></span>
							<span class="box"></span>
							<g:message code="layouts.main_auth_admin.body.content.answer.delete.relation" default="Enable to remove the answer even if it is associated with one or more questions."/>
						</label>
					</div>
				</g:form>

				<!-- Edit form -->
				<g:form url="[resource:answerInstance, action:'update']" method="PUT" autocomplete="on" class="horizontal-form answer-form">
					<g:hiddenField name="version" value="${answerInstance?.version}" />
					<fieldset class="form">
						<g:render template="form"/>
					</fieldset>
					<div class="domain-button-group">
						<!-- Cancel button -->
						<g:link type="button" uri="/answer" class="btn grey-mint"><g:message code="default.button.cancel.label" default="Cancel"/></g:link>
						<button type="submit" class="btn green-dark" name="update">
							<i class="fa fa-check"></i>
							<g:message code="default.button.update.label" default="Update"/>
						</button>
					</div>
				</g:form>
			</div> <!-- /.Content page -->
		</div> <!-- /.Page-content -->
	</div> <!-- /. Page-content-wrapper -->

	<!-- LOAD JAVASCRIPT -->
	<g:javascript src="confirmation/bootstrap-confirmation.min.js"/>
	<g:javascript src="confirmation/custom-delete.js"/>
	<g:javascript src="iCheck/icheck.min.js"/>
    <g:javascript src="select/bootstrap-select.min.js"/>
    <g:javascript src="select/jquery.multi-select.js"/>
    <g:javascript src="maxLength/bootstrap-maxlength.min.js"/>
    <g:javascript src="autosize/autosize.min.js"/>
	<g:javascript src="customIcons/answer-handler.js"/>
    <g:javascript src="domain-validation/answer-validation.js"/>

</body>
</html>

