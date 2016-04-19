<%@ page import="Test.Topic" %>
<div class="form-body">
	<!-- Row -->
	<div class="row">
		<!-- Name -->
		<div class="col-md-6">
			<div class="form-group ${hasErrors(bean: topicInstance, field: 'name', 'error')}">
				<label for="name" class="control-label">
					<h5 class="sbold">
						<g:message code="topic.name.label" default="Name"/>
						<span class="required">*</span>
					</h5>
				</label>
				<div class="input-group input-icon right">
					<i class="fa icon-offset"></i>
                    <g:textField name="name" class="form-control form-shadow name-topic backend-input" maxlength="50" value="${topicInstance?.name}"/>
					<span class="input-group-btn">
						<a href="javascript:;" class="btn green-dark" id="nameTopic-checker">
							<i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
						</a>
					</span>
				</div>
				<i class="fa fa-times i-delete-backend i-delete-topic-name"></i> <!-- Delete text icon -->
			</div>
			<div class="help-block nameTopic-block">
                <h5>
                    <g:message code="layouts.main_auth_admin.body.content.topic.create.checker.block.info.name" default="Type a name of topic and check its availability."/>
                </h5>
            </div>
		</div>

		<!-- Description -->
		<div class="col-md-6 space-betweenCol">
			<div class="form-group ${hasErrors(bean: topicInstance, field: 'description', 'error')}">
				<label for="description" class="control-label">
                    <h5 class="sbold">
                        <g:message code="topic.description.label" default="Description"/>
                    </h5>
				</label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textArea name="description" class="form-control autosizeme form-shadow description-topic backend-input" cols="40" rows="1" maxlength="500" value="${topicInstance?.description}"/>
                </div>
				<i class="fa fa-times i-delete-textArea-backend i-delete-topic-description"></i> <!-- Delete text icon -->
			</div>
		</div>
	</div>

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Visibility -->
		<div class="col-sm-6">
			<div class="${hasErrors(bean: topicInstance, field: 'visibility', 'error')}">
                <label for="visibility" class="control-label">
                    <h5 class="sbold">
                        <g:message code="layouts.main_auth_admin.body.content.topic.visibility.sublabel" default="Indicate whether the topic is visible to the user"/>
                    </h5>
                </label>

				<div class="input-group inputGroup-checkBox">
					<div class="icheck-list">
						<g:checkBox name="visibility" value="${topicInstance?.visibility}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'topic.visibility.label', default:'Visibility')}"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
