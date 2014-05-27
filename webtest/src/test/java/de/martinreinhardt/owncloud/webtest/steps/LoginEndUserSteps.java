/**
 * File: LoginEndUserSteps.java 27.05.2014, 12:42:39, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.steps;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.annotations.StepGroup;
import net.thucydides.core.pages.Pages;
import de.martinreinhardt.owncloud.webtest.pages.LoginPage;

/**
 * @author mreinhardt
 * 
 */
public class LoginEndUserSteps extends PortalUserSteps {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = 1000463057264545156L;

	private String username;

	private String password;

	/**
	 * @param pages
	 */
	public LoginEndUserSteps(Pages pages) {
		super(pages);
	}

	// PAGE STEPS

	@StepGroup
	public void enter_login_details() {
		enter_name(username);
		enter_password(password);
		login();
	}

	@StepGroup
	public void do_login(String pUsername, String pPassword) {
		enter_name(pUsername);
		enter_password(pPassword);
		login();
	}

	@Step
	public void enter_name(String username) {
		onLoginPage().enter_username(username);
	}

	@Step
	public void enter_password(String password) {
		onLoginPage().enter_password(password);
	}

	@Step
	public void login() {
		onLoginPage().do_login();
	}

	private LoginPage onLoginPage() {
		return getPages().currentPageAt(LoginPage.class);
	}

	// GETTER AND SETTER

	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @param username
	 *            the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

}
