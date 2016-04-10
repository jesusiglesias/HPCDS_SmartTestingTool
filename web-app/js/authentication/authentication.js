/*-------------------------------------------------------------------------------------------*
 *                                  AUTHENTICATION JAVASCRIPT                                *
 *-------------------------------------------------------------------------------------------*/

var Login = function() {

    /**
     * Login form.
     */
    var handleLogin = function() {

        // Login button activates when user enter the data
        var loginForm = $(".login-form");
        var loginButton =  $("#login-button");
        var usernameField = $("#username");
        var passwordField = $("#password");

        loginButton.attr('disabled', 'disabled');

        loginForm.keyup(function () {
            // Disable login button
            loginButton.attr('disabled', 'disabled');

            // Validating fields
            var username = usernameField.val().trim();
            var password = passwordField.val().trim();

            // Validating whitespaces
            var usernameWhitespace = /\s/g.test(username);
            var passwordWhitespace = /\s/g.test(password);

            if (!(username == "" || password == "" || usernameWhitespace || passwordWhitespace)) {
                    // Enable login Button
                    loginButton.removeAttr('disabled');
            }
        });
    };

    /**
     * It handles the overlay in log in action.
     */
    var handlerOverlay = function() {

        var loginButton =  $("#login-button");

        loginButton.click(function() {
            $.LoadingOverlay("show", {
                color       : "rgba(255, 255, 255, 0.2)",
                image       : "",
                fontawesome : "fa fa-spinner fa-spin"
            });
        });
    };

    var handleRegister = function() {

        function format(state) {
            if (!state.id) { return state.text; }
            var $state = $(
             '<span><img src="../assets/global/img/flags/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
            );
            
            return $state;
        }

        if (jQuery().select2 && $('#country_list').size() > 0) {
            $("#country_list").select2({
	            placeholder: '<i class="fa fa-map-marker"></i>&nbsp;Select a Country',
	            templateResult: format,
                templateSelection: format,
                width: 'auto', 
	            escapeMarkup: function(m) {
	                return m;
	            }
	        });


	        $('#country_list').change(function() {
	            $('.register-form').validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
	        });
    	}

        $('.register-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {

                fullname: {
                    required: true
                },
                email: {
                    required: true,
                    email: true
                },
                address: {
                    required: true
                },
                city: {
                    required: true
                },
                country: {
                    required: true
                },

                username: {
                    required: true
                },
                password: {
                    required: true
                },
                rpassword: {
                    equalTo: "#register_password"
                },

                tnc: {
                    required: true
                }
            },

            messages: { // custom messages for radio buttons and checkboxes
                tnc: {
                    required: "Please accept TNC first."
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit   

            },

            highlight: function(element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },

            errorPlacement: function(error, element) {
                if (element.attr("name") == "tnc") { // insert checkbox errors after the container                  
                    error.insertAfter($('#register_tnc_error'));
                } else if (element.closest('.input-icon').size() === 1) {
                    error.insertAfter(element.closest('.input-icon'));
                } else {
                    error.insertAfter(element);
                }
            },

            submitHandler: function(form) {
                form.submit();
            }
        });

        $('.register-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.register-form').validate().form()) {
                    $('.register-form').submit();
                }
                return false;
            }
        });

        jQuery('#register-btn').click(function() {
            jQuery('.login-form').hide();
            jQuery('.register-form').show();
        });

        jQuery('#register-back-btn').click(function() {
            jQuery('.login-form').show();
            jQuery('.register-form').hide();
        });
    };

    return {
        // Main function to initiate the module
        init: function() {

            handleLogin();
            handlerOverlay();
            handleRegister();
        }
    };
}();

// Init login functions when page is loaded
jQuery(document).ready(function() {
    Login.init();
});