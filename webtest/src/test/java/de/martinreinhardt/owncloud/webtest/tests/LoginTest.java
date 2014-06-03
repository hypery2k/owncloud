/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import net.thucydides.core.annotations.Story;
import net.thucydides.junit.annotations.Concurrent;
import net.thucydides.junit.runners.ThucydidesRunner;

import org.junit.Test;
import org.junit.runner.RunWith;

import de.martinreinhardt.owncloud.webtest.OwnCloud;
import de.martinreinhardt.owncloud.webtest.RoundCube;
import de.martinreinhardt.owncloud.webtest.util.AbstractUITest;

/**
 * @author mreinhardt
 * 
 */
// @RunWith(ThucydidesParameterizedRunner.class)
@Story(OwnCloud.Login.class)
@RunWith(ThucydidesRunner.class)
// @UseTestDataFrom("src/test/resources/testdata/testdata_LoginTest_trying_Login_iFrame.csv")
@Concurrent
public class LoginTest extends AbstractUITest {

	@Test
	public void trying_Login() {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("admin", "password");
	}
}
