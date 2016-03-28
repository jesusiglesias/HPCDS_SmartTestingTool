/*-------------------------------------------------------------------------------------------*
 *                                   TOPIC VALIDATION JAVASCRIPT                             *
 *-------------------------------------------------------------------------------------------*/

var DomainTopicValidation = function () {

    /**
     * Topic validation
     */
    var handlerTopicValidation = function() {

        var topicForm = $('.topic-form');

        topicForm.validate({
                errorElement: 'span', // Default input error message container
                errorClass: 'help-block help-block-error', // Default input error message class
                focusInvalid: false, // Do not focus the last invalid input
                ignore: "",  // Validate all fields including form hidden input
                rules: {
                    name: {
                        required: true,
                        maxlength: 50
                    },
                    description: {
                        maxlength: 500
                    }
                },

                messages: {
                    name: {
                        required: _requiredField,
                        maxlength: _maxlengthField
                    },
                    description: {
                        maxlength: _maxlengthField
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
     * It checks the name availability
     */
    var handlerNameAvailabilityChecker = function () {

        var name = $('#name');
        var nameTopicBlock = $('.nameTopic-block');

        $("#nameTopic-checker").click(function (e) {

            // Empty name
            if (name.val() === "") {
                name.closest('.form-group').removeClass('has-success').addClass('has-error');

                nameTopicBlock.html(_checkerNameBlockInfo);
                nameTopicBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            name.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkNameTopicAvailibility, {

                // Name value
                name: name.val()

            }, function (res) {
                btn.attr('disabled', false);

                name.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                if (res.status == 'OK') {
                    name.closest('.form-group').removeClass('has-error').addClass('has-success');

                    nameTopicBlock.html(res.message);
                    nameTopicBlock.removeClass('availibility-error');
                    nameTopicBlock.addClass('availibility-success');

                } else {
                    name.closest('.form-group').removeClass('has-success').addClass('has-error');

                    nameTopicBlock.html(res.message);
                    nameTopicBlock.addClass('availibility-error');
                }
            }, 'json');

        });
    };

    /**
     * It handles the max length of the fields
     */
    var handlerMaxlength = function() {

            /* Name field */
            $('#name').maxlength({
                limitReachedClass: "label label-danger",
                threshold: 20,
                placement: 'top',
                validate: true
            });

            /* Description field */
            $('#description').maxlength({
                limitReachedClass: "label label-danger",
                alwaysShow: true,
                placement: 'top-right-inside',
                validate: true
            });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerTopicValidation();
            handlerNameAvailabilityChecker();
            handlerMaxlength();
        }
    };

}();

jQuery(document).ready(function() {
    DomainTopicValidation.init();
});