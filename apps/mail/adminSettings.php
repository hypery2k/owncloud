<?php
$params = array('maildir','encryptstring1','encryptstring2');

if ($_POST) {
        foreach($params as $param){
                if(isset($_POST[$param])){
                        OC_Appconfig::setValue('mail', $param, $_POST[$param]);
                }
        }
}

// fill template
$tmpl = new OC_Template( 'mail', 'adminSettings');
foreach($params as $param){
                $value = OC_Appconfig::getValue('mail', $param,'');
                $tmpl->assign($param, $value);
}
return $tmpl->fetchPage();
?>