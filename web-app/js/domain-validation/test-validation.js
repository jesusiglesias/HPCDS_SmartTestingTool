/*-------------------------------------------------------------------------------------------*
 *                                   TEST VALIDATION JAVASCRIPT                              *
 *-------------------------------------------------------------------------------------------*/

var DomainTestValidation = function () {

    /**
     * Test validation
     */
    var handlerTestValidation = function() {

        var testForm = $('.test-form');

        testForm.validate({
                errorElement: 'span', // Default input error message container
                errorClass: 'help-block help-block-error', // Default input error message class
                focusInvalid: false, // Do not focus the last invalid input
                ignore: "",  // Validate all fields including form hidden input
                rules: {
                    // TODO
                    titleAnswerKey: {
                        required: true,
                        maxlength: 50
                    },
                    description: {
                        required: true,
                        maxlength: 400
                    },
                    score: {
                        required: true,
                        min: 0,
                        max: 5
                    }
                },

                messages: {
                    titleAnswerKey: {
                        required: _requiredField,
                        maxlength: _maxlengthField
                    },
                    description: {
                        required: _requiredField,
                        maxlength: _maxlengthField
                    },
                    score: {
                        required: _requiredField,
                        min: _minField,
                        max: _maxField
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
     * It checks the test name availability TODO
     */
    var handlertestNameAvailabilityChecker = function () {

        var nameTest = $('#name');
        var nameTestBlock = $('.nameTest-block');

        $("#nameTest-checker").click(function () {

            // Empty name
            if (nameTest.val() === "") {
                nameTest.closest('.form-group').removeClass('has-success').addClass('has-error');

                nameTestBlock.html(_checkerNameTestBlockInfo);
                nameTestBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            nameTest.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkNameTestAvailibility, {

                // Name value TODO
                answerKey: nameTest.val()

            }, function (res) {
                btn.attr('disabled', false);

                nameTest.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                if (res.status == 'OK') {
                    nameTest.closest('.form-group').removeClass('has-error').addClass('has-success');

                    nameTestBlock.html(res.message);
                    nameTestBlock.removeClass('availibility-error');
                    nameTestBlock.addClass('availibility-success');

                } else {
                    nameTest.closest('.form-group').removeClass('has-success').addClass('has-error');

                    nameTestBlock.html(res.message);
                    nameTestBlock.addClass('availibility-error');
                }
            }, 'json');

        });
    };

    /**
     * It handles the max length of the fields TODO
     */
    var handlerMaxlength = function() {

            /* field */
            $('#').maxlength({
                limitReachedClass: "label label-danger",
                threshold: 20,
                placement: 'top',
                validate: true
            });

            /* field */
            $('#').maxlength({
                limitReachedClass: "label label-danger",
                alwaysShow: true,
                placement: 'top-right-inside',
                validate: true
            });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerTestValidation();
            handlertestNameAvailabilityChecker();
            handlerMaxlength();
        }
    };
}();

jQuery(document).ready(function() {
    DomainTestValidation.init();
});