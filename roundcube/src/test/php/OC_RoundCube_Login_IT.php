<?php
require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once 'lib/RoundCubeLogin.class.php';
require_once 'lib/MailNetworkingException.class.php';
require_once 'lib/MailLoginException.class.php';

/**
 * Test login for integration purposes
 *
 * Used for locale dev
 *
 * @author mreinhardt
 *        
 *        
 */
class OC_RoundCube_Login_IT extends PHPUnit_Framework_TestCase
{

    /**
     * @preserveGlobalState disabled
     */
    public function testConnectionError()
    {
        try {
            $rcLogin = new OC_RoundCube_Login('127.0.0.1', '49080', 'roundcube/', true, true, true);
            $rcLogin->login("positive@roundcube.owncloud.org", "42");
        } catch (Exception $e) {
            print $e;
        }
    }
}
