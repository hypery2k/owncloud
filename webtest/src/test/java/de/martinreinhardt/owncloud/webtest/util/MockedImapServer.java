/**
 * File: MockedImapServer.java 05.06.2014, 09:06:11, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.util;

import static org.junit.Assert.assertTrue;

import java.util.Properties;
import java.util.Scanner;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.icegreen.greenmail.user.GreenMailUser;
import com.icegreen.greenmail.user.UserException;
import com.icegreen.greenmail.util.GreenMail;
import com.icegreen.greenmail.util.ServerSetupTest;

/**
 * @author mreinhardt
 * 
 */
public class MockedImapServer {

	/**
	 * 
	 */
	public static final String TEST_MAIL_SUBJECT = "RoundCube App";

	/**
	 * 
	 */
	public static final String TEST_MAIL_SENDER = "sender@roundcube.owncloud.org";

	public static MimeMessage getMockMessage(final String pPrefix,
			final EmailUserDetails pEmailUserDetails) throws AddressException,
			MessagingException {
		final MimeMessage msg = new MimeMessage((Session) null);
		msg.setSubject(TEST_MAIL_SUBJECT + " " + pPrefix);
		msg.setFrom(new InternetAddress(TEST_MAIL_SENDER));
		String message = "<div style=\"color:red;\">Some text here ..</div>";
		msg.setContent(message, "text/html; charset=utf-8");
		msg.setText("Some text here ...");
		msg.setRecipient(RecipientType.TO, new InternetAddress(
				pEmailUserDetails.getEmail()));
		return msg;
	}

	public static EmailUserDetails getPositiveEmailUserDetailsTest() {
		EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("positive@roundcube.owncloud.org");
		userDtls.setUsername("positive@roundcube.owncloud.org");
		userDtls.setPassword("42");
		return userDtls;
	}

	public static GreenMail initTestServer(final int pNumberOfMessages,
			final EmailUserDetails pEmailUserDetails) throws AddressException,
			MessagingException, UserException {
		GreenMail server = null;
		server = new GreenMail(ServerSetupTest.ALL);
		server.start();

		GreenMailUser user = server.setUser(pEmailUserDetails.getEmail(),
				pEmailUserDetails.getUsername(),
				pEmailUserDetails.getPassword());

		for (int i = 1; i < pNumberOfMessages; i++) {
			MimeMessage msg = getMockMessage(Integer.toString(i),
					pEmailUserDetails);
			user.deliver(msg);
		}
		Properties props = new Properties();
		props.put("mail.store.protocol", "imap");
		props.put("mail.host", "localhost");
		props.put("mail.imap.port", "3143");
		assertTrue(server.getReceivedMessages().length > 0);
		return server;

	}

	public static void main(String[] args) throws AddressException,
			MessagingException, UserException {
		GreenMail server = null;
		try {

			EmailUserDetails userDtls = getPositiveEmailUserDetailsTest();
			server = initTestServer(10, userDtls);

			Scanner scanner = new Scanner(System.in);
			System.out.println("Mocked imap is running.");
			System.out.println("   IMAP Port: 3143");
			System.out.println("   Email:     " + userDtls.getEmail());
			System.out.println("   User:      " + userDtls.getUsername());
			System.out.println("   Password:  " + userDtls.getPassword());
			System.out.println("press <RETURN> when done");
			scanner.nextLine();
			scanner.close();
		} finally {
			if (server != null) {
				server.stop();
			}

		}
	}
}
