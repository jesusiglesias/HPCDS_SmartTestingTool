<!-- Sidebar of statistics - left, bottom -->
<div class="portlet light customColor-profile">
    <div class="row list-separated profile-stat">
        <div class="col-xs-6">
            <div class="uppercase profile-stat-title" data-counter="counterup" data-value="${numberActiveTest}"> ${numberActiveTest}</div>
            <div class="uppercase profile-stat-text"><g:message code="layouts.main_auth_user.content.myProfile.sidebar.bottom.test" default="Active test"/></div>
        </div>
        <div class="col-xs-6">
            <div class="uppercase profile-stat-title" data-counter="counterup" data-value="${completedTest}"> ${completedTest}</div>
            <div class="uppercase profile-stat-text"><g:message code="layouts.main_auth_user.content.myProfile.sidebar.bottom.testDone" default="Completed test"/></div>
        </div>
    </div>
    <div class="row list-separated profile-stat-secondRow">
        <div class="col-xs-6">
            <div class="uppercase profile-stat-title" data-counter="counterup" data-value="${numberApprovedTest}"> ${numberApprovedTest}</div>
            <div class="uppercase profile-stat-text"><g:message code="layouts.main_auth_user.content.myProfile.sidebar.bottom.testApproved" default="Approved test"/></div>
        </div>
        <div class="col-xs-6">
            <div class="uppercase profile-stat-title-unapproved" data-counter="counterup" data-value="${numberUnapprovedTest}"> ${numberUnapprovedTest}</div>
            <div class="uppercase profile-stat-text"><g:message code="layouts.main_auth_user.content.myProfile.sidebar.bottom.testUnapproved" default="Unapproved test"/></div>
        </div>
    </div>
</div>
