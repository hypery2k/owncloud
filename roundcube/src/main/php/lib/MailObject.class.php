<?php

/**
 * ownCloud - roundcube mail plugin
 *
 * @author Martin Reinhardt
 * @copyright 2013 Martin Reinhardt contact@martinreinhardt-online.de
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU AFFERO GENERAL PUBLIC LICENSE for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

class OC_Mail_Object {

  const ERROR_CODE_GENERAL = '0';

  // LOGIN RELATED ERRORS
  const ERROR_CODE_LOGIN = '10';

  const ERROR_CODE_AUTOLOGIN = '11';

  const ERROR_CODE_NETWORK = '20';

  const ERROR_CODE_RC_NOT_FOUND = '30';

  private $errorOccurred;

  private $errorCode;

  private $errorDetails;

  private $htmlOutput;

  private $displayName;

  public function __construct() {
    $this -> errorOccurred = false;
    $this -> errorDetails = '';
    $this -> htmlOutput = '';
    $this -> displayName = '';
  }

  /**
   * append to the html output
   * @param the html to append $html
   */
  public function appendHtmlOutput($html) {
    $this -> htmlOutput = $this -> htmlOutput . $html;
  }

  /**
   * return html output
   */
  public function getHtmlOutput() {
    return $this -> htmlOutput;
  }

  /**
   * set the html output
   * @param the html out put to set $html
   */
  public function setHtmlOutput($html) {
    $this -> htmlOutput = $html;
  }

  /**
   * return display name
   */
  public function getDisplayName() {
    return $this -> displayName;
  }

  /**
   * set the display name
   * @param the name to set $name
   */
  public function setDisplayName($name) {
    $this -> displayName = $name;
  }

  /**
   * return the error code
   */
  public function getErrorCode() {
    return $this -> errorCode;
  }

  /**
   * @param error code to set $errorCode
   */
  public function setErrorCode($errorCode) {
    $this -> errorCode = $errorCode;
  }

  /**
   * return the error details
   */
  public function getErrorDetails() {
    return $this -> errorDetails;
  }

  /**
   * @param error details to set $errorDtls
   */
  public function setErrorDetails($errorDtls) {
    $this -> errorDetails = $errorDtls;
  }

  /**
   * return true if an error occurred, otherwise false
   */
  public function isErrorOccurred() {
    return $this -> errorOccurred;
  }

  /**
   * @param error code to set $error
   */
  public function setErrorOccurred($error) {
    $this -> errorOccurred = $error;
  }

}
