/**
 * File: LoginPage.java 27.05.2014, 12:33:23, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.pages;


import net.serenitybdd.core.annotations.findby.FindBy;

import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import de.martinreinhardt.owncloud.webtest.util.AbstractPage;

public class StorageChartsPage extends AbstractPage {

	@FindBy(id = "storagecharts2")
	private WebElement chartsDiv;

	public StorageChartsPage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	public boolean isDlChartsDisplayed() {
		boolean loginVisible = false;
		try {
			loginVisible = chartsDiv.isDisplayed();
		} catch (final NoSuchElementException e) {
		}
		return loginVisible;
	}
}
