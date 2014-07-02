<?php

echo('<div id="controls">
		<a href="'.\OCP\Util::linkToAbsolute('revealjs','documentation.php').'" class="button docu">'.$l->t('Documentation').'</a>
		</div>
		');

if(empty($_['list'])) {
	echo('<div id="emptyfolder">'.$l->t('No Reveal files are found in your ownCloud. Please upload a .reveal file.').'</div>');
} else {
	echo('<table class="revealist" >');
	foreach($_['list'] as $entry) {
		echo('<tr><td width="1"><a target="_blank" href="'.\OCP\Util::linkToAbsolute('revealjs','player.php').'&file='.urlencode($entry['url']).'&name='.urlencode($entry['name']).'"><img align="left" src="'.\OCP\Util::linkToAbsolute('revealjs','img/impressbig.png').'"></a></td><td><a target="_blank" href="'.\OCP\Util::linkToAbsolute('revealjs','player.php').'&file='.urlencode($entry['url']).'&name='.urlencode($entry['name']).'">'.$entry['name'].'</a></td><td>'.\OCP\Util::formatDate($entry['mtime']).'</td><td>'.\OCP\Util::humanFileSize($entry['size']).'</td></tr>');
	}
	echo('</table>');
}
?>
