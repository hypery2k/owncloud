OC.Contacts = OC.Contacts || {};

(function(window, $, OC) {
	'use strict';

	var JSONResponse = function(response, jqXHR) {
		this.getAllResponseHeaders = jqXHR.getAllResponseHeaders;
		this.getResponseHeader = jqXHR.getResponseHeader;
		this.statusCode = jqXHR.status;
		this.error = false;
		// 204 == No content
		// 304 == Not modified
		if(!response) {
			if([204, 304].indexOf(this.statusCode) === -1) {
				console.log('jqXHR', jqXHR);
				this.error = true;
				this.message = jqXHR.statusText;
			}
		} else {
			// We need to allow for both the 'old' success/error status property
			// with the body in the data property, and the newer where we rely
			// on the status code, and the entire body is used.
			if(response.status === 'error'|| this.statusCode >= 400) {
				this.error = true;
				if(this.statusCode < 500) {
					this.message = (response.data && response.data.message)
						? response.data.message
						: response;
				} else {
					this.message = t('contacts', 'Server error! Please inform system administator');
				}
			} else {
				this.data = response;
			}
		}
	};

	/**
	* An object for saving contact data to backends
	*
	* All methods returns a jQuery.Deferred object which resolves
	* to either the requested response or an error object:
	* {
	*	error: true,
	*	message: The error message
	* }
	*
	* @param string user The user to query for. Defaults to current user
	*/
	var Storage = function(user) {
		this.user = user ? user : OC.currentUser;
	};

	/**
	 * Test if localStorage is working
	 *
	 * @return bool
	 */
	Storage.prototype.hasLocalStorage = function(jqXHR) {
		if (Modernizr) {
			if (!Modernizr.localStorage) {
				return false;
			}
		}
		// Some browsers report support but doesn't have it
		// e.g. Safari in private browsing mode.
		try {
			OC.localStorage.setItem('Hello', 'World');
			OC.localStorage.removeItem('Hello');
		} catch (e) {
			return false;
		}
		return true;
	};

	/**
	 * When the response isn't returned from requestRoute(), you can
	 * wrap it in a JSONResponse so that it's parsable by other objects.
	 *
	 * @param object response The body of the response
	 * @param XMLHTTPRequest http://api.jquery.com/jQuery.ajax/#jqXHR
	 */
	Storage.prototype.formatResponse = function(response, jqXHR) {
		return new JSONResponse(response, jqXHR);
	};

	/**
	 * Get all address books registered for this user.
	 *
	 * @return An array containing object of address book metadata e.g.:
	 * {
	 * 	backend:'local',
	 * 	id:'1234'
	 * 	permissions:31,
	 * 	displayname:'Contacts'
	 * }
	 */
	Storage.prototype.getAddressBooksForUser = function() {
		return this.requestRoute(
			'contacts_address_books_for_user',
			'GET',
			{}
		);
	};

	/**
	 * Add an address book to a specific backend
	 *
	 * @param string backend - currently defaults to 'local'
	 * @param object params An object {displayname:"My contacts", description:""}
	 * @return An array containing contact data e.g.:
	 * {
	 * 	metadata:
	 * 		{
	 * 		id:'1234'
	 * 		permissions:31,
	 * 		displayname:'My contacts',
	 * 		lastmodified: (unix timestamp),
	 * 		owner: 'joye',
	 * }
	 */
	Storage.prototype.addAddressBook = function(backend, parameters) {
		console.log('Storage.addAddressBook', backend);
		return this.requestRoute(
			'contacts_address_book_add',
			'POST',
			{backend: 'local'},
			JSON.stringify(parameters)
		);
	};

	/**
	 * Update an address book in a specific backend
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param object params An object {displayname:"My contacts", description:""}
	 * @return An array containing contact data e.g.:
	 * {
	 * 	metadata:
	 * 		{
	 * 		id:'1234'
	 * 		permissions:31,
	 * 		displayname:'My contacts',
	 * 		lastmodified: (unix timestamp),
	 * 		owner: 'joye',
	 * }
	 */
	Storage.prototype.updateAddressBook = function(backend, addressBookId, properties) {
		console.log('Storage.updateAddressBook', backend);
		return this.requestRoute(
			'contacts_address_book_update',
			'POST',
			{backend: backend, addressBookId: addressBookId},
			JSON.stringify(properties)
		);
	};

	/**
	 * Delete an address book from a specific backend
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 */
	Storage.prototype.deleteAddressBook = function(backend, addressBookId) {
		console.log('Storage.deleteAddressBook', backend, addressBookId);
		return this.requestRoute(
			'contacts_address_book_delete',
			'DELETE',
			{backend: backend, addressBookId: addressBookId}
		);
	};

	/**
	 * (De)active an address book from a specific backend
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param bool state
	 */
	Storage.prototype.activateAddressBook = function(backend, addressBookId, state) {
		console.log('Storage.activateAddressBook', backend, addressBookId, state);
		return this.requestRoute(
			'contacts_address_book_activate',
			'POST',
			{backend: backend, addressBookId: addressBookId},
			JSON.stringify({state: state})
		);
	};

	/**
	 * Get contacts from an address book from a specific backend
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @return
	 * An array containing contact data e.g.:
	 * {
	 * 	metadata:
	 * 		{
	 * 		id:'1234'
	 * 		permissions:31,
	 * 		displayname:'John Q. Public',
	 * 		lastmodified: (unix timestamp),
	 * 		owner: 'joye',
	 * 		parent: (id of the parent address book)
	 * 	data: //array of VCard data
	 * }
	 */
	Storage.prototype.getAddressBook = function(backend, addressBookId) {
		var self = this,
			headers = {},
			data,
			key = 'contacts::' + backend + '::' + addressBookId,
			defer = $.Deferred();

		if(this.hasLocalStorage() && OC.localStorage.hasItem(key)) {
			data = OC.localStorage.getItem(key);
			headers['If-None-Match'] = data.Etag;
		}
		$.when(this.requestRoute(
			'contacts_address_book',
			'GET',
			{backend: backend, addressBookId: addressBookId},
			'',
			headers
		))
		.then(function(response) {
			console.log('response', response);
			if(response.statusCode === 200) {
				console.log('Returning fetched address book');
				if(response.data) {
					response.data.Etag = response.getResponseHeader('Etag');
					if (!self.hasLocalStorage()) {
						OC.localStorage.setItem(key, response.data);
					}
					defer.resolve(response);
				}
			} else if(response.statusCode === 304) {
				console.log('Returning stored address book');
				response.data = data;
				defer.resolve(response);
			}
		})
		.fail(function(response) {
			console.warn('Request Failed:', response.message);
			defer.reject();
		});
		return defer;
	};

	/**
	 * Add a contact to an address book from a specific backend
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @return An array containing contact data e.g.:
	 * {
	 * 	metadata:
	 * 		{
	 * 		id:'1234'
	 * 		permissions:31,
	 * 		displayname:'John Q. Public',
	 * 		lastmodified: (unix timestamp),
	 * 		owner: 'joye',
	 * 		parent: (id of the parent address book)
	 * 	data: //array of VCard data
	 * }
	 */
	Storage.prototype.addContact = function(backend, addressBookId) {
		console.log('Storage.addContact', backend, addressBookId);
		return this.requestRoute(
			'contacts_address_book_add_contact',
			'POST',
			{backend: backend, addressBookId: addressBookId}
		);
	};

	/**
	 * Delete a contact from an address book from a specific backend
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param string contactId Address book ID
	 */
	Storage.prototype.deleteContact = function(backend, addressBookId, contactId) {
		console.log('Storage.deleteContact', backend, addressBookId, contactId);
		return this.requestRoute(
			'contacts_address_book_delete_contact',
			'DELETE',
			{backend: backend, addressBookId: addressBookId, contactId: contactId}
		);
	}

	/**
	 * Delete a list of contacts from an address book from a specific backend
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param array contactIds Address book ID
	 */
	Storage.prototype.deleteContacts = function(backend, addressBookId, contactIds) {
		console.log('Storage.deleteContacts', backend, addressBookId, contactIds);
		return this.requestRoute(
			'contacts_address_book_delete_contacts',
			'POST',
			{backend: backend, addressBookId: addressBookId},
			JSON.stringify({contacts: contactIds})
		);
	};

	/**
	 * Move a contact to an address book from a specific backend
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param string contactId Address book ID
	 */
	Storage.prototype.moveContact = function(backend, addressBookId, contactId, target) {
		console.log('Storage.moveContact', backend, addressBookId, contactId, target);
		return this.requestRoute(
			'contacts_address_book_move_contact',
			'POST',
			{backend: backend, addressBookId: addressBookId, contactId: contactId},
			JSON.stringify(target)
		);
	};

	/**
	 * Get Image instance for a contacts profile picture
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param string contactId Address book ID
	 * @return Image
	 */
	Storage.prototype.getContactPhoto = function(backend, addressBookId, contactId) {
		var photo = new Image();
		var url = OC.Router.generate(
			'contacts_contact_photo',
			{backend: backend, addressBookId: addressBookId, contactId: contactId}
		);
		var defer = $.Deferred();
		var self = this;
		$.when(
			$(photo).on('load', function() {
				defer.resolve(photo);
			})
			.error(function() {
				console.log('Error loading contact photo')
				defer.reject();
			})
			.attr('src', url + '?refresh=' + Math.random())
		)
		.fail(function(jqxhr, textStatus, error) {
			defer.reject();
			var err = textStatus + ', ' + error;
			console.log( "Request Failed: " + err);
			$(document).trigger('status.contact.error', {
				message: t('contacts', 'Failed loading photo: {error}', {error:err})
			});
		});
		return defer.promise();
	};

	/**
	 * Get Image instance for a contacts profile picture
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param string contactId Address book ID
	 * @param string key The key to the cache where the photo is stored.
	 * @return Image
	 */
	Storage.prototype.getTempContactPhoto = function(backend, addressBookId, contactId, key) {
		var photo = new Image();
		var url = OC.Router.generate(
			'contacts_tmp_contact_photo',
			{backend: backend, addressBookId: addressBookId, contactId: contactId, key: key, refresh: Math.random()}
		);
		console.log('url', url);
		var defer = $.Deferred();
		var self = this;
		$.when(
			$(photo).on('load', function() {
				defer.resolve(photo);
			})
			.error(function(event) {
				console.log('Error loading temporary photo', event)
				defer.reject();
			})
			.attr('src', url)
		)
		.fail(function(jqxhr, textStatus, error) {
			defer.reject();
			var err = textStatus + ', ' + error;
			console.log( "Request Failed: " + err);
			$(document).trigger('status.contact.error', {
				message: t('contacts', 'Failed loading photo: {error}', {error:err})
			});
		});
		return defer.promise();
	};

	/**
	 * Get Image instance for default profile picture
	 *
	 * This method loads the default picture only once and caches it.
	 *
	 * @return Image
	 */
	Storage.prototype.getDefaultPhoto = function() {
		console.log('Storage.getDefaultPhoto');
		if(!this.defaultPhoto) {
			var defer = $.Deferred();
			var url = OC.imagePath('contacts', 'person_large.png');
			this.defaultPhoto = new Image();
			var self = this;
			$(this.defaultPhoto)
				.load(function() {
					defer.resolve(this);
				}).error(function(event) {
					defer.reject();
				}).attr('src', url)
			return defer.promise();
		} else {
			return this.defaultPhoto;
		}
	};

	/**
	 * Update a contact.
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param string contactId Contact ID
	 * @param object params An object with the following properties:
	 * @param string name The name of the property e.g. EMAIL.
	 * @param string|array|null value The of the property
	 * @param array parameters Optional parameters for the property
	 * @param string checksum For non-singular properties such as email this must contain
	 * 	an 8 character md5 checksum of the serialized \Sabre\Property
	 */
	Storage.prototype.patchContact = function(backend, addressBookId, contactId, params) {
		return this.requestRoute(
			'contacts_contact_patch',
			'PATCH',
			{backend: backend, addressBookId: addressBookId, contactId: contactId},
			JSON.stringify(params)
		);
	};

	/**
	 * Save all properties. Used when merging contacts.
	 *
	 * @param string backend
	 * @param string addressBookId Address book ID
	 * @param string contactId Contact ID
	 * @param object params An object with the all properties:
	 */
	Storage.prototype.saveAllProperties = function(backend, addressBookId, contactId, params) {
		console.log('Storage.saveAllProperties', params);
		return this.requestRoute(
			'contacts_contact_save_all',
			'POST',
			{backend: backend, addressBookId: addressBookId, contactId: contactId},
			JSON.stringify(params)
		);
	};

	/**
	 * Get all groups for this user.
	 *
	 * @return An array containing the groups, the favorites, any shared
	 * address books, the last selected group and the sort order of the groups.
	 * {
	 * 	'categories': [{'id':1',Family'}, {...}],
	 * 	'favorites': [123,456],
	 * 	'shared': [],
	 * 	'lastgroup':'1',
	 * 	'sortorder':'3,2,4'
	 * }
	 */
	Storage.prototype.getGroupsForUser = function() {
		console.log('getGroupsForUser');
		return this.requestRoute(
			'contacts_categories_list',
			'GET',
			{}
		);
	};

	/**
	 * Add a group
	 *
	 * @param string name
	 * @return A JSON object containing the (maybe sanitized) group name and its ID:
	 * {
	 * 	'id':1234,
	 * 	'name':'My group'
	 * }
	 */
	Storage.prototype.addGroup = function(name) {
		console.log('Storage.addGroup', name);
		return this.requestRoute(
			'contacts_categories_add',
			'POST',
			{},
			JSON.stringify({name: name})
		);
	};

	/**
	 * Delete a group
	 *
	 * @param string name
	 */
	Storage.prototype.deleteGroup = function(name) {
		return this.requestRoute(
			'contacts_categories_delete',
			'POST',
			{},
			JSON.stringify({name: name})
		);
	};

	/**
	 * Rename a group
	 *
	 * @param string from
	 * @param string to
	 */
	Storage.prototype.renameGroup = function(from, to) {
		return this.requestRoute(
			'contacts_categories_rename',
			'POST',
			{},
			JSON.stringify({from: from, to: to})
		);
	};

	/**
	 * Add contacts to a group
	 *
	 * @param array contactIds
	 */
	Storage.prototype.addToGroup = function(contactIds, categoryId, categoryName) {
		console.log('Storage.addToGroup', contactIds, categoryId);
		return this.requestRoute(
			'contacts_categories_addto',
			'POST',
			{categoryId: categoryId},
			JSON.stringify({contactIds: contactIds, name: categoryName})
		);
	};

	/**
	 * Remove contacts from a group
	 *
	 * @param array contactIds
	 */
	Storage.prototype.removeFromGroup = function(contactIds, categoryId, categoryName) {
		console.log('Storage.removeFromGroup', contactIds, categoryId);
		return this.requestRoute(
			'contacts_categories_removefrom',
			'POST',
			{categoryId: categoryId},
			JSON.stringify({contactIds: contactIds, name: categoryName})
		);
	};

	/**
	 * Set a user preference
	 *
	 * @param string key
	 * @param string value
	 */
	Storage.prototype.setPreference = function(key, value) {
		return this.requestRoute(
			'contacts_setpreference',
			'POST',
			{},
			JSON.stringify({key: key, value:value})
		);
	};

	Storage.prototype.prepareImport = function(backend, addressBookId, params) {
		console.log('Storage.prepareImport', backend, addressBookId);
		return this.requestRoute(
			'contacts_import_prepare',
			'POST',
			{backend: backend, addressBookId: addressBookId},
			JSON.stringify(params)
		);
	};

	Storage.prototype.startImport = function(backend, addressBookId, params) {
		console.log('Storage.startImport', backend, addressBookId);
		return this.requestRoute(
			'contacts_import_start',
			'POST',
			{backend: backend, addressBookId: addressBookId},
			JSON.stringify(params)
		);
	};

	Storage.prototype.importStatus = function(backend, addressBookId, params) {
		return this.requestRoute(
			'contacts_import_status',
			'GET',
			{backend: backend, addressBookId: addressBookId},
			params
		);
	};

	Storage.prototype.requestRoute = function(route, type, routeParams, params, additionalHeaders) {
		var isJSON = (typeof params === 'string');
		var contentType = isJSON
			? (type === 'PATCH' ? 'application/json-merge-patch' : 'application/json')
			: 'application/x-www-form-urlencoded';
		var processData = !isJSON;
		contentType += '; charset=UTF-8';
		var self = this;
		var url = OC.Router.generate(route, routeParams);
		var headers = {
			Accept : 'application/json; charset=utf-8',
		};
		if(typeof additionalHeaders === 'object') {
			headers = $.extend(headers, additionalHeaders);
		}
		var ajaxParams = {
			type: type,
			url: url,
			dataType: 'json',
			headers: headers,
			contentType: contentType,
			processData: processData,
			data: params
		};

		var defer = $.Deferred();

		var jqxhr = $.ajax(ajaxParams)
			.done(function(response, textStatus, jqXHR) {
				defer.resolve(new JSONResponse(response, jqXHR));
			})
			.fail(function(jqXHR, textStatus, error) {
				console.log(jqXHR);
				var response = jqXHR.responseText ? $.parseJSON(jqXHR.responseText) : null;
				console.log('response', response);
				defer.reject(new JSONResponse(response, jqXHR));
			});

		return defer.promise();
	};

	OC.Contacts.Storage = Storage;

})(window, jQuery, OC);
