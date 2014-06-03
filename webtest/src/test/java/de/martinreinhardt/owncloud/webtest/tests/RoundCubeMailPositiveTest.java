/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import net.thucydides.junit.annotations.Concurrent;
import net.thucydides.junit.runners.ThucydidesRunner;

import org.junit.Test;
import org.junit.runner.RunWith;

import de.martinreinhardt.owncloud.webtest.util.EmailUserDetails;

/**
 * @author mreinhardt
 * 
 */
@RunWith(ThucydidesRunner.class)
@Concurrent
public class RoundCubeMailPositiveTest extends RoundCubeMockedMailTest {

	public EmailUserDetails getEmailUserDetailsTest() {
		EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("positive@roundcube.owncloud.org");
		userDtls.setUsername("positive@roundcube.owncloud.org");
		userDtls.setPassword("42");
		return userDtls;
	}

	@Test
	public void view_download_charts() {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("positive@roundcube.owncloud.org", "42");
		loggedInuserSteps.go_to_roundcube_view();
	}
}
