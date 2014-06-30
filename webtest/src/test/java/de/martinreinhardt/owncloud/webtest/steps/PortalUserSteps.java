/**
 * File: PortalUserSteps.java 27.05.2014, 12:47:13, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.steps;

import net.thucydides.core.annotations.Step;
import net.thucydides.core.pages.Pages;
import de.martinreinhardt.owncloud.webtest.pages.LoginPage;
import de.martinreinhardt.owncloud.webtest.pages.PortalPage;
import de.martinreinhardt.owncloud.webtest.util.AbstractSteps;

/**
 * @author mreinhardt
 * 
 */
public class PortalUserSteps extends AbstractSteps {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = 1981068809574040987L;

	/**
	 * @param pages
	 */
	public PortalUserSteps(Pages pages) {
		super(pages);
	}

	@Step
	public void enter_login_area() {
		// TODO back always
		// onPortalPage().go_to_login_page();
		// onLoginPage().
	}

	private LoginPage onLoginPage() {
		return getPages().currentPageAt(LoginPage.class);
	}
}
