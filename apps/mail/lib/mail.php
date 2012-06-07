<?php

//include(OC::$APPSROOT   '/mail/RoundcubeLogin.class.php');
/**
* ownCloud - mail plugin
*
* @author David Jaedke
* @copyright 2012 David Jaedke david@stuggis.de
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
class OC_Mail_App {	
	public $mailData = '';
	public static function existLoginData($meUser) {
		$stmt = OC_DB::prepare("SELECT id FROM *PREFIX*mail WHERE ocUser = '".$meUser."'");
		$result = $stmt->execute();
		$row = $result->fetchRow();
		
		return $row['id'];
	}
	
	public static function writeBasicData($meUser) {
		$stmt = OC_DB::prepare("INSERT INTO *PREFIX*mail (ocUser) VALUES('$meUser')");
		$result = $stmt->execute();
		self::checkLoginData($meUser, 1);
	}
	
	//check logindaten
	public static function checkLoginData($meUser, $written=0) {
		$mailID = self::existLoginData($meUser);
		if(isset($mailID) && $mailID != '') {
			$stmt = OC_DB::prepare("SELECT id,ocUser,mailUser,mailPass FROM *PREFIX*mail WHERE id = $mailID");
			$result = $stmt->execute();
			$row = $result->fetchRow();
			
			return $row;
		}
		elseif ($written == 0) self::writeBasicData($meUser);	
	}
		
	//own cryptfunction
	public static function cryptMyEntry($entry) {
		
		$before = OC_Appconfig::getValue('mail', 'encryptstring1','');
		$after = OC_Appconfig::getValue('mail', 'encryptstring2','');
		$string = $before.$entry.$after;
		
		$hex='';
	    for ($i=0; $i < strlen($string); $i++) {
	        $hex .= dechex(ord($string[$i]));
	    }
	    
	    return $hex;
	}

	//decrypt password
	public static function decryptMyEntry($hex) {
		$before = OC_Appconfig::getValue('mail', 'encryptstring1','');
		$after = OC_Appconfig::getValue('mail', 'encryptstring2','');
		$string='';
	    for ($i=0; $i < strlen($hex)-1; $i+=2)
	    {
	        $string .= chr(hexdec($hex[$i].$hex[$i+1]));
	    }
	    
	    $string = str_replace(array($before,$after),'',$string);
	    return $string;
	}
	
	
	public static function showMailFrame($maildir, $ownUser, $ownPass) {

//include "RoundcubeLogin.class.php";	
 
# Create RC login object.
# Note: The first parameter is the URL-path of the RC inst.,
#       NOT the file-system path
# e.g. http://host.com/path/to/roundcube/ --> "/path/to/roundcube"
$rcl = new RoundcubeLogin($maildir, $debug);
 
try {
   # If we are already logged in, simply redirect
  // if ($rcl->isLoggedIn())
   //   $rcl->redirect();
 
   # If not, try to login and simply redirect on success
   $rcl->login($ownUser, $ownPass);
 
  // if ($rcl->isLoggedIn())
   //   $rcl->redirect();
 
   # If the login fails, display an error message
   //die("ERROR: Login failed due to a wrong user/pass combination.");

		
		echo '<iframe  src="'.$rcl->getRedirectPath().'" id="roundcubeFrame" name="roundcube" width="100%" width="100%"> </iframe>
		<script type="text/javascript">

			var buffer = 20; //scroll bar buffer

			function pageY(elem) {
			    return elem.offsetParent ? (elem.offsetTop + pageY(elem.offsetParent)) : elem.offsetTop;
			}
				
			function resizeIframe() {
			    var height = document.documentElement.clientHeight;
			    height -= pageY(document.getElementById(\'roundcubeFrame\'))+ buffer ;
			    height = (height < 0) ? 0 : height;
			    document.getElementById(\'roundcubeFrame\').style.height = height + \'px\';
			}

			$(\'#roundcubeFrame\').load(function() {
				resizeIframe();

				// remove top navigation 
				var $header = $(\'#roundcubeFrame\').contents().find(\'#header\').remove()

				// correct top padding
				$(\'#roundcubeFrame\').contents().find(\'#mainscreen\').css(\'top\',\'15px\');
			});

		</script>';
}
catch (RoundcubeLoginException $ex) {
   echo "ERROR: Technical problem, ".$ex->getMessage();
   $rcl->dumpDebugStack(); exit;
}

	}
}
?>