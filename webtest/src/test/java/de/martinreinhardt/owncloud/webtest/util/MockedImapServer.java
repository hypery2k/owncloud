/**
 * File: MockedImapServer.java 05.06.2014, 09:06:11, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.util;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.arrayWithSize;

import java.util.Properties;
import java.util.Scanner;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;

import com.icegreen.greenmail.user.GreenMailUser;
import com.icegreen.greenmail.user.UserException;
import com.icegreen.greenmail.util.GreenMail;
import com.icegreen.greenmail.util.ServerSetupTest;

/**
 * @author mreinhardt
 * 
 */
public class MockedImapServer {

	// Logger
	protected static final Logger LOG = Logger.getLogger(MockedImapServer.class);

	/**
	 * 
	 */
	public static final String TEST_MAIL_SUBJECT = "RoundCube App";

	/**
	 * 
	 */
	public static final String TEST_MAIL_SENDER = "sender@roundcube.owncloud.org";

	public static MimeMessage getMockMessage(final String pPrefix, final EmailUserDetails pEmailUserDetails)
			throws AddressException, MessagingException {
		final MimeMessage msg = new MimeMessage((Session) null);
		msg.setSubject(TEST_MAIL_SUBJECT + " " + pPrefix + " " + pEmailUserDetails.getUsername());
		msg.setFrom(new InternetAddress(TEST_MAIL_SENDER));
		final String message = "<div style=\"color:red;\">Some text here ..</div>";
		msg.setContent(message, "text/html; charset=utf-8");
		msg.setText("Some text here ...");
		msg.setRecipient(RecipientType.TO, new InternetAddress(pEmailUserDetails.getEmail()));
		return msg;
	}

	public static EmailUserDetails getPositiveEmailUserWhichIsAOcUser() {
		final EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("positive@roundcube.owncloud.org");
		userDtls.setUsername("positive@roundcube.owncloud.org");
		userDtls.setPassword("42");
		return userDtls;
	}

	public static EmailUserDetails getPositiveEmailUserWhichIsNoOcUser() {
		final EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("positive2@roundcube.owncloud.org");
		userDtls.setUsername("positive2@roundcube.owncloud.org");
		userDtls.setPassword("43");
		return userDtls;
	}

	public static GreenMail initTestServer(final int pNumberOfMessages) throws AddressException, MessagingException,
			UserException {
		final Properties props = new Properties();
		props.put("mail.store.protocol", "imap");
		props.put("mail.host", "localhost");
		props.put("mail.imap.port", "3143");
		// start mocked IMAP
		GreenMail server = null;
		server = new GreenMail(ServerSetupTest.IMAP);
		try {
			server.start();

			final GreenMailUser user = server.setUser(getPositiveEmailUserWhichIsAOcUser().getEmail(),
					getPositiveEmailUserWhichIsAOcUser().getUsername(), getPositiveEmailUserWhichIsAOcUser()
							.getPassword());

			final GreenMailUser user2 = server.setUser(getPositiveEmailUserWhichIsNoOcUser().getEmail(),
					getPositiveEmailUserWhichIsNoOcUser().getUsername(), getPositiveEmailUserWhichIsNoOcUser()
							.getPassword());

			for (int i = 0; i < pNumberOfMessages; i++) {
				final MimeMessage msg = getMockMessage(Integer.toString(i), getPositiveEmailUserWhichIsAOcUser());
				user.deliver(msg);
				user2.deliver(msg);
			}
			assertThat("", server.getReceivedMessages(), arrayWithSize(pNumberOfMessages * 2));
		} catch (Exception e) {
			LOG.error("Error during mock start", e);
		}
		return server;

	}

	public static void main(final String[] args) throws AddressException, MessagingException, UserException {
		GreenMail server = null;
		try {
			final EmailUserDetails userDtls = getPositiveEmailUserWhichIsAOcUser();
			server = initTestServer(10);

			System.out.println("Mocked imap is running.");
			System.out.println("   IMAP Port: 3143");
			System.out.println("   Email:     " + userDtls.getEmail());
			System.out.println("   User:      " + userDtls.getUsername());
			System.out.println("   Password:  " + userDtls.getPassword());
			if (args != null && args.length > 0 && args[0].contains("--silent")) {
				System.out.println("running in silent mode");
				for (;;) {

				}
			} else {
				final Scanner scanner = new Scanner(System.in);
				System.out.println("press <RETURN> when done");
				scanner.nextLine();
				scanner.close();
			}
		} finally {
			if (server != null) {
				server.stop();
			}

		}
	}
}
