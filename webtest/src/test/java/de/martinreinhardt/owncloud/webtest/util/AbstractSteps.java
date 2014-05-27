/**
 * File: AbstractSteps.java 27.05.2014, 12:41:31, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.util;

import net.thucydides.core.pages.Pages;
import net.thucydides.core.steps.ScenarioSteps;

import org.apache.log4j.Logger;

/**
 * @author mreinhardt
 * 
 */
public class AbstractSteps extends ScenarioSteps {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = 8833613353941853393L;

	/**
	 * Logger
	 */
	protected static final Logger LOG = Logger.getLogger(AbstractSteps.class);

	/**
	 * @param pages
	 */
	public AbstractSteps(Pages pages) {
		super(pages);
	}

}
