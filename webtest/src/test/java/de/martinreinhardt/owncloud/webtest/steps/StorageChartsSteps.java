/**
 * File: PortalUserSteps.java 27.05.2014, 12:47:13, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.steps;

import static org.hamcrest.MatcherAssert.assertThat;
import net.thucydides.core.annotations.Step;
import net.thucydides.core.pages.Pages;
import de.martinreinhardt.owncloud.webtest.pages.StorageChartsPage;

/**
 * @author mreinhardt
 * 
 */
public class StorageChartsSteps extends PortalUserSteps {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = 1981068809574040987L;

	/**
	 * @param pages
	 */
	public StorageChartsSteps(final Pages pages) {
		super(pages);
	}

	@Step
	public void is_stats_visible() {
		final boolean statsVisible = onStorageChartsPage().isDlChartsDisplayed();
		assertThat("No downloads stats are visible", statsVisible);
	}

	private StorageChartsPage onStorageChartsPage() {
		return getPages().currentPageAt(StorageChartsPage.class);
	}
}
