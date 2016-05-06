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

	<!-- Page-sidebar-wrapper -->
	<div class="page-sidebar-wrapper">
		<!-- Page-sidebar -->
		<div class="page-sidebar navbar-collapse collapse">
			<!-- Page-sidebar-menu -->
			<ul class="page-sidebar-menu page-header-fixed" data-keep-expanded="true" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 30px">
				<li class="sidebar-search-wrapper">
					<g:form class="sidebar-search" controller="user" action="index">
						<a href="javascript:;" class="remove">
							<i class="icon-close"></i>
						</a>
						<div class="input-group">
							<!-- ie8, ie9 does not support html5 placeholder, so it just shows field title for that-->
							<label class="control-label visible-ie8 visible-ie9" for="quickSearch"><g:message code="layouts.main_auth_admin.sidebar.search" default="Search..."/></label>
							<g:textField name="quickSearch" class="form-control placeholder-no-fix quickSearch-input backend-input" placeholder="${message(code:'layouts.main_auth_admin.sidebar.search', default:'Search...')}" autocomplete="on"/>
							<i class="fa fa-times i-delete-quickSearch"></i> <!-- Delete text icon -->
							<span class="input-group-btn">
								<a href="javascript:;" class="btn submit">
									<i class="icon-magnifier"></i>
								</a>
							</span>
						</div>
					</g:form>
				</li> <!-- /.Search form -->

				<li class="nav-item start">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="icon-home"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard" default="Dashboard"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item start">
							<g:link controller="customTasksBackend" action="dashboard" class="nav-link">
								<i class="icofont icofont-dashboard-web"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard.statistics" default="Statistics"/></span>
							</g:link>
						</li>
					</ul>
				</li>

				<!-- USERS -->
				<li class="heading">
					<h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.users" default="Users"/></h3>
				</li>

				<!-- Admin user -->
				<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="fa fa-user-secret"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.admin" default="Admin user"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link uri="/administrator/create" class="nav-link">
								<i class="fa fa-user-plus"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/administrator" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/administrator/import" class="nav-link">
								<i class="fa fa-cloud-upload"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
							</g:link>
						</li>
					</ul>
				</li>

				<!-- Normal user -->
				<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="fa fa-user"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.normalUser" default="Normal user"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link controller="user" action="create" class="nav-link">
								<i class="fa fa-user-plus"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/user" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/user/import" class="nav-link">
								<i class="fa fa-cloud-upload"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
							</g:link>
						</li>
					</ul>
				</li>
				<!-- /.USERS -->

				<!-- GENERAL -->
				<li class="heading">
					<h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.general" default="General"/></h3>
				</li>

				<!-- Department -->
				<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="fa fa-building"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.department" default="Department"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link controller="department" action="create" class="nav-link">
								<i class="fa fa-plus"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/department" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/department/import" class="nav-link">
								<i class="fa fa-cloud-upload"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
							</g:link>
						</li>
					</ul>
				</li>

				<!-- Topic -->
				<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="fa fa-briefcase"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.topic" default="Topic"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link controller="topic" action="create" class="nav-link">
								<i class="fa fa-plus"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/topic" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
							</g:link>
						</li>
                        <li class="nav-item">
                            <g:link uri="/topic/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
					</ul>
				</li>

				<!-- Catalog -->
				<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="fa fa-folder-open"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.catalog" default="Catalog"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link controller="catalog" action="create" class="nav-link">
								<i class="fa fa-plus"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/catalog" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/catalog/import" class="nav-link">
								<i class="fa fa-cloud-upload"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
							</g:link>
						</li>
					</ul>
				</li>

				<!-- Question -->
				<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="fa fa-question"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.question" default="Question"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link controller="question" action="create" class="nav-link">
								<i class="fa fa-plus"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/question" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/question/import" class="nav-link">
								<i class="fa fa-cloud-upload"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
							</g:link>
						</li>
					</ul>
				</li>

				<!-- Answer -->
				<li class="nav-item active open">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="fa fa-pencil"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.answer" default="Answer"/></span>
						<span class="selected"></span>
						<span class="arrow open"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link controller="answer" action="create" class="nav-link">
								<i class="fa fa-plus"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
							</g:link>
						</li>
						<li class="nav-item active open">
							<g:link uri="/answer" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
								<span class="selected"></span>
							</g:link>
						</li>
                        <li class="nav-item">
                            <g:link uri="/answer/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
					</ul>
				</li>
				<!-- /.GENERAL -->

				<!-- EVALUATION PROCESS -->
				<li class="heading">
					<h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.evaluationProcess" default="Evaluation process"/></h3>
				</li>

				<!-- Test -->
				<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="fa fa-file-text"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.test" default="Test"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link controller="test" action="create" class="nav-link">
								<i class="fa fa-plus"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/test" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
							</g:link>
						</li>
						<li class="nav-item">
							<g:link uri="/test/import" class="nav-link">
								<i class="fa fa-cloud-upload"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
							</g:link>
						</li>
					</ul>
				</li>

				<!-- Evaluation -->
				<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle">
						<i class="icofont icofont-badge"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.evaluation" default="Evaluation"/></span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li class="nav-item">
							<g:link uri="/evaluation" class="nav-link">
								<i class="fa fa-list"></i>
								<span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
							</g:link>
						</li>
					</ul>
				</li>
				<!-- /.TEST -->

				<!-- CONFIGURATION -->
				<li class="heading">
					<h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.configuration" default="Configurations"/></h3>
				</li>
				<li class="nav-item">
					<g:link controller="customTasksBackend" action="reloadLogConfig" class="nav-link">
						<i class="icon-settings"></i>
						<span class="title"><g:message code="layouts.main_auth_admin.sidebar.logConfiguration" default="Log configuration"/></span>
						<span class="arrow"></span>
					</g:link>
				</li>
				<!-- /.CONFIGURATION -->
			</ul> <!-- /.Page-sidebar-menu -->
		</div> <!-- Page-sidebar -->
	</div> <!-- Page-sidebar-wrapper -->

	<!-- Page-content-wrapper -->
	<div class="page-content-wrapper">
		<!-- Page-content -->
		<div class="page-content">
			<!-- Page-bar -->
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li class="iconBar-admin-container">
						<i class="fa fa-home home-icon iconBar-admin"></i>
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
					<div class="btn-group delete-confirm-popover">
						<button class="btn red-soft btn-block iconDelete-button-container" id="delete-confirm-popover" data-toggle="confirmation" data-placement="rigth" data-popout="true" data-singleton="true"
								data-original-title="${message(code: 'layouts.main_auth_admin.content.delete.confirm.message', default: 'Are you sure?')}"
								data-btn-ok-label="${message(code: 'default.button.delete.label', default: 'Delete')}"
								data-btn-cancel-label="${message(code: 'default.button.cancel.label', default: 'Cancel')}"
								data-btnOkIcon="glyphicon glyphicon-ok" data-btnOkClass="btn btn-sm btn-success"
								data-btnCancelIcon="glyphicon glyphicon-remove" data-btnCancelClass="btn btn-sm btn-danger">
							<i class="fa fa-trash iconDelete-button"></i>
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
						<button type="submit" class="btn green-dark icon-button-container" name="update">
							<i class="fa fa-check icon-button"></i>
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
	<g:javascript src="select/boostrap-select_i18n/defaults-es_CL.min.js"/>
    <g:javascript src="select/jquery.multi-select.js"/>
    <g:javascript src="maxLength/bootstrap-maxlength.min.js"/>
    <g:javascript src="autosize/autosize.min.js"/>
	<g:javascript src="customIcons/answer-handler.js"/>
    <g:javascript src="domain-validation/answer-validation.js"/>

</body>
</html>

