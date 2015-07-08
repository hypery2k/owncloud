/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import net.serenitybdd.junit.runners.SerenityRunner;
import net.thucydides.core.annotations.Issues;
import net.thucydides.core.annotations.Steps;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.annotations.WithTags;

import org.junit.Test;
import org.junit.runner.RunWith;

import de.martinreinhardt.owncloud.webtest.RoundCube;
import de.martinreinhardt.owncloud.webtest.steps.LoggedInUserSteps;
import de.martinreinhardt.owncloud.webtest.util.AbstractUITest;

/**
 * @author mreinhardt
 * 
 */
@Story(RoundCube.Login.class)
//@formatter:off
@WithTags({ 
	@WithTag(type = "app", value = "RoundCube"), 
	@WithTag(type = "Feature", value = "login"), 
})
//@formatter:on
@RunWith(SerenityRunner.class)
public class RoundCubeBasicIT extends AbstractUITest {
	@Steps
	public LoggedInUserSteps loggedIn;

	@Test
	@Issues({ "#202" })
	public void test_iframe_integration() {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("admin", "password");
		loggedIn.go_to_roundcube_view();
	}
}
