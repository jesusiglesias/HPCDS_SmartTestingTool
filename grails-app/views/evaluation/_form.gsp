<%@ page import="User.Evaluation" %>
<div class="form-body form-evaluation">
	<!-- Row -->
	<div class="row">
		<!-- Username -->
		<div class="col-md-6">
			<h5 class="sbold show-title">
				<g:message code="evaluation.show.username" default="Username"/>
			</h5>
			<g:if test="${evaluationInstance?.user}">
				<g:fieldValue bean="${evaluationInstance}" field="user.username"/>
			</g:if>
		</div>

		<!-- Name of the test -->
		<div class="col-md-6 space-betweenCol">
			<h5 class="sbold show-title">
				<g:message code="evaluation.show.test" default="Name of the test"/>
			</h5>
			<g:if test="${evaluationInstance?.testName}">
				<g:fieldValue bean="${evaluationInstance}" field="testName"/>
			</g:if>
		</div>
	</div> <!-- /.Row -->

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Number of current attempt -->
		<div class="col-md-6">
			<h5 class="sbold show-title">
				<g:message code="evaluation.attemptNumber.label" default="Number of current attempt" />
			</h5>
			<g:if test="${evaluationInstance?.attemptNumber}">
				<span class="label label-sm label-default show-entity-evaluation">
					${fieldValue(bean: evaluationInstance, field: "attemptNumber")}
				</span>
			</g:if>
		</div>

		<!-- Maximum number of attempt -->
		<div class="col-md-6 space-betweenCol">
			<h5 class="sbold show-title">
				<g:message code="evaluation.maxAttempt.label" default="Maximum number of attempts" />
			</h5>
			<g:if test="${evaluationInstance?.maxAttempt}">
				<span class="label label-sm label-primary show-entity-evaluation">
					${fieldValue(bean: evaluationInstance, field: "maxAttempt")}
				</span>
			</g:if>
		</div>
	</div>

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Final score -->
		<div class="col-md-6">
			<h5 class="sbold show-title">
				<g:message code="evaluation.show.score" default="Final score of 10" />
			</h5>
			<g:if test="${evaluationInstance.testScore >= 9}">
				<span class="label label-sm label-outstanding">
			</g:if>
			<g:elseif test="${evaluationInstance.testScore >= 7 && evaluationInstance.testScore < 9}">
				<span class="label label-sm label-success">
			</g:elseif>
			<g:elseif test="${evaluationInstance.testScore >= 5 && evaluationInstance.testScore < 7}">
				<span class="label label-sm label-warning">
			</g:elseif>
			<g:elseif test="${evaluationInstance.testScore < 5 || evaluationInstance.testScore == null}">
				<span class="label label-sm label-danger">
			</g:elseif>
			<g:if test="${evaluationInstance.testScore == null }">
				<g:message code="layouts.main_auth_user.body.title.scores.without" default="Without score"/>
			</g:if>
			<g:else>
				${fieldValue(bean: evaluationInstance, field: "testScore")}
			</g:else>
			</span>
		</div>

		<!-- Completeness date -->
		<div class="col-md-6 space-betweenCol">
			<h5 class="sbold show-title">
				<g:message code="evaluation.completenessDate.label" default="Completeness date"/>
			</h5>
			<g:if test="${evaluationInstance.completenessDate == null }">
				<g:message code="layouts.main_auth_user.body.title.scores.withoutDate" default="{0} not completed attempt" args="${evaluationInstance.attemptNumber}"/>
			</g:if>
			<g:else>
				<span class="space-date">
				<g:formatDate formatName="custom.date.evaluation.format" date="${evaluationInstance?.completenessDate}"/>
				</span>
			</g:else>
		</div>
	</div>
</div> <!-- /.Form-body -->