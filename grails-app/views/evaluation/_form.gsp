<%@ page import="User.Evaluation" %>



<div class="fieldcontain ${hasErrors(bean: evaluationInstance, field: 'attemptNumber', 'error')} required">
	<label for="attemptNumber">
		<g:message code="evaluation.attemptNumber.label" default="Attempt Number" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="attemptNumber" type="number" value="${evaluationInstance.attemptNumber}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: evaluationInstance, field: 'testScore', 'error')} required">
	<label for="testScore">
		<g:message code="evaluation.testScore.label" default="Test Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="testScore" type="number" value="${evaluationInstance.testScore}" required=""/>

</div>

