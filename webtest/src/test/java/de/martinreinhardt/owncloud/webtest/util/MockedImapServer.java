/**
 * File: MockedImapServer.java 05.06.2014, 09:06:11, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.util;

import static org.junit.Assert.assertEquals;

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

	public static EmailUserDetails getEmailUserDetailsTest() {
		EmailUserDetails userDtls = new EmailUserDetails();
		userDtls.setEmail("positive@roundcube.owncloud.org");
		userDtls.setUsername("positive@roundcube.owncloud.org");
		userDtls.setPassword("42");
		return userDtls;
	}

	public static void main(String[] args) throws AddressException,
			MessagingException, UserException {
		GreenMail server = null;
		try {
			server = new GreenMail(ServerSetupTest.ALL);
			server.start();

			EmailUserDetails userDtls = getEmailUserDetailsTest();

			final MimeMessage msg = new MimeMessage((Session) null);
			msg.setSubject("TEST"); // msg.setFrom("from@sender.com");
									// msg.setText("Some text here ...");
			msg.setRecipient(RecipientType.TO,
					new InternetAddress(userDtls.getEmail()));
			Properties props = new Properties();
			props.put("mail.store.protocol", "imap");
			props.put("mail.host", "localhost");
			props.put("mail.imap.port", "3143");

			GreenMailUser user = server.setUser(userDtls.getEmail(),
					userDtls.getUsername(), userDtls.getPassword());
			user.deliver(msg);
			assertEquals(1, server.getReceivedMessages().length);

			Scanner scanner = new Scanner(System.in);
			System.out.println("Mocked imap is running.");
			System.out.println("   IMAP Port: 3143");
			System.out.println("   Email:     "+userDtls.getEmail());
			System.out.println("   User:      "+userDtls.getUsername());
			System.out.println("   Password:  "+userDtls.getPassword());
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
