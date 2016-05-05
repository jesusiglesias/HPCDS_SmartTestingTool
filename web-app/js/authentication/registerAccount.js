/*-------------------------------------------------------------------------------------------*
 *                                REGISTER ACCOUNT JAVASCRIPT                                *
 *-------------------------------------------------------------------------------------------*/

var RegisterAccount = function () {

    /**
     * User validation
     */
    var handlerUserRegisterValidation = function() {

        var userForm = $('.register-form');

        jQuery.validator.addMethod("notEqualToUsername", function(value, element, param) {
            return this.optional(element) || value.toLowerCase() != $(param).val().toLowerCase();
        }, _equalPasswordUsername);

        userForm.validate({
            errorElement: 'span', // Default input error message container
            errorClass: 'help-block help-block-error', // Default input error message class
            focusInvalid: false, // Do not focus the last invalid input
            ignore: "",  // Validate all fields including form hidden input
            rules: {
                username: {
                    required: true,
                    maxlength: 30
                },
                email: {
                    required: true,
                    email: true,
                    maxlength: 60
                },
                password: {
                    required: true,
                    notEqualToUsername:'#username'
                },
                confirmPassword: {
                    required: true,
                    equalTo: "#password"
                },
                name: {
                    required: true,
                    maxlength: 25
                },
                surname: {
                    required: true,
                    maxlength: 40
                },
                birthDate: {
                    required: true
                },
                address: {
                    maxlength: 70
                },
                city: {
                    maxlength: 70
                },
                country: {
                    maxlength: 70
                },
                phone: {
                    maxlength: 20
                },
                sex: {
                    required: true
                },
                department: {
                    required: true
                }
            },

            messages: {
                username: {
                    required: _requiredField,
                    maxlength: _maxlengthField
                },
                email: {
                    required: _requiredField,
                    email: _emailField,
                    maxlength: _maxlengthField
                },
                password: {
                    required: _requiredField,
                    notEqualToUsername: _equalPasswordUsername
                },
                confirmPassword: {
                    required: _requiredField,
                    equalTo: _equalPassword
                },
                name: {
                    required: _requiredField,
                    maxlength: _maxlengthField
                },
                surname: {
                    required: _requiredField,
                    maxlength: _maxlengthField
                },
                birthDate: {
                    required: _requiredField
                },
                address: {
                    maxlength: _maxlengthField
                },
                city: {
                    maxlength: _maxlengthField
                },
                country: {
                    maxlength: _maxlengthField
                },
                phone: {
                    maxlength: _maxlengthField
                },
                sex: {
                    required: _requiredField
                },
                department: {
                    required: _requiredField
                }
            },

            // Render error placement for each input type
            errorPlacement: function (error, element) {
                var input = $(element).parent('.input-icon');
                input.attr("data-original-title", error.text()).tooltip({'container': 'body'});
            },

            // Set error class to the control group
            highlight: function (element) {
                $(element).closest('.form-group').removeClass("has-success").addClass('has-error');
                $(element).closest('.input-icon').children('.control-labelError').removeClass("has-success").addClass('has-error-default');
                $(element).closest('.input-icon').children('.h5-error').removeClass("has-success").addClass('has-error-default');
                $(element).closest('.form-group').children('.control-label').children('.h5-error').removeClass("has-success").addClass('has-error-default');
            },

            // Set success class to the control group
            success: function (label, element) {
                var input = $(element).parent('.input-icon');
                $(input).closest('.form-group').removeClass('has-error').addClass('has-success');
                $(element).closest('.input-icon').children('.control-labelError').removeClass("has-error-default").addClass('has-success');
                $(element).closest('.input-icon').children('.h5-error').removeClass("has-error-default").addClass('has-success');
                $(element).closest('.form-group').children('.control-label').children('.h5-error').removeClass("has-error-default").addClass('has-success');
            },

            submitHandler: function (form) {
                form.submit(); // Submit the form
            }
        });
    };

    /**
     * Register form.
     */
    var handlerDisabledButtonRegister = function() {

        // Register button activates when user enter data in all mandatory fields
        var registerForm = $(".register-form");
        var registerButton =  $("#register-button");
        var usernameField = $("#username");
        var emailField = $("#email");
        var passwordField = $("#password");
        var confirmPasswordField = $("#confirmPassword");
        var nameField = $("#name");
        var surnameField = $("#surname");

        registerButton.attr('disabled', 'disabled');

        registerForm.keyup(function () {
            // Disable login button
            registerButton.attr('disabled', 'disabled');

            // Validating fields
            var username = usernameField.val().trim();
            var email = emailField.val().trim();
            var password = passwordField.val().trim();
            var confirmPassword = confirmPasswordField.val().trim();
            var name = nameField.val().trim();
            var surname = surnameField.val().trim();

            // Validating whitespaces
            var usernameWhitespace = /\s/g.test(username);
            var emailWhitespace = /\s/g.test(email);
            var passwordWhitespace = /\s/g.test(password);
            var confirmPasswordWhitespace = /\s/g.test(confirmPassword);

            if (!(username == "" || email == "" || password == "" || confirmPassword == "" || name == "" || surname == ""
                || usernameWhitespace || emailWhitespace || passwordWhitespace || confirmPasswordWhitespace)) {
                // Enable regiuster button
                registerButton.removeAttr('disabled');
            }
        });
    };

    /**
     * It checks the username availability
     */
    var handleUsernameAvailabilityChecker = function () {

        $(".username-input-register").change(function () {
            
            var input = $(this);
            var usernameBlock = $('.username-register-block');

            // Empty username
            if (input.val() === "") {
                input.closest('.form-group').removeClass('has-success').addClass('has-error');

                usernameBlock.html(_checkerUsernameBlockInfo);
                usernameBlock.addClass('availibility-error');
                return;
            }

            input.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkUsernameAvailibility, {
                // Username value
                username: input.val()

            }, function (res) {

                input.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                // change popover font color based on the result
                if (res.status == 'OK') {
                    input.closest('.form-group').removeClass('has-error').addClass('has-success');

                    usernameBlock.html(res.message);
                    usernameBlock.removeClass('availibility-error');
                    usernameBlock.addClass('availibility-success');

                } else {
                    input.closest('.form-group').removeClass('has-success').addClass('has-error');

                    usernameBlock.html(res.message);
                    usernameBlock.addClass('availibility-error');
                }
            }, 'json');
        });
    };

    /**
     * It checks the email availability
     */
    var handleEmailAvailabilityChecker = function () {

        $(".email-input-register").change(function () {

            var input = $(this);
            var emailBlock = $('.email-register-block');

            // Empty email
            if (input.val() === "") {
                input.closest('.form-group').removeClass('has-success').addClass('has-error');

                emailBlock.html(_checkerEmailBlockInfo);
                emailBlock.addClass('availibility-error');
                return;
            }

            input.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkEmailAvailibility, {
                // Email value
                email: input.val()

            }, function (res) {

                input.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                // change popover font color based on the result
                if (res.status == 'OK') {
                    input.closest('.form-group').removeClass('has-error').addClass('has-success');

                    emailBlock.html(res.message);
                    emailBlock.removeClass('availibility-error');
                    emailBlock.addClass('availibility-success');

                } else {
                    input.closest('.form-group').removeClass('has-success').addClass('has-error');

                    emailBlock.html(res.message);
                    emailBlock.addClass('availibility-error');
                }
            }, 'json');
        });
    };

    /**
     * Handler icons in the input fields of the user
     */
    var handlerIconUserRegister = function() {

        var userUsername = $('.username-input-register');
        var iconUserUsername = $('.i-delete-register-username');
        var userEmail = $('.email-input-register');
        var iconUserEmail = $('.i-delete-register-email');
        var userPassword = $(".password-input-register");
        var iconUserPassword = $('.i-show-register-password');
        var userConfirmPassword = $(".password-confirm-input-register");
        var iconUserConfirmPassword = $('.i-show-register-confirmPassword');
        var userName = $('.name-input-register');
        var iconUserName = $('.i-delete-register-name');
        var userSurname = $('.surname-input-register');
        var iconUserSurname = $('.i-delete-register-surname');
        var userAddress = $('.address-input-register');
        var iconUserAddress = $('.i-delete-register-address');
        var userCity = $('.city-input-register');
        var iconUserCity = $('.i-delete-register-city');
        var userCountry = $('.country-input-register');
        var iconUserCountry = $('.i-delete-register-country');
        var userPhone = $('.phone-input-register');
        var iconUserPhone = $('.i-delete-register-phone');

        var isMobile = { // Mobile device
            Android: function() {
                return navigator.userAgent.match(/Android/i);
            },
            BlackBerry: function() {
                return navigator.userAgent.match(/BlackBerry/i);
            },
            iOS: function() {
                return navigator.userAgent.match(/iPhone|iPad|iPod/i);
            },
            Opera: function() {
                return navigator.userAgent.match(/Opera Mini/i);
            },
            Windows: function() {
                return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/WPDesktop/i);
            },
            any: function() {
                return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
            }
        };

        /**
         * Username
         */
        // Show delete icon
        userUsername.keydown(function(){
            iconUserUsername.show();
        });

        // Delete text and hide delete icon
        iconUserUsername.click(function() {
            userUsername.val('').focus();
            iconUserUsername.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesUsername = function() {
            if (userUsername.val() == '') {
                iconUserUsername.hide();
            }
        };

        userUsername.on('keyup keydown keypress change paste', function() {
            toggleClassesUsername(); // Still toggles the classes on any of the above events
        });
        toggleClassesUsername(); // And also on document ready

        /**
         * Email
         */
        // Show delete icon
        userEmail.keydown(function(){
            iconUserEmail.show();
        });

        // Delete text and hide delete icon
        iconUserEmail.click(function() {
            userEmail.val('').focus();
            iconUserEmail.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesEmail = function() {
            if (userEmail.val() == '') {
                iconUserEmail.hide();
            }
        };

        userEmail.on('keyup keydown keypress change paste', function() {
            toggleClassesEmail(); // Still toggles the classes on any of the above events
        });
        toggleClassesEmail(); // And also on document ready

        /**
         * Password
         */
        // Show eye icon
        userPassword.keydown(function(){
            iconUserPassword.show();
            iconUserPassword.css( {
                'cursor' : 'pointer',
                'right': 50,
                'position': 'absolute' });
        });

        // Hide eye icon when user deletes text with the keyboard
        var toggleClassesPassword = function() {
            if (userPassword.val() == '') {
                iconUserPassword.hide();
            }
        };
        userPassword.on('keyup keydown keypress change paste', function() {
            toggleClassesPassword(); // Still toggles the classes on any of the above events
        });
        toggleClassesPassword(); // and also on document ready


        // Check if it is a mobile device
        if( isMobile.any() ) {

            // Check if it is Internet Explorer - Trident and rv:11 belongs to IE 11
            if ((navigator.userAgent.match(/msie/i)) ||  (navigator.userAgent.match(/Trident/)
                && navigator.userAgent.match(/rv:11/))) {

                // Drop
                iconUserPassword.on('touchend click', function(e){
                    e.stopPropagation(); e.preventDefault();
                    userPassword.attr('type', 'password');
                });

                // Hold
                iconUserPassword.on('touchstart click', function(e){
                    e.stopPropagation(); e.preventDefault();
                    userPassword.attr('type', 'field');
                });

            } else {

                // Drop
                iconUserPassword.on('touchend click', function(e){
                    e.stopPropagation(); e.preventDefault();
                    userPassword.prop('type', 'password');
                });

                // Hold
                iconUserPassword.on('touchstart click', function(e){
                    e.stopPropagation(); e.preventDefault();
                    userPassword.prop('type', 'field');
                });
            }
        } else {

            // Check if it is Internet Explorer - Trident and rv:11 belongs to IE 11
            if ((navigator.userAgent.match(/msie/i)) ||  (navigator.userAgent.match(/Trident/)
                && navigator.userAgent.match(/rv:11/))) {

                // Drop
                iconUserPassword.mouseup(function() {
                    userPassword.attr('type', 'password');
                });

                // Hold
                iconUserPassword.mousedown(function() {
                    userPassword.attr('type', 'field');
                });

            } else {

                // Drop
                iconUserPassword.mouseup(function() {
                    userPassword.prop('type', 'password');
                });

                // Hold
                iconUserPassword.mousedown(function() {
                    userPassword.prop('type', 'field');
                });
            }
        }

        /**
         * Confirm password
         */
        // Show eye icon
        userConfirmPassword.keydown(function(){
            iconUserConfirmPassword.show();
            iconUserConfirmPassword.css( {
                'cursor' : 'pointer',
                'right': 50,
                'position': 'absolute' });
        });

        // Hide eye icon when user deletes text with the keyboard
        var toggleClassesPasswordConfirm = function() {
            if (userConfirmPassword.val() == '') {
                iconUserConfirmPassword.hide();
            }
        };
        userConfirmPassword.on('keyup keydown keypress change paste', function() {
            toggleClassesPasswordConfirm(); // Still toggles the classes on any of the above events
        });
        toggleClassesPasswordConfirm(); // and also on document ready


        // Check if it is a mobile device
        if( isMobile.any() ) {

            // Check if it is Internet Explorer - Trident and rv:11 belongs to IE 11
            if ((navigator.userAgent.match(/msie/i)) ||  (navigator.userAgent.match(/Trident/)
                && navigator.userAgent.match(/rv:11/))) {

                // Drop
                iconUserConfirmPassword.on('touchend click', function(e){
                    e.stopPropagation(); e.preventDefault();
                    userConfirmPassword.attr('type', 'password');
                });

                // Hold
                iconUserConfirmPassword.on('touchstart click', function(e){
                    e.stopPropagation(); e.preventDefault();
                    userConfirmPassword.attr('type', 'field');
                });

            } else {

                // Drop
                iconUserConfirmPassword.on('touchend click', function(e){
                    e.stopPropagation(); e.preventDefault();
                    userConfirmPassword.prop('type', 'password');
                });

                // Hold
                iconUserConfirmPassword.on('touchstart click', function(e){
                    e.stopPropagation(); e.preventDefault();
                    userConfirmPassword.prop('type', 'field');
                });
            }
        } else {

            // Check if it is Internet Explorer - Trident and rv:11 belongs to IE 11
            if ((navigator.userAgent.match(/msie/i)) ||  (navigator.userAgent.match(/Trident/)
                && navigator.userAgent.match(/rv:11/))) {

                // Drop
                iconUserConfirmPassword.mouseup(function() {
                    userConfirmPassword.attr('type', 'password');
                });

                // Hold
                iconUserConfirmPassword.mousedown(function() {
                    userConfirmPassword.attr('type', 'field');
                });

            } else {

                // Drop
                iconUserConfirmPassword.mouseup(function() {
                    userConfirmPassword.prop('type', 'password');
                });

                // Hold
                iconUserConfirmPassword.mousedown(function() {
                    userConfirmPassword.prop('type', 'field');
                });
            }
        }

        /**
         * Name
         */
        // Show delete icon
        userName.keydown(function(){
            iconUserName.show();
        });

        // Delete text and hide delete icon
        iconUserName.click(function() {
            userName.val('').focus();
            iconUserName.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesName = function() {
            if (userName.val() == '') {
                iconUserName.hide();
            }
        };

        userName.on('keyup keydown keypress change paste', function() {
            toggleClassesName(); // Still toggles the classes on any of the above events
        });
        toggleClassesName(); // And also on document ready

        /**
         * Surname
         */
        // Show delete icon
        userSurname.keydown(function(){
            iconUserSurname.show();
        });

        // Delete text and hide delete icon
        iconUserSurname.click(function() {
            userSurname.val('').focus();
            iconUserSurname.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesSurname = function() {
            if (userSurname.val() == '') {
                iconUserSurname.hide();
            }
        };

        userSurname.on('keyup keydown keypress change paste', function() {
            toggleClassesSurname(); // Still toggles the classes on any of the above events
        });
        toggleClassesSurname(); // And also on document ready

        /**
         * Address
         */
        // Show delete icon
        userAddress.keydown(function(){
            iconUserAddress.show();
        });

        // Delete text and hide delete icon
        iconUserAddress.click(function() {
            userAddress.val('').focus();
            iconUserAddress.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesAddress = function() {
            if (userAddress.val() == '') {
                iconUserAddress.hide();
            }
        };

        userAddress.on('keyup keydown keypress change paste', function() {
            toggleClassesAddress(); // Still toggles the classes on any of the above events
        });
        toggleClassesAddress(); // And also on document ready

        /**
         * City
         */
        // Show delete icon
        userCity.keydown(function(){
            iconUserCity.show();
        });

        // Delete text and hide delete icon
        iconUserCity.click(function() {
            userCity.val('').focus();
            iconUserCity.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesCity = function() {
            if (userCity.val() == '') {
                iconUserCity.hide();
            }
        };

        userCity.on('keyup keydown keypress change paste', function() {
            toggleClassesCity(); // Still toggles the classes on any of the above events
        });
        toggleClassesCity(); // And also on document ready

        /**
         * Country
         */
        // Show delete icon
        userCountry.keydown(function(){
            iconUserCountry.show();
        });

        // Delete text and hide delete icon
        iconUserCountry.click(function() {
            userCountry.val('').focus();
            iconUserCountry.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesCountry = function() {
            if (userCountry.val() == '') {
                iconUserCountry.hide();
            }
        };

        userCountry.on('keyup keydown keypress change paste', function() {
            toggleClassesCountry(); // Still toggles the classes on any of the above events
        });
        toggleClassesCountry(); // And also on document ready

        /**
         * Phone
         */
        // Show delete icon
        userPhone.keydown(function(){
            iconUserPhone.show();
        });

        // Delete text and hide delete icon
        iconUserPhone.click(function() {
            userPhone.val('').focus();
            iconUserPhone.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesPhone = function() {
            if (userPhone.val() == '') {
                iconUserPhone.hide();
            }
        };

        userPhone.on('keyup keydown keypress change paste', function() {
            toggleClassesPhone(); // Still toggles the classes on any of the above events
        });
        toggleClassesPhone(); // And also on document ready
    };

    /**
     * It handles the max length of the fields
     */
    var handlerMaxlength = function() {

        /* Username field */
        $('#username').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 10,
            placement: 'top',
            validate: true
        });

        /* Email field */
        $('#email').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 20,
            placement: 'top',
            validate: true
        });

        /* Name field */
        $('#name').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 8,
            placement: 'top',
            validate: true
        });

        /* Surname field */
        $('#surname').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 15,
            placement: 'top',
            validate: true
        });

        /* Address field */
        $('#address').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 30,
            placement: 'top',
            validate: true
        });

        /* City field */
        $('#city').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 30,
            placement: 'top',
            validate: true
        });

        /* Country field */
        $('#country').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 30,
            placement: 'top',
            validate: true
        });

        /* Phone field */
        $('#phone').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 5,
            placement: 'top',
            validate: true
        });
    };

    /**
     * It handles the select
     */
    var handlerBootstrapSelect = function () {

        $('.bs-select').selectpicker({
            iconBase: 'fa',
            tickIcon: 'fa-check'
        });
    };

    /**
     * It handles the date picker
     */
    var handlerDatePickers = function () {

        if (jQuery().datepicker) {
            $('.date-picker').datepicker({
                orientation: "left",
                autoclose: true,
                clearBtn: true,
                language: 'es',
                format: 'dd-mm-yyyy'
            });
        }
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerUserRegisterValidation();
            handlerDisabledButtonRegister();
            handleUsernameAvailabilityChecker();
            handleEmailAvailabilityChecker();
            handlerIconUserRegister();
            handlerMaxlength();
            handlerBootstrapSelect();
            handlerDatePickers();
        }
    };

}();

jQuery(document).ready(function() {
    RegisterAccount.init();
});