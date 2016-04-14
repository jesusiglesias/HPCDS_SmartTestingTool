/*-------------------------------------------------------------------------------------------*
 *                                JAVASCRIPT - ICONS TEST                                    *
 *-------------------------------------------------------------------------------------------*/

var iconTestHandler = function () {

    /**
     * Handler icons in input fields of test
     */
    var handlerIconTest = function() {

        var testName = $('.name-test');
        var iconTestName = $('.i-delete-test-name');
        var testDescription = $('.description-test');
        var iconTestDescription = $('.i-delete-test-description');
        var testNumberOfQuestions = $('.numberOfQuestions-test');
        var iconTestNumberOfQuestions = $('.i-delete-test-numberQuestions');
        var testLockTime = $('.lockTime-test');
        var iconTestLockTime = $('.i-delete-test-lockTime');

        /**
         * Name
         */
        // Show delete icon
        testName.keydown(function(){
            iconTestName.show();
        });

        // Delete text and hide delete icon
        iconTestName.click(function() {
            testName.val('').focus();
            iconTestName.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesName = function() {
            if (testName.val() == '') {
                iconTestName.hide();
            }
        };
        testName.on('keyup keydown keypress change paste', function() {
            toggleClassesName(); // Still toggles the classes on any of the above events
        });
        toggleClassesName(); // And also on document ready

        /**
         * Description
         */
        // Show delete icon
        testDescription.keydown(function(){
            iconTestDescription.show();
        });

        // Delete text and hide delete icon
        iconTestDescription.click(function() {
            testDescription.val('').focus();
            iconTestDescription.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesDescription = function() {
            if (testDescription.val() == '') {
                iconTestDescription.hide();
            }
        };

        testDescription.on('keyup keydown keypress change paste', function() {
            toggleClassesDescription(); // Still toggles the classes on any of the above events
        });
        toggleClassesDescription(); // And also on document ready

        /**
         * Number of questions
         */
        // Show delete icon
        testNumberOfQuestions.keydown(function(){
            iconTestNumberOfQuestions.show();
        });

        // Delete text and hide delete icon
        iconTestNumberOfQuestions.click(function() {
            testNumberOfQuestions.val('').focus();
            iconTestNumberOfQuestions.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesNumberOfQuestions = function() {
            if (testNumberOfQuestions.val() == '') {
                iconTestNumberOfQuestions.hide();
            }
        };

        testNumberOfQuestions.on('keyup keydown keypress change paste', function() {
            toggleClassesNumberOfQuestions(); // Still toggles the classes on any of the above events
        });
        toggleClassesNumberOfQuestions(); // And also on document ready

        /**
         * Lock time
         */
        // Show delete icon
        testLockTime.keydown(function(){
            iconTestLockTime.show();
        });

        // Delete text and hide delete icon
        iconTestLockTime.click(function() {
            testLockTime.val('').focus();
            iconTestLockTime.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesLockTime = function() {
            if (testLockTime.val() == '') {
                iconTestLockTime.hide();
            }
        };

        testLockTime.on('keyup keydown keypress change paste', function() {
            toggleClassesLockTime(); // Still toggles the classes on any of the above events
        });
        toggleClassesLockTime(); // And also on document ready
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerIconTest();
        }
    };
}();

jQuery(document).ready(function() {
    iconTestHandler.init();
});
