/**
 * 
 */
package de.martinreinhardt.owncloud.webtest.tests;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import net.thucydides.core.annotations.Issues;
import net.thucydides.core.annotations.Steps;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.annotations.WithTags;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;
import net.thucydides.junit.annotations.Concurrent;
import net.thucydides.junit.runners.ThucydidesRunner;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import com.icegreen.greenmail.user.UserException;

import de.martinreinhardt.owncloud.webtest.RoundCube;
import de.martinreinhardt.owncloud.webtest.steps.AdminSteps;
import de.martinreinhardt.owncloud.webtest.util.EmailUserDetails;

/**
 * @author mreinhardt
 */
@Story(RoundCube.ManualLogin.class)
//@formatter:off
@WithTags({ 
	@WithTag(type = "app", value = "RoundCube"), 
	@WithTag(type = "Feature", value = "user settings"),
	@WithTag(type = "Feature", value = "login"), 
})
//@formatter:on
@Issues({ "205", "#209", "#213", "#259", "#263" })
@RunWith(ThucydidesRunner.class)
@Concurrent(threads = "1")
public class RoundCubeSettingsIT extends RoundCubeMockedMailIT {

	// Logger
	protected static final Logger LOG = Logger.getLogger(RoundCubeSettingsIT.class);

	@Steps
	private AdminSteps adminSteps;

	@Test
	public void test_roundcube_mail_without_autologin() throws AddressException, MessagingException, UserException,
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
		// manual login as user
		final EmailUserDetails user = getPositiveEmailUserDetailsTest();
		endUserLogin.do_login(user.getUsername(), user.getPassword());
		try {
			loggedInuserSteps.go_to_user_settings();
			loggedInuserSteps.update_roundcube_login_and_save(user.getUsername(), user.getPassword());
			loggedInuserSteps.go_to_roundcube_view();
			rcSteps.is_not_showing_errors();
		} finally {
			loggedInuserSteps.logout();
		}
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
