/**
 * File: LoginEndUserSteps.java 27.05.2014, 12:42:39, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.steps;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.pages.Pages;
import de.martinreinhardt.owncloud.webtest.pages.AdminSettingsPage;

/**
 * @author mreinhardt
 * 
 */
public class AdminSteps extends PortalUserSteps {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = -3141185645424360620L;

	/**
	 * @param pages
	 */
	public AdminSteps(final Pages pages) {
		super(pages);
	}

	// PAGE STEPS

	@Step
	public void go_to_roundcube_advancedsettings() {
		onAdminSettingsPage().go_to_roundcube_advancedsettings();
	}

	@Step
	public void toggle_roundcube_autologin() {
		onAdminSettingsPage().toggle_roundcube_autologin();
	}

	@Step
	public void apply_roundcube_settings() {
		// TODO wait for success
		onAdminSettingsPage().save_roundcube_settings();
	}

	private AdminSettingsPage onAdminSettingsPage() {
		return getPages().currentPageAt(AdminSettingsPage.class);
	}

	// GETTER AND SETTER

}
