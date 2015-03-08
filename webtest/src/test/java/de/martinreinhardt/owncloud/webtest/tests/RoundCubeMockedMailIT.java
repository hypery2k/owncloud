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

import net.thucydides.core.annotations.Steps;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;

import com.icegreen.greenmail.user.UserException;
import com.icegreen.greenmail.util.GreenMail;

import de.martinreinhardt.owncloud.webtest.steps.LoggedInUserSteps;
import de.martinreinhardt.owncloud.webtest.steps.RoundCubeSteps;
import de.martinreinhardt.owncloud.webtest.util.AbstractUITest;
import de.martinreinhardt.owncloud.webtest.util.EmailUserDetails;
import de.martinreinhardt.owncloud.webtest.util.MockedImapServer;

/**
 * @author mreinhardt
 * 
 */
public abstract class RoundCubeMockedMailIT extends AbstractUITest {

	@Steps
	protected LoggedInUserSteps loggedInuserSteps;

	@Steps
	protected RoundCubeSteps rcSteps;

	public void runEmailTest() throws AddressException, MessagingException, UserException, TestError {

		GreenMail server = null;
		try {
			server = MockedImapServer.initTestServer(10);
			executeTestStepsFrontend();
		} finally {
			if (server != null) {
				try {
					server.stop();
				} catch (Exception e) {
				}
			}
		}
	}

	public static EmailUserDetails getPositiveEmailUserWhichIsAOcUser() {
		return MockedImapServer.getPositiveEmailUserWhichIsAOcUser();
	}

	public static EmailUserDetails getPositiveEmailUserWhichIsNoOcUser() {
		return MockedImapServer.getPositiveEmailUserWhichIsNoOcUser();
	}

	public abstract void executeTestStepsFrontend() throws TestError;
}
