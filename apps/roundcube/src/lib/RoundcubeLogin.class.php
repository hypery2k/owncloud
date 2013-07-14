<?php

/**
 * Use a PHP script to perform a login to the Roundcube mail system.
 *
 * @author Martin Reinhardt and David Jaedke and Philipp Heckel
 * @copyright 2012 Martin Reinhardt contact@martinreinhardt-online.de
 *
 * SCRIPT VERSION
 *   Version 3 (April 2012)
 *
 * REQUIREMENTS
 *   - A Roundcube installation (tested with 0.7.2)
 *    (older versions work with 0.2-beta, 0.3.x, 0.4-beta, 0.5, 0.5.1)
 *
 *   - Set the "check_ip"/"ip_check" in the config/main.inc.php file to FALSE
 *     Why? The server will perform the login, not the client (= two different IP addresses)
 *
 * INSTALLATION
 *   - Install RC on your server so that it can be accessed via the browser,
 *     e.g. at www.example.com/roundcube/
 *
 *   - Download this script and remove all spaces and new lines
 *     before "<?php" and after "?>"
 *
 *   - Include the class in your very own script and use it.
 *
 * USAGE
 *   The class provides four public methods:
 *
 *   - login($username, $password)
 *         Perform a login to the Roundcube mail system.
 *
 *         Note: If the client is already logged in, the script will re-login the user (logout/login).
 *               To prevent this behaviour, use the isLoggedIn()-function.
 *
 *         Returns: TRUE if the login suceeds, FALSE if the user/pass-combination is wrong
 *         Throws:  May throw a RoundcubeLoginException if Roundcube sends an unexpected answer
 *                  (that might happen if a new Roundcube version behaves different).
 *
 *   - isLoggedIn()
 *         Checks whether the client/browser is logged in and has a valid Roundcube session.
 *
 *         Returns: TRUE if the user is logged in, FALSE otherwise.
 *         Throws:  May also throw a RoundcubeLoginException (see above).
 *
 *   - logout()
 *         Performs a logout on the current Roundcube session.
 *
 *         Returns: TRUE if the logout was a success, FALSE otherwise.
 *         Throws:  May also throw a RoundcubeLoginException (see above).
 *
 *   - redirect()
 *         Simply redirects to Roundcube.
 *
 * SAMPLE CODE
 *   <?php
 *
 *       include "RoundcubeLogin.class.php";
 *
 *       // Create login object and enable debugging
 *       $rcl = new RoundcubeLogin("/roundcube/", true);
 *
 *       try {
 *           // If we are already logged in, simply redirect
 *           if ($rcl->isLoggedIn())
 *               $rcl->redirect();
 *
 *           // If not, try to login and simply redirect on success
 *           $rcl->login("your-email-address", "plain-text-password");
 *
 *           if ($rcl->isLoggedIn())
 *               $rcl->redirect();
 *
 *           // If the login fails, display an error message
 *           die("ERROR: Login failed due to a wrong user/pass combination.");
 *       }
 *       catch (RoundcubeLoginException $ex) {
 *           echo "ERROR: Technical problem, ".$ex->getMessage();
 *           $rcl->dumpDebugStack(); exit;
 *       }
 *
 *

 ?>
 *
 * TROUBLESHOOTING
 *   - Make sure to remove all spaces before "<?php" and after "?>"
 *   - Enable the debug mode (set the second constructor parameter to TRUE)
 *   - Ask me if you have any problems :-)
 *
 * AUTHOR/LICENSE/VERSION
 *   - Written by Philipp Heckel; Find a corresponding blog-post at
 *     http://blog.philippheckel.com/2008/05/16/roundcube-login-via-php-script/
 *
 *   - Updated April 2012, tested with Ubuntu/Firefox 3
 *     No license. Feel free to use it :-)
 *
 *   - The updated script has been tested with Roundcube 0.7.2.
 *     Older versions of the script work with Roundcube 0.2, 0.3, 0.4-beta
 *     and 0.5.1 (see blog post above)
 *
 */
class RoundcubeLogin {
	/**
	 * Relative path to the Roundcube base directory on the server.
	 *
	 * Can be set via the first argument in the constructor.
	 * If the URL is www.example.com/roundcube/, set it to "/roundcube/".
	 *
	 * @var string
	 */
	private $rcPath;

	/**
	 * DNS name of the rouncube server
	 *
	 * Can be set via the first argument in the constructor.
	 * If the URL is www.example.com/roundcube/, set it to "www.example.com".
	 *
	 * @var string
	 */
	private $rcHost;

	/**
	 * Roundcube session ID
	 *
	 * RC sends its session ID in the answer. If the first attempt doesn't
	 * work, the login-function retries it with the session ID. This does
	 * work most of the times.
	 *
	 * @var string
	 */
	private $rcSessionID;

	/**
	 * No idea what this is ...
	 */
	private $rcSessionAuth;

	/**
	 * Save the current status of the Roundcube session.
	 * 0 = unkown, 1 = logged in, -1 = not logged in.
	 *
	 * @var int
	 */
	private $rcLoginStatus;

	/**
	 * Save the number of logins
	 *
	 * @var int
	 */
	private $rcLoginCount;

	/**
	 * Roundcube 0.5.1 adds a request token for 'security'. This variable
	 * saves the last token and sends it with login and logout requests.
	 *
	 * @var string
	 */
	private $lastToken;

	/**
	 * Debugging can be enabled by setting the second argument
	 * in the constructor to TRUE.
	 *
	 * @var bool
	 */
	private $debugEnabled;

	/**
	 * Keep debug messages on a stack. To dump it, call
	 * the dumpDebugStack()-function.
	 *
	 * @var array
	 */
	private $debugStack;

	/**
	 * Create a new RoundcubeLogin class.
	 *
	 * @param string Relative webserver path to the RC installation, e.g. /roundcube/
	 * @param bool Enable debugging, - shows the full POST and the response
	 */
	public function __construct($webmailPath, $enableDebug = false) {
		$this -> debugStack = array();
		// failback to local host
		$this -> rcHost = OC_Request::serverHost();
		$this -> debugEnabled = $enableDebug;

		$this -> rcPath = $webmailPath;
		$this -> rcSessionID = true;
		$this -> rcSessionAuth = true;
		$this -> rcLoginStatus = 0;
		$this -> addDebug("Creating new RoundCubeLogin instance:", "rcHost:" . $this -> rcHost . "rcPath:" . $this -> rcPath);
	}

	/**
	 * Login to Roundcube using the IMAP username/password
	 *
	 * Note: If the function detects that we're already logged in,
	 *       it performs a re-login, i.e. a logout/login-combination to ensure
	 *       that the specified user is logged in.
	 *
	 *       If you don't want this, use the isLoggedIn()-function and redirect
	 *       the RC without calling login().
	 *
	 * @param string IMAP username
	 * @param string IMAP password (plain text)
	 * @return boolean Returns TRUE if the login was successful, FALSE otherwise
	 * @throws RoundcubeLoginException
	 */
	public function login($username, $password) {
		$this -> updateLoginStatus();

		// If already logged in, perform a re-login (logout first)
		if ($this -> isLoggedIn())
			$this -> logout();

		// Try login
		$data = (($this -> lastToken) ? "_token=" . $this -> lastToken . "&" : "") . "_task=login&_action=login&_timezone=1&_dstactive=1&_url=&_user=" . urlencode($username) . "&_pass=" . urlencode($password);

		$response = $this -> sendRequest($this -> rcPath, $data);

		//  Login successful! A redirection to ./?_task=... is a success!
		if (preg_match('/^Location\:.+_task=/mi', $response)) {
			$this -> addDebug("LOGIN SUCCESSFUL", "RC sent a redirection to ./?_task=..., that means we did it!");
			$this -> rcLoginStatus = 1;
		}

		// Login failure detected! If the login failed, RC sends the cookie "sessauth=-del-"
		else if (preg_match('/^Set-Cookie:.+sessauth=-del-;/mi', $response)) {
			header($line, false);

			$this -> addDebug("LOGIN FAILED", "RC sent 'sessauth=-del-'; User/Pass combination wrong.");
			$this -> rcLoginStatus = -1;
		}

		// Unkown, neither failure nor success.
		// This maybe the case if no session ID was sent
		else {
			$this -> addDebug("LOGIN STATUS UNKNOWN", "Neither failure nor success. This maybe the case if no session ID was sent");
			throw new RoundcubeLoginException("Unable to determine login-status due to technical problems.");
		}

		return $this -> isLoggedIn();
	}

	/**
	 * Returns whether there is an active Roundcube session.
	 *
	 * @return bool Return TRUE if a user is logged in, FALSE otherwise
	 * @throws RoundcubeLoginException
	 */
	public function isLoggedIn() {
		$this -> updateLoginStatus();

		if (!$this -> rcLoginStatus)
			throw new RoundcubeLoginException("Unable to determine login-status due to technical problems.");

		return ($this -> rcLoginStatus > 0) ? true : false;
	}

	/**
	 * Logout from Roundcube
	 * @return bool Returns TRUE if the login was successful, FALSE otherwise
	 */
	public function logout() {
		$data = (($this -> lastToken) ? "_token=" . $this -> lastToken . "&" : "") . "_action=logout&_task=logout";

		$this -> sendRequest($this -> rcPath, $data);

		return !$this -> isLoggedIn();
	}

	/**
	 * Simply redirect to the Roundcube application.
	 */
	public function redirect() {
		header("Location: {$this->rcPath}");
		exit ;
	}

	public function getRedirectPath() {
		# Prevent index error because "There is no guarantee that every web
		# server will provide any of these; servers may omit some, or provide
		# others not listed here."
		# (http://www.php.net/manual/en/reserved.variables.server.php)
		$port = (isset($_SERVER['HTTPS']) && $_SERVER["HTTPS"] || isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') ? 443 : 80;
		$protocol = (($port == 443) ? "https://" : "http://");
		$path = $protocol . rtrim($this -> rcHost, "/") . "/" . ltrim($this -> rcPath, "/");
		return $path;
	}

	/**
	 * Gets the current login status and the session cookie.
	 *
	 * It updates the private variables rcSessionID and rcLoginStatus by
	 * sending a request to the main page and parsing the result for the login form.
	 */
	private function updateLoginStatus($forceUpdate = false) {
		if ($this -> rcSessionID && $this -> rcLoginStatus && !$forceUpdate)
			return;

		// Get current session ID cookie
		if ($_COOKIE['roundcube_sessid'])
			$this -> rcSessionID = $_COOKIE['roundcube_sessid'];

		if ($_COOKIE['roundcube_sessauth'])
			$this -> rcSessionAuth = $_COOKIE['roundcube_sessauth'];

		// Send request and maybe receive new session ID
		$response = $this -> sendRequest($this -> rcPath);

		// Request token (since Roundcube 0.5.1)
		if (preg_match('/"request_token":"([^"]+)",/mi', $response, $m))
			$this -> lastToken = $m[1];

		if (preg_match('/
<input.+name="_token".+value="([^"]+)"/mi', $response, $m))
			$this -> lastToken = $m[1];
		// override previous token (if this one exists!)

		// Login form available?
		if (preg_match('/<input.+name="_pass"/mi', $response)) {
			$this -> addDebug("NOT LOGGED IN", "Detected that we're NOT logged in.");
			$this -> rcLoginStatus = -1;
		} else if (preg_match('/<div.+id="message"/mi', $response)) {
			$this -> addDebug("LOGGED IN", "Detected that we're logged in.");
			$this -> rcLoginStatus = 1;
		} else {
			$this -> addDebug("UNKNOWN LOGIN STATE", "Unable to determine the login status. Did you change the RC version?");
			throw new RoundcubeLoginException("Unable to determine the login status. Unable to continue due to technical problems.");
		}

		// If no session ID is available now, throw an exception
		if (!$this -> rcSessionID) {
			$this -> addDebug("NO SESSION ID", "No session ID received. RC version changed?");
			throw new RoundcubeLoginException("No session ID received. Unable to continue due to technical problems.");
		}
	}

	/**
	 * Send a POST/GET request to the Roundcube login-script
	 * to simulate the login.
	 *
	 * If the second parameter $postData is set, the function will
	 * use the POST method, otherwise a GET will be sent.
	 *
	 * Ensures that all cookies are sent and parses all response headers
	 * for a new Roundcube session ID. If a new SID is found, rcSessionId is set.
	 *
	 * @param string Optional POST data in urlencoded form (param1=value1&...)
	 * @return string Returns the complete request response with all headers.
	 */
	private function sendRequest($path, $postData = false) {
		$method = (!$postData) ? "GET" : "POST";
		$port = (isset($_SERVER['HTTPS']) && $_SERVER["HTTPS"] || isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') ? 443 : 80;
		$url = "/" . $path . "/";
		// fix for issue #60, see https://github.com/hypery2k/owncloud/issues/60
		$protocol = "HTTP/1.1";
		$host = (($port == 443) ? "ssl://" : "") . $this -> rcHost;

		$this -> addDebug('Trying to connect via "' . $method . '" on port "' . $port . '" to URL "' . $url . '" on host"' . $host . '"');

		// Load cookies and save them in a key/value array
		$cookies = array();

		foreach ($_COOKIE as $name => $value)
			$cookies[] = "$name=$value";

		// Add roundcube session ID if available
		if (!$_COOKIE['roundcube_sessid'] && $this -> rcSessionID)
			$cookies[] = "roundcube_sessid={$this->rcSessionID}";

		if (!$_COOKIE['roundcube_sessauth'] && $this -> rcSessionAuth)
			$cookies[] = "roundcube_sessauth={$this->
	rcSessionAuth}";

		$cookies = ($cookies) ? "Cookie: " . join("; ", $cookies) . "\r\n" : "";

		// Create POST request with the given data
		if ($method == "POST") {
			$request = "POST " . $path . " HTTP/1.1\r\n" . "Host: " . $_SERVER['HTTP_HOST'] . "\r\n" . "User-Agent: " . $_SERVER['HTTP_USER_AGENT'] . "\r\n" . "Content-Type: application/x-www-form-urlencoded\r\n" . "Content-Length: " . strlen($postData) . "\r\n" . $cookies . "Connection: close\r\n\r\n" . $postData;
		}

		// Make GET
		else {
			$request = "GET " . $path . " HTTP/1.1\r\n" . "Host: " . $_SERVER['HTTP_HOST'] . "\r\n" . "User-Agent: " . $_SERVER['HTTP_USER_AGENT'] . "\r\n" . $cookies . "Connection: close\r\n\r\n";
		}

		// Send request
		$fp = fsockopen($host, $port);
		if (!$fp) {
			$this -> addDebug("Network connection failed on fsockopen. Please check you alias for roundcube", "The network connection returned $errno - $errstr");
			throw new RoundcubeNetworkException("Unable to determine network-status due to technical problems.");
		} else {

			// Request
			$this -> addDebug("REQUEST", $request);
			fputs($fp, $request);

			// Read response and set received cookies
			$response = "";

			while (!feof($fp)) {
				$line = fgets($fp, 4096);

				// Not found
				if (preg_match('/^HTTP\/1\.\d\s+404\s+/', $line))
					throw new RoundcubeLoginException("No Roundcube installation found at '$path'");

				// Got session ID!
				if (preg_match('/^Set-Cookie:\s*(.+roundcube_sessid=([^;]+);.+)$/i', $line, $match)) {
					header($line, false);

					$this -> addDebug("GOT SESSION ID", "New session ID: '$match[2]'.");
					$this -> rcSessionID = $match[2];
				}

				// Got sessauth
				if (preg_match('/^Set-Cookie:.+roundcube_sessauth=([^;]+);/i', $line, $match)) {
					header($line, false);

					$this -> addDebug("GOT SESSION AUTH", "New session auth: '$match[1]'.");
					$this -> rcSessionAuthi = $match[1];
				}

				// Request token (since Roundcube 0.5.1)
				if (preg_match('/"request_token":"([^"]+)",/mi', $response, $m))
					$this -> lastToken = $m[1];

				if (preg_match('/
	<input.+name="_token".+value="([^"]+)"/mi', $response, $m))
					$this -> lastToken = $m[1];
				// override previous token (if this one exists!)

				$response .= $line;
			}

			fclose($fp);

			$this -> addDebug("RESPONSE", $response);
		}
		return $response;
	}

	/**
	 * Print a debug message if debugging is enabled.
	 *
	 * @param string Short action message
	 * @param string Output data
	 */
	private function addDebug($action, $data) {
		OCP\Util::writeLog('roundcube', 'RoundcubeLogin.class.php: ' . $action . ': \n ' . $data, OCP\Util::DEBUG);
	}

	/**
	 * Dump the debug stack
	 */
	public function dumpDebugStack() {
		OCP\Util::writeLog('roundcube', 'RoundcubeLogin.class.php: ' . print_r($this -> debugStack) . ' ' . print_r($data), OCP\Util::ERROR);
	}

}

/**
 * This Roundcube login exception will be thrown if the two
 * login attempts fail.
 */
class RoundcubeLoginException extends Exception {
}

/**
 * This Roundcube network exception will be thrown if an network error occurred.
 */
class RoundcubeNetworkException extends Exception {
}
		?>
