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

$ocVersion = $_['ocVersion'];
$cfgClass = $ocVersion >= 7 ? 'section' : 'personalblock';
?>
<form id="storagecharts2"  action="#" method="post">
	<!-- Prevent CSRF attacks-->
	<input type="hidden" name="requesttoken" value="<?php echo $_['requesttoken'] ?>" id="requesttoken"> 
	<input type="hidden" name="appname" value="storagecharts2">
	
	<fieldset class="<?php echo $cfgClass; ?>">
		<h2>Storage Charts 2</h2>
		<em><?php print($l->t('Uncheck charts you do not want to display')); ?></em>
		<br>
		<?php foreach($_['displays'] as $chart => $is_enable){
			if(strcmp($chart, 'cpie_rfsus') == 0){
				$chart_title = 'Current ratio free space / used space';
			}elseif(strcmp($chart, 'clines_usse') == 0){
				$chart_title = 'Daily Used Space Evolution';
			}else{
				$chart_title = 'Monthly Used Space Evolution';
			} ?>
		<div>
			<input type="checkbox" name="storagecharts2_disp[]"
				id="<?php print($chart); ?>_e" style="margin-right: 10px;"
			<?php print($is_enable?' checked':'') ?>
				value="<?php print($chart); ?>" />
			<?php print($l->t($chart_title)); ?>
		</div>
		<?php } ?>
		<input type="submit" value="<?php print($l->t('Save')); ?>" /><span
			style="color: #00A220;"><?php if(isset($_['stc_save_ok'])){
				print($l->t('Save OK'));
			} ?> </span>
	</fieldset>
</form>
