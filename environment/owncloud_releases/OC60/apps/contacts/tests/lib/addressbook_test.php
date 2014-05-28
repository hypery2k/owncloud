<?php
/**
 * Copyright (c) 2013 Thomas Tanghus (thomas@tanghus.net)
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Contacts;

use Sabre\VObject\Reader;

require_once __DIR__ . '/backend/mock.php';

class AddressBookTest extends \PHPUnit_Framework_TestCase {

	/**
	* @var array
	*/
	protected $abinfo;
	/**
	* @var OCA\Contacts\AddressBook
	*/
	protected $ab;
	/**
	* @var OCA\Contacts\Backend\AbstractBackend
	*/
	protected $backend;

	function setUp() {

		\Sabre\VObject\Component::$classMap['VCARD']	= '\OCA\Contacts\VObject\VCard';

		$this->backend = new Backend\Mock('foobar');
		$this->abinfo = $this->backend->getAddressBook('foo');
		$this->ab = new AddressBook($this->backend, $this->abinfo);

	}

	function tearDown() {
		unset($this->backend);
		unset($this->ab);
	}

	function testGetDisplayName() {

		$this->assertEquals('d-name', $this->ab->getDisplayName());

	}

	function testGetPermissions() {

		$this->assertEquals(\OCP\PERMISSION_ALL, $this->ab->getPermissions());

	}

	function testGetBackend() {

		$this->assertEquals($this->backend, $this->ab->getBackend());

	}

	function testGetChild() {

		$contact = $this->ab->getChild('123');
		$this->assertInstanceOf('OCA\\Contacts\\Contact', $contact);
		$this->assertEquals('Max Mustermann', $contact->getDisplayName());

	}

	function testAddChild() {

		$carddata = file_get_contents(__DIR__ . '/../data/test2.vcf');
		$vcard = Reader::read($carddata);
		$id = $this->ab->addChild($vcard);
		$this->assertNotEquals(false, $id);

		return $this->ab;
	}

	function testDeleteChild() {

		$this->assertTrue($this->ab->deleteChild('123'));
		$this->assertEquals(array(), $this->ab->getChildren());

	}

	function testGetChildNotFound() {

		try {
			$contact = $this->ab->getChild('Nowhere');
		} catch(\Exception $e) {
			$this->assertEquals('Contact not found', $e->getMessage());
			$this->assertEquals(404, $e->getCode());
			return;
		}

		$this->fail('Expected Exception 404.');

	}

	/**
	* @depends testAddChild
	*/
	function testGetChildren($ab) {

		$contacts = $ab->getChildren();

		$this->assertCount(2, $contacts);

		$this->assertEquals('Max Mustermann', $contacts[0]->getDisplayName());
		$this->assertEquals('John Q. Public', $contacts[1]->getDisplayName());

	}

	function testDelete() {

		$this->assertTrue($this->ab->delete());
		$this->assertEquals(array(), $this->backend->addressBooks);

	}

	function testGetLastModified() {

		$this->assertNull($this->ab->lastModified());

	}

	function testUpdate() {

		$this->assertTrue(
			$this->ab->update(array('displayname' => 'bar'))
		);

		$this->assertEquals('bar', $this->backend->addressBooks[0]['displayname']);
		$props = $this->ab->getMetaData();

		return $this->ab;

	}

	/**
	* @depends testUpdate
	*/
	function testGetMetaData($ab) {

		$props = $ab->getMetaData();
		$this->assertEquals('bar', $props['displayname']);

	}

}
