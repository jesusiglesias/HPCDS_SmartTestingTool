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
			div: '#gmapSTT',
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
		$('.iconlist .li-site').tooltip({
			container: 'body',
			title: _webSite
		});

		$('.iconlist .li-google').tooltip({
			container: 'body',
			title: "Google plus"
		});

		$('.iconlist .li-youtube').tooltip({
			container: 'body',
			title: "Youtube"
		});

		$('.iconlist .li-linkedin').tooltip({
			container: 'body',
			title: "Linkedin"
		});
	};

	/**
	 * It handles the max length of the fields
	 */
	var handlerMaxlengthForm = function() {

		/* Name field */
		$('#name').maxlength({
			limitReachedClass: "label label-danger",
			threshold: 20,
			placement: 'top',
			validate: true
		});

		/* Email field */
		$('#email').maxlength({
			limitReachedClass: "label label-danger",
			threshold: 20,
			placement: 'top',
			validate: true
		});

		/* Message field */
		$('#message').maxlength({
			limitReachedClass: "label label-danger",
			alwaysShow: true,
			placement: 'top-right-inside',
			validate: true
		});
	};

	/**
	 * It handles the select
	 */
	var handlerBootstrapSelectForm = function () {

		$('.bs-select').selectpicker({
			iconBase: 'fa',
			tickIcon: 'fa-check'
		});
	};

	return {
		// Main function to initiate the module
		init: function () {
			handlerGMaps();
			handlerTooltip();
			handlerMaxlengthForm();
			handlerBootstrapSelectForm();
		}
	};
}();

jQuery(document).ready(function() {    
   Contact.init(); 
});