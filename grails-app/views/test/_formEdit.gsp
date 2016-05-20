<%@ page import="Test.Test; Test.Catalog; Test.Topic" %>
<div class="form-body">
	<!-- Row -->
	<div class="row">
		<!-- Name -->
		<div class="col-md-6">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'name', 'error')}">
				<label for="nameNotChanged" class="control-label">
					<h5 class="sbold">
						<g:message code="test.name.label" default="Name"/>
						<span class="required"> * </span>
					</h5>
				</label>
				<div class="input-icon right">
					<g:textField name="nameNotChanged" maxlength="60" class="form-control form-shadow name-test backend-input" value="${testInstance?.name}" disabled="true"/>
				</div>
				<div class="help-block">
					<h5 class="text-justify">
						<g:message code="layouts.main_auth_admin.body.content.test.name.info.label" default="Property not editable once established."/>
					</h5>
				</div>
			</div>
		</div>

		<!-- Description -->
		<div class="col-md-6 space-betweenCol">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'description', 'error')}">
				<label for="description" class="control-label">
					<h5 class="sbold">
						<g:message code="test.description.label" default="Description"/>
						<span class="required"> * </span>
					</h5>
				</label>
				<div class="input-icon right">
					<i class="fa"></i>
					<g:textArea name="description" class="form-control autosizeme form-shadow description-test backend-input" cols="40" rows="1" maxlength="800" required="" value="${testInstance?.description}"/>
				</div>
				<i class="fa fa-times i-delete-textArea-backend i-delete-test-description"></i> <!-- Delete text icon -->
			</div>
		</div>
	</div>

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Active -->
		<div class="col-md-6">
			<div class="${hasErrors(bean: testInstance, field: 'active', 'error')}">
				<label for="active" class="control-label">
					<h5 class="sbold">
						<g:message code="layouts.main_auth_admin.body.content.test.activeTest.label" default="Indicate whether the test is active"/>
					</h5>
				</label>
				<div class="input-group inputGroup-checkBox">
					<div class="icheck-list">
						<g:checkBox name="active" value="${testInstance?.active}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code: 'test.active.label', default: 'Active')}"/>
					</div>
				</div>
			</div>
		</div>

		<!-- Number of questions -->
		<div class="col-md-6 space-betweenCol">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'numberOfQuestions', 'error')}">
				<label for="numberOfQuestions" class="control-label">
					<h5 class="sbold">
						<g:message code="test.numberOfQuestions.label" default="Number of questions"/>
						<span class="required"> * </span>
					</h5>
				</label>
				<div class="input-icon right">
					<i class="fa"></i>
					<g:field name="numberOfQuestions" type="number" class="form-control form-shadow numberOfQuestions-test backend-input" value="${testInstance?.numberOfQuestions}"/>
				</div>
				<i class="fa fa-times i-delete-testNumberquestions-backend i-delete-test-numberQuestions"></i> <!-- Delete text icon -->
			</div>
			<div class="help-block">
				<h5 class="text-justify">
					<g:message code="layouts.main_auth_admin.body.content.test.numberOfQuestions.label" default="It must be equal or less than the number of questions contained in the associated catalog."/>
				</h5>
			</div>
		</div>
	</div>

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Initial date -->
		<div class="col-md-6">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'initDate', 'error')}">
				<label for="initDate" class="control-label">
					<h5 class="sbold">
						<g:message code="test.initDate.label" default="Initial date"/>
						<span class="required"> * </span>
					</h5>
				</label>
				<div class="input-icon">
					<div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-start-date="+0d">
						<input type="text" name="initDate" id="initDate" value="${formatDate(format:'dd-MM-yyyy', date: testInstance?.initDate)}" class="form-control form-shadow initDate-test" autocomplete="off"/>
						<span class="input-group-btn">
							<button class="btn default" type="button">
								<i class="fa fa-calendar"></i>
							</button>
						</span>
					</div>
					<span class="help-block">
						<h5 class="text-justify">
							<g:message code="custom.date.picker.test.init" default="Select a date to enable the test."/>
						</h5>
					</span>
				</div>
			</div>
		</div>

		<!-- End date -->
		<div class="col-md-6 space-betweenCol">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'endDate', 'error')}">
				<label for="endDate" class="control-label">
					<h5 class="sbold">
						<g:message code="test.endDate.label" default="End date"/>
						<span class="required"> * </span>
					</h5>
				</label>
				<div class="input-icon">
					<div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-start-date="+0d">
						<input type="text" name="endDate" id="endDate" value="${formatDate(format:'dd-MM-yyyy', date: testInstance?.endDate)}" class="form-control form-shadow endDate-test" autocomplete="off"/>
						<span class="input-group-btn">
							<button class="btn default" type="button">
								<i class="fa fa-calendar"></i>
							</button>
						</span>
					</div>
					<span class="help-block">
						<h5 class="text-justify">
							<g:message code="custom.date.picker.test.end" default="Select a date to disable the test."/>
						</h5>
					</span>
				</div>
			</div>
		</div>
	</div>

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Lock time -->
		<div class="col-md-6">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'lockTime', 'error')}">
				<label for="lockTime" class="control-label">
					<h5 class="sbold">
						<g:message code="test.lockTime.minute.label" default="Maximum time allowed in minutes"/>
						<span class="required"> * </span>
					</h5>
					<h5 class="thin text-justify"><g:message code="layouts.main_auth_admin.body.content.test.lockTime.info.label" default="0 to not restrict the time of the test."/></h5>
				</label>

				<div class="input-icon right">
					<i class="fa"></i>
					<g:field name="lockTime" type="number" class="form-control form-shadow lockTime-test backend-input" value="${testInstance.lockTime}"/>
				</div>
				<i class="fa fa-times i-delete-testLockTime-backend i-delete-test-lockTime"></i> <!-- Delete text icon -->
			</div>
		</div>

		<!-- Max attempts -->
		<div class="col-md-6 space-betweenCol space-maxAttemtps">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'maxAttempts', 'error')}">
				<label for="maxAttempts" class="control-label">
					<h5 class="sbold">
						<g:message code="test.maxAttempts.label" default="Maximum number of attempts"/>
						<span class="required"> * </span>
					</h5>
				</label>
				<g:select name="maxAttempts" from="${1..5}" value="${testInstance?.maxAttempts}" noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.content.test.maxAttempts.noSelect', default: 'Select the number of attempts allowed')}"]}"
							  class="bs-select form-control select-maxAttemtps form-shadow backend-input" data-style="btn-success"/>
			</div>
		</div>
	</div>

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Topic -->
		<div class="col-md-6">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'topic', 'error')}">
				<label for="topic" class="control-label">
					<h5 class="sbold">
						<g:message code="test.topic.label" default="Topic"/>
						<span class="required"> * </span>
					</h5>
					<h5 class="thin text-justify"><g:message code="layouts.main_auth_admin.body.content.test.topic.select" default="Select the topic to which the test belongs."/></h5>
				</label>
				<g:select name="topic"
						  from="${Topic.list()}"
						  value="${testInstance?.topic*.id}"
						  optionKey="id"
						  optionValue="name"
						  noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.content.test.topic.noSelect', default: 'Select a topic')}"]}"
						  class="bs-select form-control" data-style="btn-success"
						  data-live-search="true"/>
			</div>
		</div>

		<!-- Catalog -->
		<div class="col-md-6">
			<div class="form-group ${hasErrors(bean: testInstance, field: 'catalog', 'error')}">
				<label for="catalog" class="control-label">
					<h5 class="sbold">
						<g:message code="test.catalog.label" default="Catalog"/>
						<span class="required"> * </span>
					</h5>
					<h5 class="thin text-justify"><g:message code="layouts.main_auth_admin.body.content.test.catalog.select" default="Select the catalog to which the test belongs."/></h5>
				</label>
				<g:select name="catalog"
						  from="${Catalog.list()}"
						  value="${testInstance?.catalog*.id}"
						  optionKey="id"
						  optionValue="name"
						  noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.content.test.catalog.noSelect', default: 'Select a catalog')}"]}"
						  class="bs-select form-control" data-style="btn-success"
						  data-live-search="true"/>
			</div>
		</div>
	</div>
</div>


