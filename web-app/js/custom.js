/*-------------------------------------------------------------------------------------------*
 *                            CUSTOM JAVASCRIPT - GENERAL ELEMENTS                           *
 *-------------------------------------------------------------------------------------------*/

/* SCROLL
 =================================================================== */
// Scroll Top to bottom and Back to Top
$(document).ready(function() {
    /* BACK TO TOP BUTTON
     =================================================================== */
    // Browser window scroll (in pixels) after which the "back to top" link is shown
    var offset = 300;
    // Browser window scroll (in pixels) after which the "back to top" link opacity is reduced
    var offset_opacity = 400;
    // Duration of the top scrolling animation (in ms)
    var scroll_top_duration = 700;

    // Grab the "back to top" link
     var back_to_top = $('.back-to-top');

    // Hide or show the "back to top" link
    $(window).scroll(function(){
        ( $(this).scrollTop() > offset ) ? back_to_top.addClass('cd-is-visible cd-fade-out') : back_to_top.removeClass('cd-is-visible');
        if( $(this).scrollTop() > offset_opacity ) {
            back_to_top.removeClass('cd-fade-out');
        }
    });

    // Smooth scroll to top
    back_to_top.on('click', function(event){
        event.preventDefault();
        $('body,html').animate({
                scrollTop: 0
            }, scroll_top_duration
        );
    });
});
