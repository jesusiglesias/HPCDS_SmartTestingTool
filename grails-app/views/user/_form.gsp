<%@ page import="User.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'address', 'error')} required">
	<label for="address">
		<g:message code="user.address.label" default="Address" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="address" required="" value="${userInstance?.address}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'avatar', 'error')} required">
	<label for="avatar">
		<g:message code="user.avatar.label" default="Avatar" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="avatar" required="" value="${userInstance?.avatar}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'birthDate', 'error')} required">
	<label for="birthDate">
		<g:message code="user.birthDate.label" default="Birth Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="birthDate" precision="day"  value="${userInstance?.birthDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'city', 'error')} required">
	<label for="city">
		<g:message code="user.city.label" default="City" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="city" required="" value="${userInstance?.city}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'country', 'error')} required">
	<label for="country">
		<g:message code="user.country.label" default="Country" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="country" required="" value="${userInstance?.country}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="user.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${userInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phone', 'error')} required">
	<label for="phone">
		<g:message code="user.phone.label" default="Phone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="phone" required="" value="${userInstance?.phone}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'sex', 'error')} required">
	<label for="sex">
		<g:message code="user.sex.label" default="Sex" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="sex" from="${Enumerations.Sex?.values()}" keys="${Enumerations.Sex.values()*.name()}"
			  value="${userInstance?.sex?.name()}" optionValue="${ {sex -> g.message(code:sex.gender)} }" noSelection="['': g.message(code:'enumerations.option')]" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'surname', 'error')} required">
	<label for="surname">
		<g:message code="user.surname.label" default="Surname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="surname" required="" value="${userInstance?.surname}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'zipCode', 'error')} required">
	<label for="zipCode">
		<g:message code="user.zipCode.label" default="Zip Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="zipCode" type="number" value="${userInstance.zipCode}" required=""/>

</div>

