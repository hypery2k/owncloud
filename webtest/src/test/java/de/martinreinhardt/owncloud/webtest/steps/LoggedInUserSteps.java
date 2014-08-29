/**
 * File: LoginEndUserSteps.java 27.05.2014, 12:42:39, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.steps;

import static org.hamcrest.MatcherAssert.assertThat;
import net.thucydides.core.annotations.Step;
import net.thucydides.core.pages.Pages;
import de.martinreinhardt.owncloud.webtest.pages.PortalPage;
import de.martinreinhardt.owncloud.webtest.pages.UserSettingsPage;

/**
 * @author mreinhardt
 * 
 */
public class LoggedInUserSteps extends PortalUserSteps {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = 1000463057264545156L;

	/**
	 * @param pages
	 */
	public LoggedInUserSteps(final Pages pages) {
		super(pages);
	}

	// PAGE STEPS

	@Step
	public void go_to_roundcube_view() {
		onPortalPage().go_to_roundcube_app();
	}

	@Step
	public void go_to_storagecharts_view() {
		onPortalPage().go_to_storage_charts_app();
	}

	@Step
	public void go_to_adminsettings_view() {
		onPortalPage().go_to_admin_settings();
	}

	@Step
	public void go_to_user_settings() {
		onPortalPage().go_to_user_settings();
	}

	@Step
	public void update_roundcube_login_and_save(final String pLogin, final String pPassword) {
		onUserSettingsPage().set_rc_credentials(pLogin, pPassword);
		assertThat("No status message is displayed", onUserSettingsPage().save_roundcube_settings());
		assertThat("No errors are displayed", !onUserSettingsPage().error_displayed());
	}

	@Step
	public void logout() {
		onPortalPage().do_logout();
	}

	private PortalPage onPortalPage() {
		return getPages().currentPageAt(PortalPage.class);
	}

	private UserSettingsPage onUserSettingsPage() {
		return getPages().currentPageAt(UserSettingsPage.class);
	}

}
