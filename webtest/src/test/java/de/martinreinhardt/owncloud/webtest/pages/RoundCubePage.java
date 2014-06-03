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
public class RoundCubePage extends AbstractPage {

	@FindBy(id = "errorMsg")
	private WebElement errorMsg;

	@FindBy(css = "#rcmrow1 > td.subject > a")
	private WebElement firstEmail;

	public RoundCubePage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	public String getFirstMessageSubject() {
		String result = null;
		load_iFrame("roundcubeFrame");
		clickOn(firstEmail);
		result = firstEmail.getText();
		return result;
	}

	public boolean isErrorMessageDisplayed() {
		boolean errorDisplayed = false;
		try {
			errorDisplayed = errorMsg.isDisplayed();
		} catch (NoSuchElementException e) {
		}
		return errorDisplayed;
	}
}
