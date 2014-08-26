/**
 * 
 */
package de.martinreinhardt.owncloud.webtest.tests;

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
	protected static final Logger LOG = Logger.getLogger(RoundCubeSettingsIT.class);

	@Steps
	private AdminSteps adminSteps;

	@Test
	public void test_roundcube_mail_without_autologin() throws AddressException, MessagingException, UserException,
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
		EmailUserDetails user = getPositiveEmailUserDetailsTest();
		endUserLogin.do_login(user.getUsername(), user.getPassword());
		// TODO add user login steps
		loggedInuserSteps.go_to_roundcube_view();
		appSteps.is_showing_errors();
		loggedInuserSteps.logout();

		// clear
		endUserLogin.do_login("admin", "password");
		loggedInuserSteps.go_to_adminsettings_view();
		adminSteps.go_to_roundcube_advancedsettings();
		adminSteps.toggle_roundcube_autologin();
		adminSteps.apply_roundcube_settings();
		loggedInuserSteps.logout();
	}
}
