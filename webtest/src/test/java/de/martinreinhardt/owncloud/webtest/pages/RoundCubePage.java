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

import de.martinreinhardt.owncloud.webtest.util.UITestConstants;

@DefaultUrl(UITestConstants.DEFAULT_URL)
public class RoundCubePage extends PortalPage {

	/**
	 * iframe id
	 */
	private static final String ROUNDCUBE_FRAME = "roundcubeFrame";

	/**
	 * reference id of loader item
	 */
	private static final String ROUNDCUBE_LOADER = "roundcubeLoader";

	@FindBy(id = ROUNDCUBE_FRAME)
	private WebElement rcFrame;

	@FindBy(id = "errorMsg")
	private WebElement errorMsg;

	@FindBy(id = "rcmloginuser")
	private WebElement rcLogin;

	@FindBy(css = "#rcmrow1 > td.subject > a")
	private WebElement firstEmail;

	@FindBy(id = ROUNDCUBE_LOADER)
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
					throw new TestError("Roundcube Login should not be visible!");
				}
				LOG.info("AJAX loader disappeared. Loading complete...");
			}
		} catch (final NoSuchElementException e) {
		}
	}

	public String getFirstMessageSubject() throws TestError {
		wait_for_rc_load();
		String result = null;
		load_iFrame(ROUNDCUBE_FRAME);
		clickOn(firstEmail);
		result = firstEmail.getText();
		back_to_parent_document();
		return result;
	}

	public boolean isRcLoginDisplayed() throws TestError {
		wait_for_rc_load();
		boolean loginVisible = false;
		try {
			loginVisible = rcLogin.isDisplayed();
		} catch (final NoSuchElementException e) {
		}
		back_to_parent_document();
		return loginVisible;
	}

	public boolean isErrorMessageDisplayed() throws TestError {
		wait_for_rc_load();
		boolean errorDisplayed = false;
		try {
			errorDisplayed = errorMsg.isDisplayed();
		} catch (final NoSuchElementException e) {
		}
		back_to_parent_document();
		return errorDisplayed;
	}

	public boolean isShowingRcFrame() throws TestError {
		wait_for_rc_load();
		boolean frameLoaderd = false;
		try {
			frameLoaderd = rcFrame.isDisplayed();
		} catch (final NoSuchElementException e) {
		}
		back_to_parent_document();
		return frameLoaderd;
	}
}
