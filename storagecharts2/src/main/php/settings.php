<?php

/**
 * OwnCloud - Storage Charts plugin
 *
 * @author Martin Reinhardt and Xavier Beurois
 * @copyright 2012 Xavier Beurois www.djazz-lab.net and Martin Reinhardt contact@martinreinhardt-online.de
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
// Check if we are a user
OCP\User::checkLoggedIn();
OCP\App::checkAppEnabled('storagecharts2');

$tmpl = new OCP\Template('storagecharts2', 'tpl.settings');

if(isset($_POST['storagecharts2_disp']) && count($_POST['storagecharts2_disp']) <= 3){
	$c = $_POST['storagecharts2_disp'];
	$c_disp = Array('cpie_rfsus'=>0,'clines_usse'=>0,'chisto_us'=>0);
	foreach(array_keys($c_disp) as $chart){
		if(in_array($chart, $c)){
			$c_disp[$chart] = 1;
		}
	}
	OC_DLStCharts::setUConfValue('c_disp', serialize($c_disp));
	$tmpl->assign('stc_save_ok', TRUE);
}

$displays = OC_DLStCharts::getUConfValue('c_disp', Array('uc_val' => 'a:3:{s:10:"cpie_rfsus";i:1;s:11:"clines_usse";i:1;s:9:"chisto_us";i:1;}'));
$tmpl->assign('displays', unserialize($displays['uc_val']));

// workaround to detect OC version
$ocVersion = @reset(OCP\Util::getVersion());
$tmpl->assign('ocVersion', $ocVersion);
return $tmpl->fetchPage();