<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.scoreObtained" default="STT | Score obtained"/></title>
</head>
<body>

    <!-- Horizontal menu -->
    <content tag="horizontalMenu">
        <div class="hor-menu hidden-sm hidden-xs">
            <ul class="nav navbar-nav">
                <li>
                    <g:link uri="/faq"><g:message code="layout.main_auth_user.horizontal.menu.faq" default="Help"/></g:link>
                </li>
                <li>
                    <g:link uri="/contact"><g:message code="layout.main_auth_user.horizontal.menu.contact" default="Contact"/></g:link>
                </li>
                <li>
                    <g:link uri="/cookiesPolicy"><g:message code="layout.main_auth_user.horizontal.menu.cookie" default="Cookies policy"/></g:link>
                </li>
            </ul>
        </div>
    </content>

    <!-- Responsive horizontal menu -->
    <content tag="responsiveHorizontalMenu">
        <li class="nav-item">
            <g:link uri="/faq" class="nav-link">
                <i class="icofont icofont-info"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.faq" default="Help"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
        <li class="nav-item">
            <g:link uri="/contact" class="nav-link">
                <i class="icofont icofont-speech-comments"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.contact" default="Contact"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
        <li class="nav-item">
            <g:link uri="/cookiesPolicy" class="nav-link">
                <i class="icofont icofont-file-text"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.cookie" default="Cookies policy"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
    </content>

    <!-- Page-bar -->
    <div class="page-bar-user">
        <ul class="page-breadcrumb">
            <li>
                <i class="icofont icofont-ui-home"></i>
                <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span><g:message code="layouts.main_auth_user.body.title.scoreObtained" default="Score obtained"/></span>
            </li>
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-scoreObtained">
                <h3 class="page-title-user-scoreObtained-title">
                    ${raw(flash.testName)}
                </h3>
            </div>
        </div>
    </div>

    <!-- Score obtained -->
    <div class="row row-userLayoutTitle-topicSelected">
        <div class="col-md-12 col-userLayoutTitle">

            <div class="page-title-user-scoreObtained-section">
                <h3 class="page-title-user-scoreObtained-section-title hvr-bubble-float-bottom">
                    ${g.message(code:"layouts.main_auth_user.body.title.scoreObtained", default:"Score obtained")}
                </h3>
                <p class="page-title-user-scoreObtained-section-description">
                    ${raw(flash.scoreDescription)}
                </p>
                <div class="score-obtained-container">
                    <g:if test="${flash.finalScore >= 9}">
                    <span class="score-obtained label-outstanding">
                    </g:if>
                    <g:elseif test="${flash.finalScore >= 7 && flash.finalScore < 9}">
                        <span class="score-obtained label-success">
                    </g:elseif>
                    <g:elseif test="${flash.finalScore >= 5 && flash.finalScore < 7}">
                        <span class="score-obtained label-warning">
                    </g:elseif>
                    <g:elseif test="${flash.finalScore >= 0 && flash.finalScore < 5}">
                        <span class="score-obtained label-danger">
                    </g:elseif>
                    <g:elseif test="${flash.finalScore == null}">
                    </g:elseif>
                    <g:formatNumber number="${flash.finalScore}" type="number" maxFractionDigits="2"/>
                    </span>
                </div>
                <div class="score-detailed-container">
                    <g:if test="${flash.rightQuestions}">
                        <p><span><g:message code="evaluation.rightQuestions.label" default="Right questions"/>:</span> ${flash.rightQuestions}</p>
                    </g:if>
                    <g:if test="${flash.failedQuestions}">
                        <p><span><g:message code="evaluation.failedQuestions.label" default="Failed questions"/>:</span> ${flash.failedQuestions}</p>
                    </g:if>
                    <g:if test="${flash.questionsUnanswered}">
                        <p><span><g:message code="evaluation.questionsUnanswered.label" default="Questions unanswered"/>:</span> ${flash.questionsUnanswered}</p>
                    </g:if>
                </div>

                <!-- Buttons -->
                <div class="score-obtained-buttons">
                    <g:if test="${flash.homepage}">
                        <g:link uri="/" class="btn green-dark homepage">${flash.homepage}</g:link>
                    </g:if>
                    <g:if test="${flash.tryAgain}">
                        <g:link controller="customTasksFrontEnd" action="testSelected" id="${flash.testID}" class="btn green-dark tryAgain">${flash.tryAgain}</g:link>
                    </g:if>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
