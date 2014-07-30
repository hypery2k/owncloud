<?php
/* Copyright (c) 2014, Joas Schilling nickvergessen@owncloud.com
 * This file is licensed under the Affero General Public License version 3
 * or later. See the COPYING-README file. */

/** @var OC_L10N $l */
/** @var array $_ */

p($l->t('Hello %s,', array($_['username'])));
p("\n");
p("\n");

if ($_['timeframe'] == \OCA\Activity\UserSettings::EMAIL_SEND_HOURLY) {
	p($l->t('You are receiving this email because in the last hour the following things happened at %s', array($_['owncloud_installation'])));
} else if ($_['timeframe'] == \OCA\Activity\UserSettings::EMAIL_SEND_DAILY) {
	p($l->t('You are receiving this email because in the last day the following things happened at %s', array($_['owncloud_installation'])));
} else {
	p($l->t('You are receiving this email because in the last week the following things happened at %s', array($_['owncloud_installation'])));
}
p("\n");
p("\n");

foreach ($_['activities'] as $activity) {
	p($l->t('* %s', array($activity)));
	p("\n");
}
p("\n");
