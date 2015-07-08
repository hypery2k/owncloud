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

@Story(OwnCloud.Login.class)
@WithTag("Login")
public class LoginPage extends AbstractPage {

	@FindBy(id = "user")
	private WebElement inputUsername;

	@FindBy(id = "password")
	private WebElement inputPassword;

	@FindBy(id = "submit")
	private WebElement submitLogin;

	public LoginPage(final WebDriver pWebDriver) {
		super(pWebDriver);
	}

	public void enter_username(final String keyword) {
		input(inputUsername, keyword);
	}

	public void enter_password(final String keyword) {
		input(inputPassword, keyword);
	}

	public boolean login_form_visible() {
		return inputUsername.isDisplayed() && inputPassword.isDisplayed() && submitLogin.isDisplayed();
	}

	public void do_login() {
		click(submitLogin);
	}
}
