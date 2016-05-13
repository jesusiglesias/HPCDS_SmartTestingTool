<!-- Image profile -->
<div class="profile-userpic">
    <g:if test="${currentUser?.avatar}">
        <img class="profileImage-view" alt="Profile image"
             src="${createLink(controller: 'customTasksBackend', action: 'profileImage', id: currentUser.ident())}"/>
    </g:if>
    <g:else>
        <img class="profileImage-view" alt="Profile image"
             src="${resource(dir: 'img/profile', file: 'user_profile.png')}"/>
    </g:else>
</div>
<!-- User information -->
<div class="profile-usertitle">
    <div class="profile-usertitle-name">${currentUser?.name} ${currentUser?.surname}</div>

    <div class="profile-usertitle-department">${currentUser.department?.name}</div>
</div>
<!-- Extra information -->
<div class="profile-userExtraInformation">
    <ul class="list-inline">
        <g:if test="${currentUser?.city && currentUser?.country}">
            <li><i class="fa fa-map-marker"></i> ${currentUser?.city}, ${currentUser?.country}</li>
        </g:if>
        <g:elseif test="${currentUser?.city}">
            <li><i class="fa fa-map-marker"></i> ${currentUser?.city}</li>
        </g:elseif>
        <g:elseif test="${currentUser?.country}">
            <li><i class="fa fa-map-marker"></i> ${currentUser?.country}</li>
        </g:elseif>
        <li><i class="fa fa-calendar"></i> <g:formatDate formatName="custom.date.birthdate.format" date="${currentUser?.birthDate}"/></li>
    </ul>
</div>