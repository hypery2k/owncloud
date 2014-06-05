/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

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
import de.martinreinhardt.owncloud.webtest.util.MockedImapServer;

/**
 * @author mreinhardt
 * 
 */
@Story(RoundCube.RefreshSession.class)
@WithTag(type = "app", value = "RoundCube")
@RunWith(ThucydidesRunner.class)
public class RoundCubeRefreshIT extends RoundCubeMockedMailIT {

	public EmailUserDetails getEmailUserDetailsTest() {
		EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("positive@roundcube.owncloud.org");
		userDtls.setUsername("positive@roundcube.owncloud.org");
		userDtls.setPassword("42");
		return userDtls;
	}

	@Test
	public void test_roundcube_mail_refresh() throws AddressException,
			MessagingException, UserException, TestError {
		runEmailTest();
	}

	/**
	 * Check if roundcube session get's refreshed
	 */
	public void executeTestStepsFrontend() throws TestError {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("positive@roundcube.owncloud.org", "42");
		loggedInuserSteps.go_to_roundcube_view();
		assertFalse("There should be no error displayed.",
				appSteps.is_showing_errors());
		String subjectFirst = appSteps.get_subject_of_first_email();
		LOG.info("Got the following subject: " + subjectFirst);
		assertNotNull("Subject of first email shouldn't be empty", subjectFirst);
		assertTrue("Subject of first email should be: " + MockedImapServer.TEST_MAIL_SUBJECT,
				subjectFirst.equalsIgnoreCase(MockedImapServer.TEST_MAIL_SUBJECT));
		appSteps.waitFor(6).minutes();
		assertFalse("There should be no error displayed.",
				appSteps.is_showing_errors());
		String subjectAfterWait = appSteps.get_subject_of_first_email();
		LOG.info("Got the following subject: " + subjectAfterWait);
		assertNotNull("Subject of first email shouldn't be empty",
				subjectAfterWait);
		assertTrue("Subject of first email should be: " + MockedImapServer.TEST_MAIL_SUBJECT,
				subjectAfterWait.equalsIgnoreCase(MockedImapServer.TEST_MAIL_SUBJECT));

	}
}
