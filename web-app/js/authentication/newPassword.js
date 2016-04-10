/*-------------------------------------------------------------------------------------------*
 *                                    NEW PASSWORD JAVASCRIPT                                *
 *-------------------------------------------------------------------------------------------*/

var Login = function() {

    /**
     * New password form.
     */
    var handleNewPassword = function () {

        // Reset password button activates when user enter the data
        var forgetForm = $(".forget-form");
        var newPasswordButton = $("#newPassword-button");
        var passwordField = $("#password");
        var passwordConfirmField = $("#passwordConfirm");
        var formConfirmPassword = $('.form-confirmPassword');

        newPasswordButton.attr('disabled', 'disabled');

        forgetForm.keyup(function () {
            // Disable new password button
            newPasswordButton.attr('disabled', 'disabled');

            // Validating fields
            var password = passwordField.val().trim();
            var passwordConfirm = passwordConfirmField.val().trim();

            // Validating whitespaces
            var passwordWhitespace = /\s/g.test(password);
            var passwordConfirmWhitespace = /\s/g.test(passwordConfirm);

            if (!(password == "" || passwordConfirm == "" || passwordWhitespace || passwordConfirmWhitespace)) {
                // Enable new password Button
                newPasswordButton.removeAttr('disabled');
            }
        });

        // Form validation
        forgetForm.validate({
            focusInvalid: true, // Do not focus the last invalid input
            ignore: "",
            rules: {
                passwordConfirm: {
                    equalTo: "#password"
                }
            },

            messages: {
                passwordConfirm: {
                    equalTo: _equalPassword
                }
            },

            highlight: function (element) { // Hightlight error inputs
                $(element).closest('.form-group').removeClass('has-error').addClass('has-error'); // Set error class to the control group
            },

            success: function () {
                formConfirmPassword.removeClass('has-error');
                formConfirmPassword.addClass('has-success');

                var icon = $('.i-checkPassword');
                icon.removeClass("fa-warning").addClass("fa-key");
            },

            errorPlacement: function (error) {

                var icon = $('.i-checkPassword');
                icon.removeClass('fa-key').addClass("fa-warning");
                icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
            },

            submitHandler: function (form) {
                form.submit(); // Submit the form
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
            handleNewPassword();
        }
    };
}();

// Init login functions when page is loaded
jQuery(document).ready(function() {
    Login.init();
});