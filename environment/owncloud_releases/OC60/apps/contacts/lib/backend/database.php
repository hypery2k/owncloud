<?php
/**
 * ownCloud - Database backend for Contacts
 *
 * @author Thomas Tanghus
 * @copyright 2013 Thomas Tanghus (thomas@tanghus.net)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU AFFERO GENERAL PUBLIC LICENSE for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

namespace OCA\Contacts\Backend;

use OCA\Contacts\Contact,
	OCA\Contacts\VObject\VCard,
	OCA\Contacts\Utils\Properties,
	Sabre\VObject\Reader;

/**
 * Subclass this class for Cantacts backends
 */

class Database extends AbstractBackend {

	public $name = 'local';
	static private $preparedQueries = array();

	/**
	* Sets up the backend
	*
	* @param string $addressBooksTableName
	* @param string $cardsTableName
	*/
	public function __construct(
		$userid = null,
		$options = array(
			'addressBooksTableName' => '*PREFIX*contacts_addressbooks',
			'cardsTableName' => '*PREFIX*contacts_cards',
			'indexTableName' => '*PREFIX*contacts_cards_properties'
		)
	) {
		$this->userid = $userid ? $userid : \OCP\User::getUser();
		$this->addressBooksTableName = $options['addressBooksTableName'];
		$this->cardsTableName = $options['cardsTableName'];
		$this->indexTableName = $options['indexTableName'];
		$this->addressbooks = array();
	}

	/**
	 * Returns the list of addressbooks for a specific user.
	 *
	 * @see AbstractBackend::getAddressBooksForUser
	 * @return array
	 */
	public function getAddressBooksForUser(array $options = array()) {

		try {
			if(!isset(self::$preparedQueries['addressbooksforuser'])) {
				$sql = 'SELECT `id`, `displayname`, `description`, `ctag` AS `lastmodified`, `userid` AS `owner`, `uri` FROM `'
					. $this->addressBooksTableName
					. '` WHERE `userid` = ? ORDER BY `displayname`';
				self::$preparedQueries['addressbooksforuser'] = \OCP\DB::prepare($sql);
			}
			$result = self::$preparedQueries['addressbooksforuser']->execute(array($this->userid));
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return $this->addressbooks;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.' exception: ' . $e->getMessage(), \OCP\Util::ERROR);
			return $this->addressbooks;
		}

		while($row = $result->fetchRow()) {
			$row['permissions'] = \OCP\PERMISSION_ALL;
			$this->addressbooks[$row['id']] = $row;
		}
		return $this->addressbooks;
	}

	public function getAddressBook($addressbookid, array $options = array()) {
		\OCP\Util::writeLog('contacts', __METHOD__.' id: ' . $addressbookid, \OCP\Util::DEBUG);
		$owner = isset($options['shared_by']) ? $options['shared_by'] : $this->userid;
		if($this->addressbooks && isset($this->addressbooks[$addressbookid])) {
			//print(__METHOD__ . ' ' . __LINE__ .' addressBookInfo: ' . print_r($this->addressbooks[$addressbookid], true));
			return $this->addressbooks[$addressbookid];
		}
		// Hmm, not found. Lets query the db.
		try {
			$query = 'SELECT `id`, `displayname`, `description`, `userid` AS `owner`, `ctag` AS `lastmodified`, `uri` FROM `'
				. $this->addressBooksTableName
				. '` WHERE `id` = ? AND `userid` = ?';
			if(!isset(self::$preparedQueries['getaddressbook'])) {
				self::$preparedQueries['getaddressbook'] = \OCP\DB::prepare($query);
			}
			$result = self::$preparedQueries['getaddressbook']->execute(array($addressbookid, $owner));
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: '
					. \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return null;
			}
			if((int)$result->numRows() === 0) {
				return null;
			}
			$row = $result->fetchRow();
			$row['permissions'] = \OCP\PERMISSION_ALL;
			$row['backend'] = $this->name;
			$this->addressbooks[$addressbookid] = $row;
			return $row;
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.' exception: '
				. $e->getMessage(), \OCP\Util::ERROR);
			return null;
		}
		return null;
	}

	public function hasAddressBook($addressbookid, array $options = array()) {
		// First check if it's already cached
		if($this->addressbooks && isset($this->addressbooks[$addressbookid])) {
			return true;
		}
		return count($this->getAddressBook($addressbookid)) > 0;
	}

	/**
	 * Updates an addressbook's properties
	 *
	 * @param string $addressbookid
	 * @param array $changes
	 * @return bool
	 */
	public function updateAddressBook($addressbookid, array $changes, array $options = array()) {
		if(count($changes) === 0) {
			return false;
		}

		$query = 'UPDATE `' . $this->addressBooksTableName . '` SET ';

		$updates = array();

		if(isset($changes['displayname'])) {
			$query .= '`displayname` = ?, ';
			$updates[] = $changes['displayname'];
			if($this->addressbooks && isset($this->addressbooks[$addressbookid])) {
				$this->addressbooks[$addressbookid]['displayname'] = $changes['displayname'];
			}
		}

		if(isset($changes['description'])) {
			$query .= '`description` = ?, ';
			$updates[] = $changes['description'];
			if($this->addressbooks && isset($this->addressbooks[$addressbookid])) {
				$this->addressbooks[$addressbookid]['description'] = $changes['description'];
			}
		}

		$query .= '`ctag` = ? + 1 WHERE `id` = ?';
		$updates[] = time();
		$updates[] = $addressbookid;

		try {
			$stmt = \OCP\DB::prepare($query);
			$result = $stmt->execute($updates);
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts',
					__METHOD__. 'DB error: '
					. \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return false;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts',
				__METHOD__ . ', exception: '
				. $e->getMessage(), \OCP\Util::ERROR);
			return false;
		}

		return true;
	}

	/**
	 * Creates a new address book
	 *
	 * Supported properties are 'displayname', 'description' and 'uri'.
	 * 'uri' is supported to allow to add from CardDAV requests, and MUST
	 * be used for the 'uri' database field if present.
	 * 'displayname' MUST be present.
	 *
	 * @param array $properties
	 * @param array $options - Optional (backend specific options)
	 * @return string|false The ID if the newly created AddressBook or false on error.
	 */
	public function createAddressBook(array $properties, array $options = array()) {

		if(count($properties) === 0 || !isset($properties['displayname'])) {
			return false;
		}

		$query = 'INSERT INTO `' . $this->addressBooksTableName . '` '
			. '(`userid`,`displayname`,`uri`,`description`,`ctag`) VALUES(?,?,?,?,?)';

		$updates = array($this->userid, $properties['displayname']);
		$updates[] = isset($properties['uri'])
			? $properties['uri']
			: $this->createAddressBookURI($properties['displayname']);
		$updates[] = isset($properties['description']) ? $properties['description'] : '';
		$ctag = time();
		$updates[] = $ctag;

		try {
			if(!isset(self::$preparedQueries['createaddressbook'])) {
				self::$preparedQueries['createaddressbook'] = \OCP\DB::prepare($query);
			}
			$result = self::$preparedQueries['createaddressbook']->execute($updates);
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return false;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__ . ', exception: ' . $e->getMessage(), \OCP\Util::ERROR);
			return false;
		}

		$newid = \OCP\DB::insertid($this->addressBooksTableName);
		if($this->addressbooks) {
			$updates['id'] = $newid;
			$updates['ctag'] = $ctag;
			$updates['lastmodified'] = $ctag;
			$updates['permissions'] = \OCP\PERMISSION_ALL;
			$this->addressbooks[$newid] = $updates;
		}
		return $newid;
	}

	/**
	 * Deletes an entire addressbook and all its contents
	 *
	 * NOTE: For efficience this method bypasses the cleanup hooks and deletes
	 * property indexes and category/group relations by itself.
	 *
	 * @param string $addressbookid
	 * @param array $options - Optional (backend specific options)
	 * @return bool
	 */
	public function deleteAddressBook($addressbookid, array $options = array()) {

		// Get all contact ids for this address book
		$ids = array();
		$result = null;
		$stmt = \OCP\DB::prepare('SELECT `id` FROM `' . $this->cardsTableName . '`'
					. ' WHERE `addressbookid` = ?');
		try {
			$result = $stmt->execute(array($addressbookid));
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: '
					. \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return false;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.
				', exception: ' . $e->getMessage(), \OCP\Util::ERROR);
			return false;
		}

		if(!is_null($result)) {
			while($id = $result->fetchOne()) {
				$ids[] = $id;
			}
		}

		\OCP\Util::emitHook('OCA\Contacts', 'pre_deleteAddressBook',
			array('addressbookid' => $addressbookid, 'contactids' => $ids)
		);

		// Delete contacts in address book.
		if(!isset(self::$preparedQueries['deleteaddressbookcontacts'])) {
			self::$preparedQueries['deleteaddressbookcontacts'] =
				\OCP\DB::prepare('DELETE FROM `' . $this->cardsTableName
					. '` WHERE `addressbookid` = ?');
		}
		try {
			self::$preparedQueries['deleteaddressbookcontacts']
				->execute(array($addressbookid));
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.
				', exception: ' . $e->getMessage(), \OCP\Util::ERROR);
			return false;
		}

		// Delete the address book.
		if(!isset(self::$preparedQueries['deleteaddressbook'])) {
			self::$preparedQueries['deleteaddressbook'] =
				\OCP\DB::prepare('DELETE FROM `'
					. $this->addressBooksTableName . '` WHERE `id` = ?');
		}
		try {
			self::$preparedQueries['deleteaddressbook']
				->execute(array($addressbookid));
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.
				', exception: ' . $e->getMessage(), \OCP\Util::ERROR);
			return false;
		}

		if($this->addressbooks && isset($this->addressbooks[$addressbookid])) {
			unset($this->addressbooks[$addressbookid]);
		}

		return true;
	}

	/**
	 * @brief Updates ctag for addressbook
	 * @param integer $id
	 * @return boolean
	 */
	public function setModifiedAddressBook($id) {
		$query = 'UPDATE `' . $this->addressBooksTableName
			. '` SET `ctag` = ? + 1 WHERE `id` = ?';
		if(!isset(self::$preparedQueries['touchaddressbook'])) {
			self::$preparedQueries['touchaddressbook'] = \OCP\DB::prepare($query);
		}
		$ctag = time();
		self::$preparedQueries['touchaddressbook']->execute(array($ctag, $id));

		return true;
	}

	public function lastModifiedAddressBook($addressbookid) {
		if($this->addressbooks && isset($this->addressbooks[$addressbookid])) {
			return $this->addressbooks[$addressbookid]['lastmodified'];
		}
		$addressBook = $this->getAddressBook($addressbookid);
		return $addressBook ? $addressBook['lastmodified'] : null;
	}

	/**
	 * Returns the number of contacts in a specific address book.
	 *
	 * @param string $addressbookid
	 * @param bool $omitdata Don't fetch the entire carddata or vcard.
	 * @return array
	 */
	public function numContacts($addressbookid) {
		$query = 'SELECT COUNT(*) AS `count` FROM `' . $this->cardsTableName . '` WHERE '
			. '`addressbookid` = ?';

		if(!isset(self::$preparedQueries['count'])) {
			self::$preparedQueries['count'] = \OCP\DB::prepare($query);
		}
		$result = self::$preparedQueries['count']->execute(array($addressbookid));
		if (\OCP\DB::isError($result)) {
			\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
			return null;
		}
		return (int)$result->fetchOne();
	}

	/**
	 * Returns all contacts for a specific addressbook id.
	 *
	 * @param string $addressbookid
	 * @param array $options - Optional (backend specific options)
	 * @param bool $omitdata Don't fetch the entire carddata or vcard.
	 * @return array
	 */
	public function getContacts($addressbookid, array $options = array() ) {
		//\OCP\Util::writeLog('contacts', __METHOD__.' addressbookid: ' . $addressbookid, \OCP\Util::DEBUG);
		$cards = array();
		try {
			$omitdata = isset($options['omitdata']) ? $options['omitdata'] : false;
			$qfields = $omitdata ? '`id`, `fullname` AS `displayname`' : '*';
			$query = 'SELECT ' . $qfields . ' FROM `' . $this->cardsTableName
				. '` WHERE `addressbookid` = ? ORDER BY `fullname`';
			$stmt = \OCP\DB::prepare(
				$query,
				isset($options['limit']) ? $options['limit'] : null,
				isset($options['offset']) ? $options['offset'] : null
			);
			$result = $stmt->execute(array($addressbookid));
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return $cards;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.', exception: '.$e->getMessage(), \OCP\Util::ERROR);
			return $cards;
		}

		if(!is_null($result)) {
			while($row = $result->fetchRow()) {
				$row['permissions'] = \OCP\PERMISSION_ALL;
				$cards[] = $row;
			}
		}

		return $cards;
	}

	/**
	 * Returns a specific contact.
	 *
	 * The $id for Database and Shared backends can be an array containing
	 * either 'id' or 'uri' to be able to play seamlessly with the
	 * CardDAV backend.
	 * FIXME: $addressbookid isn't used in the query, so there's no access control.
	 * 	OTOH the groups backend - OC_VCategories - doesn't no about parent collections
	 * 	only object IDs. Hmm.
	 * 	I could make a hack and add an optional, not documented 'nostrict' argument
	 * 	so it doesn't look for addressbookid.
	 *
	 * @param string $addressbookid
	 * @param mixed $id Contact ID
	 * @param array $options - Optional (backend specific options)
	 * @return array|null
	 */
	public function getContact($addressbookid, $id, array $options = array()) {
		//\OCP\Util::writeLog('contacts', __METHOD__.' identifier: ' . $addressbookid . ' ' . $id['uri'], \OCP\Util::DEBUG);

		$noCollection = isset($options['noCollection']) ? $options['noCollection'] : false;

		$where_query = '`id` = ?';
		if(is_array($id)) {
			$where_query = '';
			if(isset($id['id'])) {
				$id = $id['id'];
			} elseif(isset($id['uri'])) {
				$where_query = '`uri` = ?';
				$id = $id['uri'];
			} else {
				throw new \Exception(
					__METHOD__ . ' If second argument is an array, either \'id\' or \'uri\' has to be set.'
				);
				return null;
			}
		}
		$ids = array($id);

		if(!$noCollection) {
			$where_query .= ' AND `addressbookid` = ?';
			$ids[] = $addressbookid;
		}

		try {
			$query =  'SELECT `id`, `uri`, `carddata`, `lastmodified`, `addressbookid` AS `parent`, `fullname` AS `displayname` FROM `'
				. $this->cardsTableName . '` WHERE ' . $where_query;
			$stmt = \OCP\DB::prepare($query);
			$result = $stmt->execute($ids);
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return null;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.', exception: '.$e->getMessage(), \OCP\Util::ERROR);
			\OCP\Util::writeLog('contacts', __METHOD__.', id: '. $id, \OCP\Util::DEBUG);
			return null;
		}

		$row = $result->fetchRow();
		if(!$row) {
			\OCP\Util::writeLog('contacts', __METHOD__.', Not found, id: '. $id, \OCP\Util::DEBUG);
			return null;
		}
		$row['permissions'] = \OCP\PERMISSION_ALL;
		return $row;
	}

	public function hasContact($addressbookid, $id) {
		return $this->getContact($addressbookid, $id) !== false;
	}

	/**
	 * Creates a new contact
	 *
	 * In the Database and Shared backends contact be either a Contact object or a string
	 * with carddata to be able to play seamlessly with the CardDAV backend.
	 * If this method is called by the CardDAV backend, the carddata is already validated.
	 * NOTE: It's assumed that this method is called either from the CardDAV backend, the
	 * import script, or from the ownCloud web UI in which case either the uri parameter is
	 * set, or the contact has a UID. If neither is set, it will fail.
	 *
	 * @param string $addressbookid
	 * @param VCard|string $contact
	 * @param array $options - Optional (backend specific options)
	 * @return string|bool The identifier for the new contact or false on error.
	 */
	public function createContact($addressbookid, $contact, array $options = array()) {

		$qname = 'createcontact';
		$uri = isset($options['uri']) ? $options['uri'] : null;

		if(!$contact instanceof VCard) {
			try {
				$contact = Reader::read($contact);
			} catch(\Exception $e) {
				\OCP\Util::writeLog('contacts', __METHOD__.', exception: '.$e->getMessage(), \OCP\Util::ERROR);
				return false;
			}
		}

		try {
			$contact->validate(VCard::REPAIR|VCard::UPGRADE);
		} catch (\Exception $e) {
			OCP\Util::writeLog('contacts', __METHOD__ . ' ' .
				'Error validating vcard: ' . $e->getMessage(), \OCP\Util::ERROR);
			return false;
		}

		$uri = is_null($uri) ? $this->uniqueURI($addressbookid, $contact->UID . '.vcf') : $uri;
		$now = new \DateTime;
		$contact->REV = $now->format(\DateTime::W3C);

		$appinfo = \OCP\App::getAppInfo('contacts');
		$appversion = \OCP\App::getAppVersion('contacts');
		$prodid = '-//ownCloud//NONSGML '.$appinfo['name'].' '.$appversion.'//EN';
		$contact->PRODID = $prodid;

		$data = $contact->serialize();
		if(!isset(self::$preparedQueries[$qname])) {
		self::$preparedQueries[$qname] = \OCP\DB::prepare('INSERT INTO `'
			. $this->cardsTableName
			. '` (`addressbookid`,`fullname`,`carddata`,`uri`,`lastmodified`) VALUES(?,?,?,?,?)' );
		}
		try {
			$result = self::$preparedQueries[$qname]
				->execute(
					array(
						$addressbookid,
						(string)$contact->FN,
						$contact->serialize(),
						$uri,
						time()
					)
				);
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return false;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.', exception: '.$e->getMessage(), \OCP\Util::ERROR);
			return false;
		}
		$newid = \OCP\DB::insertid($this->cardsTableName);

		$this->setModifiedAddressBook($addressbookid);
		\OCP\Util::emitHook('OCA\Contacts', 'post_createContact',
			array('id' => $newid, 'parent' => $addressbookid, 'backend' => $this->name, 'contact' => $contact)
		);
		return (string)$newid;
	}

	/**
	 * Updates a contact
	 *
	 * @param string $addressbookid
	 * @param mixed $id Contact ID
	 * @param VCard|string $contact
	 * @param array $options - Optional (backend specific options)
	 * @see getContact
	 * @return bool
	 */
	public function updateContact($addressbookid, $id, $contact, array $options = array()) {
		$noCollection = isset($options['noCollection']) ? $options['noCollection'] : false;
		$isBatch = isset($options['isBatch']) ? $options['isBatch'] : false;
		$qname = 'updatecontact';

		$updateRevision = true;
		$isCardDAV = false;
		if(!$contact instanceof VCard) {
			try {
				$contact = Reader::read($contact);
			} catch(\Exception $e) {
				\OCP\Util::writeLog('contacts', __METHOD__.', exception: '.$e->getMessage(), \OCP\Util::ERROR);
				return false;
			}
		}

		if(is_array($id)) {
			$where_query = '';
			if(isset($id['id'])) {
				$id = $id['id'];
			} elseif(isset($id['uri'])) {
				$updateRevision = false;
				$isCardDAV = true;
				$id = $this->getIdFromUri($id['uri']);
				if(is_null($id)) {
					\OCP\Util::writeLog('contacts', __METHOD__ . ' Couldn\'t find contact', \OCP\Util::ERROR);
					return false;
				}
			} else {
				throw new \Exception(
					__METHOD__ . ' If second argument is an array, either \'id\' or \'uri\' has to be set.'
				);
			}
		}

		if($updateRevision || !isset($contact->REV)) {
			$now = new \DateTime;
			$contact->REV = $now->format(\DateTime::W3C);
		}

		$data = $contact->serialize();

		if($noCollection) {
			$me = $this->getContact(null, $id, $options);
			$addressbookid = $me['parent'];
		}

		$updates = array($contact->FN, $data, time(), $id, $addressbookid);

		$query = 'UPDATE `' . $this->cardsTableName
				. '` SET `fullname` = ?,`carddata` = ?, `lastmodified` = ? WHERE `id` = ? AND `addressbookid` = ?';
		if(!isset(self::$preparedQueries[$qname])) {
			self::$preparedQueries[$qname] = \OCP\DB::prepare($query);
		}
		try {
			$result = self::$preparedQueries[$qname]->execute($updates);
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return false;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.', exception: '
				. $e->getMessage(), \OCP\Util::ERROR);
			\OCP\Util::writeLog('contacts', __METHOD__.', id' . $id, \OCP\Util::DEBUG);
			return false;
		}

		$this->setModifiedAddressBook($addressbookid);
		if(!$isBatch) {
			\OCP\Util::emitHook('OCA\Contacts', 'post_updateContact',
				array(
					'backend' => $this->name,
					'addressBookId' => $addressbookid,
					'contactId' => $id,
					'contact' => $contact,
					'carddav' => $isCardDAV
				)
			);
		}
		return true;
	}

	/**
	 * Deletes a contact
	 *
	 * @param string $addressbookid
	 * @param string $id
	 * @param array $options - Optional (backend specific options)
	 * @see getContact
	 * @return bool
	 */
	public function deleteContact($addressbookid, $id, array $options = array()) {
		// TODO: pass the uri in $options instead.

		$qname = 'deletecontact';
		$noCollection = isset($options['noCollection']) ? $options['noCollection'] : false;
		$isBatch = isset($options['isBatch']) ? $options['isBatch'] : false;

		if(is_array($id)) {
			if(isset($id['id'])) {
				$id = $id['id'];
			} elseif(isset($id['uri'])) {
				$id = $this->getIdFromUri($id['uri']);
				if(is_null($id)) {
					\OCP\Util::writeLog('contacts', __METHOD__ . ' Couldn\'t find contact', \OCP\Util::ERROR);
					return false;
				}
			} else {
				throw new Exception(
					__METHOD__ . ' If second argument is an array, either \'id\' or \'uri\' has to be set.'
				);
			}
		}

		if(!$isBatch) {
			\OCP\Util::emitHook('OCA\Contacts', 'pre_deleteContact',
				array('id' => $id)
			);
		}

		if($noCollection) {
			$me = $this->getContact(null, $id, $options);
			$addressbookid = $me['parent'];
		}

		if(!isset(self::$preparedQueries[$qname])) {
			self::$preparedQueries[$qname] = \OCP\DB::prepare('DELETE FROM `'
				. $this->cardsTableName
				. '` WHERE `id` = ? AND `addressbookid` = ?');
		}
		\OCP\Util::writeLog('contacts', __METHOD__ . ' updates: ' . $id . '/' . $addressbookid, \OCP\Util::DEBUG);
		try {
			$result = self::$preparedQueries[$qname]->execute(array($id, $addressbookid));
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: '
					. \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return false;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__.
				', exception: ' . $e->getMessage(), \OCP\Util::ERROR);
			\OCP\Util::writeLog('contacts', __METHOD__.', id: '
				. $id, \OCP\Util::DEBUG);
			return false;
		}
		$this->setModifiedAddressBook($addressbookid);
		return true;
	}

	/**
	 * @brief Get the last modification time for a contact.
	 *
	 * Must return a UNIX time stamp or null if the backend
	 * doesn't support it.
	 *
	 * @param string $addressbookid
	 * @param mixed $id
	 * @returns int | null
	 */
	public function lastModifiedContact($addressbookid, $id) {
		$contact = $this->getContact($addressbookid, $id);
		return ($contact ? $contact['lastmodified'] : null);
	}

	/**
	 * @brief Get the contact id from the uri.
	 *
	 * @param mixed $id
	 * @returns int | null
	 */
	public function getIdFromUri($uri) {
		$query =  'SELECT `id` FROM `'. $this->cardsTableName . '` WHERE `uri` = ?';
		$stmt = \OCP\DB::prepare($query);
		$result = $stmt->execute(array($uri));
		if (\OCP\DB::isError($result)) {
			\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
			return null;
		}
		$one = $result->fetchOne();
		if(!$one) {
			\OCP\Util::writeLog('contacts', __METHOD__.', Not found, uri: '. $uri, \OCP\Util::DEBUG);
			return null;
		}
		return $one;
	}

	private function createAddressBookURI($displayname, $userid = null) {
		$userid = $userid ? $userid : \OCP\User::getUser();
		$name = str_replace(' ', '_', strtolower($displayname));
		try {
			$stmt = \OCP\DB::prepare('SELECT `uri` FROM `' . $this->addressBooksTableName . '` WHERE `userid` = ? ');
			$result = $stmt->execute(array($userid));
			if (\OCP\DB::isError($result)) {
				\OCP\Util::writeLog('contacts', __METHOD__. 'DB error: ' . \OC_DB::getErrorMessage($result), \OCP\Util::ERROR);
				return $name;
			}
		} catch(\Exception $e) {
			\OCP\Util::writeLog('contacts', __METHOD__ . ' exception: ' . $e->getMessage(), \OCP\Util::ERROR);
			return $name;
		}
		$uris = array();
		while($row = $result->fetchRow()) {
			$uris[] = $row['uri'];
		}

		$newname = $name;
		$i = 1;
		while(in_array($newname, $uris)) {
			$newname = $name.$i;
			$i = $i + 1;
		}
		return $newname;
	}

	/**
	* @brief Checks if a contact with the same URI already exist in the address book.
	* @param string $addressBookId Address book ID.
	* @param string $uri
	* @returns string Unique URI
	*/
	protected function uniqueURI($addressBookId, $uri) {
		$stmt = \OCP\DB::prepare( 'SELECT * FROM `' . $this->cardsTableName . '` WHERE `addressbookid` = ? AND `uri` = ?' );

		$result = $stmt->execute(array($addressBookId, $uri));

		if($result->numRows() > 0) {
			while(true) {
				$uri = Properties::generateUID() . '.vcf';
				$result = $stmt->execute(array($addressBookId, $uri));
				if($result->numRows() > 0) {
					continue;
				} else {
					return $uri;
				}
			}
		} else {
			return $uri;
		}
	}
}
