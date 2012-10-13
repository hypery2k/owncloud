<?php
/**
* ownCloud - roundcube mail plugin
*
\* @author Martin Reinhardt and David Jaedke
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

$l=new OC_L10N('roundcube');
OC::$CLASSPATH['OC_RoundCube_App'] = 'apps/roundcube/lib/mail.php';
OC::$CLASSPATH['RoundcubeLogin'] = 'apps/roundcube/lib/RoundcubeLogin.class.php';

OC_APP::registerAdmin('roundcube','adminSettings');
OC_App::registerPersonal('roundcube','userSettings');

OC_App::register( array(
	'order' => 10,
	'id' => 'roundcube',
	'name' => 'RoundCube Mail' )
);

OC_App::addNavigationEntry( array(
    'id' => 'roundcube_index',
    'order' => 10,
    'href' => OC_Helper::linkTo( 'roundcube', 'index.php' ),
    'icon' => OC_Helper::imagePath( 'roundcube', 'mail.png' ),
    'name' => $l->t('Webmail'))
);
?>