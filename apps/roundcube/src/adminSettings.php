<?php
$params = array('maildir','encryptstring1','encryptstring2','removeHeaderNav');

OC_Util::addscript('roundcube', 'settings');


if ($_POST) {
        foreach($params as $param){
                if(isset($_POST[$param])){
                        OC_Appconfig::setValue('roundcube', $param, $_POST[$param]);
                }
        }
}

// fill template
$tmpl = new OC_Template( 'roundcube', 'adminSettings');
foreach($params as $param){
                $value = OC_Appconfig::getValue('roundcube', $param,'');
                $tmpl->assign($param, $value);
}
return $tmpl->fetchPage();
?>