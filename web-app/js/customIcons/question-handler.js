/*-------------------------------------------------------------------------------------------*
 *                                JAVASCRIPT - ICONS QUESTION                                *
 *-------------------------------------------------------------------------------------------*/

var iconQuestionHandler = function () {

    /**
     * Handler icons in input fields of question
     */
    var handlerIconQuestion = function() {

        var questionKey = $('.key-question');
        var iconQuestionKey = $('.i-delete-question-key');
        var questionDescription = $('.description-question');
        var iconQuestionDescription = $('.i-delete-question-description');

        /**
         * Key
         */
        // Show delete icon
        questionKey.keydown(function(){
            iconQuestionKey.show();
        });

        // Delete text and hide delete icon
        iconQuestionKey.click(function() {
            questionKey.val('').focus();
            iconQuestionKey.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesKey = function() {
            if (questionKey.val() == '') {
                iconQuestionKey.hide();
            }
        };
        questionKey.on('keyup keydown keypress change paste', function() {
            toggleClassesKey(); // Still toggles the classes on any of the above events
        });
        toggleClassesKey(); // And also on document ready

        /**
         * Description
         */
        // Show delete icon
        questionDescription.keydown(function(){
            iconQuestionDescription.show();
        });

        // Delete text and hide delete icon
        iconQuestionDescription.click(function() {
            questionDescription.val('').focus();
            iconQuestionDescription.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesDescription = function() {
            if (questionDescription.val() == '') {
                iconQuestionDescription.hide();
            }
        };

        questionDescription.on('keyup keydown keypress change paste', function() {
            toggleClassesDescription(); // Still toggles the classes on any of the above events
        });
        toggleClassesDescription(); // And also on document ready
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerIconQuestion();
        }
    };
}();

jQuery(document).ready(function() {
    iconQuestionHandler.init();
});
