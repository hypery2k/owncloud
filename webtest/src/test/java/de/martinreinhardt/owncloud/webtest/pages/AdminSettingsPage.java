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

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import de.martinreinhardt.owncloud.webtest.OwnCloud;
import de.martinreinhardt.owncloud.webtest.util.AbstractPage;

@Story(OwnCloud.Apps.class)
@WithTag("Apps")
public class AdminSettingsPage extends AbstractPage {

	@FindBy(id = "rcAdvancedSettings")
	private WebElement roundcubeAdvancedPanel;

	@FindBy(id = "autoLogin")
	private WebElement rcToogleAutologin;

	@FindBy(id = "rcAdminSubmit")
	private WebElement rcSaveSettings;

	@FindBy(id = "adminmail_success_message")
	private WebElement rcSaveSuccessMessage;

	/**
	 * @param pWebDriver
	 */
	public AdminSettingsPage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	public void go_to_roundcube_advancedsettings() {
		click(roundcubeAdvancedPanel);
	}

	public void toggle_roundcube_autologin() {
		click(rcToogleAutologin);
	}

	public void save_roundcube_settings() {
		click(rcSaveSettings);
		// scroll down
		getJavascriptExecutorFacade().executeScript("scroll(0, 150)");
		element(rcSaveSuccessMessage).waitUntilVisible();
	}
}
