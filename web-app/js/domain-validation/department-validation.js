/*-------------------------------------------------------------------------------------------*
 *                              DEPARTMENT VALIDATION JAVASCRIPT                             *
 *-------------------------------------------------------------------------------------------*/

var DomainDepartmentValidation = function () {

    /**
     * Department validation
     */
    var handlerDepartmentValidation = function() {

        var departmentForm = $('.department-form');

        departmentForm.validate({
                errorElement: 'span', // Default input error message container
                errorClass: 'help-block help-block-error', // Default input error message class
                focusInvalid: false, // Do not focus the last invalid input
                ignore: "",  // Validate all fields including form hidden input
                rules: {
                    name: {
                        required: true,
                        maxlength: 50
                    }
                },

                messages: {
                    name: {
                        required: _requiredField,
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
    var handleNameAvailabilityChecker = function () {

        var name = $('#name');
        var nameBlock = $('.department-block');

        $("#nameDepartment-checker").click(function (e) {

            // Empty name
            if (name.val() === "") {
                name.closest('.form-group').removeClass('has-success').addClass('has-error');

                nameBlock.html(_checkerNameBlockInfo);
                nameBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            name.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkNameAvailibility, {

                // Name value
                name: name.val()

            }, function (res) {
                btn.attr('disabled', false);

                name.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                if (res.status == 'OK') {
                    name.closest('.form-group').removeClass('has-error').addClass('has-success');

                    nameBlock.html(res.message);
                    nameBlock.removeClass('availibility-error');
                    nameBlock.addClass('availibility-success');

                } else {
                    name.closest('.form-group').removeClass('has-success').addClass('has-error');

                    nameBlock.html(res.message);
                    nameBlock.addClass('availibility-error');
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
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerDepartmentValidation();
            handleNameAvailabilityChecker();
            handlerMaxlength();
        }
    };

}();

jQuery(document).ready(function() {
    DomainDepartmentValidation.init();
});