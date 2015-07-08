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
import net.thucydides.core.annotations.Issues;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.annotations.WithTags;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;

import org.junit.Test;
import org.junit.runner.RunWith;

import com.icegreen.greenmail.user.UserException;

import de.martinreinhardt.owncloud.webtest.RoundCube;
import de.martinreinhardt.owncloud.webtest.util.EmailUserDetails;

/**
 * @author mreinhardt
 * 
 */
@Story(RoundCube.RefreshSession.class)
//@formatter:off
@WithTags({ 
	@WithTag(type = "app", value = "RoundCube"), 
	@WithTag(type = "Feature", value = "session refresh"),
	@WithTag(type = "Feature", value = "login"), 
})
//@formatter:on
@WithTag(type = "app", value = "RoundCube")
@RunWith(SerenityRunner.class)
public class RoundCubeRefreshIT extends RoundCubeMockedMailIT {

	@Test
	@Issues({ "#228", "#230", "#230", "#237", "#247", "#251" })
	public void test_roundcube_mail_refresh() throws AddressException, MessagingException, UserException, TestError {
		runEmailTest();
	}

	/**
	 * Check if roundcube session get's refreshed
	 */
	@Override
	public void executeTestStepsFrontend() throws TestError {
		endUserLogin.enter_login_area();
		final EmailUserDetails user = getPositiveEmailUserWhichIsAOcUser();
		endUserLogin.do_login(user.getUsername(), user.getPassword());
		loggedInuserSteps.go_to_roundcube_view();
		rcSteps.is_not_showing_errors();
		rcSteps.message_should_have_a_valid_subject();
		rcSteps.wait_on_app_page(6);
		rcSteps.is_not_showing_errors();
		rcSteps.message_should_have_a_valid_subject();

	}
}
