/*-------------------------------------------------------------------------------------------*
 *                                         CONTACT PAGE                                      *
 *-------------------------------------------------------------------------------------------*/

var Contact = function () {

    return {
        // Main function to initiate the module
        init: function () {

			var map;

			$(document).ready(function(){

				// New Google map
				map = new GMaps({
					div: '#gmapbg',
					lat: 40.522794,
					lng: -3.888638
				});

				map.addMarker({
					lat: 40.522794,
					lng: -3.888638,
					title: 'Hewlett Packard CDS',
					infoWindow: {
						content: "<b>Hewlett Packard CDS</b> <br> " + _address + " <br> Las Rozas 28232 Madrid, " + _country
					}
				});
				(map.markers[0].infoWindow).open(map.map,map.markers[0]);
			});
        }
    };
}();

jQuery(document).ready(function() {    
   Contact.init(); 
});