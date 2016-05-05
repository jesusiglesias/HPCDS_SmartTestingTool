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
	 * Contact form.
	 */
	var handlerDisabledbuttonContact = function() {

		// Contact button activates when user enter data in all mandatory fields
		var contactForm = $(".contact-form");
		var contactButton =  $("#sendMail");
		var nameField = $("#name");
		var messageField = $("#message");

		contactButton.attr('disabled', 'disabled');

		contactForm.keyup(function () {
			// Disable login button
			contactButton.attr('disabled', 'disabled');

			// Validating fields
			var name = nameField.val().trim();
			var message = messageField.val().trim();

			if (!(name == "" || message == "")) {
				// Enable contact button
				contactButton.removeAttr('disabled');
			}
		});
	};

	/**
	 * Contact form validation
	 */
	var handlerContactFormValidation = function() {

		var contactForm = $(".contact-form");
		var contactButton =  $("#sendMail");
		var refreshIcon = $('.refreshIcon');
		var responseForm = $("#response");

		contactForm.validate({
			errorElement: 'span', // Default input error message container
			errorClass: 'help-block help-block-error', // Default input error message class
			focusInvalid: false, // Do not focus the last invalid input
			ignore: "",  // Validate all fields including form hidden input
			rules: {
				name: {
					required: true,
					maxlength: 65
				},
				email: {
					required: true,
					email: true,
					maxlength: 60
				},
				subject: {
					required: true
				},
				message: {
					required: true,
					maxlength: 1000
				}
			},

			messages: {
				name: {
					required: _requiredField,
					maxlength: _maxlengthField
				},
				email: {
					required: _requiredField,
					email: _emailField,
					maxlength: _maxlengthField
				},
				subject: {
					required: _requiredField
				},
				message: {
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

				// AJAX call
				$.ajax({
					url: _contactFormUrl,
					data: contactForm.serialize(),
					method: "POST",
					beforeSend: function(){
						contactButton.attr('disabled', true);
						contactButton.find('span').text(_sendingEmail);
						refreshIcon.removeClass('refresh-icon-stop');
						refreshIcon.addClass('refresh-icon');
					},
					success: function(data) {

						// Email sent successfully
						if (data.status == "successContact") {
							$(form).slideUp("slow");

							responseForm.addClass("contact-responseForm-success");
							responseForm.html(data.message).hide().slideDown("slow");

						// Email has not been sent
						} else if (data.status == "errorContact") {
							$(form).slideUp("slow");

							responseForm.addClass("contact-responseForm-error");
							responseForm.html(data.message).hide().slideDown("slow");
						}
					},
					error: function(){
						$(form).slideUp("slow");

						responseForm.addClass("contact-responseForm-error");
						responseForm.html(_responseError).hide().slideDown("slow");
					},
					complete: function(){
						setTimeout(function(){
							contactButton.removeAttr('disabled');
							contactButton.find('span').text(_sendEmail);
							refreshIcon.removeClass('refresh-icon');
							refreshIcon.addClass('refresh-icon-stop');
						}, 500);
					}
				});
			}
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
	 * Handler icons in input fields of contact form
	 */
	var handlerIconContact = function() {

		var nameContact = $('.name-contact');
		var iconNameContact = $('.i-delete-name-contact');
		var messageContact = $('.message-contact');
		var iconMessageContact = $('.i-delete-message-contact');

		/**
		 * Name
		 */
		// Show delete icon
		nameContact.keydown(function(){
			iconNameContact.show();
		});

		// Delete text and hide delete icon
		iconNameContact.click(function() {
			nameContact.val('').focus();
			iconNameContact.hide();
		});

		// Hide delete icon when user deletes text with the keyboard
		var toggleContactName = function() {
			if (nameContact.val() == '') {
				iconNameContact.hide();
			}
		};
		nameContact.on('keyup keydown keypress change paste', function() {
			toggleContactName(); // Still toggles the classes on any of the above events
		});
		toggleContactName(); // And also on document ready

		/**
		 * Message
		 */
		// Show delete icon
		messageContact.keydown(function(){
			iconMessageContact.show();
		});

		// Delete text and hide delete icon
		iconMessageContact.click(function() {
			messageContact.val('').focus();
			iconMessageContact.hide();
		});

		// Hide delete icon when user deletes text with the keyboard
		var toggleContactMessage = function() {
			if (messageContact.val() == '') {
				iconMessageContact.hide();
			}
		};

		messageContact.on('keyup keydown keypress change paste', function() {
			toggleContactMessage(); // Still toggles the classes on any of the above events
		});
		toggleContactMessage(); // And also on document ready
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
			handlerDisabledbuttonContact();
			handlerContactFormValidation();
			handlerMaxlengthForm();
			handlerIconContact();
			handlerBootstrapSelectForm();
		}
	};
}();

jQuery(document).ready(function() {    
   Contact.init(); 
});