/*-------------------------------------------------------------------------------------------*
 *                               TIMER - DOWN COUNTER JAVASCRIPT                              *
 *-------------------------------------------------------------------------------------------*/

var timerDownCounter = function () {

    /**
     * Timer about remaining time (down counter)
     */
    var handlerDownCounter = function() {

        var testTimer;
        var formQuestion = $('.form-question');

        // It transforms to seconds
        testTimer = $('.timer').FlipClock(_maximumTime*60, {
            language: _language,
            countdown: true,
            callbacks: {
                stop: function() {
                    setTimeout(function() {

                        // Submit the form
                        formQuestion.submit()

                    }, 1000);
                }
            }
        });
    };

    /**
     * Scroller top
     */
    var handlerScrollerTop = function() {

        // Toggle tranparent navbar when the user scrolls the page
        $(window).scroll(function() {

            if ($(this).scrollTop() > 43) { // Height in pixels
                $('.remaining-time').addClass('top-remaining-time');
            } else {
                $('.remaining-time').removeClass('top-remaining-time');
            }
        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerDownCounter();
            handlerScrollerTop()
        }
    };

}();

jQuery(document).ready(function() {
    timerDownCounter.init();
});