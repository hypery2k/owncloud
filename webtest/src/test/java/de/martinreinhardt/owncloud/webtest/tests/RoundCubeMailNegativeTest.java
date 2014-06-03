/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import static org.junit.Assert.assertTrue;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import net.thucydides.core.annotations.Story;
import net.thucydides.junit.annotations.Concurrent;
import net.thucydides.junit.runners.ThucydidesRunner;

import org.junit.Test;
import org.junit.runner.RunWith;

import com.icegreen.greenmail.user.UserException;

import de.martinreinhardt.owncloud.webtest.RoundCube;
import de.martinreinhardt.owncloud.webtest.util.EmailUserDetails;

/**
 * @author mreinhardt
 * 
 */
@Story(RoundCube.Login.class)
@RunWith(ThucydidesRunner.class)
@Concurrent
public class RoundCubeMailNegativeTest extends RoundCubeMockedMailTest {

	public EmailUserDetails getEmailUserDetailsTest() {
		EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("negative@roundcube.owncloud.org");
		userDtls.setUsername("negative");
		userDtls.setPassword("42");
		return userDtls;
	}

	@Test
	public void test_roundcube_mail_with_errors() throws AddressException,
			MessagingException, UserException {
		runEmailTest();
	}

	public void executeTestStepsFrontend() {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("negative@roundcube.owncloud.org", "42");
		loggedInuserSteps.go_to_roundcube_view();
		assertTrue("There should be error displayed.",
				appSteps.is_showing_errors());
	}
}
