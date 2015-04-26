-- MySQL dump 10.13  Distrib 5.5.42, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: oc_testing
-- ------------------------------------------------------
-- Server version 5.5.42-1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Tabellenstruktur für Tabelle `oc7_activity`
--

DROP TABLE IF EXISTS `oc7_activity`;
CREATE TABLE IF NOT EXISTS `oc7_activity` (
`activity_id` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8_bin NOT NULL,
  `user` varchar(64) COLLATE utf8_bin NOT NULL,
  `affecteduser` varchar(64) COLLATE utf8_bin NOT NULL,
  `app` varchar(255) COLLATE utf8_bin NOT NULL,
  `subject` varchar(255) COLLATE utf8_bin NOT NULL,
  `subjectparams` varchar(255) COLLATE utf8_bin NOT NULL,
  `message` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `messageparams` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `file` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `link` varchar(255) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_activity`
--

INSERT INTO `oc7_activity` (`activity_id`, `timestamp`, `priority`, `type`, `user`, `affecteduser`, `app`, `subject`, `subjectparams`, `message`, `messageparams`, `file`, `link`) VALUES
(1, 1430053625, 40, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', 'a:1:{i:0;s:87:"/netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx";}', '', 'a:0:{}', '/netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F'),
(2, 1430053647, 40, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', 'a:1:{i:0;s:39:"/FreeCommanderPortable_2009.02b.paf.exe";}', '', 'a:0:{}', '/FreeCommanderPortable_2009.02b.paf.exe', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F'),
(3, 1430053897, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', 'a:1:{i:0;s:16:"/libxwalkcore.so";}', '', 'a:0:{}', '/libxwalkcore.so', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F'),
(4, 1430053897, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', 'a:1:{i:0;s:37:"/xwalk_core_library_java_app_part.jar";}', '', 'a:0:{}', '/xwalk_core_library_java_app_part.jar', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F'),
(5, 1430053902, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', 'a:1:{i:0;s:87:"/netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx";}', '', 'a:0:{}', '/netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F'),
(6, 1430053990, 40, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', 'a:1:{i:0;s:31:"/Virtuelle Festplatte-s016.vmdk";}', '', 'a:0:{}', '/Virtuelle Festplatte-s016.vmdk', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_activity_mq`
--

DROP TABLE IF EXISTS `oc7_activity_mq`;
CREATE TABLE IF NOT EXISTS `oc7_activity_mq` (
`mail_id` int(11) NOT NULL,
  `amq_timestamp` int(11) NOT NULL DEFAULT '0',
  `amq_latest_send` int(11) NOT NULL DEFAULT '0',
  `amq_type` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_affecteduser` varchar(64) COLLATE utf8_bin NOT NULL,
  `amq_appid` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_subject` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_subjectparams` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_appconfig`
--

DROP TABLE IF EXISTS `oc7_appconfig`;
CREATE TABLE IF NOT EXISTS `oc7_appconfig` (
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_appconfig`
--

INSERT INTO `oc7_appconfig` (`appid`, `configkey`, `configvalue`) VALUES
('activity', 'enabled', 'yes'),
('activity', 'installed_version', '1.1.23'),
('activity', 'ocsid', '166038'),
('activity', 'types', 'filesystem'),
('backgroundjob', 'lastjob', '4'),
('bookmarks', 'enabled', 'yes'),
('bookmarks', 'installed_version', '0.4'),
('bookmarks', 'ocsid', '166042'),
('bookmarks', 'types', ''),
('calendar', 'enabled', 'yes'),
('calendar', 'installed_version', '0.6.4'),
('calendar', 'ocsid', '166043'),
('calendar', 'types', ''),
('contacts', 'enabled', 'yes'),
('contacts', 'installed_version', '0.3.0.18'),
('contacts', 'ocsid', '166044'),
('contacts', 'types', ''),
('core', 'global_cache_gc_lastrun', '1430053946'),
('core', 'installedat', '1401291989.8355'),
('core', 'lastcron', '1430054030'),
('core', 'lastupdateResult', '{"version":"8.0.2.0","versionstring":"ownCloud 8.0.2","url":"http:\\/\\/download.owncloud.org\\/community\\/owncloud-8.0.2.zip","web":"http:\\/\\/doc.owncloud.org\\/server\\/8.0\\/admin_manual\\/maintenance\\/upgrade.html"}'),
('core', 'lastupdatedat', '1430053591'),
('core', 'public_caldav', 'calendar/share.php'),
('core', 'public_calendar', 'calendar/share.php'),
('core', 'public_documents', 'documents/public.php'),
('core', 'public_files', 'files_sharing/public.php'),
('core', 'public_gallery', 'gallery/public.php'),
('core', 'public_webdav', 'files_sharing/publicwebdav.php'),
('core', 'remote_caldav', 'calendar/appinfo/remote.php'),
('core', 'remote_calendar', 'calendar/appinfo/remote.php'),
('core', 'remote_carddav', 'contacts/appinfo/remote.php'),
('core', 'remote_contacts', 'contacts/appinfo/remote.php'),
('core', 'remote_core.css', '/core/minimizer.php'),
('core', 'remote_core.js', '/core/minimizer.php'),
('core', 'remote_files', 'files/appinfo/remote.php'),
('core', 'remote_filesync', 'files/appinfo/filesync.php'),
('core', 'remote_webdav', 'files/appinfo/remote.php'),
('documents', 'enabled', 'yes'),
('documents', 'installed_version', '0.8.2'),
('documents', 'ocsid', '166045'),
('documents', 'types', ''),
('files', 'backgroundwatcher_previous_file', '22'),
('files', 'backgroundwatcher_previous_folder', '24'),
('files', 'enabled', 'yes'),
('files', 'installed_version', '1.1.9'),
('files', 'types', 'filesystem'),
('files_pdfviewer', 'enabled', 'yes'),
('files_pdfviewer', 'installed_version', '0.5'),
('files_pdfviewer', 'ocsid', '166049'),
('files_pdfviewer', 'types', ''),
('files_sharing', 'enabled', 'yes'),
('files_sharing', 'installed_version', '0.5.3'),
('files_sharing', 'ocsid', '166050'),
('files_sharing', 'types', 'filesystem'),
('files_texteditor', 'enabled', 'yes'),
('files_texteditor', 'installed_version', '0.4'),
('files_texteditor', 'ocsid', '166051'),
('files_texteditor', 'types', ''),
('files_trashbin', 'enabled', 'yes'),
('files_trashbin', 'installed_version', '0.6.2'),
('files_trashbin', 'ocsid', '166052'),
('files_trashbin', 'types', 'filesystem'),
('files_versions', 'enabled', 'yes'),
('files_versions', 'installed_version', '1.0.5'),
('files_versions', 'ocsid', '166053'),
('files_versions', 'types', 'filesystem'),
('files_videoviewer', 'enabled', 'yes'),
('files_videoviewer', 'installed_version', '0.1.3'),
('files_videoviewer', 'ocsid', '166054'),
('files_videoviewer', 'types', ''),
('firstrunwizard', 'enabled', 'no'),
('firstrunwizard', 'installed_version', '1.1'),
('firstrunwizard', 'ocsid', '166055'),
('firstrunwizard', 'types', ''),
('gallery', 'enabled', 'yes'),
('gallery', 'installed_version', '0.5.4'),
('gallery', 'ocsid', '166056'),
('gallery', 'types', 'filesystem'),
('revealjs', 'enabled', 'yes'),
('revealjs', 'installed_version', '2.4.1'),
('revealjs', 'types', ''),
('roundcube', 'autoLogin', '1'),
('roundcube', 'enabled', 'yes'),
('roundcube', 'installed_version', '2.5.4'),
('roundcube', 'maildir', '/roundcube/'),
('roundcube', 'types', ''),
('search_lucene', 'enabled', 'yes'),
('search_lucene', 'installed_version', '0.5.3'),
('search_lucene', 'ocsid', '166057'),
('search_lucene', 'types', 'filesystem'),
('storagecharts2', 'enabled', 'yes'),
('storagecharts2', 'installed_version', '2.6.1'),
('storagecharts2', 'types', ''),
('updater', 'enabled', 'yes'),
('updater', 'installed_version', '0.4'),
('updater', 'ocsid', '166059'),
('updater', 'types', '');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_bookmarks`
--

DROP TABLE IF EXISTS `oc7_bookmarks`;
CREATE TABLE IF NOT EXISTS `oc7_bookmarks` (
`id` int(11) NOT NULL,
  `url` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `title` varchar(140) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `public` smallint(6) DEFAULT '0',
  `added` int(10) unsigned DEFAULT '0',
  `lastmodified` int(10) unsigned DEFAULT '0',
  `clickcount` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_bookmarks_tags`
--

DROP TABLE IF EXISTS `oc7_bookmarks_tags`;
CREATE TABLE IF NOT EXISTS `oc7_bookmarks_tags` (
  `bookmark_id` bigint(20) DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_clndr_calendars`
--

DROP TABLE IF EXISTS `oc7_clndr_calendars`;
CREATE TABLE IF NOT EXISTS `oc7_clndr_calendars` (
`id` int(10) unsigned NOT NULL,
  `userid` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `displayname` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `ctag` int(10) unsigned NOT NULL DEFAULT '0',
  `calendarorder` int(10) unsigned NOT NULL DEFAULT '0',
  `calendarcolor` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `timezone` longtext COLLATE utf8_bin,
  `components` varchar(100) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_clndr_calendars`
--

INSERT INTO `oc7_clndr_calendars` (`id`, `userid`, `displayname`, `uri`, `active`, `ctag`, `calendarorder`, `calendarcolor`, `timezone`, `components`) VALUES
(1, 'positive@roundcube.owncloud.org', 'Default calendar', 'defaultcalendar', 1, 1, 0, NULL, NULL, 'VEVENT,VTODO,VJOURNAL');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_clndr_objects`
--

DROP TABLE IF EXISTS `oc7_clndr_objects`;
CREATE TABLE IF NOT EXISTS `oc7_clndr_objects` (
`id` int(10) unsigned NOT NULL,
  `calendarid` int(10) unsigned NOT NULL DEFAULT '0',
  `objecttype` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '',
  `startdate` datetime DEFAULT '1970-01-01 00:00:00',
  `enddate` datetime DEFAULT '1970-01-01 00:00:00',
  `repeating` int(11) DEFAULT '0',
  `summary` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `calendardata` longtext COLLATE utf8_bin,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_clndr_repeat`
--

DROP TABLE IF EXISTS `oc7_clndr_repeat`;
CREATE TABLE IF NOT EXISTS `oc7_clndr_repeat` (
`id` int(10) unsigned NOT NULL,
  `eventid` int(10) unsigned NOT NULL DEFAULT '0',
  `calid` int(10) unsigned NOT NULL DEFAULT '0',
  `startdate` datetime DEFAULT '1970-01-01 00:00:00',
  `enddate` datetime DEFAULT '1970-01-01 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_clndr_share_calendar`
--

DROP TABLE IF EXISTS `oc7_clndr_share_calendar`;
CREATE TABLE IF NOT EXISTS `oc7_clndr_share_calendar` (
  `owner` varchar(255) COLLATE utf8_bin NOT NULL,
  `share` varchar(255) COLLATE utf8_bin NOT NULL,
  `sharetype` varchar(6) COLLATE utf8_bin NOT NULL,
  `calendarid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `permissions` smallint(6) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_clndr_share_event`
--

DROP TABLE IF EXISTS `oc7_clndr_share_event`;
CREATE TABLE IF NOT EXISTS `oc7_clndr_share_event` (
  `owner` varchar(255) COLLATE utf8_bin NOT NULL,
  `share` varchar(255) COLLATE utf8_bin NOT NULL,
  `sharetype` varchar(6) COLLATE utf8_bin NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `permissions` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_contacts_addressbooks`
--

DROP TABLE IF EXISTS `oc7_contacts_addressbooks`;
CREATE TABLE IF NOT EXISTS `oc7_contacts_addressbooks` (
`id` int(10) unsigned NOT NULL,
  `userid` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `displayname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `uri` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ctag` int(10) unsigned NOT NULL DEFAULT '1',
  `active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_contacts_addressbooks`
--

INSERT INTO `oc7_contacts_addressbooks` (`id`, `userid`, `displayname`, `uri`, `description`, `ctag`, `active`) VALUES
(1, 'admin', 'Kontakte', 'kontakte', '', 1401291998, 1),
(2, 'negative@roundcube.owncloud.org', 'Contacts', 'contacts', '', 1404372624, 1),
(3, 'positive@roundcube.owncloud.org', 'Contacts', 'contacts', '', 1404372642, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_contacts_cards`
--

DROP TABLE IF EXISTS `oc7_contacts_cards`;
CREATE TABLE IF NOT EXISTS `oc7_contacts_cards` (
`id` int(10) unsigned NOT NULL,
  `addressbookid` int(10) unsigned NOT NULL DEFAULT '0',
  `fullname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `carddata` longtext COLLATE utf8_bin,
  `uri` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_contacts_cards_properties`
--

DROP TABLE IF EXISTS `oc7_contacts_cards_properties`;
CREATE TABLE IF NOT EXISTS `oc7_contacts_cards_properties` (
`id` int(10) unsigned NOT NULL,
  `userid` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `contactid` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `preferred` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_dlstcharts`
--

DROP TABLE IF EXISTS `oc7_dlstcharts`;
CREATE TABLE IF NOT EXISTS `oc7_dlstcharts` (
`stc_id` int(10) unsigned NOT NULL,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `stc_month` bigint(20) NOT NULL,
  `stc_dayts` bigint(20) NOT NULL,
  `stc_used` bigint(20) NOT NULL,
  `stc_total` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_dlstcharts_uconf`
--

DROP TABLE IF EXISTS `oc7_dlstcharts_uconf`;
CREATE TABLE IF NOT EXISTS `oc7_dlstcharts_uconf` (
`uc_id` int(10) unsigned NOT NULL,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_key` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_val` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_documents_invite`
--

DROP TABLE IF EXISTS `oc7_documents_invite`;
CREATE TABLE IF NOT EXISTS `oc7_documents_invite` (
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Related editing session id',
  `uid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `status` smallint(6) DEFAULT '0',
  `sent_on` int(10) unsigned DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_documents_member`
--

DROP TABLE IF EXISTS `oc7_documents_member`;
CREATE TABLE IF NOT EXISTS `oc7_documents_member` (
`member_id` int(10) unsigned NOT NULL COMMENT 'Unique per user and session',
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Related editing session id',
  `uid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `color` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `last_activity` int(10) unsigned DEFAULT NULL,
  `is_guest` smallint(5) unsigned NOT NULL DEFAULT '0',
  `token` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `status` smallint(5) unsigned NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_documents_op`
--

DROP TABLE IF EXISTS `oc7_documents_op`;
CREATE TABLE IF NOT EXISTS `oc7_documents_op` (
`seq` int(10) unsigned NOT NULL COMMENT 'Sequence number',
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Editing session id',
  `member` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'User and time specific',
  `opspec` longtext COLLATE utf8_bin COMMENT 'json-string'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_documents_revisions`
--

DROP TABLE IF EXISTS `oc7_documents_revisions`;
CREATE TABLE IF NOT EXISTS `oc7_documents_revisions` (
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Related editing session id',
  `seq_head` int(10) unsigned NOT NULL COMMENT 'Sequence head number',
  `member_id` int(10) unsigned NOT NULL COMMENT 'the member that saved the revision',
  `file_id` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'Relative to storage e.g. /welcome.odt',
  `save_hash` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'used to lookup revision in documents folder of member, eg hash.odt'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_documents_session`
--

DROP TABLE IF EXISTS `oc7_documents_session`;
CREATE TABLE IF NOT EXISTS `oc7_documents_session` (
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Editing session id',
  `genesis_url` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'Relative to owner documents storage /welcome.odt',
  `genesis_hash` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'To be sure the genesis did not change',
  `file_id` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'Relative to storage e.g. /welcome.odt',
  `owner` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'oC user who created the session'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_filecache`
--

DROP TABLE IF EXISTS `oc7_filecache`;
CREATE TABLE IF NOT EXISTS `oc7_filecache` (
`fileid` int(11) NOT NULL,
  `storage` int(11) NOT NULL DEFAULT '0',
  `path` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `parent` int(11) NOT NULL DEFAULT '0',
  `name` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `mimetype` int(11) NOT NULL DEFAULT '0',
  `mimepart` int(11) NOT NULL DEFAULT '0',
  `size` bigint(20) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `storage_mtime` int(11) NOT NULL DEFAULT '0',
  `encrypted` int(11) NOT NULL DEFAULT '0',
  `unencrypted_size` bigint(20) NOT NULL DEFAULT '0',
  `etag` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `permissions` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_filecache`
--

INSERT INTO `oc7_filecache` (`fileid`, `storage`, `path`, `path_hash`, `parent`, `name`, `mimetype`, `mimepart`, `size`, `mtime`, `storage_mtime`, `encrypted`, `unencrypted_size`, `etag`, `permissions`) VALUES
(1, 1, '', 'd41d8cd98f00b204e9800998ecf8427e', -1, '', 2, 1, 6377900, 1430053590, 1430053590, 0, 0, '553ce2d767e75', 31),
(12, 2, '', 'd41d8cd98f00b204e9800998ecf8427e', -1, '', 2, 1, 1573838, 1407580497, 1404375961, 0, 0, '53e5f95195416', 0),
(13, 2, 'files', '45b963397aa40d4a0063e0d85e4fe7a1', 12, 'files', 2, 1, 6040324, 1407580497, 1407580494, 0, 0, '53e5f951ab179', 31),
(14, 2, 'files/photos', '923e51351db3e8726f22ba0fa1c04d5a', 13, 'photos', 2, 1, 678556, 1407580497, 1407580494, 0, 0, '53e5f951e8a06', 31),
(16, 2, 'files/documents', '2d30f25cef1a92db784bc537e8bf128d', 13, 'documents', 2, 1, 23383, 1407580497, 1407580494, 0, 0, '53e5f951d43e6', 31),
(17, 2, 'files/ownCloudUserManual.pdf', 'c8edba2d1b8eb651c107b43532c34445', 13, 'ownCloudUserManual.pdf', 4, 3, 1573581, 1407580494, 1407580494, 0, 0, '53e5f94e5fc90', 27),
(18, 2, 'files/documents/example.odt', 'f51311bd6910ec7356d79286dcb24dec', 16, 'example.odt', 5, 3, 23383, 1407580494, 1407580494, 0, 0, '53e5f950469d5', 27),
(20, 2, 'files/photos/paris.jpg', '65154b90b985bff20d4923f224ca1c33', 14, 'paris.jpg', 9, 8, 228761, 1407580494, 1407580494, 0, 0, '53e5f950cddda', 27),
(21, 2, 'files/photos/san francisco.jpg', 'e86e87a4ecd557753734e1d34fbeecec', 14, 'san francisco.jpg', 9, 8, 216071, 1407580494, 1407580494, 0, 0, '53e5f950de044', 27),
(22, 2, 'files/photos/squirrel.jpg', 'e462c24fc17cb1a3fa3bca86d7f89593', 14, 'squirrel.jpg', 9, 8, 233724, 1407580494, 1407580494, 0, 0, '53e5f950dfca1', 27),
(23, 4, '', 'd41d8cd98f00b204e9800998ecf8427e', -1, '', 2, 1, 6377900, 1430053615, 1430053615, 0, 0, '553ce2f0aceb1', 31),
(24, 4, 'files', '45b963397aa40d4a0063e0d85e4fe7a1', 23, 'files', 2, 1, 290278062, 1430053990, 1430053989, 0, 0, '553ce4662a92a', 31),
(34, 1, 'files', '45b963397aa40d4a0063e0d85e4fe7a1', 1, 'files', 2, 1, 57185083, 1430053902, 1430053902, 0, 0, '553ce40ed30ae', 31),
(44, 2, 'files/music', '1f8cfec283cd675038bb95b599fdc75a', 13, 'music', 2, 1, 3764804, 1407580497, 1407580494, 0, 0, '53e5f951bfdc7', 31),
(45, 2, 'files/music/projekteva-letitrain.mp3', 'da7d05a957a2bbbf0e74b12c1b5fcfee', 44, 'projekteva-letitrain.mp3', 7, 6, 3764804, 1407580494, 1407580494, 0, 0, '53e5f94fc44dd', 27),
(47, 5, '', 'd41d8cd98f00b204e9800998ecf8427e', -1, '', 2, 1, 229, 1430053616, 1428594316, 0, 0, '553ce2f0aaead', 31),
(48, 5, '.ocdata', 'a840ac417b1f143f29a22c7261756dad', 47, '.ocdata', 13, 3, 0, 1428594316, 1428594316, 0, 0, '55269e8c5592a', 27),
(49, 5, 'owncloud.log', '9703bd00121351aafcb85ff51784acc5', 47, 'owncloud.log', 13, 3, 229, 1428594316, 1428594316, 0, 0, '55269e8c56480', 27),
(50, 4, 'cache', '0fea6a13c52b4d4725368f24b045ca84', 23, 'cache', 2, 1, 0, 1430053615, 1430053615, 0, 0, '553ce2f0ae263', 31),
(69, 1, 'cache', '0fea6a13c52b4d4725368f24b045ca84', 1, 'cache', 2, 1, 0, 1430053589, 1430053589, 0, 0, '553ce2d76c09a', 31),
(79, 1, 'files/photos', '923e51351db3e8726f22ba0fa1c04d5a', 34, 'photos', 2, 1, 678556, 1430053590, 1430053590, 0, 0, '553ce2d773107', 31),
(80, 1, 'files/photos/san francisco.jpg', 'e86e87a4ecd557753734e1d34fbeecec', 79, 'san francisco.jpg', 9, 8, 216071, 1430053590, 1430053590, 0, 0, '553ce2d778bbb', 27),
(81, 1, 'files/photos/paris.jpg', '65154b90b985bff20d4923f224ca1c33', 79, 'paris.jpg', 9, 8, 228761, 1430053590, 1430053590, 0, 0, '553ce2d7791c6', 27),
(82, 1, 'files/photos/squirrel.jpg', 'e462c24fc17cb1a3fa3bca86d7f89593', 79, 'squirrel.jpg', 9, 8, 233724, 1430053590, 1430053590, 0, 0, '553ce2d779cf7', 27),
(83, 1, 'files/ownCloudUserManual.pdf', 'c8edba2d1b8eb651c107b43532c34445', 34, 'ownCloudUserManual.pdf', 4, 3, 1911157, 1430053590, 1430053590, 0, 0, '553ce2d773a9d', 27),
(84, 1, 'files/music', '1f8cfec283cd675038bb95b599fdc75a', 34, 'music', 2, 1, 3764804, 1430053590, 1430053590, 0, 0, '553ce2d7747de', 31),
(85, 1, 'files/music/projekteva-letitrain.mp3', 'da7d05a957a2bbbf0e74b12c1b5fcfee', 84, 'projekteva-letitrain.mp3', 7, 6, 3764804, 1430053591, 1430053591, 0, 0, '553ce2d77d668', 27),
(86, 1, 'files/documents', '2d30f25cef1a92db784bc537e8bf128d', 34, 'documents', 2, 1, 23383, 1430053591, 1430053591, 0, 0, '553ce2d77518b', 31),
(87, 1, 'files/documents/example.odt', 'f51311bd6910ec7356d79286dcb24dec', 86, 'example.odt', 5, 3, 23383, 1430053591, 1430053591, 0, 0, '553ce2d782858', 27),
(88, 4, 'files/photos', '923e51351db3e8726f22ba0fa1c04d5a', 24, 'photos', 2, 1, 678556, 1430053616, 1430053616, 0, 0, '553ce2f0b0b5c', 31),
(89, 4, 'files/photos/san francisco.jpg', 'e86e87a4ecd557753734e1d34fbeecec', 88, 'san francisco.jpg', 9, 8, 216071, 1430053616, 1430053616, 0, 0, '553ce2f0b4687', 27),
(90, 4, 'files/photos/paris.jpg', '65154b90b985bff20d4923f224ca1c33', 88, 'paris.jpg', 9, 8, 228761, 1430053616, 1430053616, 0, 0, '553ce2f0b4d43', 27),
(91, 4, 'files/photos/squirrel.jpg', 'e462c24fc17cb1a3fa3bca86d7f89593', 88, 'squirrel.jpg', 9, 8, 233724, 1430053616, 1430053616, 0, 0, '553ce2f0b5c56', 27),
(92, 4, 'files/ownCloudUserManual.pdf', 'c8edba2d1b8eb651c107b43532c34445', 24, 'ownCloudUserManual.pdf', 4, 3, 1911157, 1430053616, 1430053616, 0, 0, '553ce2f0b134c', 27),
(93, 4, 'files/music', '1f8cfec283cd675038bb95b599fdc75a', 24, 'music', 2, 1, 3764804, 1430053616, 1430053616, 0, 0, '553ce2f0b264d', 31),
(94, 4, 'files/music/projekteva-letitrain.mp3', 'da7d05a957a2bbbf0e74b12c1b5fcfee', 93, 'projekteva-letitrain.mp3', 7, 6, 3764804, 1430053616, 1430053616, 0, 0, '553ce2f0b7456', 27),
(95, 4, 'files/documents', '2d30f25cef1a92db784bc537e8bf128d', 24, 'documents', 2, 1, 23383, 1430053616, 1430053616, 0, 0, '553ce2f0b3168', 31),
(96, 4, 'files/documents/example.odt', 'f51311bd6910ec7356d79286dcb24dec', 95, 'example.odt', 5, 3, 23383, 1430053616, 1430053616, 0, 0, '553ce2f0b8c7b', 27),
(97, 4, 'files/netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx', '63a17778a2e412fcf2ec5e7586e72ced', 24, 'netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx', 12, 3, 8379710, 1430053625, 1430053625, 0, 0, '553ce2f9707dc', 27),
(98, 4, 'files/FreeCommanderPortable_2009.02b.paf.exe', 'b731b288ec8a2208aa4a5703d061fe2a', 24, 'FreeCommanderPortable_2009.02b.paf.exe', 14, 3, 2628548, 1430053647, 1430053647, 0, 0, '553ce30f03aa6', 27),
(99, 5, 'positive@roundcube.owncloud.org', '2443f9dff8bb5d786b3bf3cea12c7b43', 47, 'positive@roundcube.owncloud.org', 2, 1, -1, 1430053615, 1430053615, 0, 0, '553ce3d591d93', 31),
(100, 5, 'positive@roundcube.owncloud.org/files', 'a5bcf12c70b5e233cf0ff4b72f2517f9', 99, 'files', 2, 1, -1, 1430053647, 1430053647, 0, 0, '553ce3d591bd3', 31),
(101, 5, 'positive@roundcube.owncloud.org/files/netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx', '3a0b212b7ad03d0790f1cfb7a729c090', 100, 'netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx', 12, 3, 8379710, 1430053625, 1430053625, 0, 0, '553ce3d5919e2', 27),
(102, 1, 'files/libxwalkcore.so', 'bc8acb82ff7b59f4abadfe681d3544cc', 34, 'libxwalkcore.so', 13, 3, 42358984, 1430053897, 1430053897, 0, 0, '553ce4097c5ac', 27),
(103, 1, 'files/xwalk_core_library_java_app_part.jar', 'c48122268d38124cb2efe34bacc4a2a6', 34, 'xwalk_core_library_java_app_part.jar', 13, 3, 68489, 1430053897, 1430053897, 0, 0, '553ce409b5cbf', 27),
(104, 1, 'files/netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx', '63a17778a2e412fcf2ec5e7586e72ced', 34, 'netflixwebkit-baseduifortvdevices-techblogslideshareversion-110907200905-phpapp02.pptx', 12, 3, 8379710, 1430053902, 1430053902, 0, 0, '553ce40ecc24a', 27),
(105, 4, 'files/Virtuelle Festplatte-s016.vmdk', '829811ee3570c4dc71ed6103e9b2339b', 24, 'Virtuelle Festplatte-s016.vmdk', 13, 3, 272891904, 1430053989, 1430053989, 0, 0, '553ce46573afb', 27);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_files_trash`
--

DROP TABLE IF EXISTS `oc7_files_trash`;
CREATE TABLE IF NOT EXISTS `oc7_files_trash` (
  `id` varchar(250) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timestamp` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `location` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(4) COLLATE utf8_bin DEFAULT NULL,
  `mime` varchar(255) COLLATE utf8_bin DEFAULT NULL,
`auto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_file_map`
--

DROP TABLE IF EXISTS `oc7_file_map`;
CREATE TABLE IF NOT EXISTS `oc7_file_map` (
  `logic_path` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `logic_path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `physic_path` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `physic_path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_gallery_sharing`
--

DROP TABLE IF EXISTS `oc7_gallery_sharing`;
CREATE TABLE IF NOT EXISTS `oc7_gallery_sharing` (
  `token` varchar(64) COLLATE utf8_bin NOT NULL,
  `gallery_id` int(11) NOT NULL DEFAULT '0',
  `recursive` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_groups`
--

DROP TABLE IF EXISTS `oc7_groups`;
CREATE TABLE IF NOT EXISTS `oc7_groups` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_groups`
--

INSERT INTO `oc7_groups` (`gid`) VALUES
('admin');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_group_admin`
--

DROP TABLE IF EXISTS `oc7_group_admin`;
CREATE TABLE IF NOT EXISTS `oc7_group_admin` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_group_user`
--

DROP TABLE IF EXISTS `oc7_group_user`;
CREATE TABLE IF NOT EXISTS `oc7_group_user` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_group_user`
--

INSERT INTO `oc7_group_user` (`gid`, `uid`) VALUES
('admin', 'admin');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_jobs`
--

DROP TABLE IF EXISTS `oc7_jobs`;
CREATE TABLE IF NOT EXISTS `oc7_jobs` (
`id` int(10) unsigned NOT NULL,
  `class` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `argument` varchar(256) COLLATE utf8_bin NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_jobs`
--

INSERT INTO `oc7_jobs` (`id`, `class`, `argument`, `last_run`) VALUES
(1, 'OC\\Cache\\FileGlobalGC', 'null', 1430053946),
(2, 'OC\\BackgroundJob\\Legacy\\RegularJob', '["\\\\OC\\\\Files\\\\Cache\\\\BackgroundWatcher","checkNext"]', 1430053992),
(3, 'OC\\BackgroundJob\\Legacy\\RegularJob', '["OC_RoundCube_AuthHelper","refresh"]', 1430054008),
(4, 'OCA\\Activity\\BackgroundJob\\EmailNotification', 'null', 1430053607),
(5, 'OCA\\Activity\\BackgroundJob\\ExpireActivities', 'null', 1430053610),
(11, 'OC\\BackgroundJob\\Legacy\\QueuedJob', '{"app":"search_lucene","klass":"OCA\\\\Search_Lucene\\\\Hooks","method":"doIndexFile","parameters":"{\\"path\\":\\"\\\\\\/Virtuelle Festplatte-s016.vmdk\\",\\"user\\":\\"positive@roundcube.owncloud.org\\"}"}', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_locks`
--

DROP TABLE IF EXISTS `oc7_locks`;
CREATE TABLE IF NOT EXISTS `oc7_locks` (
`id` int(10) unsigned NOT NULL,
  `userid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `owner` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `timeout` int(10) unsigned DEFAULT NULL,
  `created` bigint(20) DEFAULT NULL,
  `token` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `scope` smallint(6) DEFAULT NULL,
  `depth` smallint(6) DEFAULT NULL,
  `uri` longtext COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_lucene_status`
--

DROP TABLE IF EXISTS `oc7_lucene_status`;
CREATE TABLE IF NOT EXISTS `oc7_lucene_status` (
  `fileid` int(11) NOT NULL DEFAULT '0',
  `status` varchar(1) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_mimetypes`
--

DROP TABLE IF EXISTS `oc7_mimetypes`;
CREATE TABLE IF NOT EXISTS `oc7_mimetypes` (
`id` int(11) NOT NULL,
  `mimetype` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_mimetypes`
--

INSERT INTO `oc7_mimetypes` (`id`, `mimetype`) VALUES
(3, 'application'),
(13, 'application/octet-stream'),
(4, 'application/pdf'),
(5, 'application/vnd.oasis.opendocument.text'),
(12, 'application/vnd.openxmlformats-officedocument.presentationml.presentation'),
(11, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
(10, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),
(14, 'application/x-ms-dos-executable'),
(6, 'audio'),
(7, 'audio/mpeg'),
(1, 'httpd'),
(2, 'httpd/unix-directory'),
(8, 'image'),
(9, 'image/jpeg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_permissions`
--

DROP TABLE IF EXISTS `oc7_permissions`;
CREATE TABLE IF NOT EXISTS `oc7_permissions` (
  `fileid` int(11) NOT NULL DEFAULT '0',
  `user` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `permissions` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_permissions`
--

INSERT INTO `oc7_permissions` (`fileid`, `user`, `permissions`) VALUES
(17, 'negative@roundcube.owncloud.org', 27),
(46, 'positive@roundcube.owncloud.org', 27),
(38, 'admin', 27),
(34, 'admin', 31),
(37, 'admin', 31),
(36, 'admin', 31),
(35, 'admin', 31),
(27, 'positive@roundcube.owncloud.org', 31),
(26, 'positive@roundcube.owncloud.org', 31),
(25, 'positive@roundcube.owncloud.org', 31);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_pictures_images_cache`
--

DROP TABLE IF EXISTS `oc7_pictures_images_cache`;
CREATE TABLE IF NOT EXISTS `oc7_pictures_images_cache` (
  `uid_owner` varchar(64) COLLATE utf8_bin NOT NULL,
  `path` varchar(256) COLLATE utf8_bin NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_preferences`
--

DROP TABLE IF EXISTS `oc7_preferences`;
CREATE TABLE IF NOT EXISTS `oc7_preferences` (
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_preferences`
--

INSERT INTO `oc7_preferences` (`userid`, `appid`, `configkey`, `configvalue`) VALUES
('admin', 'files', 'cache_version', '5'),
('admin', 'firstrunwizard', 'show', '0'),
('admin', 'login', 'lastLogin', '1430053848'),
('false', 'contacts', 'contacts_properties_indexed', 'yes'),
('negative@roundcube.owncloud.org', 'files', 'cache_version', '5'),
('negative@roundcube.owncloud.org', 'firstrunwizard', 'show', '0'),
('negative@roundcube.owncloud.org', 'login', 'lastLogin', '1407580493'),
('positive@roundcube.owncloud.org', 'contacts', 'lastgroup', 'all'),
('positive@roundcube.owncloud.org', 'files', 'cache_version', '5'),
('positive@roundcube.owncloud.org', 'firstrunwizard', 'show', '0'),
('positive@roundcube.owncloud.org', 'login', 'lastLogin', '1430053781');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_privatedata`
--

DROP TABLE IF EXISTS `oc7_privatedata`;
CREATE TABLE IF NOT EXISTS `oc7_privatedata` (
`keyid` int(10) unsigned NOT NULL,
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `app` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `key` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_properties`
--

DROP TABLE IF EXISTS `oc7_properties`;
CREATE TABLE IF NOT EXISTS `oc7_properties` (
`id` int(11) NOT NULL,
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertypath` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertyname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertyvalue` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_roundcube`
--

DROP TABLE IF EXISTS `oc7_roundcube`;
CREATE TABLE IF NOT EXISTS `oc7_roundcube` (
`id` bigint(20) NOT NULL,
  `oc_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_password` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_roundcube`
--

INSERT INTO `oc7_roundcube` (`id`, `oc_user`, `mail_user`, `mail_password`) VALUES
(1, 'positive@roundcube.owncloud.org', '', ''),
(2, 'negative@roundcube.owncloud.org', '', ''),
(3, 'admin', '', '');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_share`
--

DROP TABLE IF EXISTS `oc7_share`;
CREATE TABLE IF NOT EXISTS `oc7_share` (
`id` int(11) NOT NULL,
  `share_type` smallint(6) NOT NULL DEFAULT '0',
  `share_with` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `uid_owner` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `parent` int(11) DEFAULT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `item_source` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `item_target` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `file_source` int(11) DEFAULT NULL,
  `file_target` varchar(512) COLLATE utf8_bin DEFAULT NULL,
  `permissions` smallint(6) NOT NULL DEFAULT '0',
  `stime` bigint(20) NOT NULL DEFAULT '0',
  `accepted` smallint(6) NOT NULL DEFAULT '0',
  `expiration` datetime DEFAULT NULL,
  `token` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `mail_send` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_share_external`
--

DROP TABLE IF EXISTS `oc7_share_external`;
CREATE TABLE IF NOT EXISTS `oc7_share_external` (
`id` int(11) NOT NULL,
  `remote` varchar(512) COLLATE utf8_bin NOT NULL COMMENT 'Url of the remove owncloud instance',
  `share_token` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Public share token',
  `password` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Optional password for the public share',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Original name on the remote server',
  `owner` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'User that owns the public share on the remote server',
  `user` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Local user which added the external share',
  `mountpoint` varchar(4000) COLLATE utf8_bin NOT NULL COMMENT 'Full path where the share is mounted',
  `mountpoint_hash` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'md5 hash of the mountpoint'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_storagecharts2`
--

DROP TABLE IF EXISTS `oc7_storagecharts2`;
CREATE TABLE IF NOT EXISTS `oc7_storagecharts2` (
`stc_id` int(10) unsigned NOT NULL,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `stc_month` bigint(20) NOT NULL,
  `stc_dayts` bigint(20) NOT NULL,
  `stc_used` double NOT NULL,
  `stc_total` double NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_storagecharts2`
--

INSERT INTO `oc7_storagecharts2` (`stc_id`, `oc_uid`, `stc_month`, `stc_dayts`, `stc_used`, `stc_total`) VALUES
(1, 'admin', 201407, 1404345600, 18506249, 1657109111305),
(2, 'admin', 201407, 1406678400, 18640400, 1652918066704),
(3, 'negative@roundcube.owncloud.org', 201407, 1406678400, 18566821, 1652918124197),
(4, 'positive@roundcube.owncloud.org', 201407, 1406678400, 18449214, 1652915671870),
(5, 'negative@roundcube.owncloud.org', 201408, 1407542400, 6124817, 1651559183633),
(6, 'positive@roundcube.owncloud.org', 201503, 1426118400, 6482489, 12870085177),
(7, 'admin', 201504, 1428537600, 6389656, 12565974936),
(8, 'admin', 201504, 1430006400, 347543616, 2800928832),
(9, 'positive@roundcube.owncloud.org', 201504, 1430006400, 347543811, 2800920835);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_storagecharts2_uconf`
--

DROP TABLE IF EXISTS `oc7_storagecharts2_uconf`;
CREATE TABLE IF NOT EXISTS `oc7_storagecharts2_uconf` (
`uc_id` int(10) unsigned NOT NULL,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_key` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_val` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_storagecharts2_uconf`
--

INSERT INTO `oc7_storagecharts2_uconf` (`uc_id`, `oc_uid`, `uc_key`, `uc_val`) VALUES
(1, 'admin', 'hu_size', '3'),
(2, 'admin', 'hu_size_hus', '3'),
(3, 'positive@roundcube.owncloud.org', 'hu_size_hus', '3'),
(4, 'positive@roundcube.owncloud.org', 'hu_size', '3');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_storages`
--

DROP TABLE IF EXISTS `oc7_storages`;
CREATE TABLE IF NOT EXISTS `oc7_storages` (
  `id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
`numeric_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_storages`
--

INSERT INTO `oc7_storages` (`id`, `numeric_id`) VALUES
('home::admin', 1),
('home::negative@roundcube.owncloud.org', 2),
('home::positive@roundcube.owncloud.org', 4),
('local::/var/www/oc_testing/mysql/owncloud/data/', 3),
('local::/var/www/owncloud/data/', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_users`
--

DROP TABLE IF EXISTS `oc7_users`;
CREATE TABLE IF NOT EXISTS `oc7_users` (
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `displayname` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_users`
--

INSERT INTO `oc7_users` (`uid`, `displayname`, `password`) VALUES
('admin', NULL, '$2a$08$ppgj7UMJoLNEJHNWjKOlaOp/JO3TJ4/9VoOrhFZvsHmFe0Lm4MbDG'),
('negative@roundcube.owncloud.org', NULL, '$2a$08$lkwE4UYlQ90A2b6cUNpgZOeTDRPCZrMEufih50Jeifg/dtOJ4J2MG'),
('positive@roundcube.owncloud.org', NULL, '$2a$08$0b7DGj2Y6PS8lAfCuXBOd.H2cj83HX0jfZG2xy1ilnCSU54ZFgRZq');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_vcategory`
--

DROP TABLE IF EXISTS `oc7_vcategory`;
CREATE TABLE IF NOT EXISTS `oc7_vcategory` (
`id` int(10) unsigned NOT NULL,
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `category` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `oc7_vcategory`
--

INSERT INTO `oc7_vcategory` (`id`, `uid`, `type`, `category`) VALUES
(1, 'positive@roundcube.owncloud.org', 'event', 'Geburtstag'),
(2, 'positive@roundcube.owncloud.org', 'event', 'Gesch��ftlich'),
(3, 'positive@roundcube.owncloud.org', 'event', 'Anruf'),
(4, 'positive@roundcube.owncloud.org', 'event', 'Kunden'),
(5, 'positive@roundcube.owncloud.org', 'event', 'Lieferant'),
(6, 'positive@roundcube.owncloud.org', 'event', 'Urlaub'),
(7, 'positive@roundcube.owncloud.org', 'event', 'Ideen'),
(8, 'positive@roundcube.owncloud.org', 'event', 'Reise'),
(9, 'positive@roundcube.owncloud.org', 'event', 'Jubil��um'),
(10, 'positive@roundcube.owncloud.org', 'event', 'Treffen'),
(11, 'positive@roundcube.owncloud.org', 'event', 'Anderes'),
(12, 'positive@roundcube.owncloud.org', 'event', 'Pers��nlich'),
(13, 'positive@roundcube.owncloud.org', 'event', 'Projekte'),
(14, 'positive@roundcube.owncloud.org', 'event', 'Fragen'),
(15, 'positive@roundcube.owncloud.org', 'event', 'Arbeit');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `oc7_vcategory_to_object`
--

DROP TABLE IF EXISTS `oc7_vcategory_to_object`;
CREATE TABLE IF NOT EXISTS `oc7_vcategory_to_object` (
  `objid` int(10) unsigned NOT NULL DEFAULT '0',
  `categoryid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `oc7_activity`
--
ALTER TABLE `oc7_activity`
 ADD PRIMARY KEY (`activity_id`), ADD KEY `activity_user_time` (`affecteduser`,`timestamp`), ADD KEY `activity_filter_by` (`affecteduser`,`user`,`timestamp`), ADD KEY `activity_filter_app` (`affecteduser`,`app`,`timestamp`);

--
-- Indizes für die Tabelle `oc7_activity_mq`
--
ALTER TABLE `oc7_activity_mq`
 ADD PRIMARY KEY (`mail_id`), ADD KEY `amp_user` (`amq_affecteduser`), ADD KEY `amp_latest_send_time` (`amq_latest_send`), ADD KEY `amp_timestamp_time` (`amq_timestamp`);

--
-- Indizes für die Tabelle `oc7_appconfig`
--
ALTER TABLE `oc7_appconfig`
 ADD PRIMARY KEY (`appid`,`configkey`), ADD KEY `appconfig_config_key_index` (`configkey`), ADD KEY `appconfig_appid_key` (`appid`);

--
-- Indizes für die Tabelle `oc7_bookmarks`
--
ALTER TABLE `oc7_bookmarks`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indizes für die Tabelle `oc7_bookmarks_tags`
--
ALTER TABLE `oc7_bookmarks_tags`
 ADD UNIQUE KEY `bookmark_tag` (`bookmark_id`,`tag`);

--
-- Indizes für die Tabelle `oc7_clndr_calendars`
--
ALTER TABLE `oc7_clndr_calendars`
 ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `oc7_clndr_objects`
--
ALTER TABLE `oc7_clndr_objects`
 ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `oc7_clndr_repeat`
--
ALTER TABLE `oc7_clndr_repeat`
 ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `oc7_contacts_addressbooks`
--
ALTER TABLE `oc7_contacts_addressbooks`
 ADD PRIMARY KEY (`id`), ADD KEY `c_addressbook_userid_index` (`userid`);

--
-- Indizes für die Tabelle `oc7_contacts_cards`
--
ALTER TABLE `oc7_contacts_cards`
 ADD PRIMARY KEY (`id`), ADD KEY `c_addressbookid_index` (`addressbookid`);

--
-- Indizes für die Tabelle `oc7_contacts_cards_properties`
--
ALTER TABLE `oc7_contacts_cards_properties`
 ADD PRIMARY KEY (`id`), ADD KEY `cp_name_index` (`name`), ADD KEY `cp_value_index` (`value`), ADD KEY `cp_contactid_index` (`contactid`);

--
-- Indizes für die Tabelle `oc7_dlstcharts`
--
ALTER TABLE `oc7_dlstcharts`
 ADD PRIMARY KEY (`stc_id`);

--
-- Indizes für die Tabelle `oc7_dlstcharts_uconf`
--
ALTER TABLE `oc7_dlstcharts_uconf`
 ADD PRIMARY KEY (`uc_id`);

--
-- Indizes für die Tabelle `oc7_documents_member`
--
ALTER TABLE `oc7_documents_member`
 ADD PRIMARY KEY (`member_id`);

--
-- Indizes für die Tabelle `oc7_documents_op`
--
ALTER TABLE `oc7_documents_op`
 ADD PRIMARY KEY (`seq`), ADD UNIQUE KEY `documents_op_eis_idx` (`es_id`,`seq`);

--
-- Indizes für die Tabelle `oc7_documents_revisions`
--
ALTER TABLE `oc7_documents_revisions`
 ADD UNIQUE KEY `documents_rev_eis_idx` (`es_id`,`seq_head`);

--
-- Indizes für die Tabelle `oc7_documents_session`
--
ALTER TABLE `oc7_documents_session`
 ADD PRIMARY KEY (`es_id`);

--
-- Indizes für die Tabelle `oc7_filecache`
--
ALTER TABLE `oc7_filecache`
 ADD PRIMARY KEY (`fileid`), ADD UNIQUE KEY `fs_storage_path_hash` (`storage`,`path_hash`), ADD KEY `fs_parent_name_hash` (`parent`,`name`), ADD KEY `fs_storage_mimetype` (`storage`,`mimetype`), ADD KEY `fs_storage_mimepart` (`storage`,`mimepart`), ADD KEY `fs_storage_size` (`storage`,`size`,`fileid`);

--
-- Indizes für die Tabelle `oc7_files_trash`
--
ALTER TABLE `oc7_files_trash`
 ADD PRIMARY KEY (`auto_id`), ADD KEY `id_index` (`id`), ADD KEY `timestamp_index` (`timestamp`), ADD KEY `user_index` (`user`);

--
-- Indizes für die Tabelle `oc7_file_map`
--
ALTER TABLE `oc7_file_map`
 ADD PRIMARY KEY (`logic_path_hash`), ADD UNIQUE KEY `file_map_pp_index` (`physic_path_hash`);

--
-- Indizes für die Tabelle `oc7_groups`
--
ALTER TABLE `oc7_groups`
 ADD PRIMARY KEY (`gid`);

--
-- Indizes für die Tabelle `oc7_group_admin`
--
ALTER TABLE `oc7_group_admin`
 ADD PRIMARY KEY (`gid`,`uid`), ADD KEY `group_admin_uid` (`uid`);

--
-- Indizes für die Tabelle `oc7_group_user`
--
ALTER TABLE `oc7_group_user`
 ADD PRIMARY KEY (`gid`,`uid`);

--
-- Indizes für die Tabelle `oc7_jobs`
--
ALTER TABLE `oc7_jobs`
 ADD PRIMARY KEY (`id`), ADD KEY `job_class_index` (`class`);

--
-- Indizes für die Tabelle `oc7_locks`
--
ALTER TABLE `oc7_locks`
 ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `oc7_lucene_status`
--
ALTER TABLE `oc7_lucene_status`
 ADD PRIMARY KEY (`fileid`), ADD KEY `status_index` (`status`);

--
-- Indizes für die Tabelle `oc7_mimetypes`
--
ALTER TABLE `oc7_mimetypes`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `mimetype_id_index` (`mimetype`);

--
-- Indizes für die Tabelle `oc7_permissions`
--
ALTER TABLE `oc7_permissions`
 ADD KEY `id_user_index` (`fileid`,`user`);

--
-- Indizes für die Tabelle `oc7_preferences`
--
ALTER TABLE `oc7_preferences`
 ADD PRIMARY KEY (`userid`,`appid`,`configkey`);

--
-- Indizes für die Tabelle `oc7_privatedata`
--
ALTER TABLE `oc7_privatedata`
 ADD PRIMARY KEY (`keyid`);

--
-- Indizes für die Tabelle `oc7_properties`
--
ALTER TABLE `oc7_properties`
 ADD PRIMARY KEY (`id`), ADD KEY `property_index` (`userid`);

--
-- Indizes für die Tabelle `oc7_roundcube`
--
ALTER TABLE `oc7_roundcube`
 ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `oc7_share`
--
ALTER TABLE `oc7_share`
 ADD PRIMARY KEY (`id`), ADD KEY `item_share_type_index` (`item_type`,`share_type`), ADD KEY `file_source_index` (`file_source`), ADD KEY `token_index` (`token`);

--
-- Indizes für die Tabelle `oc7_share_external`
--
ALTER TABLE `oc7_share_external`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `sh_external_mp` (`user`,`mountpoint_hash`), ADD KEY `sh_external_user` (`user`);

--
-- Indizes für die Tabelle `oc7_storagecharts2`
--
ALTER TABLE `oc7_storagecharts2`
 ADD PRIMARY KEY (`stc_id`);

--
-- Indizes für die Tabelle `oc7_storagecharts2_uconf`
--
ALTER TABLE `oc7_storagecharts2_uconf`
 ADD PRIMARY KEY (`uc_id`);

--
-- Indizes für die Tabelle `oc7_storages`
--
ALTER TABLE `oc7_storages`
 ADD PRIMARY KEY (`numeric_id`), ADD UNIQUE KEY `storages_id_index` (`id`);

--
-- Indizes für die Tabelle `oc7_users`
--
ALTER TABLE `oc7_users`
 ADD PRIMARY KEY (`uid`);

--
-- Indizes für die Tabelle `oc7_vcategory`
--
ALTER TABLE `oc7_vcategory`
 ADD PRIMARY KEY (`id`), ADD KEY `uid_index` (`uid`), ADD KEY `type_index` (`type`), ADD KEY `category_index` (`category`);

--
-- Indizes für die Tabelle `oc7_vcategory_to_object`
--
ALTER TABLE `oc7_vcategory_to_object`
 ADD PRIMARY KEY (`categoryid`,`objid`,`type`), ADD KEY `vcategory_objectd_index` (`objid`,`type`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `oc7_activity`
--
ALTER TABLE `oc7_activity`
MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT für Tabelle `oc7_activity_mq`
--
ALTER TABLE `oc7_activity_mq`
MODIFY `mail_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_bookmarks`
--
ALTER TABLE `oc7_bookmarks`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_clndr_calendars`
--
ALTER TABLE `oc7_clndr_calendars`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT für Tabelle `oc7_clndr_objects`
--
ALTER TABLE `oc7_clndr_objects`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_clndr_repeat`
--
ALTER TABLE `oc7_clndr_repeat`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_contacts_addressbooks`
--
ALTER TABLE `oc7_contacts_addressbooks`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT für Tabelle `oc7_contacts_cards`
--
ALTER TABLE `oc7_contacts_cards`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_contacts_cards_properties`
--
ALTER TABLE `oc7_contacts_cards_properties`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_dlstcharts`
--
ALTER TABLE `oc7_dlstcharts`
MODIFY `stc_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_dlstcharts_uconf`
--
ALTER TABLE `oc7_dlstcharts_uconf`
MODIFY `uc_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_documents_member`
--
ALTER TABLE `oc7_documents_member`
MODIFY `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique per user and session';
--
-- AUTO_INCREMENT für Tabelle `oc7_documents_op`
--
ALTER TABLE `oc7_documents_op`
MODIFY `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sequence number';
--
-- AUTO_INCREMENT für Tabelle `oc7_filecache`
--
ALTER TABLE `oc7_filecache`
MODIFY `fileid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=106;
--
-- AUTO_INCREMENT für Tabelle `oc7_files_trash`
--
ALTER TABLE `oc7_files_trash`
MODIFY `auto_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_jobs`
--
ALTER TABLE `oc7_jobs`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT für Tabelle `oc7_locks`
--
ALTER TABLE `oc7_locks`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_mimetypes`
--
ALTER TABLE `oc7_mimetypes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT für Tabelle `oc7_privatedata`
--
ALTER TABLE `oc7_privatedata`
MODIFY `keyid` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_properties`
--
ALTER TABLE `oc7_properties`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_roundcube`
--
ALTER TABLE `oc7_roundcube`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT für Tabelle `oc7_share`
--
ALTER TABLE `oc7_share`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_share_external`
--
ALTER TABLE `oc7_share_external`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `oc7_storagecharts2`
--
ALTER TABLE `oc7_storagecharts2`
MODIFY `stc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT für Tabelle `oc7_storagecharts2_uconf`
--
ALTER TABLE `oc7_storagecharts2_uconf`
MODIFY `uc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT für Tabelle `oc7_storages`
--
ALTER TABLE `oc7_storages`
MODIFY `numeric_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT für Tabelle `oc7_vcategory`
--
ALTER TABLE `oc7_vcategory`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
