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
import net.thucydides.core.annotations.StepGroup;
import net.thucydides.core.pages.Pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.JavascriptExecutor;

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

	// Logger
	protected static final Logger LOG = Logger.getLogger(LoggedInUserSteps.class);

	/**
	 * @param pages
	 */
	public LoggedInUserSteps(final Pages pages) {
		super(pages);
	}

	// PAGE STEPS

	@Step
	public void go_to_roundcube_view() {
		LOG.info("Going to rouncube page");
		onPortalPage().go_to_roundcube_app();
		LOG.info("Done going to rouncube page");
	}

	@Step
	public void go_to_storagecharts_view() {
		LOG.info("Going to storagecharts page");
		onPortalPage().go_to_storage_charts_app();
		LOG.info("Done going to storagecharts page");
	}

	@Step
	public void go_to_adminsettings_view() {
		LOG.info("Going to admin settings page");
		onPortalPage().go_to_admin_settings();
		LOG.info("Done going to admin settings page");
	}

	@Step
	public void go_to_user_settings() {
		LOG.info("Going to user settings page");
		onPortalPage().go_to_user_settings();
		LOG.info("Done going to user settings page");
	}
	
	@Step
	public void update_roundcube_login(final String pLogin, final String pPassword) {
		onUserSettingsPage().set_rc_credentials(pLogin, pPassword);
		assertThat("No status message is displayed", onUserSettingsPage().save_roundcube_settings());
	}
	
	@Step
	public void save_roundcube_login_details() {
        ((JavascriptExecutor)getDriver()).executeScript("window.scrollTo(0, 200);");
		assertThat("No errors are displayed", !onUserSettingsPage().error_displayed());
	}

	@StepGroup
	public void update_roundcube_login_and_save(final String pLogin, final String pPassword) {
		update_roundcube_login(pLogin, pPassword);
		save_roundcube_login_details();
	}

	@Step
	public void logout() {
		LOG.info("Starting logout");
		onPortalPage().do_logout();
		LOG.info("Logout done.");
	}

	private PortalPage onPortalPage() {
		return getPages().currentPageAt(PortalPage.class);
	}

	private UserSettingsPage onUserSettingsPage() {
		return getPages().currentPageAt(UserSettingsPage.class);
	}

}
