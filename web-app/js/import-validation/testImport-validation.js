/*-------------------------------------------------------------------------------------------*
 *                                TEST IMPORT VALIDATION JAVASCRIPT                          *
 *-------------------------------------------------------------------------------------------*/

var TestImportValidation = function () {

    /**
     * Test import validation
     */
    var handlerTestImportValidation = function() {

        var testImportForm = $('.test-import-form');
        var testImportButton = $('#test-import-button');
        var refreshIcon = $('.refreshIcon');

        testImportForm.validate({
                errorElement: 'span', // Default input error message container
                errorClass: 'help-block help-block-error', // Default input error message class
                focusInvalid: false, // Do not focus the last invalid input
                ignore: "",  // Validate all fields including form hidden input
                rules: {
                    importFileAdmin: {
                        required: true
                    }
                },

                messages: {
                    avatar: {
                        required: _requiredField
                    }
                },

                // Render error placement for each input type
                errorPlacement: function (error, element) {
                },

                // Set error class to the control group
                highlight: function (element) {
                    $(element)
                        .closest('.input-group').removeClass("has-success").addClass('has-error');
                },

                // Set success class to the control group
                success: function (label, element) {
                    $(element).closest('.input-group').removeClass('has-error').addClass('has-success');
                },

                submitHandler: function (form) {
                    testImportButton.attr('disabled', true);
                    testImportButton.find('span').text(_importingData);
                    refreshIcon.removeClass('refresh-icon-stop');
                    refreshIcon.addClass('refresh-icon');

                    form.submit(); // Submit the form
                }
            });
    };

    /**
     * Handler tooltip
     */
    var handlerTooltip = function() {

        // Global tooltips
        $('.tooltips').tooltip();

        // Portlet tooltips
        $('.portlet > .portlet-title .fullscreen').tooltip({
            container: 'body',
            title: _fullscreenTooltip
        });

        $('.portlet > .portlet-title > .tools > .remove').tooltip({
            container: 'body',
            title: _removeTooltip
        });
        $('.portlet > .portlet-title > .tools > .collapse, .portlet > .portlet-title > .tools > .expand').tooltip({
            container: 'body',
            title: _collapseTooltip
        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerTestImportValidation();
            handlerTooltip();
        }
    };

}();

jQuery(document).ready(function() {
    TestImportValidation.init();
});