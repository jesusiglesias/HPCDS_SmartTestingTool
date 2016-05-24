<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.testSelected" default="STT | Test selected"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/normalUser', file: 'testSelected.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/counter', file: 'flipclock.css')}" type="text/css"/>

    <script type="text/javascript">

        // Variables to use in javascript
        var _language = '${g.message(code:'default.remaining.time.language', default:'en')}';
        var _maximumTime = '${maximumTime}';
        var _exitTestLink = '${g.createLink(controller: "customTasksFrontEnd", action: 'topicSelected', id: "${topicID}")}';

        jQuery(document).ready(function() {

            /**
             * Redirect in exit action
             */
            $('.exit-test').confirmation({
                onConfirm: function() {
                    window.location.replace(_exitTestLink);
                }
            });
        });

    </script>
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
                <span><g:message code="layouts.main_auth_user.body.title.breadcrumb" default="Test selected"/></span>
            </li>
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Remaining time -->
    <g:if test="${maximumTime > 0}">
        <div class="remaining-time">
            <p><g:message code="layouts.main_auth_user.body.testSelected.remaining.time" default="Remaining time"/></p>
            <div class=" col-md-12 col-md-offset-0 col-remaining-time">
                <div class="timer">
                </div>
            </div>
        </div>
    </g:if>

    <!-- Page-title -->
    <div class="row row-userLayoutTitle row-testSelected">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-testSelected">
                <h3 class="page-title-user-testSelected-title">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.testSelected", default:"<span class='text-lowercase'>{0}</span> test", args:["${testName}"]))}
                </h3>
                <p class="page-title-user-testSelected-description">
                    <g:if test="${maximumTime == 0}">
                        ${raw(g.message(code:"layouts.main_auth_user.body.description.testSelected", default:"Complete the test and when you finished click on the <span class='sbold'>Finish test</span> button."))}
                    </g:if>
                    <g:else>
                        ${raw(g.message(code:"layouts.main_auth_user.body.description.testSelected.timer", default:"Complete the test in the time allowed and when you finished click on the <span class='sbold'>Finish test</span> button. " +
                                "<br> <span class='sbold'>Note that</span> if the time expires the test will be sent to scoring automatically with the current answers."))}
                    </g:else>
                </p>
            </div>
        </div>
    </div>

    <!-- Test form -->
    <g:form controller="customTasksFrontEnd" action="calculateEvaluation" method="POST" autocomplete="off">

        <!-- Questions -->
        <g:each in="${questions}" status="i" var="question">
            <g:if test="${(i % 2) == 0 ? 'row' : ''}">
                <div class="row">
            </g:if>
            <div class="col-md-6">
                ${question.description}

                <!-- Answers -->
                <g:each in="${question.answers}" status="j" var="answer">
                    ${answer.description}
                </g:each>
            </div>
            <g:if test="${(i % 2) != 0}">
                </div>
            </g:if>
        </g:each>

        <!-- Buttons -->
        <div class="domain-button-group">
            <!-- Cancel button -->
            <g:link type="button" class="btn grey-mint exit-test"
                    data-toggle="confirmation" data-placement="rigth" data-popout="true" data-singleton="true"
                    data-original-title="${message(code: 'layouts.main_auth_admin.content.delete.confirm.message', default: 'Are you sure?')}"
                    data-btn-ok-label="${message(code: 'default.test.exit', default: 'Exit')}"
                    data-btn-cancel-label="${message(code: 'default.button.cancel.label', default: 'Cancel')}"
                    data-btnOkIcon="glyphicon glyphicon-ok" data-btnOkClass="btn btn-sm btn-success"
                    data-btnCancelIcon="glyphicon glyphicon-remove" data-btnCancelClass="btn btn-sm btn-danger">
                <g:message code="default.test.exit" default="Exit"/>
            </g:link>

            <!-- Submit button -->
            <button type="submit" class="btn green-dark icon-button-container" name="update">
                <i class="icofont icofont-certificate-alt-2 icon-button ico-certificate-test"></i>
                <g:message code="default.test.finish" default="Finish test"/>
            </button>
        </div>
    </g:form>

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="confirmation/bootstrap-confirmation.min.js"/>

    <!-- Establishe timer -->
    <g:if test="${maximumTime > 0}">
        <g:javascript src="counter/flipclock.min.js"/>
        <g:javascript src="counter/timer-downcounter.js"/>
    </g:if>

</body>
</html>
