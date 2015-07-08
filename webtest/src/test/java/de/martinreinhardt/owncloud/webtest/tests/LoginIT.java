/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import net.serenitybdd.junit.runners.SerenityRunner;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.annotations.WithTags;

import org.junit.Test;
import org.junit.runner.RunWith;

import de.martinreinhardt.owncloud.webtest.OwnCloud;
import de.martinreinhardt.owncloud.webtest.util.AbstractUITest;

/**
 * @author mreinhardt
 * 
 */
// @RunWith(ThucydidesParameterizedRunner.class)
@Story(OwnCloud.Login.class)
@WithTags({ 
	@WithTag(type = "testtype", name = "smoke")
})
@RunWith(SerenityRunner.class)
// @UseTestDataFrom("src/test/resources/testdata/testdata_LoginTest_trying_Login_iFrame.csv")
public class LoginIT extends AbstractUITest {

	@Test
	public void test_oc_login() {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("admin", "password");
	}
}
