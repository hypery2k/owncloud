-- OwnCloud 6.0.4 database setup
-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: oc_testing
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.12.04.1-log

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
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `user_id` int(10) unsigned NOT NULL,
  `cache_key` varchar(128) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  KEY `expires_index` (`expires`),
  KEY `user_cache_index` (`user_id`,`cache_key`),
  CONSTRAINT `user_id_fk_cache` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_index`
--

DROP TABLE IF EXISTS `cache_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_index` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `expires` datetime DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_index` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_index`
--

LOCK TABLES `cache_index` WRITE;
/*!40000 ALTER TABLE `cache_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_messages`
--

DROP TABLE IF EXISTS `cache_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_messages` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`mailbox`,`uid`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_messages` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_messages`
--

LOCK TABLES `cache_messages` WRITE;
/*!40000 ALTER TABLE `cache_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_shared`
--

DROP TABLE IF EXISTS `cache_shared`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_shared` (
  `cache_key` varchar(255) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  KEY `expires_index` (`expires`),
  KEY `cache_key_index` (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_shared`
--

LOCK TABLES `cache_shared` WRITE;
/*!40000 ALTER TABLE `cache_shared` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_shared` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_thread`
--

DROP TABLE IF EXISTS `cache_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_thread` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_thread` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_thread`
--

LOCK TABLES `cache_thread` WRITE;
/*!40000 ALTER TABLE `cache_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactgroupmembers`
--

DROP TABLE IF EXISTS `contactgroupmembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactgroupmembers` (
  `contactgroup_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`contactgroup_id`,`contact_id`),
  KEY `contactgroupmembers_contact_index` (`contact_id`),
  CONSTRAINT `contactgroup_id_fk_contactgroups` FOREIGN KEY (`contactgroup_id`) REFERENCES `contactgroups` (`contactgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contact_id_fk_contacts` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactgroupmembers`
--

LOCK TABLES `contactgroupmembers` WRITE;
/*!40000 ALTER TABLE `contactgroupmembers` DISABLE KEYS */;
/*!40000 ALTER TABLE `contactgroupmembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactgroups`
--

DROP TABLE IF EXISTS `contactgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactgroups` (
  `contactgroup_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`contactgroup_id`),
  KEY `contactgroups_user_index` (`user_id`,`del`),
  CONSTRAINT `user_id_fk_contactgroups` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactgroups`
--

LOCK TABLES `contactgroups` WRITE;
/*!40000 ALTER TABLE `contactgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `contactgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `email` text NOT NULL,
  `firstname` varchar(128) NOT NULL DEFAULT '',
  `surname` varchar(128) NOT NULL DEFAULT '',
  `vcard` longtext,
  `words` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `user_contacts_index` (`user_id`,`del`),
  CONSTRAINT `user_id_fk_contacts` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dictionary` (
  `user_id` int(10) unsigned DEFAULT NULL,
  `language` varchar(5) NOT NULL,
  `data` longtext NOT NULL,
  UNIQUE KEY `uniqueness` (`user_id`,`language`),
  CONSTRAINT `user_id_fk_dictionary` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
/*!40000 ALTER TABLE `dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identities`
--

DROP TABLE IF EXISTS `identities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identities` (
  `identity_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `standard` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `organization` varchar(128) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL,
  `reply-to` varchar(128) NOT NULL DEFAULT '',
  `bcc` varchar(128) NOT NULL DEFAULT '',
  `signature` text,
  `html_signature` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`identity_id`),
  KEY `user_identities_index` (`user_id`,`del`),
  KEY `email_identities_index` (`email`,`del`),
  CONSTRAINT `user_id_fk_identities` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identities`
--

LOCK TABLES `identities` WRITE;
/*!40000 ALTER TABLE `identities` DISABLE KEYS */;
INSERT INTO `identities` VALUES (1,1,'2014-06-05 14:15:08',0,1,'','','positive@roundcube.owncloud.org','','',NULL,0);
/*!40000 ALTER TABLE `identities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_activity`
--

DROP TABLE IF EXISTS `oc6_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_activity` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `user` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `affecteduser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `app` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subjectparams` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `messageparams` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_activity`
--

LOCK TABLES `oc6_activity` WRITE;
/*!40000 ALTER TABLE `oc6_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_appconfig`
--

DROP TABLE IF EXISTS `oc6_appconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_appconfig` (
  `appid` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`appid`,`configkey`),
  KEY `appconfig_config_key_index` (`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_appconfig`
--

LOCK TABLES `oc6_appconfig` WRITE;
/*!40000 ALTER TABLE `oc6_appconfig` DISABLE KEYS */;
INSERT INTO `oc6_appconfig` VALUES ('activity','enabled','yes'),('activity','installed_version','1.1.2'),('activity','types','filesystem'),('backgroundjob','lastjob','1'),('bookmarks','enabled','yes'),('bookmarks','installed_version','0.3'),('bookmarks','types',''),('calendar','enabled','yes'),('calendar','installed_version','0.6.3'),('calendar','types',''),('contacts','enabled','yes'),('contacts','installed_version','0.3'),('contacts','types',''),('core','global_cache_gc_lastrun','1407579521'),('core','installedat','1401291989.8355'),('core','lastupdatedat','1407579519'),('core','lastupdateResult','{\"version\":\"7.0.1.1\",\"versionstring\":\"ownCloud 7.0.1\",\"url\":\"http:\\/\\/download.owncloud.org\\/community\\/owncloud-7.0.1.zip\",\"web\":\"http:\\/\\/owncloud.org\\/\"}'),('core','public_caldav','calendar/share.php'),('core','public_calendar','calendar/share.php'),('core','public_documents','documents/public.php'),('core','public_files','files_sharing/public.php'),('core','public_gallery','gallery/public.php'),('core','public_webdav','files_sharing/public.php'),('core','remote_caldav','calendar/appinfo/remote.php'),('core','remote_calendar','calendar/appinfo/remote.php'),('core','remote_carddav','contacts/appinfo/remote.php'),('core','remote_contacts','contacts/appinfo/remote.php'),('core','remote_core.css','/core/minimizer.php'),('core','remote_core.js','/core/minimizer.php'),('core','remote_files','files/appinfo/remote.php'),('core','remote_filesync','files/appinfo/filesync.php'),('core','remote_webdav','files/appinfo/remote.php'),('documents','enabled','yes'),('documents','installed_version','0.8.1'),('documents','types',''),('files','backgroundwatcher_previous_file','31'),('files','backgroundwatcher_previous_folder','27'),('files','enabled','yes'),('files','installed_version','1.1.7'),('files','types','filesystem'),('files_pdfviewer','enabled','yes'),('files_pdfviewer','installed_version','0.3'),('files_pdfviewer','types',''),('files_sharing','enabled','yes'),('files_sharing','installed_version','0.3.5'),('files_sharing','types','filesystem'),('files_texteditor','enabled','yes'),('files_texteditor','installed_version','0.3'),('files_texteditor','types',''),('files_trashbin','enabled','yes'),('files_trashbin','installed_version','0.5'),('files_trashbin','types','filesystem'),('files_versions','enabled','yes'),('files_versions','installed_version','1.0.3'),('files_versions','types','filesystem'),('files_videoviewer','enabled','yes'),('files_videoviewer','installed_version','0.1.2'),('files_videoviewer','types',''),('firstrunwizard','enabled','yes'),('firstrunwizard','installed_version','1.0'),('firstrunwizard','types',''),('gallery','enabled','yes'),('gallery','installed_version','0.5.3'),('gallery','types','filesystem'),('revealjs','enabled','yes'),('revealjs','installed_version','2.4.1'),('revealjs','types',''),('roundcube','autoLogin','1'),('roundcube','enabled','yes'),('roundcube','installed_version','2.5.1'),('roundcube','maildir','/oc_testing/mysql/roundcube/'),('roundcube','types',''),('search_lucene','enabled','yes'),('search_lucene','installed_version','0.5.2'),('search_lucene','types','filesystem'),('storagecharts2','enabled','yes'),('storagecharts2','installed_version','2.5.0'),('storagecharts2','types',''),('updater','enabled','yes'),('updater','installed_version','0.3'),('updater','types','');
/*!40000 ALTER TABLE `oc6_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_clndr_calendars`
--

DROP TABLE IF EXISTS `oc6_clndr_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_clndr_calendars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displayname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `ctag` int(10) unsigned NOT NULL DEFAULT '0',
  `calendarorder` int(10) unsigned NOT NULL DEFAULT '0',
  `calendarcolor` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` longtext COLLATE utf8_unicode_ci,
  `components` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_clndr_calendars`
--

LOCK TABLES `oc6_clndr_calendars` WRITE;
/*!40000 ALTER TABLE `oc6_clndr_calendars` DISABLE KEYS */;
INSERT INTO `oc6_clndr_calendars` VALUES (1,'positive@roundcube.owncloud.org','Default calendar','defaultcalendar',1,1,0,NULL,NULL,'VEVENT,VTODO,VJOURNAL');
/*!40000 ALTER TABLE `oc6_clndr_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_clndr_objects`
--

DROP TABLE IF EXISTS `oc6_clndr_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_clndr_objects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `calendarid` int(10) unsigned NOT NULL DEFAULT '0',
  `objecttype` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `startdate` datetime DEFAULT '1970-01-01 00:00:00',
  `enddate` datetime DEFAULT '1970-01-01 00:00:00',
  `repeating` int(11) DEFAULT '0',
  `summary` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `calendardata` longtext COLLATE utf8_unicode_ci,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastmodified` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_clndr_objects`
--

LOCK TABLES `oc6_clndr_objects` WRITE;
/*!40000 ALTER TABLE `oc6_clndr_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_clndr_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_clndr_repeat`
--

DROP TABLE IF EXISTS `oc6_clndr_repeat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_clndr_repeat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventid` int(10) unsigned NOT NULL DEFAULT '0',
  `calid` int(10) unsigned NOT NULL DEFAULT '0',
  `startdate` datetime DEFAULT '1970-01-01 00:00:00',
  `enddate` datetime DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_clndr_repeat`
--

LOCK TABLES `oc6_clndr_repeat` WRITE;
/*!40000 ALTER TABLE `oc6_clndr_repeat` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_clndr_repeat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_clndr_share_calendar`
--

DROP TABLE IF EXISTS `oc6_clndr_share_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_clndr_share_calendar` (
  `owner` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `share` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sharetype` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `calendarid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `permissions` smallint(6) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_clndr_share_calendar`
--

LOCK TABLES `oc6_clndr_share_calendar` WRITE;
/*!40000 ALTER TABLE `oc6_clndr_share_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_clndr_share_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_clndr_share_event`
--

DROP TABLE IF EXISTS `oc6_clndr_share_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_clndr_share_event` (
  `owner` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `share` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sharetype` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `permissions` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_clndr_share_event`
--

LOCK TABLES `oc6_clndr_share_event` WRITE;
/*!40000 ALTER TABLE `oc6_clndr_share_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_clndr_share_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_contacts_addressbooks`
--

DROP TABLE IF EXISTS `oc6_contacts_addressbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_contacts_addressbooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `displayname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ctag` int(10) unsigned NOT NULL DEFAULT '1',
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_contacts_addressbooks`
--

LOCK TABLES `oc6_contacts_addressbooks` WRITE;
/*!40000 ALTER TABLE `oc6_contacts_addressbooks` DISABLE KEYS */;
INSERT INTO `oc6_contacts_addressbooks` VALUES (1,'admin','Kontakte','kontakte','',1401291998,1),(2,'negative@roundcube.owncloud.org','Contacts','contacts','',1404372624,1),(3,'positive@roundcube.owncloud.org','Contacts','contacts','',1404372642,1);
/*!40000 ALTER TABLE `oc6_contacts_addressbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_contacts_cards`
--

DROP TABLE IF EXISTS `oc6_contacts_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_contacts_cards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` int(10) unsigned NOT NULL DEFAULT '0',
  `fullname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `carddata` longtext COLLATE utf8_unicode_ci,
  `uri` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_contacts_cards`
--

LOCK TABLES `oc6_contacts_cards` WRITE;
/*!40000 ALTER TABLE `oc6_contacts_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_contacts_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_contacts_cards_properties`
--

DROP TABLE IF EXISTS `oc6_contacts_cards_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_contacts_cards_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `contactid` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preferred` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cp_name_index` (`name`),
  KEY `cp_value_index` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_contacts_cards_properties`
--

LOCK TABLES `oc6_contacts_cards_properties` WRITE;
/*!40000 ALTER TABLE `oc6_contacts_cards_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_contacts_cards_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_dlstcharts`
--

DROP TABLE IF EXISTS `oc6_dlstcharts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_dlstcharts` (
  `stc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `stc_month` bigint(20) NOT NULL,
  `stc_dayts` bigint(20) NOT NULL,
  `stc_used` bigint(20) NOT NULL,
  `stc_total` bigint(20) NOT NULL,
  PRIMARY KEY (`stc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_dlstcharts`
--

LOCK TABLES `oc6_dlstcharts` WRITE;
/*!40000 ALTER TABLE `oc6_dlstcharts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_dlstcharts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_dlstcharts_uconf`
--

DROP TABLE IF EXISTS `oc6_dlstcharts_uconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_dlstcharts_uconf` (
  `uc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `uc_key` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `uc_val` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`uc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_dlstcharts_uconf`
--

LOCK TABLES `oc6_dlstcharts_uconf` WRITE;
/*!40000 ALTER TABLE `oc6_dlstcharts_uconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_dlstcharts_uconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_documents_invite`
--

DROP TABLE IF EXISTS `oc6_documents_invite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_documents_invite` (
  `es_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) DEFAULT '0',
  `sent_on` int(10) unsigned DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_documents_invite`
--

LOCK TABLES `oc6_documents_invite` WRITE;
/*!40000 ALTER TABLE `oc6_documents_invite` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_documents_invite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_documents_member`
--

DROP TABLE IF EXISTS `oc6_documents_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_documents_member` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `es_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `last_activity` int(10) unsigned NOT NULL,
  `is_guest` smallint(5) unsigned NOT NULL DEFAULT '0',
  `token` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_documents_member`
--

LOCK TABLES `oc6_documents_member` WRITE;
/*!40000 ALTER TABLE `oc6_documents_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_documents_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_documents_op`
--

DROP TABLE IF EXISTS `oc6_documents_op`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_documents_op` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `es_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `member` int(10) unsigned NOT NULL DEFAULT '1',
  `opspec` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `documents_op_eis_idx` (`es_id`,`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_documents_op`
--

LOCK TABLES `oc6_documents_op` WRITE;
/*!40000 ALTER TABLE `oc6_documents_op` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_documents_op` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_documents_revisions`
--

DROP TABLE IF EXISTS `oc6_documents_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_documents_revisions` (
  `es_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `seq_head` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `file_id` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `save_hash` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `documents_rev_eis_idx` (`es_id`,`seq_head`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_documents_revisions`
--

LOCK TABLES `oc6_documents_revisions` WRITE;
/*!40000 ALTER TABLE `oc6_documents_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_documents_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_documents_session`
--

DROP TABLE IF EXISTS `oc6_documents_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_documents_session` (
  `es_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `genesis_url` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `genesis_hash` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `file_id` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `owner` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`es_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_documents_session`
--

LOCK TABLES `oc6_documents_session` WRITE;
/*!40000 ALTER TABLE `oc6_documents_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_documents_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_file_map`
--

DROP TABLE IF EXISTS `oc6_file_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_file_map` (
  `logic_path` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `logic_path_hash` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `physic_path` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `physic_path_hash` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`logic_path_hash`),
  UNIQUE KEY `file_map_pp_index` (`physic_path_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_file_map`
--

LOCK TABLES `oc6_file_map` WRITE;
/*!40000 ALTER TABLE `oc6_file_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_file_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_filecache`
--

DROP TABLE IF EXISTS `oc6_filecache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_filecache` (
  `fileid` int(11) NOT NULL AUTO_INCREMENT,
  `storage` int(11) NOT NULL DEFAULT '0',
  `path` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path_hash` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `parent` int(11) NOT NULL DEFAULT '0',
  `name` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mimetype` int(11) NOT NULL DEFAULT '0',
  `mimepart` int(11) NOT NULL DEFAULT '0',
  `size` bigint(20) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `storage_mtime` int(11) NOT NULL DEFAULT '0',
  `encrypted` int(11) NOT NULL DEFAULT '0',
  `unencrypted_size` bigint(20) NOT NULL DEFAULT '0',
  `etag` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fileid`),
  UNIQUE KEY `fs_storage_path_hash` (`storage`,`path_hash`),
  KEY `fs_parent_name_hash` (`parent`,`name`),
  KEY `fs_storage_mimetype` (`storage`,`mimetype`),
  KEY `fs_storage_mimepart` (`storage`,`mimepart`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_filecache`
--

LOCK TABLES `oc6_filecache` WRITE;
/*!40000 ALTER TABLE `oc6_filecache` DISABLE KEYS */;
INSERT INTO `oc6_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,0,1407511208,1401291998,0,0,'53e4eaa835d65'),(12,2,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,1573838,1404375964,1404375961,0,0,'53b5139ce3c91'),(13,2,'files','45b963397aa40d4a0063e0d85e4fe7a1',12,'files',2,1,6040581,1404375964,1404375961,0,0,'53b5139d09954'),(14,2,'files/photos','923e51351db3e8726f22ba0fa1c04d5a',13,'photos',2,1,678556,1404375964,1404375961,0,0,'53b5139d4f65f'),(16,2,'files/documents','2d30f25cef1a92db784bc537e8bf128d',13,'documents',2,1,23383,1404375964,1404375961,0,0,'53b5139d3872e'),(17,2,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',13,'ownCloudUserManual.pdf',4,3,1573838,1404375961,1404375961,0,0,'53b513997d2e6'),(18,2,'files/documents/example.odt','f51311bd6910ec7356d79286dcb24dec',16,'example.odt',5,3,23383,1404375961,1404375961,0,0,'53b5139c4227b'),(20,2,'files/photos/paris.jpg','65154b90b985bff20d4923f224ca1c33',14,'paris.jpg',9,8,228761,1404375961,1404375961,0,0,'53b5139ca65bb'),(21,2,'files/photos/san francisco.jpg','e86e87a4ecd557753734e1d34fbeecec',14,'san francisco.jpg',9,8,216071,1404375961,1404375961,0,0,'53b5139ca6a00'),(22,2,'files/photos/squirrel.jpg','e462c24fc17cb1a3fa3bca86d7f89593',14,'squirrel.jpg',9,8,233724,1404375961,1404375961,0,0,'53b5139ca6d2c'),(23,4,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,6040581,1407510818,1404376039,0,0,'53e4e9226cf70'),(24,4,'files','45b963397aa40d4a0063e0d85e4fe7a1',23,'files',2,1,6040581,1407510818,1407510813,0,0,'53e4e9228121b'),(25,4,'files/photos','923e51351db3e8726f22ba0fa1c04d5a',24,'photos',2,1,678556,1407510818,1407510813,0,0,'53e4e922be46d'),(26,4,'files/music','1f8cfec283cd675038bb95b599fdc75a',24,'music',2,1,3764804,1407510818,1407510813,0,0,'53e4e922a9e38'),(27,4,'files/documents','2d30f25cef1a92db784bc537e8bf128d',24,'documents',2,1,23383,1407510818,1407510813,0,0,'53e4e92295801'),(29,4,'files/documents/example.odt','f51311bd6910ec7356d79286dcb24dec',27,'example.odt',5,3,23383,1407510813,1407510813,0,0,'53e4e92174587'),(30,4,'files/music/projekteva-letitrain.mp3','da7d05a957a2bbbf0e74b12c1b5fcfee',26,'projekteva-letitrain.mp3',7,6,3764804,1407510813,1407510813,0,0,'53e4e921c5fa2'),(31,4,'files/photos/paris.jpg','65154b90b985bff20d4923f224ca1c33',25,'paris.jpg',9,8,228761,1407510813,1407510813,0,0,'53e4e9222b9e6'),(32,4,'files/photos/san francisco.jpg','e86e87a4ecd557753734e1d34fbeecec',25,'san francisco.jpg',9,8,216071,1407510813,1407510813,0,0,'53e4e9222be10'),(33,4,'files/photos/squirrel.jpg','e462c24fc17cb1a3fa3bca86d7f89593',25,'squirrel.jpg',9,8,233724,1407510813,1407510813,0,0,'53e4e9222c22d'),(34,1,'files','45b963397aa40d4a0063e0d85e4fe7a1',1,'files',2,1,6040581,1407511208,1407511203,0,0,'53e4eaa849ea0'),(35,1,'files/photos','923e51351db3e8726f22ba0fa1c04d5a',34,'photos',2,1,678556,1407511208,1407511203,0,0,'53e4eaa887123'),(36,1,'files/music','1f8cfec283cd675038bb95b599fdc75a',34,'music',2,1,3764804,1407511208,1407511203,0,0,'53e4eaa872acd'),(37,1,'files/documents','2d30f25cef1a92db784bc537e8bf128d',34,'documents',2,1,23383,1407511208,1407511203,0,0,'53e4eaa85e496'),(38,1,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',34,'ownCloudUserManual.pdf',4,3,1573838,1407511203,1407511203,0,0,'53e4eaa434db3'),(39,1,'files/documents/example.odt','f51311bd6910ec7356d79286dcb24dec',37,'example.odt',5,3,23383,1407511203,1407511203,0,0,'53e4eaa6b8eae'),(40,1,'files/music/projekteva-letitrain.mp3','da7d05a957a2bbbf0e74b12c1b5fcfee',36,'projekteva-letitrain.mp3',7,6,3764804,1407511203,1407511203,0,0,'53e4eaa72ac9c'),(41,1,'files/photos/paris.jpg','65154b90b985bff20d4923f224ca1c33',35,'paris.jpg',9,8,228761,1407511203,1407511203,0,0,'53e4eaa788ba6'),(42,1,'files/photos/san francisco.jpg','e86e87a4ecd557753734e1d34fbeecec',35,'san francisco.jpg',9,8,216071,1407511203,1407511203,0,0,'53e4eaa798ef3'),(43,1,'files/photos/squirrel.jpg','e462c24fc17cb1a3fa3bca86d7f89593',35,'squirrel.jpg',9,8,233724,1407511203,1407511203,0,0,'53e4eaa79928f'),(44,2,'files/music','1f8cfec283cd675038bb95b599fdc75a',13,'music',2,1,3764804,1404375964,1404375961,0,0,'53b5139d205ba'),(45,2,'files/music/projekteva-letitrain.mp3','da7d05a957a2bbbf0e74b12c1b5fcfee',44,'projekteva-letitrain.mp3',7,6,3764804,1404375961,1404375961,0,0,'53b5139b84b89'),(46,4,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',24,'ownCloudUserManual.pdf',4,3,1573838,1407510813,1407510813,0,0,'53e4e91dbb58a');
/*!40000 ALTER TABLE `oc6_filecache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_files_trash`
--

DROP TABLE IF EXISTS `oc6_files_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_files_trash` (
  `id` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` varchar(12) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `location` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mime` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  KEY `id_index` (`id`),
  KEY `timestamp_index` (`timestamp`),
  KEY `user_index` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_files_trash`
--

LOCK TABLES `oc6_files_trash` WRITE;
/*!40000 ALTER TABLE `oc6_files_trash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_files_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_files_trashsize`
--

DROP TABLE IF EXISTS `oc6_files_trashsize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_files_trashsize` (
  `user` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `size` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_files_trashsize`
--

LOCK TABLES `oc6_files_trashsize` WRITE;
/*!40000 ALTER TABLE `oc6_files_trashsize` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_files_trashsize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_files_versions`
--

DROP TABLE IF EXISTS `oc6_files_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_files_versions` (
  `user` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `size` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_files_versions`
--

LOCK TABLES `oc6_files_versions` WRITE;
/*!40000 ALTER TABLE `oc6_files_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_files_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_gallery_sharing`
--

DROP TABLE IF EXISTS `oc6_gallery_sharing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_gallery_sharing` (
  `token` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `gallery_id` int(11) NOT NULL DEFAULT '0',
  `recursive` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_gallery_sharing`
--

LOCK TABLES `oc6_gallery_sharing` WRITE;
/*!40000 ALTER TABLE `oc6_gallery_sharing` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_gallery_sharing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_group_admin`
--

DROP TABLE IF EXISTS `oc6_group_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_group_admin` (
  `gid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `group_admin_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_group_admin`
--

LOCK TABLES `oc6_group_admin` WRITE;
/*!40000 ALTER TABLE `oc6_group_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_group_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_group_user`
--

DROP TABLE IF EXISTS `oc6_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_group_user` (
  `gid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_group_user`
--

LOCK TABLES `oc6_group_user` WRITE;
/*!40000 ALTER TABLE `oc6_group_user` DISABLE KEYS */;
INSERT INTO `oc6_group_user` VALUES ('admin','admin');
/*!40000 ALTER TABLE `oc6_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_groups`
--

DROP TABLE IF EXISTS `oc6_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_groups` (
  `gid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_groups`
--

LOCK TABLES `oc6_groups` WRITE;
/*!40000 ALTER TABLE `oc6_groups` DISABLE KEYS */;
INSERT INTO `oc6_groups` VALUES ('admin');
/*!40000 ALTER TABLE `oc6_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_jobs`
--

DROP TABLE IF EXISTS `oc6_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `argument` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `job_class_index` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_jobs`
--

LOCK TABLES `oc6_jobs` WRITE;
/*!40000 ALTER TABLE `oc6_jobs` DISABLE KEYS */;
INSERT INTO `oc6_jobs` VALUES (1,'OC\\Cache\\FileGlobalGC','null',1407579542),(2,'OC\\BackgroundJob\\Legacy\\RegularJob','[\"\\\\OC\\\\Files\\\\Cache\\\\BackgroundWatcher\",\"checkNext\"]',1407579527),(3,'OC\\BackgroundJob\\Legacy\\RegularJob','[\"OC_RoundCube_AuthHelper\",\"refresh\"]',1407579529);
/*!40000 ALTER TABLE `oc6_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_locks`
--

DROP TABLE IF EXISTS `oc6_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_locks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timeout` int(10) unsigned DEFAULT NULL,
  `created` bigint(20) DEFAULT NULL,
  `token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `scope` smallint(6) DEFAULT NULL,
  `depth` smallint(6) DEFAULT NULL,
  `uri` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_locks`
--

LOCK TABLES `oc6_locks` WRITE;
/*!40000 ALTER TABLE `oc6_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_lucene_status`
--

DROP TABLE IF EXISTS `oc6_lucene_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_lucene_status` (
  `fileid` int(11) NOT NULL DEFAULT '0',
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fileid`),
  KEY `status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_lucene_status`
--

LOCK TABLES `oc6_lucene_status` WRITE;
/*!40000 ALTER TABLE `oc6_lucene_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_lucene_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_mimetypes`
--

DROP TABLE IF EXISTS `oc6_mimetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_mimetypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mimetype` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mimetype_id_index` (`mimetype`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_mimetypes`
--

LOCK TABLES `oc6_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc6_mimetypes` DISABLE KEYS */;
INSERT INTO `oc6_mimetypes` VALUES (3,'application'),(4,'application/pdf'),(5,'application/vnd.oasis.opendocument.text'),(6,'audio'),(7,'audio/mpeg'),(1,'httpd'),(2,'httpd/unix-directory'),(8,'image'),(9,'image/jpeg');
/*!40000 ALTER TABLE `oc6_mimetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_permissions`
--

DROP TABLE IF EXISTS `oc6_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_permissions` (
  `fileid` int(11) NOT NULL DEFAULT '0',
  `user` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permissions` int(11) NOT NULL DEFAULT '0',
  KEY `id_user_index` (`fileid`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_permissions`
--

LOCK TABLES `oc6_permissions` WRITE;
/*!40000 ALTER TABLE `oc6_permissions` DISABLE KEYS */;
INSERT INTO `oc6_permissions` VALUES (17,'negative@roundcube.owncloud.org',27),(46,'positive@roundcube.owncloud.org',27),(24,'positive@roundcube.owncloud.org',31),(38,'admin',27),(34,'admin',31),(37,'admin',31),(36,'admin',31),(35,'admin',31);
/*!40000 ALTER TABLE `oc6_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_pictures_images_cache`
--

DROP TABLE IF EXISTS `oc6_pictures_images_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_pictures_images_cache` (
  `uid_owner` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_pictures_images_cache`
--

LOCK TABLES `oc6_pictures_images_cache` WRITE;
/*!40000 ALTER TABLE `oc6_pictures_images_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_pictures_images_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_preferences`
--

DROP TABLE IF EXISTS `oc6_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_preferences` (
  `userid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `appid` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`userid`,`appid`,`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_preferences`
--

LOCK TABLES `oc6_preferences` WRITE;
/*!40000 ALTER TABLE `oc6_preferences` DISABLE KEYS */;
INSERT INTO `oc6_preferences` VALUES ('admin','files','cache_version','5'),('admin','firstrunwizard','show','0'),('admin','login_token','4de85e5ccc3aabfa200290bda929d6b0','1407579518'),('admin','login_token','967d306e42f8e28313c3a5ebdd8c3f03','1407511203'),('admin','roundcube','privateSSLKey','-----BEGIN PRIVATE KEY-----\nMIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANKJDbNcjd8W3M9L\nH5evXh7dyfm8WpcpCFjzM3o+fZnLDOsH2Gw8uLwnjG6MMewHP1qwNYer1gzl0zOn\n9fuip1s/C2XOoocDzJ7XWPjKt+CP4slZ5I4g7z0llqhQfKjGFJcyYYtwaZsX2F3N\n+5ywMQ6O6+hrxmkoJ5aaBYe3IHLRAgMBAAECgYASxGjWPj/fTRht2hJ84QMQ2VBx\n1Jp2sw+tbjB+iyeDGBiUsuRV8au+CgB4skKY+aRqHx8GcwjnqW0EQ8qnnb4xOJdn\nxp2zmlLbFLxusLtdZjJ/8E5F6Hv7PLruYpUr5KOOhuu3j0HCkpX+j4gjtogDa1mR\ni2Um3GfmO2ZYJ0ND4QJBAPhogXYR+A/WiV9GzR/hqZ/5XnUyiLkCMt5o8BVIDS/X\nSse3vHMe1+cE9Gsjdi/zt0FfBOovWApzBWEeflxFzaUCQQDY+D0JteJMdXPgYqZ9\nQsvb2KwQJ/oRKn0k/bslDTxqtLPP90MotEo7DhS+1kFgnPWy0f+YyNX6Q9UsyGG2\n5yC9AkApt3M2XuIn1sGPLJa6Ke2QnhJM4EWxvDrKuxjGmikMxb0bOTH+q0la1Kwv\nae8pMmauJcTvhy/j4Vkf7D0QRfC5AkBK/UlDYOzNFk8tf4shggOpgXK+xsJkSnYk\nYdnbzX5TNw9q0oAQwndhf9Vlu/GurbEx0+juaoOiUu2L49n5+FpVAkEAh9/249ST\nXkWoU7WXvqCn0xtkd7Nus05ssdWM6XO6A+YABGsvWCJxd1+qElG5JwsRU+NhX9sH\n8Ey0sFtw2Qqqww==\n-----END PRIVATE KEY-----\n'),('admin','roundcube','publicSSLKey','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSiQ2zXI3fFtzPSx+Xr14e3cn5\nvFqXKQhY8zN6Pn2ZywzrB9hsPLi8J4xujDHsBz9asDWHq9YM5dMzp/X7oqdbPwtl\nzqKHA8ye11j4yrfgj+LJWeSOIO89JZaoUHyoxhSXMmGLcGmbF9hdzfucsDEOjuvo\na8ZpKCeWmgWHtyBy0QIDAQAB\n-----END PUBLIC KEY-----\n'),('false','contacts','contacts_properties_indexed','yes'),('negative@roundcube.owncloud.org','files','cache_version','5'),('negative@roundcube.owncloud.org','login_token','9bbbc291f31e8f9c03e1285e02609152','1404375961'),('negative@roundcube.owncloud.org','login_token','a7e7f6ecda9ca0cbb97afdda5320cd45','1404372624'),('negative@roundcube.owncloud.org','login_token','b9b346399f283a3c620554f244fa07f7','1404373021'),('negative@roundcube.owncloud.org','roundcube','privateSSLKey','-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMxqXD6lvbD3Yn+0\noUAw7pr9btmK4XZ9UznFq94z+eGZY2sYWHT96sWJdow3CcP+d9aBQHWW3sfilcgE\nFESmz1SIh99x+FrdxU2ByZxnQxVcEGIEFJc4W4suF5Wkjyzwf9GFrQt/zEf38rp/\n54tshFstSTcoklspoZfg0hYF+hMBAgMBAAECgYEAyOtB/9GowWhmyF8in5V48Z5o\ndiqrsWs9gmtoot8znSrHLVyglV1+hOq4OtleH+beo1gno2zHTHDKB+76fP/4h7xT\nXoXBqew9JVEuUU4igzlvhPSh5DygaF5j8ixwi1T9q7PuUdQ5f7LMENR3DCeeCOSs\nzyuVDeaWQB9kDNGeroECQQDqnlQfykX3viBy8x+lC9ro4281RrKngryxKWmex4SH\nMP7u528jEBX7lrKtusk7gVFH6fMciAe9idBwB+KGRkO/AkEA3wtkj3oRqflfG3om\nS3v1ytnIkdxrP5CNYUjobat1RAKknAKBAoYxz0saIcEKTdb4lvJ0JhgWJFnBYJ9L\nk15ZPwJAO2UPqOidI+W280LHPRIuPgztp1AZhDydpj/0pCSgUVU/BJ4ETZ0R45o3\n67FAplbLi+gXCp8JTptn8CSe3R1GowJBAJvoKMipuQMpDrP0NCR7Z5n9lVdvzX/H\nGSwxfFZ8jSGW/10V2vvataKCiqehegRjCazpmQqvt3p9StCxSHCgeJ0CQGezholu\nvwNHgsn2D2ZtYC9a1dZ+k7RGuTumK/1rkC/CxJdHMSE6W1m4kYo8uSdnDqHn0vjc\nhoUJxlfVRcPhzfI=\n-----END PRIVATE KEY-----\n'),('negative@roundcube.owncloud.org','roundcube','publicSSLKey','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMalw+pb2w92J/tKFAMO6a/W7Z\niuF2fVM5xaveM/nhmWNrGFh0/erFiXaMNwnD/nfWgUB1lt7H4pXIBBREps9UiIff\ncfha3cVNgcmcZ0MVXBBiBBSXOFuLLheVpI8s8H/Rha0Lf8xH9/K6f+eLbIRbLUk3\nKJJbKaGX4NIWBfoTAQIDAQAB\n-----END PUBLIC KEY-----\n'),('positive@roundcube.owncloud.org','contacts','lastgroup','all'),('positive@roundcube.owncloud.org','files','cache_version','5'),('positive@roundcube.owncloud.org','firstrunwizard','show','0'),('positive@roundcube.owncloud.org','login_token','f503bef03b6c9e65d5bdb4ca822a95e9','1407510813'),('positive@roundcube.owncloud.org','roundcube','privateSSLKey','-----BEGIN PRIVATE KEY-----\nMIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALXs/ltq2QFHBbTj\nGyq6u/nKEOC//xvifa80HAZGAx7ZnbFMQZE8QipnmZQ7fWReH9Nogs+APA9XVXKT\nNgTymQ2JsUCCAcDUSr9I6l/sl3uDL2Lb6/y6APJ2ITxToAl+XHUXZyOFZcRZEcHB\njnC3SPgGKIO4SSh320arKUETfiUTAgMBAAECgYBWvflJfVia01JVPTPm28JlB4Ok\npebtVMC4mRADrb4vJ3OY5dMdfK3PqjYAB51yDa7/DgXRCkOYzPtg9e/7y/BNRR96\n+zfHaGOrRFjmKz+Pp5HfS4ENO2Lvf7WTMaOYX/H58Jp33sBG8XEk6cSeCfIX1Y9y\nNk06pw2xc78M/uRZAQJBAPDeOaaNf9CPkpKMrnM3mnBqC+xbOBJwA9GBxsCf/ltY\nXZ/frjcWGjlI1Y5Q9k+xSQNoGxis+fUXQzlWqOZZ8OkCQQDBWtNBR+1iR8tBA9Ep\nXlkVpGHWQ58QTEm45hZ7WZ7V2x0VDTjNZHWtjC4s3sYuTy59QIqoRBZ87gVEmIUO\nMgibAkEA1dnXgYIbusXdsnNo5y601Z2xnFWYwPXmzfnUxmzGXb9k0G69tHbRLY72\n2/YR2ctjMb0aYZwiCHJw4tWH+4xbEQJAS1GPA1n6bZNb6KqM+plnCFgtSGK0/otJ\nGH6AeXJSvimJbZ7l5pRghscZYZ8yAe4URPQ0TxGe1PF/GdZz1jDFSwJAQKY0MOR3\nLQ445dtLvJEZwHt8L2K98XbduvOmxSnanuuXKJxaDPGZQzWBMRGGsVjXURbGtZmh\nI05NTCxKA+U9pQ==\n-----END PRIVATE KEY-----\n'),('positive@roundcube.owncloud.org','roundcube','publicSSLKey','-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC17P5batkBRwW04xsqurv5yhDg\nv/8b4n2vNBwGRgMe2Z2xTEGRPEIqZ5mUO31kXh/TaILPgDwPV1VykzYE8pkNibFA\nggHA1Eq/SOpf7Jd7gy9i2+v8ugDydiE8U6AJflx1F2cjhWXEWRHBwY5wt0j4BiiD\nuEkod9tGqylBE34lEwIDAQAB\n-----END PUBLIC KEY-----\n');
/*!40000 ALTER TABLE `oc6_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_privatedata`
--

DROP TABLE IF EXISTS `oc6_privatedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_privatedata` (
  `keyid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `app` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`keyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_privatedata`
--

LOCK TABLES `oc6_privatedata` WRITE;
/*!40000 ALTER TABLE `oc6_privatedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_privatedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_properties`
--

DROP TABLE IF EXISTS `oc6_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `propertypath` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `propertyname` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `propertyvalue` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `property_index` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_properties`
--

LOCK TABLES `oc6_properties` WRITE;
/*!40000 ALTER TABLE `oc6_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_roundcube`
--

DROP TABLE IF EXISTS `oc6_roundcube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_roundcube` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `oc_user` varchar(4096) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mail_user` varchar(4096) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mail_password` varchar(4096) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_roundcube`
--

LOCK TABLES `oc6_roundcube` WRITE;
/*!40000 ALTER TABLE `oc6_roundcube` DISABLE KEYS */;
INSERT INTO `oc6_roundcube` VALUES (1,'positive@roundcube.owncloud.org','',''),(2,'negative@roundcube.owncloud.org','',''),(3,'admin','','');
/*!40000 ALTER TABLE `oc6_roundcube` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_share`
--

DROP TABLE IF EXISTS `oc6_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `share_type` smallint(6) NOT NULL DEFAULT '0',
  `share_with` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid_owner` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `parent` int(11) DEFAULT NULL,
  `item_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `item_source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_target` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_source` int(11) DEFAULT NULL,
  `file_target` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permissions` smallint(6) NOT NULL DEFAULT '0',
  `stime` bigint(20) NOT NULL DEFAULT '0',
  `accepted` smallint(6) NOT NULL DEFAULT '0',
  `expiration` datetime DEFAULT NULL,
  `token` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mail_send` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `item_share_type_index` (`item_type`,`share_type`),
  KEY `file_source_index` (`file_source`),
  KEY `token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_share`
--

LOCK TABLES `oc6_share` WRITE;
/*!40000 ALTER TABLE `oc6_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_storagecharts2`
--

DROP TABLE IF EXISTS `oc6_storagecharts2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_storagecharts2` (
  `stc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `stc_month` bigint(20) NOT NULL,
  `stc_dayts` bigint(20) NOT NULL,
  `stc_used` double NOT NULL,
  `stc_total` double NOT NULL,
  PRIMARY KEY (`stc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_storagecharts2`
--

LOCK TABLES `oc6_storagecharts2` WRITE;
/*!40000 ALTER TABLE `oc6_storagecharts2` DISABLE KEYS */;
INSERT INTO `oc6_storagecharts2` VALUES (1,'admin',201407,1404345600,18506249,1657109111305),(2,'positive@roundcube.owncloud.org',201408,1407456000,6128936,1651624903976),(3,'admin',201408,1407456000,12253195,1651628959755),(4,'admin',201408,1407542400,12365207,1651643714967);
/*!40000 ALTER TABLE `oc6_storagecharts2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_storagecharts2_uconf`
--

DROP TABLE IF EXISTS `oc6_storagecharts2_uconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_storagecharts2_uconf` (
  `uc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `uc_key` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `uc_val` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`uc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_storagecharts2_uconf`
--

LOCK TABLES `oc6_storagecharts2_uconf` WRITE;
/*!40000 ALTER TABLE `oc6_storagecharts2_uconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_storagecharts2_uconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_storages`
--

DROP TABLE IF EXISTS `oc6_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_storages` (
  `id` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numeric_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`numeric_id`),
  UNIQUE KEY `storages_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_storages`
--

LOCK TABLES `oc6_storages` WRITE;
/*!40000 ALTER TABLE `oc6_storages` DISABLE KEYS */;
INSERT INTO `oc6_storages` VALUES ('home::admin',1),('home::negative@roundcube.owncloud.org',2),('home::positive@roundcube.owncloud.org',4),('local::/var/www/oc_testing/mysql/owncloud/data/',3);
/*!40000 ALTER TABLE `oc6_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_users`
--

DROP TABLE IF EXISTS `oc6_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_users` (
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `displayname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_users`
--

LOCK TABLES `oc6_users` WRITE;
/*!40000 ALTER TABLE `oc6_users` DISABLE KEYS */;
INSERT INTO `oc6_users` VALUES ('admin',NULL,'$2a$08$ppgj7UMJoLNEJHNWjKOlaOp/JO3TJ4/9VoOrhFZvsHmFe0Lm4MbDG'),('negative@roundcube.owncloud.org',NULL,'$2a$08$lkwE4UYlQ90A2b6cUNpgZOeTDRPCZrMEufih50Jeifg/dtOJ4J2MG'),('positive@roundcube.owncloud.org',NULL,'$2a$08$0b7DGj2Y6PS8lAfCuXBOd.H2cj83HX0jfZG2xy1ilnCSU54ZFgRZq');
/*!40000 ALTER TABLE `oc6_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_vcategory`
--

DROP TABLE IF EXISTS `oc6_vcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_vcategory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid_index` (`uid`),
  KEY `type_index` (`type`),
  KEY `category_index` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_vcategory`
--

LOCK TABLES `oc6_vcategory` WRITE;
/*!40000 ALTER TABLE `oc6_vcategory` DISABLE KEYS */;
INSERT INTO `oc6_vcategory` VALUES (1,'positive@roundcube.owncloud.org','event','Geburtstag'),(2,'positive@roundcube.owncloud.org','event','Gesch��ftlich'),(3,'positive@roundcube.owncloud.org','event','Anruf'),(4,'positive@roundcube.owncloud.org','event','Kunden'),(5,'positive@roundcube.owncloud.org','event','Lieferant'),(6,'positive@roundcube.owncloud.org','event','Urlaub'),(7,'positive@roundcube.owncloud.org','event','Ideen'),(8,'positive@roundcube.owncloud.org','event','Reise'),(9,'positive@roundcube.owncloud.org','event','Jubil��um'),(10,'positive@roundcube.owncloud.org','event','Treffen'),(11,'positive@roundcube.owncloud.org','event','Anderes'),(12,'positive@roundcube.owncloud.org','event','Pers��nlich'),(13,'positive@roundcube.owncloud.org','event','Projekte'),(14,'positive@roundcube.owncloud.org','event','Fragen'),(15,'positive@roundcube.owncloud.org','event','Arbeit');
/*!40000 ALTER TABLE `oc6_vcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc6_vcategory_to_object`
--

DROP TABLE IF EXISTS `oc6_vcategory_to_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc6_vcategory_to_object` (
  `objid` int(10) unsigned NOT NULL DEFAULT '0',
  `categoryid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`,`objid`,`type`),
  KEY `vcategory_objectd_index` (`objid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc6_vcategory_to_object`
--

LOCK TABLES `oc6_vcategory_to_object` WRITE;
/*!40000 ALTER TABLE `oc6_vcategory_to_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc6_vcategory_to_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searches`
--

DROP TABLE IF EXISTS `searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searches` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` int(3) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `data` text,
  PRIMARY KEY (`search_id`),
  UNIQUE KEY `uniqueness` (`user_id`,`type`,`name`),
  CONSTRAINT `user_id_fk_searches` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searches`
--

LOCK TABLES `searches` WRITE;
/*!40000 ALTER TABLE `searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `sess_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `ip` varchar(40) NOT NULL,
  `vars` mediumtext NOT NULL,
  PRIMARY KEY (`sess_id`),
  KEY `changed_index` (`changed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES ('1','2014-08-09 12:18:50','2014-08-09 12:18:50','144.76.176.16','bGFuZ3VhZ2V8czo1OiJlbl9VUyI7dGVtcHxiOjE7c2tpbnxzOjU6ImxhcnJ5Ijs='),('lho2uoah08s1mobfd8e9412qm3','2014-06-05 14:15:18','2014-06-05 14:17:37','213.209.99.153','bGFuZ3VhZ2V8czo1OiJkZV9ERSI7dGVtcHxiOjE7c2tpbnxzOjU6ImxhcnJ5Ijt0YXNrfHM6NToibG9naW4iOw=='),('m0qkcg75rlundkuhhs5sbd9764','2014-08-08 17:13:32','2014-08-08 17:17:42','144.76.176.16','bGFuZ3VhZ2V8czo1OiJkZV9ERSI7c2tpbnxzOjU6ImxhcnJ5IjtpbWFwX25hbWVzcGFjZXxhOjM6e3M6ODoicGVyc29uYWwiO047czo1OiJvdGhlciI7TjtzOjY6InNoYXJlZCI7Tjt9aW1hcF9kZWxpbWl0ZXJ8czoxOiIuIjt1c2VyX2lkfHM6MToiMSI7dXNlcm5hbWV8czozMToicG9zaXRpdmVAcm91bmRjdWJlLm93bmNsb3VkLm9yZyI7c3RvcmFnZV9ob3N0fHM6OToibG9jYWxob3N0IjtzdG9yYWdlX3BvcnR8aTozMTQzO3N0b3JhZ2Vfc3NsfE47cGFzc3dvcmR8czoyNDoiMGFzMnh0bHg0cnFmU3p1NExGb1V1dz09Ijtsb2dpbl90aW1lfGk6MTQwNzUxMDgxMjt0aW1lem9uZXxzOjE6IjEiO3Rhc2t8czo0OiJtYWlsIjtpbWFwX2hvc3R8czo5OiJsb2NhbGhvc3QiO21ib3h8czo1OiJJTkJPWCI7c29ydF9jb2x8czowOiIiO3NvcnRfb3JkZXJ8czo0OiJERVNDIjtTVE9SQUdFX1RIUkVBRHxiOjA7U1RPUkFHRV9RVU9UQXxiOjA7U1RPUkFHRV9MSVNULUVYVEVOREVEfGI6MDtsaXN0X2F0dHJpYnxhOjQ6e3M6NDoibmFtZSI7czo4OiJtZXNzYWdlcyI7czoyOiJpZCI7czoxMToibWVzc2FnZWxpc3QiO3M6NToiY2xhc3MiO3M6NDg6InJlY29yZHMtdGFibGUgbWVzc2FnZWxpc3Qgc29ydGhlYWRlciBmaXhlZGhlYWRlciI7czoxNToib3B0aW9uc21lbnVpY29uIjtzOjQ6InRydWUiO31za2luX3BhdGh8czoxMToic2tpbnMvbGFycnkiO2ZvbGRlcnN8YToxOntzOjU6IklOQk9YIjthOjI6e3M6MzoiY250IjtpOjk7czo2OiJtYXh1aWQiO047fX11bnNlZW5fY291bnR8YToxOntzOjU6IklOQk9YIjtpOjk7fWJyb3dzZXJfY2Fwc3xhOjM6e3M6MzoicGRmIjtzOjE6IjAiO3M6NToiZmxhc2giO3M6MToiMCI7czozOiJ0aWYiO3M6MToiMCI7fXNhZmVfbWVzc2FnZXN8YToxOntzOjc6IklOQk9YOjEiO2I6MDt9d3JpdGVhYmxlX2Fib29rfGI6MTs=');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `name` varchar(64) NOT NULL,
  `value` mediumtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system` VALUES ('roundcube-version','2014042900');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `mail_host` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `last_login` datetime DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `preferences` longtext,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`,`mail_host`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'positive@roundcube.owncloud.org','localhost','2014-06-05 14:15:08','2014-08-08 17:13:32','de_DE',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'oc_testing'
--

--
-- Dumping routines for database 'oc_testing'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-09 12:19:52
