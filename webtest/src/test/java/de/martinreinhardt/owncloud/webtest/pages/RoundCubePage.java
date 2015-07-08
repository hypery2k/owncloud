/**
 * File: LoginPage.java 27.05.2014, 12:33:23, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.pages;


import net.serenitybdd.core.annotations.findby.FindBy;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;

import org.apache.log4j.Logger;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class RoundCubePage extends PortalPage {

	// Logger
	private static final Logger LOG = Logger.getLogger(RoundCubePage.class);

	/**
	 * iframe id
	 */
	private static final String ROUNDCUBE_FRAME = "roundcubeFrame";

	/**
	 * reference id of loader item
	 */
	private static final String ROUNDCUBE_LOADER = "roundcubeLoader";
	/**
	 * reference xpath to new loader
	 */
	private static final String ROUNDCUBE_LOADER_NEW = "//*[contains(@class,'loading')]";

	@FindBy(id = ROUNDCUBE_FRAME)
	private WebElement rcFrame;

	@FindBy(id = "errorMsg")
	private WebElement errorMsg;

	@FindBy(id = "rcmloginuser")
	private WebElement rcLogin;

	@FindBy(xpath = "(//tbody//td[contains(@class,'subject')]/a)[1]")
	private WebElement firstEmail;

	@FindBy(id = ROUNDCUBE_LOADER)
	private WebElement ajaxLoader;

	@FindBy(xpath = ROUNDCUBE_LOADER_NEW)
	private WebElement newAjaxLoader;

	public RoundCubePage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	/**
	 * Waits for the ajax status loader to disappear
	 * 
	 * @throws TestError
	 */
	private void wait_for_rc_load() throws TestError {
		waitFor(300).milliseconds();
		this.load_iFrame(ROUNDCUBE_FRAME);
		try {
			if (element(newAjaxLoader).isCurrentlyVisible()) {
				// wait for loader icon to disappear
				element(newAjaxLoader).waitUntilNotVisible();
				if (isRcLoginDisplayed()) {
					throw new TestError("Roundcube Login should not be visible!");
				}
				LOG.info("AJAX loader disappeared. Loading complete...");
			}
		} catch (final NoSuchElementException e1) {
			LOG.info("New AJAX Roundcube loader not found");
		}
		try {
			if (element(ajaxLoader).isCurrentlyVisible()) {
				// wait for loader icon to disappear
				element(ajaxLoader).waitUntilNotVisible();
				if (isRcLoginDisplayed()) {
					throw new TestError("Roundcube Login should not be visible!");
				}
				LOG.info("AJAX loader disappeared. Loading complete...");
			}
		} catch (final NoSuchElementException e2) {
			LOG.info("AJAX Roundcube loader not found");
		}
	}

	public String getFirstMessageSubject() throws TestError {
		wait_for_rc_load();
		load_iFrame(ROUNDCUBE_FRAME);
		clickOn(firstEmail);
		final String result = firstEmail.getText();
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
