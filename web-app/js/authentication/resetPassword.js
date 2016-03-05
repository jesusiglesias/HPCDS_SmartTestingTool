/*-------------------------------------------------------------------------------------------*
 *                                  RESET PASSWORD JAVASCRIPT                                *
 *-------------------------------------------------------------------------------------------*/

var Login = function() {

    /**
     * Restore password form.
     */
    var handleForgetPassword = function () {

        // Reset password button activates when user enter the data
        var forgetForm = $(".forget-form");
        var restoreButton = $("#restore-button");
        var emailField = $("#email");

        restoreButton.attr('disabled', 'disabled');

        forgetForm.keyup(function () {
            // Disable reset button
            restoreButton.attr('disabled', 'disabled');

            // Validating fields
            var email = emailField.val().trim();

            // Validating whitespaces
            var emailWhitespace = /\s/g.test(email);

            if (!(email == "" || emailWhitespace)) {
                // Enable reset Button
                restoreButton.removeAttr('disabled');
            }
        });

        // Form validation
        forgetForm.validate({
            errorElement: 'span', // Default input error message container
            errorClass: 'help-block', // Default input error message class
            focusInvalid: false, // Do not focus the last invalid input
            ignore: "",
            rules: {
                email: {
                    required: true,
                    email: true
                }
            },

            messages: {
                email: {
                    required: "",
                    email: _forgotPassword
                }
            },

            highlight: function (element) { // Hightlight error inputs
                $(element).closest('.form-group').addClass('has-error'); // Set error class to the control group
            },

            success: function (label) {
                label.closest('.form-group').removeClass('has-error');
                label.closest('.form-group').addClass('has-success');
                label.remove();
            },

            errorPlacement: function (error, element) {
                error.insertAfter(element.closest('.form-control'));
            }
        });

        $('.forget-form input').keypress(function (e) {

            if (e.which == 13) {
                if (forgetForm.validate().form()) {
                    forgetForm.submit();
                }
                return false;
            }
        });
    };

    return {
        // Main function to initiate the module
        init: function() {
            handleForgetPassword();
        }
    };
}();

// Init login functions when page is loaded
jQuery(document).ready(function() {
    Login.init();
});