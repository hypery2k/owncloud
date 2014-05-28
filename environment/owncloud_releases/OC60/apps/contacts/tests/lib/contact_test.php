<?php
/**
 * Copyright (c) 2013 Thomas Tanghus (thomas@tanghus.net)
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Contacts;

use Sabre\VObject\Reader;
use OCA\Contacts\Utils\JSONSerializer;

require_once __DIR__ . '/backend/mock.php';

class ContactTest extends \PHPUnit_Framework_TestCase {

	/**
	* @var array
	*/
	protected $abinfo;
	/**
	* @var OCA\Contacts\AddressBook
	*/
	protected $ab;
	/**
	* @var OCA\Contacts\Contact
	*/
	protected $contact;
	/**
	* @var OCA\Contacts\Backend\AbstractBackend
	*/
	protected $backend;

	function setUp() {

		$this->backend = new Backend\Mock('foobar');
		$this->abinfo = $this->backend->getAddressBook('foo');
		$this->ab = new AddressBook($this->backend, $this->abinfo);
		$this->contact = $this->ab->getChild('123');
	}

	function tearDown() {
		unset($this->backend);
		unset($this->ab);
		unset($this->contact);
	}

	function testGetDisplayName() {

		$this->assertEquals('Max Mustermann', $this->contact->getDisplayName());

	}

	function testGetMetaData() {

		$props = $this->contact->getMetaData();
		$this->assertEquals('Max Mustermann', $props['displayname']);
		$this->assertEquals('foobar', $props['owner']);
		$this->assertEquals(\OCP\PERMISSION_ALL, $props['permissions']);
		$this->assertEquals($this->ab->getId(), $props['parent']);

	}

	function testGetPermissions() {

		$this->assertEquals($this->ab->getPermissions(), $this->contact->getPermissions());
		$this->assertEquals(\OCP\PERMISSION_ALL, $this->contact->getPermissions());

	}

	function testGetParent() {

		$this->assertEquals($this->ab, $this->contact->getParent());

	}

	function testGetBackend() {

		$this->assertEquals($this->backend, $this->contact->getBackend());

	}

	function testDelete() {

		$this->assertTrue($this->contact->delete());

	}

	function testIsSaved() {

		$this->assertTrue($this->contact->isSaved());

		$this->contact->FN = 'Don Quixote';

		$this->assertEquals(false, $this->contact->isSaved());

	}

	function testSave() {

		$this->contact->FN = 'Don Quixote';

		$this->assertTrue($this->contact->save());

		$this->assertTrue($this->contact->isSaved());

	}

	function testSetByChecksum() {
		// TODO: Move JSONSerializer tests to a TestUtils class or something
		$serialized = JSONSerializer::serializeContact($this->contact);

		$this->assertTrue(is_array($serialized));

		$this->assertArrayHasKey('data', $serialized);

		$this->assertArrayHasKey('EMAIL', $serialized['data']);

		$checksum = $serialized['data']['EMAIL'][0]['checksum'];
		$newchecksum = $this->contact->setPropertyByChecksum($checksum, 'EMAIL', 'mmustermann@example.org');

		$this->assertNotEquals($checksum, $newchecksum);

		$this->assertEquals('mmustermann@example.org', (string)$this->contact->EMAIL);

	}

	function testSetByChecksumFail() {

		try {
			$this->contact->setPropertyByChecksum('87654321', 'EMAIL', 'mmustermann@example.org');
		} catch(\Exception $e) {
			$this->assertEquals('Property not found', $e->getMessage());
			$this->assertEquals(404, $e->getCode());
			return;
		}

		$this->fail('Expected Exception 404.');

	}

	function testUnsetByChecksum() {

		$serialized = JSONSerializer::serializeContact($this->contact);
		$checksum = $serialized['data']['EMAIL'][0]['checksum'];

		$this->assertTrue(isset($this->contact->EMAIL));

		$this->contact->unsetPropertyByChecksum($checksum);

		$this->assertTrue(!isset($this->contact->EMAIL));

	}

	function testSetByName() {

		$this->assertTrue(!isset($this->contact->NICKNAME));

		$this->assertTrue($this->contact->setPropertyByName('NICKNAME', 'Maxie'));

		$this->assertTrue(isset($this->contact->NICKNAME));

		$this->assertEquals((string)$this->contact->NICKNAME, 'Maxie');

	}

}