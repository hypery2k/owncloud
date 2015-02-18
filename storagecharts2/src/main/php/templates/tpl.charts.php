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
 * JS minified by http://fmarcia.info/jsmin/test.html
 *
 */


foreach($_['sc_sort'] as $sc_sort){
	if($_['c_disp'][$sc_sort]){
		// add js for each sorting
		$scSort=$sc_sort;
		//$js = $js.'StorageCharts2.render(\"'.OC_DLStChartsLoader::loadChart($sc_sort, $l).'\");';
	}
}

if($_['c_disp']['clines_usse']){
	$huSize = $_['hu_size'];
	//$js = $js.'StorageCharts2.linesUsseUnitsSelect(\"'.$_['hu_size'].'\");';
}
if($_['c_disp']['chisto_us']){
	$huSizeHus = $_['hu_size_hus'];
	//$js = $js.'StorageCharts2.histoUsUnitsSelect(\"'.$_['hu_size_hus'].'\");';
}
?>

<div id="storagecharts2" data-sc-sort="<?php  print($scSort)?>" data-sc-size="<?php  print($huSize)?>" data-sc-size-hus="<?php  print($huSizeHus)?>">
	<div class="personalblock topblock titleblock">
		<span><?php print($l->t('Drag\'N\'Drop on the chart title to re-order')); ?></span>
	</div>
</div>
<div id="stc_frame">
	<div id="stc_sortable">
	<?php foreach($_['sc_sort'] as $sc_sort){
		if(strcmp($sc_sort, 'cpie_rfsus') == 0){
			$sc_sort_title = 'Current ratio free space / used space';
		}elseif(strcmp($sc_sort, 'clines_usse') == 0){
			$sc_sort_title = 'Daily Used Space Evolution';
		}else{
			$sc_sort_title = 'Monthly Used Space Evolution';
		}
		if($_['c_disp'][$sc_sort]){ 
		?>
		<div id="<?php print($sc_sort); ?>" class="personalblock">
			<h3>
				<img
					src="<?php print(OCP\Util::imagePath('storagecharts2', 'move.png')); ?>" />
				<?php print($l->t($sc_sort_title).' '.$l->t('for')); ?>
				"<?php print(OC_Group::inGroup(OCP\User::getUser(), 'admin')?$l->t('all users'):OCP\User::getDisplayName()); ?>"
			</h3>
			<div id="<?php print(substr($sc_sort, 1)); ?>" style="max-width: 100%; height: 400px; margin: 0 auto">
			</div>
		</div>
	<?php }
	} ?>
	</div>
</div>
