/* {[The file is published on the basis of YetiForce Public License 3.0 that can be found in the following directory: licenses/LicenseEN.txt or yetiforce.com]} */
'use strict';

Settings_PDF_Edit_Js("Settings_PDF_Edit1_Js", {}, {
	init: function () {
		this.initialize();
	},
	/**
	 * Function to get the container which holds all the reports step1 elements
	 * @return jQuery object
	 */
	getContainer: function () {
		return this.step1Container;
	},
	/**
	 * Function to set the reports step1 container
	 * @params : element - which represents the reports step1 container
	 * @return : current instance
	 */
	setContainer: function (element) {
		this.step1Container = element;
		return this;
	},
	/**
	 * Function  to intialize the reports step1
	 */
	initialize: function (container) {
		if (typeof container === "undefined") {
			container = jQuery('#pdf_step1');
		}
		if (container.is('#pdf_step1')) {
			this.setContainer(container);
		} else {
			this.setContainer(jQuery('#pdf_step1'));
		}
	},
	submit: function () {
		var aDeferred = jQuery.Deferred();
		var form = this.getContainer();
		var formData = form.serializeFormData();
		formData['async'] = false;
		var progressIndicatorElement = jQuery.progressIndicator({
			'position': 'html',
			'blockInfo': {
				'enabled': true
			}
		});

		var saveData = form.serializeFormData();
		saveData['action'] = 'Save';
		saveData['step'] = 1;
		saveData['async'] = false;
		AppConnector.request(saveData).done(function (data) {
			data = JSON.parse(data);
			if (data.success == true) {
				Settings_Vtiger_Index_Js.showMessage({text: app.vtranslate('JS_PDF_SAVED_SUCCESSFULLY')});
				var pdfRecordElement = jQuery('[name="record"]', form);
				if (pdfRecordElement.val() === '') {
					pdfRecordElement.val(data.result.id);
					formData['record'] = data.result.id;
				}

				formData['record'] = data.result.id;
				AppConnector.request(formData).done(function (data) {
					form.hide();
					progressIndicatorElement.progressIndicator({
						'mode': 'hide'
					})
					aDeferred.resolve(data);
				}).fail(function (error, err) {
					app.errorLog(error, err);
				});
			}
		}).fail(function (error, err) {
			app.errorLog(error, err);
		});

		return aDeferred.promise();
	},
	registerCancelStepClickEvent: function (form) {
		jQuery('button.cancelLink', form).on('click', function () {
			window.history.back();
		});
	},
	registerMarginCheckboxClickEvent: function (container) {
		container.find('#margin_chkbox').on('change', function () {
			var status = jQuery(this).is(':checked');

			if (status) {
				container.find('.margin_inputs').addClass('d-none');
			} else {
				container.find('.margin_inputs').removeClass('d-none');
			}
		});
	},

	registerEvents: function () {
		var container = this.getContainer();
		//After loading 1st step only, we will enable the Next button
		container.find('[type="submit"]').removeAttr('disabled');

		var opts = app.validationEngineOptions;
		// to prevent the page reload after the validation has completed
		opts['onValidationComplete'] = function (form, valid) {
			//returns the valid status
			return valid;
		};
		opts['promptPosition'] = "bottomRight";
		container.validationEngine(opts);
		this.registerCancelStepClickEvent(container);
		this.registerMarginCheckboxClickEvent(container);
	}
});
