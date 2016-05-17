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

<!-- TODO
<div class="row row-userLayoutTitle">
    <div class="col-md-12 col-userLayoutTitle">
        <!-- Page-title
        <div class="page-title-user-topic-section">

            <p class="page-title-user-topic-section-description">
               No existe ninguna materia en el sistema.
            </p>
        </div>
    </div>
</div> -->

    <!-- Topics -->
    <g:each in="${activeTopics}" status="i" var="activeTopic">

        <g:if test="${(i % 2) == 0 ? 'row' : ''}">
            <div class="row row-userLayoutTitle-home-ribbons">
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
    </g:each>

</body>
</html>
