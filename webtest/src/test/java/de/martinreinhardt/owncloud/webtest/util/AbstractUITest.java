/**
 * File: AbstractUITest.java 27.05.2014, 12:45:57, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.util;

import net.thucydides.core.annotations.Managed;
import net.thucydides.core.annotations.ManagedPages;
import net.thucydides.core.annotations.Steps;
import net.thucydides.core.pages.Pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.WebDriver;

import de.martinreinhardt.owncloud.webtest.steps.LoginEndUserSteps;

/**
 * @author mreinhardt
 * 
 */
public class AbstractUITest {

	// Logger
	protected static final Logger LOG = Logger.getLogger(AbstractUITest.class);

	@Managed(uniqueSession = true)
	public WebDriver webdriver;

	@ManagedPages
	public Pages pages;

	@Steps
	public LoginEndUserSteps endUserLogin;

}
