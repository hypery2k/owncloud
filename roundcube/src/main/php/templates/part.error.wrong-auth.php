<div id="errorMsg">
    <h1><?php echo $l->t("You don't have any email account configured correctly yet. Please check you username and password.") ?></h1>
    <div>
       <small><?php echo $l->t('You can manage your email accounts here:') ?></small>
	    <a class="button" href="<?php print_unescaped(OCP\Util::linkToRoute('settings_personal')) ?>"><?php echo $l -> t('Settings'); ?></a>
	</div>
</div>