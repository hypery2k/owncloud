/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import net.serenitybdd.junit.runners.SerenityRunner;
import net.thucydides.core.annotations.Steps;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.core.annotations.WithTags;

import org.junit.Test;
import org.junit.runner.RunWith;

import de.martinreinhardt.owncloud.webtest.StorageCharts;
import de.martinreinhardt.owncloud.webtest.steps.LoggedInUserSteps;
import de.martinreinhardt.owncloud.webtest.steps.StorageChartsSteps;
import de.martinreinhardt.owncloud.webtest.util.AbstractUITest;

/**
 * @author mreinhardt
 * 
 */
@Story(StorageCharts.ViewStats.class)
//@formatter:off
@WithTags({ 
	@WithTag(type = "app", value = "StorageCharts"), 
	@WithTag(type = "feature", value = "use high charts"),
	@WithTag(type = "feature", value = "display stats"), 
	@WithTag(type = "testtype", name = "smoke")
})
//@formatter:on
@RunWith(SerenityRunner.class)
public class StorageChartsBasicIT extends AbstractUITest {

	@Steps
	public LoggedInUserSteps loggedIn;

	@Steps
	public StorageChartsSteps dlSteps;

	@Test	
	public void view_download_charts() {
		endUserLogin.enter_login_area();
		endUserLogin.do_login("admin", "password");
		loggedIn.go_to_storagecharts_view();
		dlSteps.is_stats_visible();
	}
}
