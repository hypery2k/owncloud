<div id="errorMsg">
	<h1>
		<?php echo $l->t("You have errors in your settings") ?>
	</h1>
	<div>
		<span><?php echo $l->t('You can manage your admin settings here:') ?></span> 
		<br> <br> 
		<a class="button"
			href="<?php print_unescaped(OCP\Util::linkToRoute('settings_admin')) ?>"><?php echo $l -> t('Settings'); ?>
		</a>
	</div>
</div>
