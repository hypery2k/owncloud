<?php
/**
 * @author Thomas Tanghus
 * @copyright 2013-2014 Thomas Tanghus (thomas@tanghus.net)
 *
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Contacts;

class SearchProvider extends \OC_Search_Provider{
	public function search($query) {
		$unescape = function($value) {
			return strtr($value, array('\,' => ',', '\;' => ';'));
		};

		$searchresults = array();
		$results = \OCP\Contacts::search($query, array('N', 'FN', 'EMAIL', 'NICKNAME', 'ORG'));
		$l = new \OC_l10n('contacts');
		foreach($results as $result) {
			$link = \OCP\Util::linkToRoute('contacts_index').'#' . $result['id'];
			$props = array();
			$display = (isset($result['FN']) && $result['FN']) ? $result['FN'] : null;
			foreach(array('EMAIL', 'NICKNAME', 'ORG') as $searchvar) {
				if(isset($result[$searchvar]) && $result[$searchvar]) {
					if(is_array($result[$searchvar])) {
						$result[$searchvar] = array_filter($result[$searchvar]);
					}
					$prop = is_array($result[$searchvar]) ? implode(',', $result[$searchvar]) : $result[$searchvar];
					$props[] = $prop;
					$display = $display ?: $result[$searchvar];
				}
			}
			$props = array_map($unescape, $props);
			$searchresults[]=new \OC_Search_Result($display, implode(', ', $props), $link, (string)$l->t('Contact'), null);//$name,$text,$link,$type
		}
		return $searchresults;
	}
}
