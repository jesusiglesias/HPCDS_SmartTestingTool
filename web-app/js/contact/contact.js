/*-------------------------------------------------------------------------------------------*
 *                                         CONTACT PAGE                                      *
 *-------------------------------------------------------------------------------------------*/

var Contact = function () {

	/**
	 * Handler GMaps
	 */
	var handlerGMaps = function() {

		var map;

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
	};

	/**
	 * Handler tooltip
	 */
	var handlerTooltip = function() {

		// Global tooltips
		$('.tooltips').tooltip();

		// Portlet tooltips
		$('.c-content-iconlist-1 .li-site').tooltip({
			container: 'body',
			title: _webSite
		});

		$('.c-content-iconlist-1 .li-google').tooltip({
			container: 'body',
			title: "Google plus"
		});

		$('.c-content-iconlist-1 .li-youtube').tooltip({
			container: 'body',
			title: "Youtube"
		});

		$('.c-content-iconlist-1 .li-linkedin').tooltip({
			container: 'body',
			title: "Linkedin"
		});
	};

	return {
		// Main function to initiate the module
		init: function () {
			handlerGMaps();
			handlerTooltip();
		}
	};
}();

jQuery(document).ready(function() {    
   Contact.init(); 
});