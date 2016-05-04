/*-------------------------------------------------------------------------------------------*
 *                               CUSTOM JAVASCRIPT - COOKIE POLICY                           *
 *-------------------------------------------------------------------------------------------*/

/**
 * It obtains the cookie that warns to the user about cookie policy.
 *
 * @param name Cookie's name.
 */
function GetCookie(name) {
    
    var arg=name+"=";
    var alen=arg.length;
    var clen=document.cookie.length;
    var i=0;
    
    while (i<clen) {
        var j=i+alen;

        if (document.cookie.substring(i,j)==arg) {
            return "1";
        }
        i=document.cookie.indexOf(" ",i)+1;
        if (i==0) {
            break;
        }
    }
    return null;
}

function closeCookies() {

    var contentCookie = $('#cookie-container');

    var visit=GetCookie("STT_cookie_policy");

    if (visit==1){
        contentCookie.slideToggle( "slow");
    }
}

jQuery(function() {

    var contentCookie = $('#cookie-container');

    // Get cookie
    var visit=GetCookie("STT_cookie_policy");

    if ( visit != 1 ){

        contentCookie.show();

	    var expire=new Date();
	    expire=new Date(expire.getTime()+7776000000);
	    document.cookie="STT_cookie_policy=accepted; expires="+expire;
    }
});