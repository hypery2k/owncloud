<?php

/**
* ownCloud - Activity App
*
* @author Joas Schilling
* @copyright 2014 Joas Schilling nickvergessen@owncloud.com
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

namespace OCA\Activity\Controller;

use OCA\Activity\Data;
use OCA\Activity\GroupHelper;
use OCA\Activity\Navigation;
use OCA\Activity\UserSettings;
use OCP\AppFramework\Controller;
use OCP\AppFramework\Http\TemplateResponse;
use OCP\IRequest;

class Activities extends Controller {
	const DEFAULT_PAGE_SIZE = 30;

	/** @var \OCA\Activity\Data */
	protected $data;

	/** @var \OCA\Activity\GroupHelper */
	protected $helper;

	/** @var \OCA\Activity\Navigation */
	protected $navigation;

	/** @var \OCA\Activity\UserSettings */
	protected $settings;

	/** @var string */
	protected $user;

	/**
	 * constructor of the controller
	 *
	 * @param string $appName
	 * @param IRequest $request
	 * @param Data $data
	 * @param GroupHelper $helper
	 * @param Navigation $navigation
	 * @param UserSettings $settings
	 * @param string $user
	 */
	public function __construct($appName, IRequest $request, Data $data, GroupHelper $helper, Navigation $navigation, UserSettings $settings, $user) {
		parent::__construct($appName, $request);
		$this->data = $data;
		$this->helper = $helper;
		$this->navigation = $navigation;
		$this->settings = $settings;
		$this->user = $user;
	}

	/**
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 *
	 * @param string $filter
	 * @return TemplateResponse
	 */
	public function showList($filter = 'all') {
		$filter = $this->data->validateFilter($filter);

		return new TemplateResponse('activity', 'list', [
			'appNavigation'	=> $this->navigation->getTemplate($filter),
			'filter'		=> $filter,
		]);
	}

	/**
	 * @NoAdminRequired
	 *
	 * @param int $page
	 * @param string $filter
	 * @return TemplateResponse
	 */
	public function fetch($page, $filter = 'all') {
		$pageOffset = $page - 1;
		$filter = $this->data->validateFilter($filter);

		return new TemplateResponse('activity', 'activities.part', [
			'activity' => $this->data->read($this->helper, $this->settings, $pageOffset * self::DEFAULT_PAGE_SIZE, self::DEFAULT_PAGE_SIZE, $filter)
		], '');
	}
}
