<%@ page import="User.Evaluation" %>
<div class="form-body">
	<!-- Row -->
	<div class="row">
		<!-- Username -->
		<div class="col-md-6">
			<g:if test="${evaluationInstance?.user}">
				<h5 class="sbold show-title">
					<g:message code="evaluation.show.username" default="Username"/>
				</h5>
				<g:fieldValue bean="${evaluationInstance}" field="user.username"/>
			</g:if>
		</div>

		<!-- Name of the test -->
		<div class="col-md-6 space-betweenCol">
			<g:if test="${evaluationInstance?.testName}">
				<h5 class="sbold show-title">
					<g:message code="evaluation.show.test" default="Name of the test"/>
				</h5>
				<g:fieldValue bean="${evaluationInstance}" field="testName"/>
			</g:if>
		</div>
	</div> <!-- /.Row -->

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Username -->
		<div class="col-md-6">
			<g:if test="${evaluationInstance?.testScore}">
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
				<g:elseif test="${evaluationInstance.testScore < 5}">
					<span class="label label-sm label-danger">
				</g:elseif>
				${fieldValue(bean: evaluationInstance, field: "testScore")}
				</span>
			</g:if>
		</div>

		<!-- Name of the test -->
		<div class="col-md-6 space-betweenCol">
			<g:if test="${evaluationInstance?.attemptNumber}">
				<h5 class="sbold show-title">
					<g:message code="evaluation.show.maxAttempts" default="Number of current attempt" />
				</h5>
				<span class="label label-sm label-default show-entity">
					${fieldValue(bean: evaluationInstance, field: "attemptNumber")}
				</span>
			</g:if>
		</div>
	</div>
</div> <!-- /.Form-body -->