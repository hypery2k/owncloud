/**
 * File: PortalUserSteps.java 27.05.2014, 12:47:13, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.steps;

import net.thucydides.core.pages.Pages;
import de.martinreinhardt.owncloud.webtest.pages.RoundCubePage;

/**
 * @author mreinhardt
 * 
 */
public class RoundCubeSteps extends PortalUserSteps {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = 1981068809574040987L;

	/**
	 * @param pages
	 */
	public RoundCubeSteps(Pages pages) {
		super(pages);
	}

	public boolean is_showing_errors() {
		return onWebmailPage().isErrorMessageDisplayed();
	}

	private RoundCubePage onWebmailPage() {
		return getPages().currentPageAt(RoundCubePage.class);
	}
}
