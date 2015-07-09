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
import net.thucydides.core.reports.adaptors.xunit.model.TestError;

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
@RunWith(SerenityRunner.class)
public class RoundCubeMailNegativeIT extends RoundCubeMockedMailIT {

	@Test
	public void test_roundcube_mail_with_errors() throws AddressException, MessagingException, UserException, TestError {
		runEmailTest();
	}

	@Override
	public void executeTestStepsFrontend() throws TestError {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("negative@roundcube.owncloud.org", "42");
		loggedInuserSteps.go_to_roundcube_view();
		rcSteps.is_showing_errors();
	}
}
