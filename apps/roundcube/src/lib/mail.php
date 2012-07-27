<?php

/**
* ownCloud - roundcube mail plugin
*
* @author Martin Reinhardt
* @copyright 2012 Martin Reinhardt contact@martinreinhardt-online.de
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

/**
 * This class manages the roundcube app. It enables the db integration and 
 * connects to the roundcube installation via the roundcube API
 */
class OC_RoundCube_App {	
	public $mailData = '';

	/**
	 * @brief check if login for the user exiss
	 * @param user object $meUser
	 * @returns the user id
	 *
	 */
	public static function existLoginData($meUser) {
		$stmt = OC_DB::prepare("SELECT id FROM *PREFIX*roundcube WHERE ocUser = '".$meUser."'");
		$result = $stmt->execute();
		$row = $result->fetchRow();
		
		return $row['id'];
	}
	
	/**
	 * @brief write basic information for the user in the app configu
	 * @param user object $meUser
	 * @returns true/false
	 *
	 * This function creates a simple personal entry for each user to distinguish them later
	 *
	 * It also chekcs the login data
	 */
	public static function writeBasicData($meUser) {
		$stmt = OC_DB::prepare("INSERT INTO *PREFIX*roundcube (ocUser) VALUES('$meUser')");
		$result = $stmt->execute();
		self::checkLoginData($meUser, 1);
	}
	
	//check logindaten


	/**
	 * @brief chek the login parameters
	 * @param user object $meUser
	 * @param write the basic user data to db
	 * @returns the login data
	 *
	 * This function tries to load the configured login data for roundcube and return it.
	 */
	public static function checkLoginData($meUser, $written=0) {
		$mailID = self::existLoginData($meUser);
		if(isset($mailID) && $mailID != '') {
			$stmt = OC_DB::prepare("SELECT id,ocUser,mailUser,mailPass FROM *PREFIX*roundcube WHERE id = $mailID");
			$result = $stmt->execute();
			$row = $result->fetchRow();
			
			return $row;
		}
		elseif ($written == 0) self::writeBasicData($meUser);	
	}
		
	/**
	 * @brief own cryptfunction
	 * @param object to encrypt $entry
	 * @returns encrypted entry
	 *
	 */
	public static function cryptMyEntry($entry) {
		
		$before = OC_Appconfig::getValue('roundcube', 'encryptstring1','');
		$after = OC_Appconfig::getValue('roundcube', 'encryptstring2','');
		$string = $before.$entry.$after;
		
		$hex='';
	    for ($i=0; $i < strlen($string); $i++) {
	        $hex .= dechex(ord($string[$i]));
	    }
	    
	    return $hex;
	}

	/**
	 * @brief own cryptfunction
	 * @param object to encrypt $hex
	 * @returns decrypted entry
	 *
	 */
	public static function decryptMyEntry($hex) {
		$before = OC_Appconfig::getValue('roundcube', 'encryptstring1','');
		$after = OC_Appconfig::getValue('roundcube', 'encryptstring2','');
		$string='';
	    for ($i=0; $i < strlen($hex)-1; $i+=2)
	    {
	        $string .= chr(hexdec($hex[$i].$hex[$i+1]));
	    }
	    
	    $string = str_replace(array($before,$after),'',$string);
	    return $string;
	}
	
	/**
	 * @brief showing up roundcube iFrame
	 * @param path to roundcube installation, Note: The first parameter is the URL-path of the RC inst  NOT the file-system path http://host.com/path/to/roundcube/ --> "/path/to/roundcube" $maildir
	 * @param roundcube username $ownUser
	 * @param roundcube password $ownPass
	 *
	 */
	public static function showMailFrame($maildir, $ownUser, $ownPass) {

		// Create RC login object.
		$rcl = new RoundcubeLogin($maildir);
 
		try {
				// Try to login
	 			OCP\Util::writeLog('roundcube','Trying to log into roundcube webinterface under '.$maildir.' as user '.$ownUser,OCP\Util::DEBUG);
	   			if ($rcl->login($ownUser, $ownPass)){
	         		OCP\Util::writeLog('roundcube','Successfully logged into roundcube ',OCP\Util::DEBUG);
				} else {
					// If the login fails, display an error message in the loggs
					OCP\Util::writeLog('roundcube','RoundCube can\'t login to roundcube due to a login error to roundcube',OCP\Util::ERROR);
				}
			OCP\Util::writeLog('roundcube','Preparing iFrame for roundcube:'.$rcl->getRedirectPath(),OCP\Util::DEBUG);
						// loadign image
		$loader_image = OC_Helper::imagePath( 'roundcube', 'loader.gif' );
		
		$removeHeaderNav = OC_Appconfig::getValue('roundcube', 'removeHeaderNav','');
		if(strcmp($removeHeaderNav, '1') == 0) {
			$disable_header_nav = 'true';	
		}else {
			$disable_header_nav = 'false';
			echo "//".$removeHeaderNav;
		}
		// create iFrame begin
		echo '
	<img src="'.$loader_image.'" id="loader">
	<iframe  style="display:none" src="'.$rcl->getRedirectPath().'" id="roundcubeFrame" name="roundcube" width="100%" width="100%"> </iframe>
		<script type="text/javascript">
	
				var buffer = 20; //scroll bar buffer
	
				function pageY(elem) {
				    return elem.offsetParent ? (elem.offsetTop + pageY(elem.offsetParent)) : elem.offsetTop;
				}
					
				function resizeIframe() {
				    var height = document.documentElement.clientHeight;
				    height -= pageY(document.getElementById(\'roundcubeFrame\'))+ buffer ;
';
					echo '
				    height = (height < 0) ? 0 : height;
				    document.getElementById(\'roundcubeFrame\').style.height = height + \'px\';
					
				}
	
				$(\'#roundcubeFrame\').load(function() {
					resizeIframe();

					var mainscreen = $(\'#roundcubeFrame\').contents().find(\'#mainscreen\');
					// remove header line, includes about line and 
					var top_line = $(\'#roundcubeFrame\').contents().find(\'#topline\');
					// correct top padding
					var top_margin= 5;
					try{
						top_margin= parseInt(mainscreen.css(\'top\'),10)-top_line.height();
					} catch(e){}
					top_line.remove();

					// remove logout button	 				
					$(\'#roundcubeFrame\').contents().find(\'.button-logout\').remove();
	
					if('.$disable_header_nav.') {
						
						var top_nav = $(\'#roundcubeFrame\').contents().find(\'#topnav\');
						// check if the above element exits (only in new larry theme, if null use rc 0.7 default theme
						if(top_nav.height()==null){
							top_nav = $(\'#roundcubeFrame\').contents().find(\'#taskbar\');
						} else {
							top_margin= top_margin-top_nav.height();
						}
						top_nav.remove();
					}
					// correct top padding
					$(\'#roundcubeFrame\').contents().find(\'#mainscreen\').css(\'top\',top_margin);

					$(\'#loader\').fadeOut(\'slow\');
					$(\'#roundcubeFrame\').slideDown(\'slow\');
					
				});
	
			</script>';
			// create iFrame end
		}
		catch (RoundcubeLoginException $ex) {
		   echo "ERROR: Technical problem, ".$ex->getMessage();
		   $rcl->dumpDebugStack(); exit;
			OCP\Util::writeLog('roundcube','RoundCube can\'t login to roundcube due to a login exception to roundcube',OCP\Util::ERROR);
		}

	}
}
?>