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

import net.serenitybdd.junit.runners.SerenityRunner;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.annotations.WithTags;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;

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
@WithTags({ 
	@WithTag(type = "app", value = "RoundCube"),
    @WithTag(type = "testtype", name = "smoke")
})
@RunWith(SerenityRunner.class)
public class RoundCubeMailPositiveIT extends RoundCubeMockedMailIT {

	// Logger
	protected static final Logger LOG = Logger.getLogger(RoundCubeMailPositiveIT.class);

	@Test
	public void test_roundcube_mail_without_errors() throws AddressException, MessagingException, UserException,
			TestError {
		runEmailTest();
	}

	@Override
	public void executeTestStepsFrontend() throws TestError {
		endUserLogin.enter_login_area();
		endUserLogin.do_login(//@formatter:off
				getPositiveEmailUserWhichIsAOcUser().getUsername(), 
				getPositiveEmailUserWhichIsAOcUser().getPassword());//@formatter:on
		loggedInuserSteps.go_to_roundcube_view();
		rcSteps.is_not_showing_errors();
		rcSteps.message_should_have_a_valid_subject();
		rcSteps.is_not_showing_errors();
	}
}
