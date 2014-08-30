/**
 * File: AbstractPage.java 27.05.2014, 12:33:23, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.util;

import net.thucydides.core.pages.PageObject;

import org.apache.log4j.Logger;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.internal.Coordinates;
import org.openqa.selenium.internal.Locatable;

/**
 * Basic template for all test page objects
 * 
 * @author mreinhardt
 * 
 */
public class AbstractPage extends PageObject {

	// Logger
	protected static final Logger LOG = Logger.getLogger(AbstractPage.class);

	public AbstractPage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	/**
	 * Switches to the first iFrame in the webpage
	 */
	protected void load_iFrame(final String pFrameID) {
		try {
			super.getDriver().switchTo().frame(pFrameID);
		} catch (final Exception e) {
			LOG.debug("Unable to switch to iframe");
		}
	}

	/**
	 * Waits for the ajax status loader to disappear
	 */
	public void wait_for_load() {
		try {
			waitFor(500).milliseconds();
			// TODO implement
			// wait for ui blocker to disappear
			// if (element(blockUI).isCurrentlyVisible()) {
			// element(blockUI).waitUntilNotVisible();
			// LOG.info("UI Blocker disappeared");
			// }
			// if (element(ajaxLoader).isCurrentlyVisible()) {
			// // wait for loader icon to disappear
			// element(ajaxLoader).waitUntilNotVisible();
			// LOG.info("AJAX loader disappeared. Loading complete...");
			// }
		} catch (final Exception e) {
		}
	}

	// Simple Helper Methods

	/**
	 * Scrolls to the selected page element
	 * 
	 * @param pElement
	 */
	public void scrollTo(final WebElement pElement) {
		LOG.info("Starting scrolling to element ");
		// scroll to element
		final Coordinates coordinate = ((Locatable) pElement).getCoordinates();
		coordinate.onPage();
		coordinate.inViewPort();
		LOG.info("Scrolling to element done.");
	}

	/**
	 * Click the selected page element
	 * 
	 * @param pElement
	 */
	public void click(final WebElement pElement) {
		LOG.info("Starting clicking element ");
		wait_for_load();
		// scroll to element
		scrollTo(pElement);
		element(pElement).click();
		wait_for_load();
		LOG.info("Clicking element done.");
	}

	/**
	 * enter input in the selected input
	 * 
	 * @param pElement
	 * @param keyword
	 *            to enter
	 */
	public void input(final WebElement pElement, final String keyword) {
		wait_for_load();
		try {
			LOG.info("click element ");
			element(pElement).click();
		} catch (final Exception e) {
		}
		LOG.info("Typing input of element ");
		element(pElement).type(keyword);
		wait_for_load();
	}

}
