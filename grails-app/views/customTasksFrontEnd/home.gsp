<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.home" default="STT | Home page"/></title>

    <script type="text/javascript">
        // Handler tooltips
        jQuery(document).ready(function() {

            // Variables to use in javascript
            var _activeTest = '${g.message(code:'layouts.main_auth_user.body.title.topic.tooltip.test', default:'Number of active test')}';

            // Global tooltips
            $('.tooltips').tooltip();

            // Portlet tooltips
            $('.ribbon-vertical-left').tooltip({
                container: 'body',
                title: _activeTest
            });
        })
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
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-home">
                <h3 class="page-title-user-home-title">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.home", default:"Welcome to <span>smart testing tool</span>!"))}
                </h3>
                <p class="page-title-user-home-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.home.description", default:"<strong>HP CDS</strong> platform for online evaluation of their knowledge and skills."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Topics -->
    <div class="row row-userLayoutTitle-home">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-topic-section">
                <h3 class="page-title-user-topic-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.topic" default="Topics"/>
                </h3>
                <p class="page-title-user-topic-section-description">
                    <g:message code="layouts.main_auth_user.body.title.topic.description" default="Topics are semantic containers of test of different levels of difficulty. Access a particular topic to show the active test."/>
                </p>
            </div>
        </div>
    </div>

    <!-- Search input -->
    <div class="row row-userLayoutTitle searchForm-home">
        <div class="col-md-12 text-center">
            <label for="search-topic" class="control-label">
                <span class="sbold">
                    <g:message code="layouts.main_auth_user.body.title.topic.search" default="Search topic:"/>
                </span>
                <div class="input-group input-icon right">
                    <i class="fa fa-search searchForm-home-icon"></i>
                    <input id="search-topic" name="search-topic" type="text" class="form-control form-shadow input-sm input-xlarge input-inline" autocomplete="off">
                </div>
            </label>
        </div>
    </div>

    <!-- No topics -->
    <g:if test="${activeTopics.size() == 0}">
        <div class="row row-userLayoutTitle">
            <div class="col-xs-10 col-xs-offset-1 col-lg-8 col-lg-offset-2 col-userLayoutTitle">
                <div class="mt-element-ribbon">
                    <div class="ribbon ribbon-vertical-left ribbon-color ribbon-shadow uppercase">
                        <div class="ribbon-sub ribbon-bookmark"></div>
                        <i class="icofont icofont-bag-alt"></i>
                    </div>
                    <!-- Name -->
                    <div class="ribbon ribbon-right ribbon-clip ribbon-shadow ribbon-border-dash-hor ribbon-color-success uppercase">
                        <div class="ribbon-sub ribbon-clip ribbon-right"></div>
                            <g:message code="layouts.main_auth_user.body.title.no.topic.title" default="Information"/>
                    </div>
                    <!-- Description -->
                    <p class="ribbon-content-without-topic text-center">
                        <g:message code="layouts.main_auth_user.body.title.no.topic.description" default="There are not visible topics in the system. Please, contact us if you believe that it exists a problem."/>
                    </p>
                </div>
            </div>
        </div>
    </g:if>
    <g:else>
        <!-- Topics -->
        <g:each in="${activeTopics}" status="i" var="activeTopic">

            <g:if test="${(i % 2) == 0 ? 'row' : ''}">
                <div class="row row-userLayoutTitle-home-ribbons ribbon-search-topic">
            </g:if>
            <div class="col-md-6">
                <div class="mt-element-ribbon">
                    <!-- Number of test -->
                    <div class="ribbon ribbon-vertical-left ribbon-color ribbon-shadow uppercase">
                        <div class="ribbon-sub ribbon-bookmark"></div>
                        <span>${numberActiveTest[i]}</span>
                    </div>
                    <!-- Name -->
                    <div class="ribbon ribbon-right ribbon-clip ribbon-shadow ribbon-border-dash-hor ribbon-color-success uppercase">
                        <div class="ribbon-sub ribbon-clip ribbon-right"></div>
                        ${activeTopic?.name}
                    </div>
                    <!-- Description -->
                    <p class="ribbon-content">
                        ${(activeTopic?.description) ?:"${raw(g.message(code: 'layouts.main_auth_user.body.title.topic.without.description', default: 'It has not provided any description for this topic.'))}"}
                    </p>

                    <g:if test="${numberActiveTest[i] != 0}">
                        <!-- Button -->
                        <g:link controller="customTasksFrontEnd" action="topicSelected" id="${activeTopic?.id}" class="btn blue-hoki">
                            <g:message code="layouts.main_auth_user.body.title.topic.button" default="Enter"/>
                        </g:link>
                    </g:if>
                </div>
            </div>
            <g:if test="${(i % 2) != 0}">
                </div>
            </g:if>

            <!-- Last element -->
            <g:if test="${i == activeTopics.size() - 1 && (i % 2) == 0}">
                </div>
            </g:if>

        </g:each>
    </g:else>

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="search/jquery.hideseek.min.js"/>
    <g:javascript src="search/search-initialization.js"/>

</body>
</html>
