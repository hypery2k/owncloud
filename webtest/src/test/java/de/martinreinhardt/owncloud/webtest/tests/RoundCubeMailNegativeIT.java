/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;


import static org.hamcrest.MatcherAssert.assertThat;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;
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
@Story(RoundCube.ShowMailView.class)
@WithTag(type = "app", value = "RoundCube")
@RunWith(ThucydidesRunner.class)
public class RoundCubeMailNegativeIT extends RoundCubeMockedMailIT {

	public EmailUserDetails getEmailUserDetailsTest() {
		EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("negative@roundcube.owncloud.org");
		userDtls.setUsername("negative");
		userDtls.setPassword("42");
		return userDtls;
	}

	@Test
	public void test_roundcube_mail_with_errors() throws AddressException,
			MessagingException, UserException, TestError {
		runEmailTest();
	}

	public void executeTestStepsFrontend() throws TestError {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("negative@roundcube.owncloud.org", "42");
		loggedInuserSteps.go_to_roundcube_view();
		assertThat("There should be an error displayed.",
				appSteps.is_showing_errors());
		appSteps.waitFor(1).minutes();
	}
}
