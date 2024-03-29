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
                    name: {
                        required: true,
                        maxlength: 60
                    },
                    description: {
                        required: true,
                        maxlength: 800
                    },
                    initDate: {
                        required: true
                    },
                    endDate: {
                        required: true
                    },
                    lockTime: {
                        required: true,
                        min: 0
                    },
                    maxAttempts: {
                        required: true,
                        min: 1,
                        max: 5
                    },
                    penalty: {
                        required: true,
                        min: 0,
                        max: 100,
                        digits: true
                    },
                    numberOfQuestions: {
                        required: true,
                        min: 0
                    },
                    topic: {
                        required: true
                    },
                    catalog: {
                        required: true
                    }
                },

                messages: {
                    name: {
                        required: _requiredField,
                        maxlength: _maxlengthField
                    },
                    description: {
                        required: _requiredField,
                        maxlength: _maxlengthField
                    },
                    initDate: {
                        required: _requiredField
                    },
                    endDate: {
                        required: _requiredField
                    },
                    lockTime: {
                        required: _requiredField,
                        min: _minField
                    },
                    maxAttempts: {
                        required: _requiredField,
                        min: _minField,
                        max: _maxField
                    },
                    penalty: {
                        required: _requiredField,
                        min: _minField,
                        max: _maxField,
                        digits: _digits
                    },
                    numberOfQuestions: {
                        required: _requiredField,
                        min: _minField
                    },
                    topic: {
                        required: _requiredField
                    },
                    catalog: {
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
     * It checks the test name availability
     */
    var handlerTestNameAvailabilityChecker = function () {

        var nameTest = $('.name-test');
        var nameTestBlock = $('.nameTest-block');

        $("#nameTest-checker").click(function () {

            // Empty name
            if (nameTest.val() === "") {
                nameTest.closest('.form-group').removeClass('has-success').addClass('has-error');

                nameTestBlock.html(_checkerTestNameBlockInfo);
                nameTestBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            nameTest.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkTestNameAvailibility, {

                // Name value
                testName: nameTest.val()

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
     * It handles the max length of the fields
     */
    var handlerMaxlength = function() {

            /* Name field */
            $('.name-test').maxlength({
                limitReachedClass: "label label-danger",
                threshold: 20,
                placement: 'top',
                validate: true
            });

            /* Description field */
            $('.description-test').maxlength({
                limitReachedClass: "label label-danger",
                alwaysShow: true,
                placement: 'top-right-inside',
                validate: true
            });
    };

    /**
     * It handles the select
     */
    var handlerBootstrapSelect = function () {

        // It adds the subtext
        $(".select-maxAttemtps option[value=\"0\"]").attr("data-subtext", _attempts);
        $(".select-maxAttemtps option[value=\"1\"]").attr("data-subtext", _attempt);
        $(".select-maxAttemtps option[value=\"2\"]").attr("data-subtext", _attempts);
        $(".select-maxAttemtps option[value=\"3\"]").attr("data-subtext", _attempts);
        $(".select-maxAttemtps option[value=\"4\"]").attr("data-subtext", _attempts);
        $(".select-maxAttemtps option[value=\"5\"]").attr("data-subtext", _attempts);

        $('.bs-select').selectpicker({
            iconBase: 'fa',
            tickIcon: 'fa-check'
        });
    };

    /**
     * It handles the enabled/disabled option of penalty field
     */
    var handlerEnabledPenalty = function () {
        
        var selectMaxAttemtps = $('.select-maxAttemtps');
        var penaltyField = $('.penalty-test ');

        selectMaxAttemtps.on('changed.bs.select', function (e, newValue) {
            console.log(newValue);

            // Disable penalty field
            if (newValue == 1) {
                console.log("valor 1");
                penaltyField.attr("disabled", true);

            // Enable penalty field
            } else {
                console.log("valor distinto de 1");
                penaltyField.removeAttr("disabled", false);
            }
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
            handlerTestValidation();
            handlerTestNameAvailabilityChecker();
            handlerMaxlength();
            handlerBootstrapSelect();
            handlerEnabledPenalty();
            handlerDatePickers();
        }
    };
}();

jQuery(document).ready(function() {
    DomainTestValidation.init();
});