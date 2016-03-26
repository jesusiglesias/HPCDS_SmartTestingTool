<%@ page import="Test.Catalog" %>
<div class="form-body">
	<!-- Row -->
	<div class="row">
		<!-- Name -->
		<div class="col-md-12">
			<div class="form-group ${hasErrors(bean: catalogInstance, field: 'name', 'error')}">
				<label for="name" class="control-label">
					<g:message code="catalog.name.label" default="Name"/>
					<span class="required"> * </span>
				</label>
				<div class="input-group input-icon right">
					<i class="fa icon-offset"></i>
					<g:textField name="name" maxlength="50" value="${catalogInstance?.name}" class="form-control"/>
					<span class="input-group-btn">
						<a href="javascript:;" class="btn green-dark" id="nameCatalog-checker">
							<i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
						</a>
					</span>
				</div>
			</div>
			<div class="help-block catalog-block"><g:message code="layouts.main_auth_admin.body.content.catalog.create.checker.block.info.name" default="Type a name of catalog and check its availability."/> </div>
		</div>
    </div> <!-- /.Row -->
</div> <!-- /.Form-body -->