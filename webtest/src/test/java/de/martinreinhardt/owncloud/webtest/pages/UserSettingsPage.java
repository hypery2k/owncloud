/**
 * File: LoginPage.java 27.05.2014, 12:33:23, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.pages;

import net.serenitybdd.core.annotations.findby.FindBy;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import de.martinreinhardt.owncloud.webtest.OwnCloud;
import de.martinreinhardt.owncloud.webtest.util.AbstractPage;

@Story(OwnCloud.Apps.class)
@WithTag("Apps")
public class UserSettingsPage extends AbstractPage {

	private final static String RC_ID_STATUS_MSG = "rc_usermail_success_message";

	@FindBy(id = "roundcube")
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
		element(rcSettingsPanel).waitUntilVisible();
		scrollTo(rcSettingsPanel);
	}

	public void set_rc_credentials(final String pLogin, final String pPassword) {
		element(rcUser).waitUntilVisible();
		input(rcUser, pLogin);
		element(rcPassword).waitUntilVisible();
		input(rcPassword, pPassword);
	}

	public boolean save_roundcube_settings() {
		click(rcSaveSettings);
		waitForRenderedElementsToBePresent(By.id(RC_ID_STATUS_MSG));
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
