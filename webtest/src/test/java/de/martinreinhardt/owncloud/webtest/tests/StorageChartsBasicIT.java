/**
 * File: LoginTest.java 27.05.2014, 12:44:50, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.tests;

import static org.junit.Assert.assertTrue;
import net.thucydides.core.annotations.Steps;
import net.thucydides.core.annotations.Story;
import net.thucydides.core.annotations.WithTag;
import net.thucydides.junit.runners.ThucydidesRunner;

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
@WithTag(type = "app", value = "StorageCharts")
@RunWith(ThucydidesRunner.class)
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
		assertTrue("No downloads stats are visible", dlSteps.is_stats_visible());
	}
}
