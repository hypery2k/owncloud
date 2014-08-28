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
import de.martinreinhardt.owncloud.webtest.util.MockedImapServer;

/**
 * @author mreinhardt
 * 
 */
public abstract class RoundCubeMockedMailIT extends MockedImapServer {

	@Steps
	protected LoggedInUserSteps loggedInuserSteps;

	@Steps
	protected RoundCubeSteps appSteps;

	public void runEmailTest() throws AddressException, MessagingException, UserException, TestError {

		GreenMail server = null;
		try {
			server = initTestServer(10);
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

	public abstract void executeTestStepsFrontend() throws TestError;
}
