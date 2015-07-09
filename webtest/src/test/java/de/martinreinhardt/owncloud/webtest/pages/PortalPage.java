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
public class PortalPage extends AbstractPage {

	//  APP MENU
	
	@FindBy(xpath = "//a[contains(@class,'menutoggle')]")
	private WebElement appMenu;
	
	// APPS

	@FindBy(xpath = "//*[@data-id='roundcube_index']/a/img")
	private WebElement roundcubeButton;

	@FindBy(xpath = "//*[@data-id='storagecharts2_index']/a/img")
	private WebElement storageChartsButton;
	
	// SETTINGS MENU

	@FindBy(xpath = "//*[@id='settings']//span")
	private WebElement settingsDropdownButton;

	@FindBy(xpath = "//*[@id='settings']//li[1]/a")
	private WebElement userSettingsDropdownButton;

	@FindBy(xpath = "//*[@id='settings']//li[3]/a")
	private WebElement adminSettingsDropdownButton;

	@FindBy(id = "logout")
	private WebElement logoutButton;

	/**
	 * @param pWebDriver
	 */
	public PortalPage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	public void go_to_roundcube_app() {
		try {
			click(appMenu);
		} catch (final Exception e) {
		}
		click(roundcubeButton);
	}

	public void go_to_storage_charts_app() {
		try {
			click(appMenu);
		} catch (final Exception e) {
		}
		click(storageChartsButton);
	}

	public void open_settings_dropdown() {
		element(settingsDropdownButton).waitUntilVisible();
		click(settingsDropdownButton);
	}

	public void go_to_admin_settings() {
		open_settings_dropdown();
		element(adminSettingsDropdownButton).waitUntilVisible();
		click(adminSettingsDropdownButton);
	}

	public void go_to_user_settings() {
		open_settings_dropdown();
		element(userSettingsDropdownButton).waitUntilVisible();
		click(userSettingsDropdownButton);
	}

	public void do_logout() {
		open_settings_dropdown();
		element(logoutButton).waitUntilVisible();
		click(logoutButton);
	}
}
