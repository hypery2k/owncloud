/**
 * File: UITestConstants.java 27.05.2014, 12:33:23, author: mreinhardt
 * 
 * Project: OwnCloud
 *
 * https://www.martinreinhardt-online.de/apps
 */
package de.martinreinhardt.owncloud.webtest.util;

/**
 * Helper class for web tests to wrap up constants, like URLs or timeout
 * 
 * @author mreinhardt
 * 
 */
public class UITestConstants {

	public static final String DEFAULT_URL = "/";

	public String getOwnCloudUrl() {
		// read docker host IP
		final String host = System.getProperty("oc.app.ip") != null ? System.getProperty("oc.ip") + "/owncloud/"
				: "http://127.0.0.1/owncloud/";
		return host;
	}
}
