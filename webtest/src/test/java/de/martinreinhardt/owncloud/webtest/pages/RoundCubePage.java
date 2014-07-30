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
import net.thucydides.core.reports.adaptors.xunit.model.TestError;

import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import de.martinreinhardt.owncloud.webtest.util.AbstractPage;
import de.martinreinhardt.owncloud.webtest.util.UITestConstants;

@DefaultUrl(RoundCubePage.URL_RC_APP)
public class RoundCubePage extends AbstractPage {

	/**
	 * 
	 */
	private static final String ROUNDCUBE_FRAME = "roundcubeFrame";

	public static final String URL_RC_APP = UITestConstants.DEFAULT_URL
			+ "index.php/apps/roundcube";

	@FindBy(id = "errorMsg")
	private WebElement errorMsg;

	@FindBy(id = "rcmloginuser")
	private WebElement rcLogin;

	@FindBy(css = "#rcmrow1 > td.subject > a")
	private WebElement firstEmail;

	@FindBy(id = "loader")
	private WebElement ajaxLoader;

	public RoundCubePage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	/**
	 * Waits for the ajax status loader to disappear
	 * 
	 * @throws TestError
	 */
	private void wait_for_rc_load() throws TestError {
		this.load_iFrame(ROUNDCUBE_FRAME);
		try {
			waitFor(500).milliseconds();
			if (element(ajaxLoader).isCurrentlyVisible()) {
				// wait for loader icon to disappear
				element(ajaxLoader).waitUntilNotVisible();
				if (isRcLoginDisplayed()) {
					throw new TestError(
							"Roundcube Login should not be visible!");
				}
				LOG.info("AJAX loader disappeared. Loading complete...");
			}
		} catch (NoSuchElementException e) {
		}
	}

	public String getFirstMessageSubject() throws TestError {
		wait_for_rc_load();
		String result = null;
		load_iFrame(ROUNDCUBE_FRAME);
		clickOn(firstEmail);
		result = firstEmail.getText();
		return result;
	}

	public boolean isRcLoginDisplayed() throws TestError {
		wait_for_rc_load();
		boolean loginVisible = false;
		try {
			loginVisible = rcLogin.isDisplayed();
		} catch (NoSuchElementException e) {
		}
		return loginVisible;
	}

	public boolean isErrorMessageDisplayed() throws TestError {
		wait_for_rc_load();
		boolean errorDisplayed = false;
		try {
			errorDisplayed = errorMsg.isDisplayed();
		} catch (NoSuchElementException e) {
		}
		return errorDisplayed;
	}
}
