# App development discontinoued 

> **I quit the  development of OwnCloud apps Sorry to say, if anybody wants to take over the project, feel free to take over.** for coding contribution please see the "Development" section of this document.

# Apps for owncloud

[![Build Status](https://martinreinhardt-online.de/jenkins/buildStatus/icon?job=owncloud/OwnCloud_smoke_tests)](https://martinreinhardt-online.de/jenkins/job/owncloud/job/OwnCloud_smoke_tests/)
 [![Join the chat at https://gitter.im/hypery2k/owncloud](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/hypery2k/owncloud?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
 [![Bountysource](https://www.bountysource.com/badge/team?team_id=59276&style=bounties_posted)](https://www.bountysource.com/teams/hypery2k-owncloud/bounties?utm_source=owncloud&utm_medium=shield&utm_campaign=bounties_posted) [![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=mreinhardt&url=https://github.com/hypery2k/owncloud&title=badges&language=&tags=github&category=software)

> In this repo you'll find apps and enhancements for owncloud.

Feel free to donate
<a href='http://www.pledgie.com/campaigns/23447'><img alt='Click here to lend your support to: Owncloud Apps and make a donation at www.pledgie.com !' src='http://www.pledgie.com/campaigns/23447.png?skin_name=chrome' border='0' /></a> <a target="_blank" href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2SAK2NYWB8QA2">
<img alt="" border="0" src="https://www.paypalobjects.com/de_DE/DE/i/btn/btn_donateCC_LG.gif"/>
</img></a>

> Nightly build status:  [!https://martinreinhardt-online.de/jenkins/buildStatus/icon?job=owncloud/OwnCloud_nightly!|https://martinreinhardt-online.de/jenkins/job/owncloud/job/OwnCloud_nightly/]



## Apps

### Currently released
* [Roundcube](roundcube/README.md)
* [StorageCharts](storagecharts2/README.md)

### In Development
* [revealjs](revealjs/README.md)

### Planned
* [ldapprofile](ldapprofile/README.md)

## Development

See [Wiki](https://github.com/hypery2k/owncloud/wiki/Development-Setup) for details about the setup for development.
A Maven-Site is also [available](https://martinreinhardt-online.de/jenkins/job/owncloud/job/OwnCloud_nightly/site/).

Please take in consideration backport to older version of OC and a compatibility layer with nextcloud as new enhancements.

### Contribute coding using interface of github ##
Submitting improved code fixes and enhancements is easy:

1. Log in to GitHub

2. Fork the Repository
  * https://github.com/hypery2k/owncloud
  * Click "Fork" and you'll have your very own copy of the repository plugin source code at http://github.com/{your-username}/owncloud

3. Edit files within your fork.
  This can be done directly on GitHub.com at http://github.com/{your-username}/owncloud

4. Submit a Pull Request (tell in a issue/pull explicit details about your changes)
  * Click "Pull Prequest"
  * Enter a Message details that will go with your commit to be reviewed by others
  * Click “Send Pull Request”

#### Multiple Pull Requests and Edits ###
When submitting pull requests, it is extremely helpful to isolate the changes you want included from other unrelated changes you may have made to your fork of plugin repository. The easiest way to accomplish this is to use a different branch for each pull request. The github interface when submit the pull request will ask for that. There are a number of ways to create branches within your fork, but GitHub makes the process very easy:

1. Start by finding the file you want to edit in Typesetter's code repository at https://github.com/hypery2k/owncloud.
2. Once you have located the file, navigate to the code view and click "Edit". For example, if you want to change the xxxx.php file, the "Edit" button would appear on this page: https://github.com/hypery2k/owncloud/blob/master/xxxx.php
3. Now, edit the file as you like then click "Propose File Change"

**NOTE** here we use the "xxx" file as example, but this not exist in the plugin repository

Nightly Builds are [available](https://martinreinhardt-online.de/jenkins/job/owncloud/job/OwnCloud_nightly/). See the download last successfull artifacts in the middle of the screen.

License
------------

These OwnCloud apps is licensed under [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

## Downloads

Work under main configurations: oc 7 & rc 1.1.0 or oc 8 & rc 1.2.0, both with mysql or postgres. Other combinations may fail, please see currently opened issues before report someting, we need colaboration support.

### Nightly Builds

Nightly builds are [available here](https://martinreinhardt-online.de/jenkins/job/owncloud/job/OwnCloud_nightly/). See the download last successfull artifacts in the middle of the screen.
Please use stable buils below:

### Stable builds:

You'll find the correct version here: https://apps.owncloud.com/content/show.php/roundcube?content=151523
Scroll down and you see this:
![roundcube_apps_owncloud_com](https://cloud.githubusercontent.com/assets/979121/8286163/59b48e74-1908-11e5-9444-cb472d2b2e5d.png)
