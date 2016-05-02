<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.contact" default="STT | Contact"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'bootstrap-select.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/contact', file: 'contact.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/iconfont', file: 'icofont.css')}" type="text/css"/>

    <script>
        // Variables to use in script
        var _address = '${g.message(code:'layouts.main_auth_user.body.map.address', default:'José Echegaray street,')}';
        var _country = '${g.message(code:'layouts.main_auth_user.body.map.country', default:'Spain')}';
        var _webSite = '${g.message(code:'layouts.main_auth_user.body.map.icon.web', default:'Web site')}';
    </script>
</head>

<body>

    <!-- Page-bar -->
    <div class="page-bar-user">
        <ul class="page-breadcrumb">
            <li>
                <i class="icofont icofont-ui-home"></i>
                <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span><g:message code="layouts.main_auth_user.body.title.contactUs" default="Contact us"/></span>
            </li>
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title -->
    <h3 class="page-title-user">
        <g:message code="layouts.main_auth_user.body.title.contactUs" default="Contact us"/>
    </h3>

    <!-- Google maps-->
    <div class="contactPage-container">
        <div class="row" data-auto-height=".c-height">
            <div class="col-lg-8 col-md-6 contactMapCol"></div>
                <div class="col-lg-4 col-md-6 contactMapCol">
                    <div class="body">
                        <div class="section">
                            <h3>Hewlett Packard CDS</h3>
                        </div>
                        <div class="section">
                            <div class="label uppercase"><g:message code="layouts.main_auth_user.body.map.title.address" default="Address"/></div>
                            <p><g:message code="layouts.main_auth_user.body.map.address" default="José Echegaray street,"/><br/>Las Rozas 28232 Madrid,<br/><g:message code="layouts.main_auth_user.body.map.country" default="Spain"/></p>
                        </div>
                        <div class="section">
                            <div class="label uppercase"><g:message code="layouts.main_auth_user.body.map.title.contact" default="Contact"/></div>
                            <p><i class="icofont icofont-ui-email"></i> <a href="mailto:smartestingtool.info@gmail.com" class="contact-map-email">smartestingtool.info@gmail.com</a></p>
                            <p><i class="icofont icofont-phone-circle"></i> +34 91 631 16 84 </p>
                        </div>
                        <div class="section">
                            <div class="label uppercase"><g:message code="layouts.main_auth_user.body.map.title.social" default="Social"/></div>
                            <br/>
                            <ul class="iconlist">
                                <li class="li-site">
                                    <a href="https://www.hpcds.com/">
                                        <i class="icofont icofont-web"></i>
                                    </a>
                                </li>
                                <li class="li-google">
                                    <a href="https://plus.google.com/103304739299282206903">
                                        <i class="fa fa-google"></i>
                                    </a>
                                </li>
                                <li class="li-youtube">
                                    <a href="https://www.youtube.com/user/HPCDSNL">
                                        <i class="fa fa-youtube-play"></i>
                                    </a>
                                </li>
                                <li class="li-linkedin">
                                    <a href="https://www.linkedin.com/company/hp-cds">
                                        <i class="fa fa-linkedin"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        <div id="gmapSTT" class="contactPage-gmap"></div>
    </div>

    <div class="contentPage-form">
        <div class="row">
            <div class="col-md-12 contactPageFAQ">
                <div class="containerContactPage">
                    <div class="title inverse">
                        <h3 class="uppercase"><g:message code="layouts.main_auth_user.body.map.faq.title" default="Need to know more?"/></h3>
                        <div class="line-left"></div>
                        <p><g:message code="layouts.main_auth_user.body.map.faq.description" default="Visit our FAQ page to learn more about SMART TESTING TOOL."/></p>
                        <g:link uri="/FAQ" class="btn green-dark"><g:message code="layouts.main_auth_user.body.map.faq.button" default="Visit FAQ"/></g:link>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="containerMailcontact">
                    <!-- Title form -->
                    <div class="title">
                        <h3 class="uppercase"><g:message code="layouts.main_auth_user.body.map.contact.form.title" default="Or contact us by email"/></h3>
                        <div class="line-left bg-dark"></div>
                        <p><g:message code="layouts.main_auth_user.body.map.contact.form.description" default="Our helpline is always open to receive any inquiry or feedback. Please feel free to drop us an email from the form below and we will get back to you as soon as we can."/></p>
                    </div>
                    <!-- Form contact -->
                    <g:form controller="customTasksFrontEnd" action="contactForm" method="POST">
                        <!-- Name -->
                        <div class="form-group">
                            <label for="name" class="control-label">
                                <h5 class="sbold">
                                    <g:message code="default.contact.form.name" default="Name"/>
                                    <span class="required"> * </span>
                                </h5>
                            </label>
                            <div class="input-icon right">
                                <i class="fa"></i>
                                <g:textField name="name" maxlength="65" class="form-control form-shadow name-user backend-input input-md"/>
                            </div>
                            <i class="fa fa-times i-delete-without-name-backend i-delete-user-name"></i> <!-- Delete text icon -->
                        </div>
                        <!-- Email -->
                        <div class="form-group">
                            <label for="email" class="control-label">
                                <h5 class="sbold">
                                    <g:message code="default.contact.form.email" default="Email"/>
                                    <span class="required"> * </span>
                                    </h5>
                                </label>
                                <div class="input-icon right">
                                    <i class="fa icon-offset"></i>
                                    <g:field type="email" name="email" maxlength="60" class="form-control form-shadow emptySpaces email-user backend-input input-md" disabled="true" value="${sec.loggedInUserInfo(field:"email")}"/>
                                </div>
                        </div>

                        <div class="form-group">
                            <label for="subject" class="control-label">
                                <h5 class="sbold">
                                    <g:message code="default.contact.form.subject" default="Subject"/>
                                    <span class="required">*</span>
                                </h5>
                            </label>
                            <g:select name="subject" from="${subjectList}" noSelection="${['': "${g.message(code: 'layouts.main_auth_user.body.map.contact.form.subject', default: 'Select a subject')}"]}"
                                      class="bs-select form-control select-score input-md" data-style="btn-success"/>
                        </div>
                        <!-- Message -->
                        <div class="form-group">
                            <label for="message" class="control-label">
                                <h5 class="sbold">
                                    <g:message code="default.contact.form.message" default="Message"/>
                                    <span class="required">*</span>
                                </h5>
                            </label>
                            <div class="input-icon right">
                                <i class="fa"></i>
                                <g:textArea name="message" class="form-control autosizeme form-shadow description-topic backend-input input-md" cols="40" rows="4" maxlength="1000"/>
                            </div>
                            <i class="fa fa-times i-delete-textArea-backend i-delete-topic-description"></i> <!-- Delete text icon -->
                        </div>
                        <!-- Button -->
                        <g:submitButton name="sendMail" class="btn green-dark btn-block contact-form-button" value="${message(code: 'layouts.main_auth_user.body.map.contact.form.button', default: 'Send')}" />
                    </g:form>
                </div>
            </div>
        </div>
    </div>

    <!-- LOAD JAVASCRIPT -->
    <script src="http://maps.google.com/maps/api/js?key=AIzaSyAVkszaEghO-lK3QH156C0w9ANDG2BeHc0" type="text/javascript"></script>
    <g:javascript src="contact/gmaps.min.js"/>
    <g:javascript src="autosize/autosize.min.js"/>
    <g:javascript src="select/bootstrap-select.min.js"/>
    <g:javascript src="select/boostrap-select_i18n/defaults-es_CL.min.js"/>
    <g:javascript src="maxLength/bootstrap-maxlength.min.js"/>
    <g:javascript src="contact/contact.js"/>

</body>
</html>