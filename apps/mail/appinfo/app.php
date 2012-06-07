<?php
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

$l=new OC_L10N('mail');
OC::$CLASSPATH['OC_Mail_App'] = 'apps/mail/lib/mail.php';
OC::$CLASSPATH['RoundcubeLogin'] = 'apps/mail/lib/RoundcubeLogin.class.php';

OC_APP::registerAdmin('mail','adminSettings');
OC_App::registerPersonal('mail','userSettings');

OC_App::register( array(
	'order' => 10,
	'id' => 'mail',
	'name' => 'Mail' )
);

OC_App::addNavigationEntry( array(
    'id' => 'mail_index',
    'order' => 10,
    'href' => OC_Helper::linkTo( 'mail', 'index.php' ),
    'icon' => OC_Helper::imagePath( 'mail', 'mail.png' ),
    'name' => $l->t('Mail'))
);
?>