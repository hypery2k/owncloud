/**
 * 
 */
package de.martinreinhardt.owncloud.webtest.tests;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import net.thucydides.core.annotations.Steps;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.icegreen.greenmail.user.UserException;

import de.martinreinhardt.owncloud.webtest.steps.AdminSteps;
import de.martinreinhardt.owncloud.webtest.util.EmailUserDetails;
import de.martinreinhardt.owncloud.webtest.util.MockedImapServer;

/**
 * @author mreinhardt
 * 
 */
public class RoundCubeSettingsIT extends RoundCubeMockedMailIT {

	// Logger
	protected static final Logger LOG = Logger
			.getLogger(RoundCubeMailPositiveIT.class);

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
	public void test_roundcube_mail_without_autologin() throws AddressException,
			MessagingException, UserException, TestError {
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
	}
}
