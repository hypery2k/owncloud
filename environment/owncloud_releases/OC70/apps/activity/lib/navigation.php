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
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

namespace OCA\Activity;

/**
 * Class Navigation
 *
 * @package OCA\Activity
 */
class Navigation {
	/** @var \OC_L10N */
	protected $l;

	/** @var string */
	protected $active;

	/** @var string */
	protected $rssLink;

	/**
	 * Construct
	 *
	 * @param \OC_L10N $l
	 * @param null|string $active Navigation entry that should be marked as active
	 */
	public function __construct(\OC_L10N $l, $active = 'all') {
		$this->l = $l;
		$this->active = $active;
		$this->rssLink = '';
	}

	/**
	 * Get the users we want to send an email to
	 *
	 * @param null|string $forceActive Navigation entry that should be marked as active
	 * @return \OCP\Template
	 */
	public function getTemplate($forceActive = null) {
		$active = $forceActive ?: $this->active;

		$template = new \OCP\Template('activity', 'navigation', '');
		$entries = $this->getLinkList();

		$additionalEntries = \OC::$server->getActivityManager()->getNavigation();
		$entries['apps'] = array_merge($entries['apps'], $additionalEntries['apps']);
		$entries['top'] = array_merge($entries['top'], $additionalEntries['top']);

		if (sizeof($entries['apps']) === 1) {
			// If there is only the files app, we simply do not show it,
			// as it is the same as the 'all' filter.
			$entries['apps'] = array();
		}

		$template->assign('activeNavigation', $active);
		$template->assign('navigations', $entries);
		$template->assign('rssLink', $this->rssLink);

		return $template;
	}

	public function setRSSToken($rssToken) {
		if ($rssToken) {
			$this->rssLink = \OCP\Util::linkToAbsolute('activity', 'rss.php', array('token' => $rssToken));
		}
		else {
			$this->rssLink = '';
		}
	}

	/**
	 * Get all items for the users we want to send an email to
	 *
	 * @return array Notification data (user => array of rows from the table)
	 */
	protected function getLinkList() {
		$topEntries = array(
			array(
				'id' => 'all',
				'name' => (string) $this->l->t('All Activities'),
				'url' => \OCP\Util::linkToAbsolute('activity', 'index.php'),
			),
			array(
				'id' => 'self',
				'name' => (string) $this->l->t('Activities by you'),
				'url' => \OCP\Util::linkToAbsolute('activity', 'index.php', array('filter' => 'self')),
			),
			array(
				'id' => 'by',
				'name' => (string) $this->l->t('Activities by others'),
				'url' => \OCP\Util::linkToAbsolute('activity', 'index.php', array('filter' => 'by')),
			),
			array(
				'id' => 'shares',
				'name' => (string) $this->l->t('Shares'),
				'url' => \OCP\Util::linkToAbsolute('activity', 'index.php', array('filter' => 'shares')),
			),
		);

		$appFilterEntries = array(
			array(
				'id' => 'files',
				'name' => (string) $this->l->t('Files'),
				'url' => \OCP\Util::linkToAbsolute('activity', 'index.php', array('filter' => 'files')),
			),
		);

		return array(
			'top'		=> $topEntries,
			'apps'		=> $appFilterEntries,
		);
	}
}
