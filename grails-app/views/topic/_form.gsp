<%@ page import="Test.Topic" %>
<div class="form-body">
	<!-- Row -->
	<div class="row">
		<!-- Name -->
		<div class="col-md-6">
			<div class="form-group ${hasErrors(bean: topicInstance, field: 'name', 'error')}">
				<label for="name" class="control-label">
					<g:message code="topic.name.label" default="Name"/>
					<span class="required"> * </span>
				</label>
				<div class="input-group input-icon right">
					<i class="fa icon-offset"></i>
                    <g:textField name="name" class="form-control" maxlength="50" value="${topicInstance?.name}"/>
					<span class="input-group-btn">
						<a href="javascript:;" class="btn green-dark" id="nameTopic-checker">
							<i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
						</a>
					</span>
				</div>
			</div>
			<div class="help-block nameTopic-block"><g:message code="layouts.main_auth_admin.body.content.topic.create.checker.block.info.name" default="Type a name of topic and check its availability."/> </div>
		</div>

		<!-- Description -->
		<div class="col-md-6 space-betweenCol">
			<div class="form-group ${hasErrors(bean: topicInstance, field: 'description', 'error')}">
				<label for="description" class="control-label">
					<g:message code="topic.description.label" default="Description"/>
				</label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textArea name="description" class="form-control autosizeme" cols="40" rows="1" maxlength="500" value="${topicInstance?.description}"/>
                </div>
			</div>
		</div>
	</div>

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Visibility -->
		<div class="col-sm-6">
			<div class="${hasErrors(bean: topicInstance, field: 'visibility', 'error')}">
				<div class="input-group">
					<div class="icheck-list">
						<g:checkBox name="visibility" value="${topicInstance?.visibility}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'topic.visibility.label', default:'Visibility')}"/>
					</div>
				</div>
			</div>
		</div>
		<!-- Tests TODO -->
		<div class="col-sm-6">
            <div class="form-group ${hasErrors(bean: topicInstance, field: 'tests', 'error')}">
                <label for="tests" class="control-label">
                    <g:message code="topic.tests.label" default="Test"/>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:select name="tests" from="${Test.Test.list()}" multiple="multiple" optionKey="id" size="5" value="${topicInstance?.tests*.id}" class="many-to-many"/>
                </div>
            </div>
		</div>
	</div>
</div>
