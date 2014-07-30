/**
 * File: LoginPage.java 27.05.2014, 12:33:23, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.pages;

import net.thucydides.core.annotations.DefaultUrl;
import net.thucydides.core.annotations.findby.FindBy;

import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import de.martinreinhardt.owncloud.webtest.util.AbstractPage;
import de.martinreinhardt.owncloud.webtest.util.UITestConstants;

@DefaultUrl(UITestConstants.DEFAULT_URL)
public class StorageChartsPage extends AbstractPage {

	public static final String URL_SC_APP = "index.php/apps/storagecharts2/charts.php";

	@FindBy(id = "storagecharts2")
	private WebElement chartsDiv;

	public StorageChartsPage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	public boolean isDlChartsDisplayed() {
		boolean loginVisible = false;
		try {
			loginVisible = chartsDiv.isDisplayed();
		} catch (NoSuchElementException e) {
		}
		return loginVisible;
	}
}
