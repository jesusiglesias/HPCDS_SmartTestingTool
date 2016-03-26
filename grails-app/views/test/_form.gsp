<%@ page import="Test.Test" %>



<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'active', 'error')} ">
	<label for="active">
		<g:message code="test.active.label" default="Active" />
		
	</label>
	<g:checkBox name="active" value="${testInstance?.active}" />

</div>

<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="test.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${testInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'difficultyLevel', 'error')} required">
	<label for="difficultyLevel">
		<g:message code="test.difficultyLevel.label" default="Difficulty Level" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="difficultyLevel" from="${Enumerations.DifficultyLevel?.values()}" keys="${Enumerations.DifficultyLevel.values()*.name()}" required="" value="${testInstance?.difficultyLevel?.name()}" />

</div>

<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="test.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day"  value="${testInstance?.endDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'initDate', 'error')} required">
	<label for="initDate">
		<g:message code="test.initDate.label" default="Init Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="initDate" precision="day"  value="${testInstance?.initDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'lockTime', 'error')} required">
	<label for="lockTime">
		<g:message code="test.lockTime.label" default="Lock Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="lockTime" type="number" value="${testInstance.lockTime}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'maxAttempts', 'error')} required">
	<label for="maxAttempts">
		<g:message code="test.maxAttempts.label" default="Max Attempts" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="maxAttempts" type="number" value="${testInstance.maxAttempts}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="test.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${testInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'numberOfQuestions', 'error')} required">
	<label for="numberOfQuestions">
		<g:message code="test.numberOfQuestions.label" default="Number Of Questions" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numberOfQuestions" type="number" value="${testInstance.numberOfQuestions}" required=""/>

</div>

