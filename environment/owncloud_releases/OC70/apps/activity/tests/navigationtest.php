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
 */

namespace OCA\Activity\Tests;

use OCA\Activity\Navigation;

class NavigationTest extends \PHPUnit_Framework_TestCase {
	public function getTemplateData() {
		return array(
			array(
				'all',
				null,
				array(
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'all',
								'class'				=> 'active',
							),
						),
					),
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'self',
							),
						),
					),
				),
				array(
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'self',
								'class'				=> 'active',
							),
						),
					),
				),
			),
			array(
				'all',
				'self',
				array(
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'all',
							),
						),
					),
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'self',
								'class'				=> 'active',
							),
						),
					),
				),
				array(
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'all',
								'class'				=> 'active',
							),
						),
					),
				),
			),
			array(
				'random',
				null,
				array(
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'all',
							),
						),
					),
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'self',
							),
						),
					),
				),
				array(
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'all',
								'class'				=> 'active',
							),
						),
					),
				),
			),
			array(
				'random',
				'all',
				array(
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'all',
								'class'				=> 'active',
							),
						),
					),
					array(
						'tag'		=> 'ul',
						'parent'	=> array(
							'tag'		=> 'div',
							'id'		=> 'app-navigation',
						),
						'descendant'	=> array(
							'tag'		=> 'a',
							'attributes' => array(
								'data-navigation'	=> 'self',
							),
						),
					),
				),
				array(),
			),
		);
	}

	/**
	 * @dataProvider getTemplateData
	 */
	public function testHooksDeleteUser($constructorActive, $forceActive, $matchTags, $notMatchTags) {
		$l = \OCP\Util::getL10N('activity');
		$navigation = new Navigation($l, $constructorActive);
		$output = $navigation->getTemplate($forceActive)->fetchPage();

		foreach ($matchTags as $matcher) {
			$this->assertTag($matcher, $output);
		}
		foreach ($notMatchTags as $matcher) {
			$this->assertNotTag($matcher, $output);
		}
	}

}
