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
	 * Waits for the ajax status loader to disappear
	 */
	public void wait_for_ajax_load() {
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
		} catch (Exception e) {
		}
	}

	// Simple Helper Methods

	/**
	 * Scrolls to the selected page element
	 * 
	 * @param pElement
	 */
	public void scrollTo(WebElement pElement) {
		LOG.info("Starting scrolling to element ");
		// scroll to element
		Coordinates coordinate = ((Locatable) pElement).getCoordinates();
		coordinate.onPage();
		coordinate.inViewPort();
		LOG.info("Scrolling to element done.");
	}

	/**
	 * Click the selected page element
	 * 
	 * @param pElement
	 */
	public void click(WebElement pElement) {
		LOG.info("Starting clicking element ");
		wait_for_ajax_load();
		// scroll to element
		scrollTo(pElement);
		element(pElement).click();
		wait_for_ajax_load();
		LOG.info("Clicking element done.");
	}

	/**
	 * enter input in the selected input
	 * 
	 * @param pElement
	 * @param keyword
	 *            to enter
	 */
	public void input(WebElement pElement, String keyword) {
		wait_for_ajax_load();
		try {
			LOG.info("click element ");
			element(pElement).click();
		} catch (Exception e) {
		}
		LOG.info("Typing input of element ");
		element(pElement).type(keyword);
		wait_for_ajax_load();
	}

}
