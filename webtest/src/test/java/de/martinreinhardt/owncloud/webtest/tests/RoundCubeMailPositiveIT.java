/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;
import net.thucydides.junit.runners.ThucydidesRunner;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;

import com.icegreen.greenmail.user.UserException;

import de.martinreinhardt.owncloud.webtest.RoundCube;

/**
 * @author mreinhardt
 * 
 */
@Story(RoundCube.ShowMailView.class)
@WithTag(type = "app", value = "RoundCube")
@RunWith(ThucydidesRunner.class)
public class RoundCubeMailPositiveIT extends RoundCubeMockedMailIT {

	// Logger
	protected static final Logger LOG = Logger.getLogger(RoundCubeMailPositiveIT.class);

	@Test
	public void test_roundcube_mail_without_errors() throws AddressException, MessagingException, UserException,
			TestError {
		runEmailTest();
	}

	public void executeTestStepsFrontend() throws TestError {
		endUserLogin.enter_login_area();
		endUserLogin.do_login(getPositiveEmailUserDetailsTest().getUsername(), getPositiveEmailUserDetailsTest()
				.getPassword());
		loggedInuserSteps.go_to_roundcube_view();
		appSteps.is_not_showing_errors();
		appSteps.message_should_have_a_valid_subject();
		appSteps.waitFor(1).minutes();
		appSteps.is_not_showing_errors();
	}
}
