/**
 * File: PortalUserSteps.java 27.05.2014, 12:47:13, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.steps;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.notNullValue;
import net.thucydides.core.annotations.Step;
import net.thucydides.core.pages.Pages;
import net.thucydides.core.reports.adaptors.xunit.model.TestError;
import de.martinreinhardt.owncloud.webtest.pages.RoundCubePage;
import de.martinreinhardt.owncloud.webtest.util.MockedImapServer;

/**
 * @author mreinhardt
 * 
 */
public class RoundCubeSteps extends PortalUserSteps {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = 1981068809574040987L;

	/**
	 * @param pages
	 */
	public RoundCubeSteps(Pages pages) {
		super(pages);
	}

	@Step
	public void is_showing_errors() throws TestError {
		boolean errorMsgVisible = onWebmailPage().isErrorMessageDisplayed();
		assertThat("There should be an error displayed.", errorMsgVisible);
	}

	@Step
	public void is_not_showing_errors() throws TestError {
		boolean errorMsgVisible = onWebmailPage().isErrorMessageDisplayed();
		assertThat("There should be no error displayed.", !errorMsgVisible);

	}

	@Step
	public boolean is_page_loaded() throws TestError {
		return onWebmailPage().isShowingRcFrame();
	}

	@Step
	public String get_subject_of_first_email() throws TestError {
		return onWebmailPage().getFirstMessageSubject();
	}

	@Step
	public void message_should_have_a_valid_subject() throws TestError {
		String subject = onWebmailPage().getFirstMessageSubject();
		LOG.info("Got the following subject: " + subject);
		assertThat("Subject of first email shouldn't be empty", subject, notNullValue());
		assertThat("Subject of first email should be: " + MockedImapServer.TEST_MAIL_SUBJECT,
				subject.contains(MockedImapServer.TEST_MAIL_SUBJECT));
	}

	private RoundCubePage onWebmailPage() {
		return getPages().currentPageAt(RoundCubePage.class);
	}
}
