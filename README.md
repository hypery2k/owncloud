Some Apps for owncloud
========

If anybody wants to stand in for the development of the app, feel free to use my code The upcoming release 2.5.1 of roundcube and storage charts 2 will be the last release. It takes to much time and money supporting this kind of development.

========
[![Build Status](https://martinreinhardt-online.de/jenkins/buildStatus/icon?job=OwnCloud_nightly)](https://martinreinhardt-online.de/jenkins/job/OwnCloud_nightly/)

In this repo you'll find apps and enhancements for owncloud. 

<a href='http://www.pledgie.com/campaigns/23447'><img alt='Click here to lend your support to: Owncloud Apps and make a donation at www.pledgie.com !' src='http://www.pledgie.com/campaigns/23447.png?skin_name=chrome' border='0' /></a>

Or via PayPal: 

<a target="_blank" href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2SAK2NYWB8QA2">
<img alt="" border="0" src="https://www.paypalobjects.com/de_DE/DE/i/btn/btn_donateCC_LG.gif"/>
</img></a>
## Currently released

### Roundcube
Embedd roundcube interface in owncloud

![RoundCube App](https://github.com/hypery2k/owncloud/raw/master/src/site/images/roundcube_screenshot.png)

### StorageCharts
* reenable StorageCharts App for OwnCloud 6 

#### Requirements:
* OwnCloud 5.0+  (tested with 5.0 - 7.0.0)
* Mailserver with IMAP-Support
* Roundcube Webmailclient (tested with roundcubemail-0.7,0.8,0.9 and 1.0)


## Development

see [Wiki](https://github.com/hypery2k/owncloud/wiki/Development-Setup) for details about the setup for development.
A Maven-Site is also [available](https://martinreinhardt-online.de/jenkins/job/OwnCloud_nightly/site/).

Nightly Builds are [available](https://martinreinhardt-online.de/jenkins/job/OwnCloud_nightly/). See the download last successfull artifacts in the middle of the screen

To run all unit tests execute

```mvn clean test```

To run only javascript test go to one module and execute

```grunt test```

For javascript unit test debugging execute:

```karma start src/test/webapp/karma.conf.js```
 
and point your browser to http://localhost:9080/

##Planned


### RevealJS
* Viewer
* Online-Editor

### LDAP Profile Editor
* Edit LDAP user profile including password change
* update picture
