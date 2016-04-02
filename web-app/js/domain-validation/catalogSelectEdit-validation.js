/*-------------------------------------------------------------------------------------------*
 *                                CATALOG EDIT VALIDATION JAVASCRIPT                         *
 *-------------------------------------------------------------------------------------------*/

var DomainCatalogEditValidation = function () {

    /**
     * Catalog validation
     */
    var handlerCatalogCreateValidation = function() {

        var catalogForm = $('.catalog-form');

        catalogForm.validate({
            errorElement: 'span', // Default input error message container
            errorClass: 'help-block help-block-error', // Default input error message class
            focusInvalid: false, // Do not focus the last invalid input
            ignore: "",  // Validate all fields including form hidden input
            rules: {
                name: {
                    required: true,
                    maxlength: 100
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
    var handlerNameAvailabilityChecker = function () {

        var name = $('#name');
        var nameBlock = $('.catalog-block');

        $("#nameCatalog-checker").click(function (e) {

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

            $.post(_checkNameCatalogAvailibility, {

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
            threshold: 40,
            placement: 'top',
            validate: true
        });
    };

    /**
     * It handles the multi select in edit view
     */
    var handlerBootstrapMultiSelectEdit = function() {

        $.fn.select2.defaults.set("theme", "bootstrap");

        $(".select2, .select2-multiple").select2({
            language: "es",
            width: null,
            allowClear: true
        });

        $("button[data-select2-open]").click(function() {
            $("#" + $(this).data("select2-open")).select2("open");
        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerCatalogCreateValidation();
            handlerNameAvailabilityChecker();
            handlerMaxlength();
            handlerBootstrapMultiSelectEdit();
        }
    };

}();

jQuery(document).ready(function() {
    DomainCatalogEditValidation.init();
});