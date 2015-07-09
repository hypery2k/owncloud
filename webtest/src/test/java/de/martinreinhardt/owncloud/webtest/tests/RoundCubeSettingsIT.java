/**
 * 
 */
package de.martinreinhardt.owncloud.webtest.tests;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import com.icegreen.greenmail.user.UserException;

import de.martinreinhardt.owncloud.webtest.RoundCube;
import de.martinreinhardt.owncloud.webtest.steps.AdminSteps;
import de.martinreinhardt.owncloud.webtest.util.EmailUserDetails;
import net.serenitybdd.junit.runners.SerenityRunner;
import net.thucydides.core.annotations.Issues;
import net.thucydides.core.annotations.Steps;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.annotations.WithTags;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;
import net.thucydides.junit.annotations.Concurrent;

/**
 * @author mreinhardt
 */
@Story(RoundCube.ManualLogin.class)
// @formatter:off
@WithTags({ @WithTag(type = "app", value = "RoundCube"),
		@WithTag(type = "feature", value = "user settings"),
		@WithTag(type = "feature", value = "login") 
})
// @formatter:on
@RunWith(SerenityRunner.class)
@Concurrent(threads = "1")
public class RoundCubeSettingsIT extends RoundCubeMockedMailIT {

	// Logger
	protected static final Logger LOG = Logger
			.getLogger(RoundCubeSettingsIT.class);

	@Steps
	private AdminSteps adminSteps;

	@Test
	@Issues({ "#205", "#209", "#213", "#259", "#263" })
	public void test_roundcube_mail_without_autologin()
			throws AddressException, MessagingException, UserException,
			TestError {
		runEmailTest();
	}

	@Before
	public void setup() {
		// disable autologin
		endUserLogin.enter_login_area();
		endUserLogin.do_login("admin", "password");
		loggedInuserSteps.go_to_adminsettings_view();
		adminSteps.go_to_roundcube_advancedsettings();
		adminSteps.toggle_roundcube_autologin();
		adminSteps.apply_roundcube_settings();
		loggedInuserSteps.logout();
	}

	@Override
	public void executeTestStepsFrontend() throws TestError {
		LOG.info("Starting manual login direct as roundcube user");
		// manual login as user
		final EmailUserDetails ocLogin = getPositiveEmailUserWhichIsAOcUser();
		final EmailUserDetails rcLogin = getPositiveEmailUserWhichIsNoOcUser();
		endUserLogin.do_login(ocLogin.getUsername(), ocLogin.getPassword());
		try {
			loggedInuserSteps.go_to_user_settings();
			loggedInuserSteps.update_roundcube_login_and_save(
					rcLogin.getUsername(), rcLogin.getPassword());
			loggedInuserSteps.logout();
			endUserLogin.do_login(ocLogin.getUsername(), ocLogin.getPassword());
			loggedInuserSteps.go_to_roundcube_view();
			rcSteps.is_not_showing_errors();
			rcSteps.message_should_have_a_valid_subject();
			rcSteps.waitFor(20).seconds();
			rcSteps.is_not_showing_errors();
			loggedInuserSteps.go_to_user_settings();
		} finally {
			loggedInuserSteps.logout();
		}
		LOG.info("Done manual login direct as roundcube user");
	}

	@After
	public void reset() {
		// enable autologin again
		endUserLogin.do_login("admin", "password");
		loggedInuserSteps.go_to_adminsettings_view();
		adminSteps.go_to_roundcube_advancedsettings();
		adminSteps.toggle_roundcube_autologin();
		adminSteps.apply_roundcube_settings();
		loggedInuserSteps.logout();
	}
}
