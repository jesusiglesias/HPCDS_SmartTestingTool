<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.contact" default="STT | Contact"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'bootstrap-select.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/normalUser', file: 'contactFAQ.css')}" type="text/css"/>

    <script>
        // Variables to use in script
        var _address = '${g.message(code:'layouts.main_auth_user.body.map.address', default:'José Echegaray street,')}';
        var _country = '${g.message(code:'layouts.main_auth_user.body.map.country', default:'Spain')}';
        var _webSite = '${g.message(code:'layouts.main_auth_user.body.map.icon.web', default:'Web site')}';
        var _requiredField = '${g.message(code:'default.validation.required', default:'This field is required.')}';
        var _emailField = '${g.message(code:'default.validation.email', default:'Please, enter a valid email address.')}';
        var _maxlengthField = '${g.message(code:'default.validation.maxlength', default:'Please, enter less than {0} characters.')}';
        var _sendEmail = '${message(code: "layouts.main_auth_user.body.map.contact.form.button", default: "Send")}';
        var _sendingEmail = '${message(code: "customTasksUser.login.stateAccount.sending", default: "Sending...")}';
        var _responseError = '${message(code: "customTasksUser.sendEmail.error", default: "An internal error has occurred during the sending email. You try it again later.")}';
        var _contactFormUrl = '${g.createLink(controller: "customTasksFrontEnd", action: 'contactForm')}';
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
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-contact">
                <h3 class="page-title-user-contact-title">
                    <g:message code="layouts.main_auth_user.body.title.contactUs" default="Contact us"/>
                </h3>
                <p class="page-title-user-contact-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.contactUs.description", default:"In this section you can check more information about us and contact us through the form established for it."))}
                </p>
            </div>
        </div>
    </div>

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
                            <p><i class="icofont icofont-social-google-map"></i> <g:message code="layouts.main_auth_user.body.map.address" default="José Echegaray street,"/><br/>Las Rozas 28232 Madrid,<br/><g:message code="layouts.main_auth_user.body.map.country" default="Spain"/></p>
                        </div>
                        <div class="section">
                            <div class="label uppercase"><g:message code="layouts.main_auth_user.body.map.title.contact" default="Contact"/></div>
                            <p><i class="icofont icofont-ui-email"></i> <a href="mailto:smartestingtool.info@gmail.com" class="contact-map-email break-word">smartestingtool.info@gmail.com</a></p>
                            <p><i class="icofont icofont-phone-circle"></i> +34 91 631 16 84 </p>
                        </div>
                        <div class="section">
                            <div class="label uppercase"><g:message code="layouts.main_auth_user.body.map.title.social" default="Social"/></div>
                            <br/>
                            <ul class="iconlist">
                                <li class="li-site hvr-bounce-to-top-contact">
                                    <a href="https://www.hpcds.com/">
                                        <i class="icofont icofont-web"></i>
                                    </a>
                                </li>
                                <li class="li-google hvr-bounce-to-top-contact">
                                    <a href="https://plus.google.com/103304739299282206903">
                                        <i class="fa fa-google"></i>
                                    </a>
                                </li>
                                <li class="li-youtube hvr-bounce-to-top-contact">
                                    <a href="https://www.youtube.com/user/HPCDSNL">
                                        <i class="fa fa-youtube-play"></i>
                                    </a>
                                </li>
                                <li class="li-linkedin hvr-bounce-to-top-contact">
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
                        <p>${raw(g.message(code:"layouts.main_auth_user.body.map.faq.description", default:"Visit our FAQs page to learn more about <strong>SMART TESTING TOOL</strong>."))}</p>
                        <g:link uri="/faq" class="btn green-dark"><g:message code="layouts.main_auth_user.body.map.faq.button" default="Visit FAQs"/></g:link>
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
                    <form class="contact-form" autocomplete="on">
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
                                <g:textField name="name" maxlength="65" class="form-control form-shadow name-contact contact-input input-md"/>
                                <i class="fa fa-times i-delete-name-contact"></i> <!-- Delete text icon -->
                            </div>
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
                                    <i class="fa"></i>
                                    <g:field type="email" name="email" maxlength="60" class="form-control form-shadow emptySpaces input-md" disabled="true" value="${sec.loggedInUserInfo(field:"email")}"/>
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
                                <g:textArea name="message" class="form-control autosizeme form-shadow message-contact contact-input input-md" cols="40" rows="4" maxlength="1000"/>
                                <i class="fa fa-times i-delete-message-contact"></i> <!-- Delete text icon -->
                            </div>
                        </div>
                        <!-- Button -->
                        <button type="submit" name="sendMail" id="sendMail" class="btn green-dark btn-block contact-form-button">
                            <i class="fa fa-refresh fa-lg refresh-icon-stop refreshIcon"></i>
                            <span><g:message code="layouts.main_auth_user.body.map.contact.form.button" default="Send"/></span>
                        </button>
                    </form>
                    <div id="response"></div>
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