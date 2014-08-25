/**
 * 
 */
package de.martinreinhardt.owncloud.webtest.tests;

import static org.hamcrest.MatcherAssert.assertThat;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import net.thucydides.core.annotations.Steps;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;
import net.thucydides.junit.runners.ThucydidesRunner;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;

import com.icegreen.greenmail.user.UserException;

import de.martinreinhardt.owncloud.webtest.RoundCube;
import de.martinreinhardt.owncloud.webtest.steps.AdminSteps;
import de.martinreinhardt.owncloud.webtest.util.EmailUserDetails;

/**
 * @author mreinhardt
 * 
 */
@Story(RoundCube.AutoLogin.class)
@WithTag(type = "app", value = "RoundCube")
@RunWith(ThucydidesRunner.class)
public class RoundCubeSettingsIT extends RoundCubeMockedMailIT {

	// Logger
	protected static final Logger LOG = Logger
			.getLogger(RoundCubeSettingsIT.class);

	@Steps
	private AdminSteps adminSteps;

	public EmailUserDetails getEmailUserDetailsTest() {
		EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("positive@roundcube.owncloud.org");
		userDtls.setUsername("positive@roundcube.owncloud.org");
		userDtls.setPassword("42");
		return userDtls;
	}

	@Test
	public void test_roundcube_mail_without_autologin()
			throws AddressException, MessagingException, UserException,
			TestError {
		runEmailTest();
	}

	public void executeTestStepsFrontend() throws TestError {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("admin", "password");
		loggedInuserSteps.go_to_adminsettings_view();
		adminSteps.go_to_roundcube_advancedsettings();
		adminSteps.toggle_roundcube_autologin();
		adminSteps.apply_roundcube_settings();
		loggedInuserSteps.logout();
		// TODO add user login steps

		endUserLogin.do_login(getEmailUserDetailsTest().getUsername(),
				getEmailUserDetailsTest().getPassword());
		loggedInuserSteps.go_to_roundcube_view();
		assertThat("There should be an error displayed.",
				appSteps.is_showing_errors());

		// clear
		endUserLogin.do_login("admin", "password");
		loggedInuserSteps.go_to_adminsettings_view();
		adminSteps.go_to_roundcube_advancedsettings();
		adminSteps.toggle_roundcube_autologin();
		adminSteps.apply_roundcube_settings();
		loggedInuserSteps.logout();
	}
}
