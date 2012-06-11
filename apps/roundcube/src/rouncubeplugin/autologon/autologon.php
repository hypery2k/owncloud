<?php

/**
 * Sample plugin to try out some hooks.
 * This performs an automatic login if accessed from localhost
 */
class autologon extends rcube_plugin
{
  public $task = 'login';
 
  function init()
  {
    $this->add_hook('startup', array($this, 'startup'));
    $this->add_hook('authenticate', array($this, 'authenticate'));
  }
 
  function startup($args)
  {
    $rcmail = rcmail::get_instance();
 
    // change action to login
    if (empty($_SESSION['user_id']) && !empty($_POST['_autologin']))
      $args['action'] = 'login';
 
    return $args;
  }
 
  function authenticate($args)
  {
    if (!empty($_POST['_autologin'])) {
      $args['user'] = $_POST['_user'];
      $args['pass'] = $_POST['_pass'];
      $args['cookiecheck'] = false;
      $args['valid'] = true;
    }
 
    return $args;
  }
}
?>