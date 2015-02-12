<?php
/**
 * @author Lukas Reschke
 * @copyright 2014 Lukas Reschke lukas@owncloud.com
 *
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Files_PdfViewer\Controller;

use OCP\AppFramework\Http\TemplateResponse;
use OCP\IRequest;
use OCP\IURLGenerator;
use Test\TestCase;

class DisplayControllerTest extends TestCase {
	/** @var string */
	private $appName;
	/** @var IRequest */
	private $request;
	/** @var IURLGenerator */
	private $urlGenerator;
	/** @var DisplayController */
	private $controller;

	public function setUp(){
		$this->appName = 'files_pdfviewer';

		$this->request = $this->getMockBuilder(
			'\OCP\IRequest')
			->disableOriginalConstructor()
			->getMock();
		$this->urlGenerator = $this->getMockBuilder(
			'\OCP\IUrlGenerator')
			->disableOriginalConstructor()
			->getMock();
		$this->controller = new DisplayController(
			$this->appName,
			$this->request,
			$this->urlGenerator
		);

		parent::setUp();
	}

	public function testShowPdfViewer() {
		$params = [
			'urlGenerator' => $this->urlGenerator
		];
		$expectedResponse = new TemplateResponse($this->appName, 'viewer', $params, 'blank');

		$this->assertEquals($expectedResponse, $this->controller->showPdfViewer());
	}

}
