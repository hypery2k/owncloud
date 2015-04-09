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
-- Table structure for table `oc7_activity`
--

DROP TABLE IF EXISTS `oc7_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_activity` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `link` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `activity_user_time` (`affecteduser`,`timestamp`),
  KEY `activity_filter_by` (`affecteduser`,`user`,`timestamp`),
  KEY `activity_filter_app` (`affecteduser`,`app`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_activity`
--

LOCK TABLES `oc7_activity` WRITE;
/*!40000 ALTER TABLE `oc7_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_activity_mq`
--

DROP TABLE IF EXISTS `oc7_activity_mq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_activity_mq` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT,
  `amq_timestamp` int(11) NOT NULL DEFAULT '0',
  `amq_latest_send` int(11) NOT NULL DEFAULT '0',
  `amq_type` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_affecteduser` varchar(64) COLLATE utf8_bin NOT NULL,
  `amq_appid` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_subject` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_subjectparams` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`mail_id`),
  KEY `amp_user` (`amq_affecteduser`),
  KEY `amp_latest_send_time` (`amq_latest_send`),
  KEY `amp_timestamp_time` (`amq_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_activity_mq`
--

LOCK TABLES `oc7_activity_mq` WRITE;
/*!40000 ALTER TABLE `oc7_activity_mq` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_activity_mq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_appconfig`
--

DROP TABLE IF EXISTS `oc7_appconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_appconfig` (
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin,
  PRIMARY KEY (`appid`,`configkey`),
  KEY `appconfig_config_key_index` (`configkey`),
  KEY `appconfig_appid_key` (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_appconfig`
--

LOCK TABLES `oc7_appconfig` WRITE;
/*!40000 ALTER TABLE `oc7_appconfig` DISABLE KEYS */;
INSERT INTO `oc7_appconfig` VALUES ('activity','enabled','yes'),('activity','installed_version','1.1.23'),('activity','ocsid','166038'),('activity','types','filesystem'),('backgroundjob','lastjob','1'),('bookmarks','enabled','yes'),('bookmarks','installed_version','0.4'),('bookmarks','ocsid','166042'),('bookmarks','types',''),('calendar','enabled','yes'),('calendar','installed_version','0.6.4'),('calendar','ocsid','166043'),('calendar','types',''),('contacts','enabled','yes'),('contacts','installed_version','0.3.0.18'),('contacts','ocsid','166044'),('contacts','types',''),('core','global_cache_gc_lastrun','1426138302'),('core','installedat','1401291989.8355'),('core','lastcron','1426138302'),('core','lastupdateResult','[]'),('core','lastupdatedat','1426138282'),('core','public_caldav','calendar/share.php'),('core','public_calendar','calendar/share.php'),('core','public_documents','documents/public.php'),('core','public_files','files_sharing/public.php'),('core','public_gallery','gallery/public.php'),('core','public_webdav','files_sharing/publicwebdav.php'),('core','remote_caldav','calendar/appinfo/remote.php'),('core','remote_calendar','calendar/appinfo/remote.php'),('core','remote_carddav','contacts/appinfo/remote.php'),('core','remote_contacts','contacts/appinfo/remote.php'),('core','remote_core.css','/core/minimizer.php'),('core','remote_core.js','/core/minimizer.php'),('core','remote_files','files/appinfo/remote.php'),('core','remote_filesync','files/appinfo/filesync.php'),('core','remote_webdav','files/appinfo/remote.php'),('documents','enabled','yes'),('documents','installed_version','0.8.2'),('documents','ocsid','166045'),('documents','types',''),('files','backgroundwatcher_previous_file','22'),('files','backgroundwatcher_previous_folder','24'),('files','enabled','yes'),('files','installed_version','1.1.9'),('files','types','filesystem'),('files_pdfviewer','enabled','yes'),('files_pdfviewer','installed_version','0.5'),('files_pdfviewer','ocsid','166049'),('files_pdfviewer','types',''),('files_sharing','enabled','yes'),('files_sharing','installed_version','0.5.3'),('files_sharing','ocsid','166050'),('files_sharing','types','filesystem'),('files_texteditor','enabled','yes'),('files_texteditor','installed_version','0.4'),('files_texteditor','ocsid','166051'),('files_texteditor','types',''),('files_trashbin','enabled','yes'),('files_trashbin','installed_version','0.6.2'),('files_trashbin','ocsid','166052'),('files_trashbin','types','filesystem'),('files_versions','enabled','yes'),('files_versions','installed_version','1.0.5'),('files_versions','ocsid','166053'),('files_versions','types','filesystem'),('files_videoviewer','enabled','yes'),('files_videoviewer','installed_version','0.1.3'),('files_videoviewer','ocsid','166054'),('files_videoviewer','types',''),('firstrunwizard','enabled','no'),('firstrunwizard','installed_version','1.1'),('firstrunwizard','ocsid','166055'),('firstrunwizard','types',''),('gallery','enabled','yes'),('gallery','installed_version','0.5.4'),('gallery','ocsid','166056'),('gallery','types','filesystem'),('revealjs','enabled','yes'),('revealjs','installed_version','2.4.1'),('revealjs','types',''),('roundcube','autoLogin','1'),('roundcube','enabled','yes'),('roundcube','installed_version','2.5.4'),('roundcube','maildir','/roundcube/'),('roundcube','types',''),('search_lucene','enabled','yes'),('search_lucene','installed_version','0.5.3'),('search_lucene','ocsid','166057'),('search_lucene','types','filesystem'),('storagecharts2','enabled','yes'),('storagecharts2','installed_version','2.6.0.42'),('storagecharts2','types',''),('updater','enabled','yes'),('updater','installed_version','0.4'),('updater','ocsid','166059'),('updater','types','');
/*!40000 ALTER TABLE `oc7_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_bookmarks`
--

DROP TABLE IF EXISTS `oc7_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_bookmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `title` varchar(140) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `public` smallint(6) DEFAULT '0',
  `added` int(10) unsigned DEFAULT '0',
  `lastmodified` int(10) unsigned DEFAULT '0',
  `clickcount` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_bookmarks`
--

LOCK TABLES `oc7_bookmarks` WRITE;
/*!40000 ALTER TABLE `oc7_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_bookmarks_tags`
--

DROP TABLE IF EXISTS `oc7_bookmarks_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_bookmarks_tags` (
  `bookmark_id` bigint(20) DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  UNIQUE KEY `bookmark_tag` (`bookmark_id`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_bookmarks_tags`
--

LOCK TABLES `oc7_bookmarks_tags` WRITE;
/*!40000 ALTER TABLE `oc7_bookmarks_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_bookmarks_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_clndr_calendars`
--

DROP TABLE IF EXISTS `oc7_clndr_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_clndr_calendars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `displayname` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `ctag` int(10) unsigned NOT NULL DEFAULT '0',
  `calendarorder` int(10) unsigned NOT NULL DEFAULT '0',
  `calendarcolor` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `timezone` longtext COLLATE utf8_bin,
  `components` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_clndr_calendars`
--

LOCK TABLES `oc7_clndr_calendars` WRITE;
/*!40000 ALTER TABLE `oc7_clndr_calendars` DISABLE KEYS */;
INSERT INTO `oc7_clndr_calendars` VALUES (1,'positive@roundcube.owncloud.org','Default calendar','defaultcalendar',1,1,0,NULL,NULL,'VEVENT,VTODO,VJOURNAL');
/*!40000 ALTER TABLE `oc7_clndr_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_clndr_objects`
--

DROP TABLE IF EXISTS `oc7_clndr_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_clndr_objects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `calendarid` int(10) unsigned NOT NULL DEFAULT '0',
  `objecttype` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '',
  `startdate` datetime DEFAULT '1970-01-01 00:00:00',
  `enddate` datetime DEFAULT '1970-01-01 00:00:00',
  `repeating` int(11) DEFAULT '0',
  `summary` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `calendardata` longtext COLLATE utf8_bin,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_clndr_objects`
--

LOCK TABLES `oc7_clndr_objects` WRITE;
/*!40000 ALTER TABLE `oc7_clndr_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_clndr_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_clndr_repeat`
--

DROP TABLE IF EXISTS `oc7_clndr_repeat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_clndr_repeat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventid` int(10) unsigned NOT NULL DEFAULT '0',
  `calid` int(10) unsigned NOT NULL DEFAULT '0',
  `startdate` datetime DEFAULT '1970-01-01 00:00:00',
  `enddate` datetime DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_clndr_repeat`
--

LOCK TABLES `oc7_clndr_repeat` WRITE;
/*!40000 ALTER TABLE `oc7_clndr_repeat` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_clndr_repeat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_clndr_share_calendar`
--

DROP TABLE IF EXISTS `oc7_clndr_share_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_clndr_share_calendar` (
  `owner` varchar(255) COLLATE utf8_bin NOT NULL,
  `share` varchar(255) COLLATE utf8_bin NOT NULL,
  `sharetype` varchar(6) COLLATE utf8_bin NOT NULL,
  `calendarid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `permissions` smallint(6) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_clndr_share_calendar`
--

LOCK TABLES `oc7_clndr_share_calendar` WRITE;
/*!40000 ALTER TABLE `oc7_clndr_share_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_clndr_share_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_clndr_share_event`
--

DROP TABLE IF EXISTS `oc7_clndr_share_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_clndr_share_event` (
  `owner` varchar(255) COLLATE utf8_bin NOT NULL,
  `share` varchar(255) COLLATE utf8_bin NOT NULL,
  `sharetype` varchar(6) COLLATE utf8_bin NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `permissions` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_clndr_share_event`
--

LOCK TABLES `oc7_clndr_share_event` WRITE;
/*!40000 ALTER TABLE `oc7_clndr_share_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_clndr_share_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_contacts_addressbooks`
--

DROP TABLE IF EXISTS `oc7_contacts_addressbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_contacts_addressbooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `displayname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `uri` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ctag` int(10) unsigned NOT NULL DEFAULT '1',
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `c_addressbook_userid_index` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_contacts_addressbooks`
--

LOCK TABLES `oc7_contacts_addressbooks` WRITE;
/*!40000 ALTER TABLE `oc7_contacts_addressbooks` DISABLE KEYS */;
INSERT INTO `oc7_contacts_addressbooks` VALUES (1,'admin','Kontakte','kontakte','',1401291998,1),(2,'negative@roundcube.owncloud.org','Contacts','contacts','',1404372624,1),(3,'positive@roundcube.owncloud.org','Contacts','contacts','',1404372642,1);
/*!40000 ALTER TABLE `oc7_contacts_addressbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_contacts_cards`
--

DROP TABLE IF EXISTS `oc7_contacts_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_contacts_cards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` int(10) unsigned NOT NULL DEFAULT '0',
  `fullname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `carddata` longtext COLLATE utf8_bin,
  `uri` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `c_addressbookid_index` (`addressbookid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_contacts_cards`
--

LOCK TABLES `oc7_contacts_cards` WRITE;
/*!40000 ALTER TABLE `oc7_contacts_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_contacts_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_contacts_cards_properties`
--

DROP TABLE IF EXISTS `oc7_contacts_cards_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_contacts_cards_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `contactid` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `preferred` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cp_name_index` (`name`),
  KEY `cp_value_index` (`value`),
  KEY `cp_contactid_index` (`contactid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_contacts_cards_properties`
--

LOCK TABLES `oc7_contacts_cards_properties` WRITE;
/*!40000 ALTER TABLE `oc7_contacts_cards_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_contacts_cards_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_dlstcharts`
--

DROP TABLE IF EXISTS `oc7_dlstcharts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_dlstcharts` (
  `stc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `stc_month` bigint(20) NOT NULL,
  `stc_dayts` bigint(20) NOT NULL,
  `stc_used` bigint(20) NOT NULL,
  `stc_total` bigint(20) NOT NULL,
  PRIMARY KEY (`stc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_dlstcharts`
--

LOCK TABLES `oc7_dlstcharts` WRITE;
/*!40000 ALTER TABLE `oc7_dlstcharts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_dlstcharts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_dlstcharts_uconf`
--

DROP TABLE IF EXISTS `oc7_dlstcharts_uconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_dlstcharts_uconf` (
  `uc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_key` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_val` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`uc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_dlstcharts_uconf`
--

LOCK TABLES `oc7_dlstcharts_uconf` WRITE;
/*!40000 ALTER TABLE `oc7_dlstcharts_uconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_dlstcharts_uconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_documents_invite`
--

DROP TABLE IF EXISTS `oc7_documents_invite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_documents_invite` (
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Related editing session id',
  `uid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `status` smallint(6) DEFAULT '0',
  `sent_on` int(10) unsigned DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_documents_invite`
--

LOCK TABLES `oc7_documents_invite` WRITE;
/*!40000 ALTER TABLE `oc7_documents_invite` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_documents_invite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_documents_member`
--

DROP TABLE IF EXISTS `oc7_documents_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_documents_member` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique per user and session',
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Related editing session id',
  `uid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `color` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `last_activity` int(10) unsigned DEFAULT NULL,
  `is_guest` smallint(5) unsigned NOT NULL DEFAULT '0',
  `token` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `status` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_documents_member`
--

LOCK TABLES `oc7_documents_member` WRITE;
/*!40000 ALTER TABLE `oc7_documents_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_documents_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_documents_op`
--

DROP TABLE IF EXISTS `oc7_documents_op`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_documents_op` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sequence number',
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Editing session id',
  `member` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'User and time specific',
  `opspec` longtext COLLATE utf8_bin COMMENT 'json-string',
  PRIMARY KEY (`seq`),
  UNIQUE KEY `documents_op_eis_idx` (`es_id`,`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_documents_op`
--

LOCK TABLES `oc7_documents_op` WRITE;
/*!40000 ALTER TABLE `oc7_documents_op` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_documents_op` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_documents_revisions`
--

DROP TABLE IF EXISTS `oc7_documents_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_documents_revisions` (
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Related editing session id',
  `seq_head` int(10) unsigned NOT NULL COMMENT 'Sequence head number',
  `member_id` int(10) unsigned NOT NULL COMMENT 'the member that saved the revision',
  `file_id` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'Relative to storage e.g. /welcome.odt',
  `save_hash` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'used to lookup revision in documents folder of member, eg hash.odt',
  UNIQUE KEY `documents_rev_eis_idx` (`es_id`,`seq_head`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_documents_revisions`
--

LOCK TABLES `oc7_documents_revisions` WRITE;
/*!40000 ALTER TABLE `oc7_documents_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_documents_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_documents_session`
--

DROP TABLE IF EXISTS `oc7_documents_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_documents_session` (
  `es_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Editing session id',
  `genesis_url` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'Relative to owner documents storage /welcome.odt',
  `genesis_hash` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'To be sure the genesis did not change',
  `file_id` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'Relative to storage e.g. /welcome.odt',
  `owner` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'oC user who created the session',
  PRIMARY KEY (`es_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_documents_session`
--

LOCK TABLES `oc7_documents_session` WRITE;
/*!40000 ALTER TABLE `oc7_documents_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_documents_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_file_map`
--

DROP TABLE IF EXISTS `oc7_file_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_file_map` (
  `logic_path` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `logic_path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `physic_path` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `physic_path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`logic_path_hash`),
  UNIQUE KEY `file_map_pp_index` (`physic_path_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_file_map`
--

LOCK TABLES `oc7_file_map` WRITE;
/*!40000 ALTER TABLE `oc7_file_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_file_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_filecache`
--

DROP TABLE IF EXISTS `oc7_filecache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_filecache` (
  `fileid` int(11) NOT NULL AUTO_INCREMENT,
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
  `permissions` int(11) DEFAULT '0',
  PRIMARY KEY (`fileid`),
  UNIQUE KEY `fs_storage_path_hash` (`storage`,`path_hash`),
  KEY `fs_parent_name_hash` (`parent`,`name`),
  KEY `fs_storage_mimetype` (`storage`,`mimetype`),
  KEY `fs_storage_mimepart` (`storage`,`mimepart`),
  KEY `fs_storage_size` (`storage`,`size`,`fileid`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_filecache`
--

LOCK TABLES `oc7_filecache` WRITE;
/*!40000 ALTER TABLE `oc7_filecache` DISABLE KEYS */;
INSERT INTO `oc7_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,0,1406722005,1401291998,0,0,'53d8dfd5e64e3',0),(12,2,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,1573838,1407580497,1404375961,0,0,'53e5f95195416',0),(13,2,'files','45b963397aa40d4a0063e0d85e4fe7a1',12,'files',2,1,6040324,1407580497,1407580494,0,0,'53e5f951ab179',31),(14,2,'files/photos','923e51351db3e8726f22ba0fa1c04d5a',13,'photos',2,1,678556,1407580497,1407580494,0,0,'53e5f951e8a06',31),(16,2,'files/documents','2d30f25cef1a92db784bc537e8bf128d',13,'documents',2,1,23383,1407580497,1407580494,0,0,'53e5f951d43e6',31),(17,2,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',13,'ownCloudUserManual.pdf',4,3,1573581,1407580494,1407580494,0,0,'53e5f94e5fc90',27),(18,2,'files/documents/example.odt','f51311bd6910ec7356d79286dcb24dec',16,'example.odt',5,3,23383,1407580494,1407580494,0,0,'53e5f950469d5',27),(20,2,'files/photos/paris.jpg','65154b90b985bff20d4923f224ca1c33',14,'paris.jpg',9,8,228761,1407580494,1407580494,0,0,'53e5f950cddda',27),(21,2,'files/photos/san francisco.jpg','e86e87a4ecd557753734e1d34fbeecec',14,'san francisco.jpg',9,8,216071,1407580494,1407580494,0,0,'53e5f950de044',27),(22,2,'files/photos/squirrel.jpg','e462c24fc17cb1a3fa3bca86d7f89593',14,'squirrel.jpg',9,8,233724,1407580494,1407580494,0,0,'53e5f950dfca1',27),(23,4,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,6377900,1426138281,1426138281,0,0,'550124aa2e8c3',31),(24,4,'files','45b963397aa40d4a0063e0d85e4fe7a1',23,'files',2,1,6377900,1426138282,1426138282,0,0,'550124aa30209',31),(34,1,'files','45b963397aa40d4a0063e0d85e4fe7a1',1,'files',2,1,6040324,1406722005,1406722002,0,0,'53d8dfd6374dc',31),(35,1,'files/photos','923e51351db3e8726f22ba0fa1c04d5a',34,'photos',2,1,678556,1406722005,1406722002,0,0,'53d8dfd69f32c',31),(36,1,'files/music','1f8cfec283cd675038bb95b599fdc75a',34,'music',2,1,3764804,1406722005,1406722002,0,0,'53d8dfd68ace9',31),(37,1,'files/documents','2d30f25cef1a92db784bc537e8bf128d',34,'documents',2,1,23383,1406722005,1406722002,0,0,'53d8dfd66c3df',31),(38,1,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',34,'ownCloudUserManual.pdf',4,3,1573581,1406722002,1406722002,0,0,'53d8dfd31c8c8',27),(39,1,'files/documents/example.odt','f51311bd6910ec7356d79286dcb24dec',37,'example.odt',5,3,23383,1406722002,1406722002,0,0,'53d8dfd49f750',27),(40,1,'files/music/projekteva-letitrain.mp3','da7d05a957a2bbbf0e74b12c1b5fcfee',36,'projekteva-letitrain.mp3',7,6,3764804,1406722002,1406722002,0,0,'53d8dfd514156',27),(41,1,'files/photos/paris.jpg','65154b90b985bff20d4923f224ca1c33',35,'paris.jpg',9,8,228761,1406722002,1406722002,0,0,'53d8dfd58c3b4',27),(42,1,'files/photos/san francisco.jpg','e86e87a4ecd557753734e1d34fbeecec',35,'san francisco.jpg',9,8,216071,1406722002,1406722002,0,0,'53d8dfd58c632',27),(43,1,'files/photos/squirrel.jpg','e462c24fc17cb1a3fa3bca86d7f89593',35,'squirrel.jpg',9,8,233724,1406722002,1406722002,0,0,'53d8dfd58c88f',27),(44,2,'files/music','1f8cfec283cd675038bb95b599fdc75a',13,'music',2,1,3764804,1407580497,1407580494,0,0,'53e5f951bfdc7',31),(45,2,'files/music/projekteva-letitrain.mp3','da7d05a957a2bbbf0e74b12c1b5fcfee',44,'projekteva-letitrain.mp3',7,6,3764804,1407580494,1407580494,0,0,'53e5f94fc44dd',27),(47,5,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,0,1426138282,1426138252,0,0,'550124aa2aee3',31),(48,5,'.ocdata','a840ac417b1f143f29a22c7261756dad',47,'.ocdata',13,3,0,1426138252,1426138252,0,0,'5501248cd518a',27),(49,5,'owncloud.log','9703bd00121351aafcb85ff51784acc5',47,'owncloud.log',13,3,0,1426137960,1426137960,0,0,'5501248cd5a7b',27),(50,4,'cache','0fea6a13c52b4d4725368f24b045ca84',23,'cache',2,1,0,1426138281,1426138281,0,0,'550124aa308d3',31),(60,4,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',24,'ownCloudUserManual.pdf',4,3,1911157,1426138281,1426138281,0,0,'550124aa31c70',27),(61,4,'files/photos','923e51351db3e8726f22ba0fa1c04d5a',24,'photos',2,1,678556,1426138281,1426138281,0,0,'550124aa32988',31),(62,4,'files/photos/squirrel.jpg','e462c24fc17cb1a3fa3bca86d7f89593',61,'squirrel.jpg',9,8,233724,1426138281,1426138281,0,0,'550124aa3573d',27),(63,4,'files/photos/paris.jpg','65154b90b985bff20d4923f224ca1c33',61,'paris.jpg',9,8,228761,1426138281,1426138281,0,0,'550124aa36626',27),(64,4,'files/photos/san francisco.jpg','e86e87a4ecd557753734e1d34fbeecec',61,'san francisco.jpg',9,8,216071,1426138282,1426138282,0,0,'550124aa37074',27),(65,4,'files/documents','2d30f25cef1a92db784bc537e8bf128d',24,'documents',2,1,23383,1426138282,1426138282,0,0,'550124aa33008',31),(66,4,'files/documents/example.odt','f51311bd6910ec7356d79286dcb24dec',65,'example.odt',5,3,23383,1426138282,1426138282,0,0,'550124aa38f13',27),(67,4,'files/music','1f8cfec283cd675038bb95b599fdc75a',24,'music',2,1,3764804,1426138282,1426138282,0,0,'550124aa33f3a',31),(68,4,'files/music/projekteva-letitrain.mp3','da7d05a957a2bbbf0e74b12c1b5fcfee',67,'projekteva-letitrain.mp3',7,6,3764804,1426138282,1426138282,0,0,'550124aa3a82d',27);
/*!40000 ALTER TABLE `oc7_filecache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_files_trash`
--

DROP TABLE IF EXISTS `oc7_files_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_files_trash` (
  `id` varchar(250) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timestamp` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `location` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(4) COLLATE utf8_bin DEFAULT NULL,
  `mime` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`auto_id`),
  KEY `id_index` (`id`),
  KEY `timestamp_index` (`timestamp`),
  KEY `user_index` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_files_trash`
--

LOCK TABLES `oc7_files_trash` WRITE;
/*!40000 ALTER TABLE `oc7_files_trash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_files_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_gallery_sharing`
--

DROP TABLE IF EXISTS `oc7_gallery_sharing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_gallery_sharing` (
  `token` varchar(64) COLLATE utf8_bin NOT NULL,
  `gallery_id` int(11) NOT NULL DEFAULT '0',
  `recursive` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_gallery_sharing`
--

LOCK TABLES `oc7_gallery_sharing` WRITE;
/*!40000 ALTER TABLE `oc7_gallery_sharing` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_gallery_sharing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_group_admin`
--

DROP TABLE IF EXISTS `oc7_group_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_group_admin` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `group_admin_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_group_admin`
--

LOCK TABLES `oc7_group_admin` WRITE;
/*!40000 ALTER TABLE `oc7_group_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_group_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_group_user`
--

DROP TABLE IF EXISTS `oc7_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_group_user` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_group_user`
--

LOCK TABLES `oc7_group_user` WRITE;
/*!40000 ALTER TABLE `oc7_group_user` DISABLE KEYS */;
INSERT INTO `oc7_group_user` VALUES ('admin','admin');
/*!40000 ALTER TABLE `oc7_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_groups`
--

DROP TABLE IF EXISTS `oc7_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_groups` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_groups`
--

LOCK TABLES `oc7_groups` WRITE;
/*!40000 ALTER TABLE `oc7_groups` DISABLE KEYS */;
INSERT INTO `oc7_groups` VALUES ('admin');
/*!40000 ALTER TABLE `oc7_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_jobs`
--

DROP TABLE IF EXISTS `oc7_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `argument` varchar(256) COLLATE utf8_bin NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `job_class_index` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_jobs`
--

LOCK TABLES `oc7_jobs` WRITE;
/*!40000 ALTER TABLE `oc7_jobs` DISABLE KEYS */;
INSERT INTO `oc7_jobs` VALUES (1,'OC\\Cache\\FileGlobalGC','null',1426138302),(2,'OC\\BackgroundJob\\Legacy\\RegularJob','[\"\\\\OC\\\\Files\\\\Cache\\\\BackgroundWatcher\",\"checkNext\"]',1426135806),(3,'OC\\BackgroundJob\\Legacy\\RegularJob','[\"OC_RoundCube_AuthHelper\",\"refresh\"]',1426135816),(4,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',1426135795),(5,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',1426138277);
/*!40000 ALTER TABLE `oc7_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_locks`
--

DROP TABLE IF EXISTS `oc7_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_locks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `owner` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `timeout` int(10) unsigned DEFAULT NULL,
  `created` bigint(20) DEFAULT NULL,
  `token` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `scope` smallint(6) DEFAULT NULL,
  `depth` smallint(6) DEFAULT NULL,
  `uri` longtext COLLATE utf8_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_locks`
--

LOCK TABLES `oc7_locks` WRITE;
/*!40000 ALTER TABLE `oc7_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_lucene_status`
--

DROP TABLE IF EXISTS `oc7_lucene_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_lucene_status` (
  `fileid` int(11) NOT NULL DEFAULT '0',
  `status` varchar(1) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`fileid`),
  KEY `status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_lucene_status`
--

LOCK TABLES `oc7_lucene_status` WRITE;
/*!40000 ALTER TABLE `oc7_lucene_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_lucene_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_mimetypes`
--

DROP TABLE IF EXISTS `oc7_mimetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_mimetypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mimetype` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mimetype_id_index` (`mimetype`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_mimetypes`
--

LOCK TABLES `oc7_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc7_mimetypes` DISABLE KEYS */;
INSERT INTO `oc7_mimetypes` VALUES (3,'application'),(13,'application/octet-stream'),(4,'application/pdf'),(5,'application/vnd.oasis.opendocument.text'),(12,'application/vnd.openxmlformats-officedocument.presentationml.presentation'),(11,'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),(10,'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),(6,'audio'),(7,'audio/mpeg'),(1,'httpd'),(2,'httpd/unix-directory'),(8,'image'),(9,'image/jpeg');
/*!40000 ALTER TABLE `oc7_mimetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_permissions`
--

DROP TABLE IF EXISTS `oc7_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_permissions` (
  `fileid` int(11) NOT NULL DEFAULT '0',
  `user` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `permissions` int(11) NOT NULL DEFAULT '0',
  KEY `id_user_index` (`fileid`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_permissions`
--

LOCK TABLES `oc7_permissions` WRITE;
/*!40000 ALTER TABLE `oc7_permissions` DISABLE KEYS */;
INSERT INTO `oc7_permissions` VALUES (17,'negative@roundcube.owncloud.org',27),(46,'positive@roundcube.owncloud.org',27),(38,'admin',27),(34,'admin',31),(37,'admin',31),(36,'admin',31),(35,'admin',31),(27,'positive@roundcube.owncloud.org',31),(26,'positive@roundcube.owncloud.org',31),(25,'positive@roundcube.owncloud.org',31);
/*!40000 ALTER TABLE `oc7_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_pictures_images_cache`
--

DROP TABLE IF EXISTS `oc7_pictures_images_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_pictures_images_cache` (
  `uid_owner` varchar(64) COLLATE utf8_bin NOT NULL,
  `path` varchar(256) COLLATE utf8_bin NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_pictures_images_cache`
--

LOCK TABLES `oc7_pictures_images_cache` WRITE;
/*!40000 ALTER TABLE `oc7_pictures_images_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_pictures_images_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_preferences`
--

DROP TABLE IF EXISTS `oc7_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_preferences` (
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin,
  PRIMARY KEY (`userid`,`appid`,`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_preferences`
--

LOCK TABLES `oc7_preferences` WRITE;
/*!40000 ALTER TABLE `oc7_preferences` DISABLE KEYS */;
INSERT INTO `oc7_preferences` VALUES ('admin','files','cache_version','5'),('admin','firstrunwizard','show','0'),('admin','login','lastLogin','1406722185'),('false','contacts','contacts_properties_indexed','yes'),('negative@roundcube.owncloud.org','files','cache_version','5'),('negative@roundcube.owncloud.org','firstrunwizard','show','0'),('negative@roundcube.owncloud.org','login','lastLogin','1407580493'),('positive@roundcube.owncloud.org','contacts','lastgroup','all'),('positive@roundcube.owncloud.org','files','cache_version','5'),('positive@roundcube.owncloud.org','firstrunwizard','show','0'),('positive@roundcube.owncloud.org','login','lastLogin','1426138281');
/*!40000 ALTER TABLE `oc7_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_privatedata`
--

DROP TABLE IF EXISTS `oc7_privatedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_privatedata` (
  `keyid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `app` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `key` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`keyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_privatedata`
--

LOCK TABLES `oc7_privatedata` WRITE;
/*!40000 ALTER TABLE `oc7_privatedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_privatedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_properties`
--

DROP TABLE IF EXISTS `oc7_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertypath` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertyname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertyvalue` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `property_index` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_properties`
--

LOCK TABLES `oc7_properties` WRITE;
/*!40000 ALTER TABLE `oc7_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_roundcube`
--

DROP TABLE IF EXISTS `oc7_roundcube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_roundcube` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `oc_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_password` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_roundcube`
--

LOCK TABLES `oc7_roundcube` WRITE;
/*!40000 ALTER TABLE `oc7_roundcube` DISABLE KEYS */;
INSERT INTO `oc7_roundcube` VALUES (1,'positive@roundcube.owncloud.org','',''),(2,'negative@roundcube.owncloud.org','',''),(3,'admin','','');
/*!40000 ALTER TABLE `oc7_roundcube` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_share`
--

DROP TABLE IF EXISTS `oc7_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `mail_send` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `item_share_type_index` (`item_type`,`share_type`),
  KEY `file_source_index` (`file_source`),
  KEY `token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_share`
--

LOCK TABLES `oc7_share` WRITE;
/*!40000 ALTER TABLE `oc7_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_share_external`
--

DROP TABLE IF EXISTS `oc7_share_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_share_external` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remote` varchar(512) COLLATE utf8_bin NOT NULL COMMENT 'Url of the remove owncloud instance',
  `share_token` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Public share token',
  `password` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Optional password for the public share',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Original name on the remote server',
  `owner` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'User that owns the public share on the remote server',
  `user` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Local user which added the external share',
  `mountpoint` varchar(4000) COLLATE utf8_bin NOT NULL COMMENT 'Full path where the share is mounted',
  `mountpoint_hash` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'md5 hash of the mountpoint',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sh_external_mp` (`user`,`mountpoint_hash`),
  KEY `sh_external_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_share_external`
--

LOCK TABLES `oc7_share_external` WRITE;
/*!40000 ALTER TABLE `oc7_share_external` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_share_external` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_storagecharts2`
--

DROP TABLE IF EXISTS `oc7_storagecharts2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_storagecharts2` (
  `stc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `stc_month` bigint(20) NOT NULL,
  `stc_dayts` bigint(20) NOT NULL,
  `stc_used` double NOT NULL,
  `stc_total` double NOT NULL,
  PRIMARY KEY (`stc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_storagecharts2`
--

LOCK TABLES `oc7_storagecharts2` WRITE;
/*!40000 ALTER TABLE `oc7_storagecharts2` DISABLE KEYS */;
INSERT INTO `oc7_storagecharts2` VALUES (1,'admin',201407,1404345600,18506249,1657109111305),(2,'admin',201407,1406678400,18640400,1652918066704),(3,'negative@roundcube.owncloud.org',201407,1406678400,18566821,1652918124197),(4,'positive@roundcube.owncloud.org',201407,1406678400,18449214,1652915671870),(5,'negative@roundcube.owncloud.org',201408,1407542400,6124817,1651559183633),(6,'positive@roundcube.owncloud.org',201503,1426118400,6482489,12870085177);
/*!40000 ALTER TABLE `oc7_storagecharts2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_storagecharts2_uconf`
--

DROP TABLE IF EXISTS `oc7_storagecharts2_uconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_storagecharts2_uconf` (
  `uc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_key` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_val` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`uc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_storagecharts2_uconf`
--

LOCK TABLES `oc7_storagecharts2_uconf` WRITE;
/*!40000 ALTER TABLE `oc7_storagecharts2_uconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_storagecharts2_uconf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_storages`
--

DROP TABLE IF EXISTS `oc7_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_storages` (
  `id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `numeric_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`numeric_id`),
  UNIQUE KEY `storages_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_storages`
--

LOCK TABLES `oc7_storages` WRITE;
/*!40000 ALTER TABLE `oc7_storages` DISABLE KEYS */;
INSERT INTO `oc7_storages` VALUES ('home::admin',1),('home::negative@roundcube.owncloud.org',2),('home::positive@roundcube.owncloud.org',4),('local::/var/www/oc_testing/mysql/owncloud/data/',3),('local::/var/www/owncloud/data/',5);
/*!40000 ALTER TABLE `oc7_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_users`
--

DROP TABLE IF EXISTS `oc7_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_users` (
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `displayname` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_users`
--

LOCK TABLES `oc7_users` WRITE;
/*!40000 ALTER TABLE `oc7_users` DISABLE KEYS */;
INSERT INTO `oc7_users` VALUES ('admin',NULL,'$2a$08$ppgj7UMJoLNEJHNWjKOlaOp/JO3TJ4/9VoOrhFZvsHmFe0Lm4MbDG'),('negative@roundcube.owncloud.org',NULL,'$2a$08$lkwE4UYlQ90A2b6cUNpgZOeTDRPCZrMEufih50Jeifg/dtOJ4J2MG'),('positive@roundcube.owncloud.org',NULL,'$2a$08$0b7DGj2Y6PS8lAfCuXBOd.H2cj83HX0jfZG2xy1ilnCSU54ZFgRZq');
/*!40000 ALTER TABLE `oc7_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_vcategory`
--

DROP TABLE IF EXISTS `oc7_vcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_vcategory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `category` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid_index` (`uid`),
  KEY `type_index` (`type`),
  KEY `category_index` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_vcategory`
--

LOCK TABLES `oc7_vcategory` WRITE;
/*!40000 ALTER TABLE `oc7_vcategory` DISABLE KEYS */;
INSERT INTO `oc7_vcategory` VALUES (1,'positive@roundcube.owncloud.org','event','Geburtstag'),(2,'positive@roundcube.owncloud.org','event','Gesch��ftlich'),(3,'positive@roundcube.owncloud.org','event','Anruf'),(4,'positive@roundcube.owncloud.org','event','Kunden'),(5,'positive@roundcube.owncloud.org','event','Lieferant'),(6,'positive@roundcube.owncloud.org','event','Urlaub'),(7,'positive@roundcube.owncloud.org','event','Ideen'),(8,'positive@roundcube.owncloud.org','event','Reise'),(9,'positive@roundcube.owncloud.org','event','Jubil��um'),(10,'positive@roundcube.owncloud.org','event','Treffen'),(11,'positive@roundcube.owncloud.org','event','Anderes'),(12,'positive@roundcube.owncloud.org','event','Pers��nlich'),(13,'positive@roundcube.owncloud.org','event','Projekte'),(14,'positive@roundcube.owncloud.org','event','Fragen'),(15,'positive@roundcube.owncloud.org','event','Arbeit');
/*!40000 ALTER TABLE `oc7_vcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc7_vcategory_to_object`
--

DROP TABLE IF EXISTS `oc7_vcategory_to_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc7_vcategory_to_object` (
  `objid` int(10) unsigned NOT NULL DEFAULT '0',
  `categoryid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`,`objid`,`type`),
  KEY `vcategory_objectd_index` (`objid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc7_vcategory_to_object`
--

LOCK TABLES `oc7_vcategory_to_object` WRITE;
/*!40000 ALTER TABLE `oc7_vcategory_to_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc7_vcategory_to_object` ENABLE KEYS */;
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
INSERT INTO `session` VALUES ('1','2015-01-06 18:14:55','2015-01-06 18:15:04','144.76.176.16','bGFuZ3VhZ2V8czo1OiJlbl9VUyI7dGVtcHxiOjE7c2tpbnxzOjU6ImxhcnJ5Ijt0YXNrfHM6NToibG9naW4iOw=='),('lho2uoah08s1mobfd8e9412qm3','2014-06-05 14:15:18','2014-06-05 14:17:37','213.209.99.153','bGFuZ3VhZ2V8czo1OiJkZV9ERSI7dGVtcHxiOjE7c2tpbnxzOjU6ImxhcnJ5Ijt0YXNrfHM6NToibG9naW4iOw=='),('nbfgofejdq1kftavljtffu6vp1','2015-03-12 05:31:21','2015-03-12 05:31:21','127.0.0.1','dGVtcHxiOjE7bGFuZ3VhZ2V8czo1OiJlbl9VUyI7dGFza3xzOjU6ImxvZ2luIjs=');
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
INSERT INTO `users` VALUES (1,'positive@roundcube.owncloud.org','localhost','2014-06-05 14:15:08','2014-06-05 14:15:08','de_DE',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-12  5:32:31
