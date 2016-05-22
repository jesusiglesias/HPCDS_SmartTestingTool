<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.topicSelected" default="STT | Topic selected"/></title>

    <script type="text/javascript">

        // Handler tooltips
        function tooltipTest (element, _message) {

            // Global tooltips
            $('.tooltips').tooltip({delay: 2000});

            // Portlet tooltips
            $(element).tooltip({
                container: 'body',
                title: _message
            });
        }
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
                <span><g:message code="layouts.main_auth_user.body.title.topicSelected" default="Topic selected"/></span>
            </li>
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-topicSelected">
                <h3 class="page-title-user-topicSelected-title">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.topicSelected.title", default:"Available test"))}
                </h3>
                <p class="page-title-user-topicSelected-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.topicSelected.description", default:"Complete the test to score your knowledge in different topics."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Topics -->
    <div class="row row-userLayoutTitle-topicSelected">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-test-section">
                <h3 class="page-title-user-test-section-title hvr-bubble-float-bottom">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.topicSelected.topic", default:"<span class='thin text-lowercase'>{0}</span> topic", args:["${topicName}"]))}
                </h3>
                <p class="page-title-user-test-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.topicSelected.topic.description", default:"Select a test from the available to access evaluation. <strong>Note:</strong> the test may have an activation in a certain date range, a \
limit time for its realization or maximum number of attempts. <br><br> <strong>Read the description carefully before accessing it.</strong>"))}
                </p>
            </div>
        </div>
    </div>

    <!-- Search input -->
    <div class="row row-userLayoutTitle searchForm-home">
        <div class="col-md-12 text-center">
            <label for="search-test" class="control-label">
                <span class="sbold">
                    <g:message code="layouts.main_auth_user.body.title.topicSelected.search" default="Search test:"/>
                </span>
                <div class="input-group input-icon right">
                    <i class="fa fa-search searchForm-home-icon"></i>
                    <input id="search-test" name="search-test" type="text" class="form-control form-shadow input-sm input-xlarge input-inline" autocomplete="off">
                </div>
            </label>
        </div>
    </div>

    <!-- Available test -->
    <g:each in="${availableTotalTest}" status="i" var="availableTest">
        <g:if test="${(i % 2) == 0 ? 'row' : ''}">
            <div class="row row-userLayoutTitle-home-ribbons ribbon-search-test">
        </g:if>
            <div class="col-md-6">
                <div class="mt-element-ribbon mt-element-ribbon-custom">

                    <!-- Accessible or not test -->
                    <div class="ribbon ribbon-vertical-left ribbon-color ribbon-shadow uppercase tooltip-${i}">
                        <div class="ribbon-sub ribbon-bookmark ribbon-sub-${i}"></div>
                        <!-- span-icon elements -->
                    </div>

                    <!-- Name -->
                    <div class="ribbon ribbon-right ribbon-clip ribbon-shadow ribbon-border-dash-hor ribbon-color-success ribbon-right-custom uppercase">
                        <div class="ribbon-sub ribbon-clip ribbon-right"></div>
                        ${availableTest?.name}
                    </div>

                    <!-- Description -->
                    <p class="ribbon-content ribbon-content-border">
                        ${availableTest?.description}
                    </p>

                    <!-- Dates -->
                    <p class="ribbon-margin-paragraph">
                        <span class="ribbon-content-text"><g:message
                                code="layouts.main_auth_user.body.topicSelected.information.accesibility" default="Accessible during the dates:"/></span>
                        <span class="ribbon-content-value"><i class="icofont icofont-calendar"></i> <g:formatDate formatName="custom.date.test" date="${availableTest?.initDate}"/> - <g:formatDate formatName="custom.date.test" date="${availableTest?.endDate}"/></span>
                    </p>

                    <!-- Maximum number of attempts -->
                    <p class="ribbon-margin-paragraph">
                        <span class="ribbon-content-text"><g:message
                                code="layouts.main_auth_user.body.topicSelected.information.attempts"
                                default="Maximum number of attempts allowed:"/>
                        </span>
                        <span class="ribbon-content-value"><i class="icofont icofont-pen-alt-2"></i>
                            ${availableTest?.maxAttempts}
                            <g:if test="${availableTest?.maxAttempts == 1}">
                                <g:message code="layouts.main_auth_user.body.topicSelected.information.attempts.attempt" default="attempt"/>
                            </g:if>
                            <g:else>
                                <g:message code="layouts.main_auth_user.body.topicSelected.information.attempts.attempts" default="attempts"/>
                            </g:else>
                        </span>
                    </p>

                    <!-- Limit time -->
                    <p class="ribbon-margin-paragraph">
                        <span class="ribbon-content-text"><g:message code="layouts.main_auth_user.body.topicSelected.information.time" default="Limit time of completeness:"/></span>
                        <span class="ribbon-content-value"><i class="icofont icofont-clock-time"></i>
                            <g:if test="${availableTest?.lockTime == 0}">
                                <g:message code="layouts.main_auth_user.body.topicSelected.information.time.without.limit" default="unlimited"/>
                            </g:if>
                            <g:elseif test="${availableTest?.lockTime == 1}">
                                ${availableTest?.lockTime} <g:message code="layouts.main_auth_user.body.topicSelected.information.time.minute" default="minute"/>
                            </g:elseif>
                            <g:else>
                                ${availableTest?.lockTime} <g:message code="layouts.main_auth_user.body.topicSelected.information.time.minutes" default="minutes"/>
                            </g:else>
                        </span>
                    </p>

                    <!-- Number of questions -->
                    <p class="ribbon-margin-paragraph">
                        <span class="ribbon-content-text"><g:message
                                code="layouts.main_auth_user.body.topicSelected.information.question"
                                default="Number of questions:"/></span>
                        <span class="ribbon-content-value"><i class="icofont icofont-question"></i>
                            <g:if test="${availableTest?.numberOfQuestions == 0}">
                                <g:message code="layouts.main_auth_user.body.topicSelected.information.question.without.questions" default="Without questions"/>
                            </g:if>
                            <g:elseif test="${availableTest?.numberOfQuestions == 1}">
                                ${availableTest?.numberOfQuestions} <g:message code="layouts.main_auth_user.body.topicSelected.information.question.question" default="question"/>
                            </g:elseif>
                            <g:else>
                                ${availableTest?.numberOfQuestions} <g:message code="layouts.main_auth_user.body.topicSelected.information.question.questions" default="questions"/>
                            </g:else>
                        </span>
                    </p>
                    <!-- Start test if has questions and is within the time allowed -->
                    <g:if test="${allowedDate[i] && allowedAttempt[i] && availableTest?.numberOfQuestions > 0}">
                        <!-- Button -->
                        <g:link controller="customTasksFrontEnd" action="testSelected" id="${availableTest?.id}" class="btn blue-hoki ribbon-margin-button">
                            <g:message code="layouts.main_auth_user.body.topicSelected.button" default="Start test"/>
                        </g:link>
                    </g:if>
                </div>
            </div>
        <g:if test="${(i % 2) != 0}">
            </div>
        </g:if>

        <!-- Call to tooltip function -->
        <g:if test="${allowedDate[i] && allowedAttempt[i] && availableTest?.numberOfQuestions > 0}">
            <script>
                $("<i class='icofont icofont-check-circled' style='color: #419C8D;'></i>").insertAfter(".ribbon-sub-${i}");
                tooltipTest(".tooltip-${i}", "${accessible}");
            </script>
        </g:if>
        <g:else>
            <script>
                $("<i class='icofont icofont-close-circled' style='color: rgb(189, 75, 75);'></i>").insertAfter(".ribbon-sub-${i}");
                tooltipTest(".tooltip-${i}", "${inaccessible}");
            </script>
        </g:else>
    </g:each>

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="search/jquery.hideseek.min.js"/>
    <g:javascript src="search/search-initialization.js"/>

</body>
</html>
