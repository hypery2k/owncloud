<div id="firstrun">
    <h1><?php echo $l->t("You don't have any email account configured yet.") ?></h1>
    <div>
        <small><?php echo $l->t('You can manage your email accounts here:') ?></small>
	    <a class="button" href="<?php print_unescaped(OCP\Util::linkToRoute('settings_personal')) ?>"><?php echo $l -> t('Settings'); ?></a>
	</div>
</div>