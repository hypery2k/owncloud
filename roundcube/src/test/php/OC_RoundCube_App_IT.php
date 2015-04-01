<?php
require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once 'lib/RoundCubeApp.class.php';
require_once 'lib/MailObject.class.php';
require_once 'lib/RoundCubeLogin.class.php';
require_once 'lib/MailNetworkingException.class.php';
require_once 'lib/MailLoginException.class.php';

/**
 * Test App for integration purposes
 *
 * Used for locale dev
 *
 * @author mreinhardt
 *        
 *        
 */
class OC_RoundCube_App_IT extends PHPUnit_Framework_TestCase
{

    /**
     * @preserveGlobalState disabled
     */
    public function testLogin()
    {
        try {
            if (! isset($_SESSION)) {
                $_SESSION = array();
            }
            OC_RoundCube_App::login('127.0.0.1', '49080', 'roundcube', 'positive@roundcube.owncloud.org', '42');
        } catch (Exception $e) {
            echo OC_RoundCube_App::showMailFrame('127.0.0.1', '49080', 'roundcube')->getHtmlOutput();
        }
    }
}
