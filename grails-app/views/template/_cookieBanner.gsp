<!-- Cookie block -->
<div id="cookie-container" class="row" style="display: none">
    <div id="cookie-message" class="col-xs-12">
        <p>
            <i class="fa fa-exclamation-circle fa-custom" aria-hidden="true"></i>
            <g:message code="layouts.main_auth_user.body.content.cookie.message" default="This site uses cookies for the correct user navigation. If you continue browsing, it considers that you accept its use."/>
        </p>
        <div>
            <g:link controller="customTasksUserInformation" action="cookiesPolicy" class="btn blue-chambray btn-sm"><g:message code="layouts.main_auth_user.body.content.cookie.information" default="More information"/></g:link>
            <a onclick="closeCookies();" style="cursor:pointer;" class="btn blue-chambray btn-sm">
                <g:message code="layouts.main_auth_user.body.content.cookie.close" default="Close"/>
            </a>
        </div>
    </div>
</div>