/*-------------------------------------------------------------------------------------------*
 *                                 ADMIN VALIDATION JAVASCRIPT                               *
 *-------------------------------------------------------------------------------------------*/

var DomainAdminValidation = function () {

    /**
     * Admin validation
     */
    var handlerAdminValidation = function() {

        var adminForm = $('.admin-form');

        adminForm.validate({
                errorElement: 'span', // Default input error message container
                errorClass: 'help-block help-block-error', // Default input error message class
                focusInvalid: false, // Do not focus the last invalid input
                ignore: "",  // Validate all fields including form hidden input
                rules: {
                    username: {
                        required: true
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    password: {
                        required: true
                    },
                    confirmPassword: {
                        required: true,
                        equalTo: "#password"
                    }
                },

                messages: {
                    username: {
                        required: _requiredField
                    },
                    email: {
                        required: _requiredField,
                        email: _emailField
                    },
                    password: {
                        required: _requiredField
                    },
                    confirmPassword: {
                        required: _requiredField,
                        equalTo: _equalPassword
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

    return {
        // Main function to initiate the module
        init: function () {
            handlerAdminValidation();
        }
    };

}();

jQuery(document).ready(function() {
    DomainAdminValidation.init();
});