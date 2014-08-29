/**
 * File: LoginPage.java 27.05.2014, 12:33:23, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.pages;

import net.thucydides.core.annotations.DefaultUrl;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.annotations.findby.FindBy;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import de.martinreinhardt.owncloud.webtest.OwnCloud;
import de.martinreinhardt.owncloud.webtest.util.AbstractPage;
import de.martinreinhardt.owncloud.webtest.util.UITestConstants;

@Story(OwnCloud.Apps.class)
@WithTag("Apps")
@DefaultUrl(UITestConstants.DEFAULT_URL)
public class UserSettingsPage extends AbstractPage {

	private final static String RC_ID_STATUS_MSG = "rc_usermail_success_message";

	@FindBy(id = "rc_mail_settings")
	private WebElement rcSettingsPanel;

	@FindBy(id = "rc_mail_username")
	private WebElement rcUser;

	@FindBy(id = "rc_mail_password")
	private WebElement rcPassword;

	@FindBy(id = "rc_usermail_update")
	private WebElement rcSaveSettings;

	@FindBy(id = RC_ID_STATUS_MSG)
	private WebElement rcStatusMsg;

	@FindBy(id = "_mail_error_message")
	private WebElement rcErrorMsg;

	@FindBy(id = "rc_mail_error_empty_message")
	private WebElement rcEmptyErrorMsg;

	/**
	 * @param pWebDriver
	 */
	public UserSettingsPage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	public void go_to_roundcube_usersettings() {
		scrollTo(rcSettingsPanel);
	}

	public void set_rc_credentials(final String pLogin, final String pPassword) {
		input(rcUser, pLogin);
		input(rcPassword, pPassword);
	}

	public boolean save_roundcube_settings() {
		click(rcSaveSettings);
		return rcStatusMsg.isDisplayed();
	}

	public boolean error_displayed() {
		boolean errorDisplay = false;
		try {
			errorDisplay = rcErrorMsg.isDisplayed() || rcEmptyErrorMsg.isDisplayed();
		} catch (Exception e) {

		}
		return errorDisplay;
	}
}
