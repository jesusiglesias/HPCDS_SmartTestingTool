/*-------------------------------------------------------------------------------------------*
 *                  PROFILE USER - PERSONAL INFORMATION VALIDATION JAVASCRIPT                 *
 *-------------------------------------------------------------------------------------------*/

var DomainInformationProfileValidation = function () {

    /**
     * Profile user validation - Personal information
     */
    var handlerInformationProfileValidation = function() {

        var profileInformationForm = $('.profileUser-form');

        profileInformationForm.validate({
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
                    var icon = $(element).parent('.input-icon').children('i');
                    icon.removeClass('fa-check').addClass("fa-warning");  
                    icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
                },

                // Set error class to the control group
                highlight: function (element) {
                    $(element)
                        .closest('.form-group').removeClass("has-success").addClass('has-error');
                },

                // Set success class to the control group
                success: function (label, element) {
                    var icon = $(element).parent('.input-icon').children('i');
                    $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
                    icon.removeClass("fa-warning").addClass("fa-check");
                },

                submitHandler: function (form) {
                    form.submit(); // Submit the form
                }
            });
    };

    /**
     * Handler icons in input fields of user profile
     */
    var handlerIconUserProfile = function() {

        var userProfileEmail = $('.email-userProfile');
        var iconUserProfileEmail = $('.i-delete-userProfile-email');
        var userProfileName = $('.name-userProfile');
        var iconUserProfileName = $('.i-delete-userProfile-name');
        var userProfileSurname = $('.surname-userProfile');
        var iconUserProfileSurname = $('.i-delete-userProfile-surname');
        var userProfileAddress = $('.address-userProfile');
        var iconUserProfileAddress = $('.i-delete-userProfile-address');
        var userProfileCity = $('.city-userProfile');
        var iconUserProfileCity = $('.i-delete-userProfile-city');
        var userProfileCountry = $('.country-userProfile');
        var iconUserProfileCountry = $('.i-delete-userProfile-country');
        var userProfilePhone = $('.phone-userProfile');
        var iconUserProfilePhone = $('.i-delete-userProfile-phone');

        /**
         * Email
         */
        // Show delete icon
        userProfileEmail.keydown(function(){
            iconUserProfileEmail.show();
        });

        // Delete text and hide delete icon
        iconUserProfileEmail.click(function() {
            userProfileEmail.val('').focus();
            iconUserProfileEmail.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesEmailProfile = function() {
            if (userProfileEmail.val() == '') {
                iconUserProfileEmail.hide();
            }
        };

        userProfileEmail.on('keyup keydown keypress change paste', function() {
            toggleClassesEmailProfile(); // Still toggles the classes on any of the above events
        });
        toggleClassesEmailProfile(); // And also on document ready

        /**
         * Name
         */
        // Show delete icon
        userProfileName.keydown(function(){
            iconUserProfileName.show();
        });

        // Delete text and hide delete icon
        iconUserProfileName.click(function() {
            userProfileName.val('').focus();
            iconUserProfileName.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesNameProfile = function() {
            if (userProfileName.val() == '') {
                iconUserProfileName.hide();
            }
        };

        userProfileName.on('keyup keydown keypress change paste', function() {
            toggleClassesNameProfile(); // Still toggles the classes on any of the above events
        });
        toggleClassesNameProfile(); // And also on document ready

        /**
         * Surname
         */
        // Show delete icon
        userProfileSurname.keydown(function(){
            iconUserProfileSurname.show();
        });

        // Delete text and hide delete icon
        iconUserProfileSurname.click(function() {
            userProfileSurname.val('').focus();
            iconUserProfileSurname.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesSurnameProfile = function() {
            if (userProfileSurname.val() == '') {
                iconUserProfileSurname.hide();
            }
        };

        userProfileSurname.on('keyup keydown keypress change paste', function() {
            toggleClassesSurnameProfile(); // Still toggles the classes on any of the above events
        });
        toggleClassesSurnameProfile(); // And also on document ready

        /**
         * Address
         */
        // Show delete icon
        userProfileAddress.keydown(function(){
            iconUserProfileAddress.show();
        });

        // Delete text and hide delete icon
        iconUserProfileAddress.click(function() {
            userProfileAddress.val('').focus();
            iconUserProfileAddress.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesAddressProfile = function() {
            if (userProfileAddress.val() == '') {
                iconUserProfileAddress.hide();
            }
        };

        userProfileAddress.on('keyup keydown keypress change paste', function() {
            toggleClassesAddressProfile(); // Still toggles the classes on any of the above events
        });
        toggleClassesAddressProfile(); // And also on document ready

        /**
         * City
         */
        // Show delete icon
        userProfileCity.keydown(function(){
            iconUserProfileCity.show();
        });

        // Delete text and hide delete icon
        iconUserProfileCity.click(function() {
            userProfileCity.val('').focus();
            iconUserProfileCity.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesCityProfile = function() {
            if (userProfileCity.val() == '') {
                iconUserProfileCity.hide();
            }
        };

        userProfileCity.on('keyup keydown keypress change paste', function() {
            toggleClassesCityProfile(); // Still toggles the classes on any of the above events
        });
        toggleClassesCityProfile(); // And also on document ready

        /**
         * Country
         */
        // Show delete icon
        userProfileCountry.keydown(function(){
            iconUserProfileCountry.show();
        });

        // Delete text and hide delete icon
        iconUserProfileCountry.click(function() {
            userProfileCountry.val('').focus();
            iconUserProfileCountry.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesCountryProfile = function() {
            if (userProfileCountry.val() == '') {
                iconUserProfileCountry.hide();
            }
        };

        userProfileCountry.on('keyup keydown keypress change paste', function() {
            toggleClassesCountryProfile(); // Still toggles the classes on any of the above events
        });
        toggleClassesCountryProfile(); // And also on document ready

        /**
         * Phone
         */
        // Show delete icon
        userProfilePhone.keydown(function(){
            iconUserProfilePhone.show();
        });

        // Delete text and hide delete icon
        iconUserProfilePhone.click(function() {
            userProfilePhone.val('').focus();
            iconUserProfilePhone.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesPhoneProfile = function() {
            if (userProfilePhone.val() == '') {
                iconUserProfilePhone.hide();
            }
        };

        userProfilePhone.on('keyup keydown keypress change paste', function() {
            toggleClassesPhoneProfile(); // Still toggles the classes on any of the above events
        });
        toggleClassesPhoneProfile(); // And also on document ready
    };

    /**
     * It checks the email availability
     */
    var handleEmailAvailabilityChecker = function () {

        var emailProfile = $('#email');
        var emailProfileBlock = $('.emailProfile-block');

        $("#email-profile-checker").click(function (e) {

            // Empty email
            if (emailProfile.val() === "") {
                emailProfile.closest('.form-group').removeClass('has-success').addClass('has-error');

                emailProfileBlock.html(_checkerEmailProfileBlockInfo);
                emailProfileBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            emailProfile.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkEmailProfileAvailibility, {

                // Email value
                email: emailProfile.val()

            }, function (res) {
                btn.attr('disabled', false);

                emailProfile.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                if (res.status == 'OK') {
                    emailProfile.closest('.form-group').removeClass('has-error').addClass('has-success');

                    emailProfileBlock.html(res.message);
                    emailProfileBlock.removeClass('availibility-error');
                    emailProfileBlock.addClass('availibility-success');

                } else {
                    emailProfile.closest('.form-group').removeClass('has-success').addClass('has-error');

                    emailProfileBlock.html(res.message);
                    emailProfileBlock.addClass('availibility-error');
                }
            }, 'json');

        });
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
                orientation: "auto",
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
            handlerInformationProfileValidation();
            handlerIconUserProfile();
            handleEmailAvailabilityChecker();
            handlerMaxlength();
            handlerBootstrapSelect();
            handlerDatePickers();
        }
    };

}();

jQuery(document).ready(function() {
    DomainInformationProfileValidation.init();
});