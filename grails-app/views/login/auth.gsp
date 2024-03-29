<!-------------------------------------------------------------------------------------------*
 *                                    AUTHENTICATION PAGE                                    *
 *------------------------------------------------------------------------------------------->

<html>
<!-- HEAD -->
<head>
    <meta name="layout" content="main_login"/>
    <title><g:message code="views.login.auth.head.title" default="Smart testing tool"/></title>
    <!-- Cookie message -->
    <g:javascript src="cookies/cookies.js"/>

    <script type="text/javascript">

        // Variables to use in script
        var methodUrl = '${g.createLink(controller: "customTasksUser", action: 'statusNotification')}';
        var _stateErrorAccount = '${g.message(code:'customTasksUser.login.stateAccount', default:'Error!')}';
        var inputEmail = '${g.field(type: 'email', id:'emailUser', name:'emailUser', autocomplete:'on')}';
        var _okButton = '${g.message(code:'customTasksUser.login.stateAccount.ok', default:'OK')}';
        var _sendButton = '${g.message(code:'customTasksUser.login.stateAccount.send', default:'Send')}';
        var _cancelButton = '${g.message(code:'customTasksUser.login.stateAccount.cancel', default:'Cancel')}';
        var _successEmail = '${g.message(code:'customTasksUser.login.stateAccount.successful', default:'Email sent successfully!')}';
        var _descriptionSuccessEmail = '${g.message(code:'customTasksUser.login.stateAccount.successful.description', default:'Soon you will receive a response from the administrator.')}';
        var _errorEmail = '${g.message(code:'customTasksUser.login.stateAccount.failure.description', default:'Email with incorrect format, non-existent in the system or a problem has occurred during sending email.')}';
        var _internalError = '${g.message(code:'customTasksUser.login.stateAccount.failure.internalError', default:'It has not been able to connect to the internal server. Try again later.')}';
        var _enabledAccount = '${g.message(code:'views.login.auth.register.alert.title', default:'You must complete the registration!')}';
        var _confirmedAccount = '${g.message(code:'views.login.auth.register.completed.alert.title', default:'User account confirmed!')}';

        // Auto close alert
        function createAutoClosingAlert(selector) {

            var alert = $(selector);

            window.setTimeout(function () {
                alert.hide(1000, function () {
                    $(this).remove();
                });
            }, 5000);
        }
    </script>

</head> <!-- /.HEAD -->

<!-- BODY -->
<body>

    <!-- Authentication -->
    <div class="content">

        <div class="form-title">
            <span class="form-title"><g:message code="views.login.auth.form.title" default="Welcome."/></span>
            <span class="form-subtitle"><g:message code="views.login.auth.form.subtitle" default="Please login."/></span>
        </div>

        <!-- Account states notification -->
        <g:if test='${flash.errorLogin}'>
              <script type="text/javascript">
                  swal({
                      title: _stateErrorAccount,
                      html: '<p>${flash.errorLogin}</p> <br/> <p><input id="emailUser" class="form-control form-control-solid"></p>',
                      type: 'error',
                      showCancelButton: true,
                      cancelButtonText: _cancelButton,
                      confirmButtonText: _sendButton,
                      closeOnConfirm: false,
                      customClass: 'errorSweetAlert'
                  },
                  function() {
                      $.ajax({
                          url: methodUrl,
                          data: { email: $('#emailUser').val(), type: '${flash.errorMessageType}' },
                          beforeSend: function(){
                              swal.disableButtons();
                              $('.sweet-confirm').text('');
                          },
                          success: function(data) {
                              if (data == "sent") {
                                  swal({
                                      title: _successEmail,
                                      text: _descriptionSuccessEmail,
                                      type: 'success',
                                      confirmButtonText: _okButton,
                                      closeOnConfirm: true,
                                      customClass: 'successSweetAlert'
                                  })
                              } else {
                                  swal({
                                      title: _stateErrorAccount,
                                      text: _errorEmail,
                                      type: 'error',
                                      confirmButtonText: _okButton,
                                      closeOnConfirm: true,
                                      customClass: 'errorSweetAlert'
                                  })
                              }
                          },
                          error: function(data) {
                              swal({
                                  title: _stateErrorAccount,
                                  text: _internalError,
                                  type: 'error',
                                  confirmButtonText: _okButton,
                                  closeOnConfirm: true,
                                  customClass: 'errorSweetAlert'
                              })
                          },
                          complete: function(){
                              swal.enableButtons();
                          }
                      });
                  });
              </script>
        </g:if>

        <!-- Enabled account notification -->
        <g:if test='${flash.errorDisabledLogin}'>
            <script type="text/javascript">
                swal({
                    title: _stateErrorAccount,
                    text: '${flash.errorDisabledLogin}',
                    type: 'error',
                    confirmButtonText: _okButton,
                    closeOnConfirm: true,
                    customClass: 'errorSweetAlert'
                });
            </script>
        </g:if>

        <!-- Not user notification -->
        <g:if test='${flash.errorLoginUser}'>
            <div class="alert alert-danger alert-danger-custom alert-dismissable alert-notuser-reauth-invalidsession fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>
                <span> ${raw(flash.errorLoginUser)} </span>
            </div>
            <g:javascript>
                createAutoClosingAlert('.alert-notuser-reauth-invalidsession');
            </g:javascript>
        </g:if>

        <!-- Reauthenticate notification -->
        <g:if test='${flash.reauthenticate}'>
            <div class="alert alert-block alert-warning alert-warning-custom alert-dismissable alert-notuser-reauth-invalidsession fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden='true'></button>
                <h5 class="alert-heading alert-reauthentication">${raw(g.message(code:'views.login.auth.warning.title', default:'<strong>Warning!</strong>'))} </h5>
                <p> ${flash.reauthenticate} </p>
            </div>
        </g:if>

        <!-- Invalid session notification, authentication service exception -->
        <g:if test='${flash.errorInvalidSessionAuthenticationException}'>
            <div class="alert alert-block alert-danger alert-danger-custom alert-dismissable alert-notuser-reauth-invalidsession fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden='true'></button>
                <p> ${flash.errorInvalidSessionAuthenticationException} </p>
            </div>
            <g:javascript>
                createAutoClosingAlert('.alert-notuser-reauth-invalidsession');
            </g:javascript>
        </g:if>

        <!-- New password successful -->
        <g:if test='${flash.newPasswordSuccessful}'>
            <div class="alert alert-block alert-success alert-success-custom alert-dismissable alert-restorePasswordSuccessful fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden='true'></button>
                <p> ${raw(flash.newPasswordSuccessful)} </p>
            </div>
            <g:javascript>
                createAutoClosingAlert('.alert-restorePasswordSuccessful');
            </g:javascript>
        </g:if>

        <!-- New user registered successful -->
        <g:if test='${flash.userRegisterMessage}'>
            <script type="text/javascript">
                swal({
                    title: _enabledAccount,
                    text: '${flash.userRegisterMessage}',
                    type: 'success',
                    confirmButtonText: _okButton,
                    closeOnConfirm: true,
                    customClass: 'successSweetAlert'
                });
            </script>
        </g:if>

        <!-- User account enabled successful -->
        <g:if test='${flash.userEnabledMessage}'>
            <script type="text/javascript">
                swal({
                    title: _confirmedAccount,
                    text: '${flash.userEnabledMessage}',
                    type: 'success',
                    confirmButtonText: _okButton,
                    closeOnConfirm: true,
                    customClass: 'successSweetAlert'
                });
            </script>
        </g:if>

        <!-- Login form -->
        <form action='${postUrl}' method='POST' class="login-form" autocomplete="on">

            <!-- Username/email Field -->
            <div class="form-group form-md-line-input form-md-floating-label has-success">
                <div class="input-icon right">
                    <g:textField class="form-control user-input autofill-input emptySpaces" id="username" name='stt_hp_username' value="${session['SPRING_SECURITY_LAST_USERNAME']}" autocomplete="on"/>
                    <label for="username"><g:message code="views.login.auth.form.username/email" default="Username/Email"/></label>
                    <span class="help-block"><g:message code="views.login.auth.form.username/email.help" default="Enter a valid username or email"/></span>
                    <i class="fa fa-times i-delete" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="icon-user"></i>
                </div>
            </div>

            <!-- Password Field -->
            <div class="form-group form-md-line-input form-md-floating-label has-success">
                <div class="input-icon right">
                    <g:passwordField class="form-control password-input autofill-input emptySpaces" id="password" name='stt_hp_password' autocomplete="off" />
                    <label for="password"><g:message code="views.login.auth.form.password" default="Password"/></label>
                    <span class="help-block"><g:message code="views.login.auth.form.password.help" default="Enter your password"/></span>
                    <i class="fa fa-eye i-show"></i> <!-- Show password icon -->
                    <i class="fa fa-key"></i>
                </div>
            </div>

            <!-- Remember me and password -->
            <div class="form-actions action-remember-password">
                <div class="pull-left">
                    <div class="md-checkbox rememberme">
                        <input type="checkbox" name='${rememberMeParameter}' id='remember_me' class="md-check" <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                        <label for="remember_me" class="">
                            <span></span>
                            <span class="check"></span>
                            <span class="box"></span>
                            <g:message code="views.login.auth.form.rememberme" default="Remember me"/>
                        </label>
                    </div>
                </div>

                <!-- Only it shows when is root path. In reauthentication path does not show -->
                <g:if test='${!flash.reauthenticate}'>
                    <!-- Forgot password -->
                    <div class="pull-right forget-password-block">
                        <g:link uri="/forgotPassword" id="forget-password" class="forget-password"><g:message code="views.login.auth.form.forgotPassword" default="Forgot Password?"/></g:link>
                    </div>
                </g:if>
            </div>

            <!-- Log in -->
            <div class="form-actions">
                <g:submitButton  name="${message(code: "views.login.auth.form.login.button", default: "Log in")}" id="login-button" class="btn green-dark btn-block"/>
            </div>
        </form> <!-- /.Authentication form -->

        <!-- Only it shows when is root path. In reauthentication path does not show -->
        <g:if test='${!flash.reauthenticate}'>
            <!-- Line -->
            <div class="login-options"></div>

            <!-- Create account button -->
            <div class="create-account">
                <g:link uri="/register" class="btn grey-steel signup-button" id="register-btn"><g:message code="views.login.auth.form.createAccount" default="Create an account"/></g:link>
            </div>
         </g:if>
    </div> <!-- /.Authentication -->

    <!-- Only it shows when is root path. In reauthentication path is not displayed -->
    <g:if test='${!flash.reauthenticate}'>
        <div class="copyright"> 2016 © <g:link uri="http://es.linkedin.com/in/jesusgiglesias" class="author-link"> Jesús Iglesias García </g:link></div>
        <div class="logoHP">
            <g:link uri="https://www.hpcds.com/" class="logoAuth">
                <asset:image src="logo/logo_hp.png" alt="HP CDS" class="hvr-wobble-vertical"/>
            </g:link>
            <g:link uri="https://www.inf.uva.es/" class="logoEscuela logoAuthEscuela">
                <asset:image src="logo/logo_escuela.png" alt="UVa" class="hvr-wobble-vertical"/>
            </g:link>
        </div>
    </g:if>

    <!-- Cookie block - Template -->
    <g:render template="../template/cookieBanner"/>

    <g:javascript src="authentication/authentication.js"/>
    <g:javascript src="overlay/loadingoverlay.min.js"/>

</body>
</html>