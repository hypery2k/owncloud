-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: oc_testing
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1-log

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
-- Table structure for table `oc8_activity`
--

DROP TABLE IF EXISTS `oc8_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_activity` (
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
-- Dumping data for table `oc8_activity`
--

LOCK TABLES `oc8_activity` WRITE;
/*!40000 ALTER TABLE `oc8_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_activity_mq`
--

DROP TABLE IF EXISTS `oc8_activity_mq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_activity_mq` (
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
-- Dumping data for table `oc8_activity_mq`
--

LOCK TABLES `oc8_activity_mq` WRITE;
/*!40000 ALTER TABLE `oc8_activity_mq` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_activity_mq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_appconfig`
--

DROP TABLE IF EXISTS `oc8_appconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_appconfig` (
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin,
  PRIMARY KEY (`appid`,`configkey`),
  KEY `appconfig_config_key_index` (`configkey`),
  KEY `appconfig_appid_key` (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_appconfig`
--

LOCK TABLES `oc8_appconfig` WRITE;
/*!40000 ALTER TABLE `oc8_appconfig` DISABLE KEYS */;
INSERT INTO `oc8_appconfig` VALUES ('activity','enabled','yes'),('activity','installed_version','1.2.0'),('activity','ocsid','166038'),('activity','types','filesystem'),('backgroundjob','lastjob','1'),('core','global_cache_gc_lastrun','1423740279'),('core','installedat','1423740271.9515'),('core','lastcron','1423740279'),('core','lastupdatedat','1423740272.0338'),('core','public_files','files_sharing/public.php'),('core','public_gallery','gallery/public.php'),('core','public_webdav','files_sharing/publicwebdav.php'),('core','remote_files','files/appinfo/remote.php'),('core','remote_webdav','files/appinfo/remote.php'),('files','enabled','yes'),('files','installed_version','1.1.9'),('files','types','filesystem'),('files_locking','enabled','yes'),('files_locking','installed_version',''),('files_locking','types','filesystem'),('files_pdfviewer','enabled','yes'),('files_pdfviewer','installed_version','0.7'),('files_pdfviewer','ocsid','166049'),('files_pdfviewer','types',''),('files_sharing','enabled','yes'),('files_sharing','installed_version','0.6.0'),('files_sharing','ocsid','166050'),('files_sharing','types','filesystem'),('files_texteditor','enabled','yes'),('files_texteditor','installed_version','0.4'),('files_texteditor','ocsid','166051'),('files_texteditor','types',''),('files_trashbin','enabled','yes'),('files_trashbin','installed_version','0.6.2'),('files_trashbin','ocsid','166052'),('files_trashbin','types','filesystem'),('files_versions','enabled','yes'),('files_versions','installed_version','1.0.5'),('files_versions','ocsid','166053'),('files_versions','types','filesystem'),('files_videoviewer','enabled','yes'),('files_videoviewer','installed_version','0.1.3'),('files_videoviewer','ocsid','166054'),('files_videoviewer','types',''),('firstrunwizard','enabled','yes'),('firstrunwizard','installed_version','1.1'),('firstrunwizard','ocsid','166055'),('firstrunwizard','types',''),('gallery','enabled','yes'),('gallery','installed_version','0.6.0'),('gallery','ocsid','166056'),('gallery','types',''),('provisioning_api','enabled','yes'),('provisioning_api','installed_version','0.2'),('provisioning_api','types','filesystem'),('templateeditor','enabled','yes'),('templateeditor','installed_version','0.1'),('templateeditor','types',''),('updater','enabled','yes'),('updater','installed_version','0.4'),('updater','ocsid','166059'),('updater','types','');
/*!40000 ALTER TABLE `oc8_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_file_map`
--

DROP TABLE IF EXISTS `oc8_file_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_file_map` (
  `logic_path` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `logic_path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `physic_path` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `physic_path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`logic_path_hash`),
  UNIQUE KEY `file_map_pp_index` (`physic_path_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_file_map`
--

LOCK TABLES `oc8_file_map` WRITE;
/*!40000 ALTER TABLE `oc8_file_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_file_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_filecache`
--

DROP TABLE IF EXISTS `oc8_filecache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_filecache` (
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_filecache`
--

LOCK TABLES `oc8_filecache` WRITE;
/*!40000 ALTER TABLE `oc8_filecache` DISABLE KEYS */;
INSERT INTO `oc8_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,2486024,1423740281,1423738600,0,0,'54dc8d79d764b',23),(2,1,'files','45b963397aa40d4a0063e0d85e4fe7a1',1,'files',2,1,2486024,1423740281,1423738607,0,0,'54dc8d79eba01',31),(3,1,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',2,'Photos',2,1,678556,1423740281,1423738604,0,0,'54dc8d7a20446',31),(4,1,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',2,'Documents',2,1,36227,1423740281,1423738606,0,0,'54dc8d7a0be48',31),(5,1,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',2,'ownCloudUserManual.pdf',4,3,1771241,1423738608,1423738608,0,0,'3003c388fa13546fac22f73fa35d93d1',27),(6,1,'files/Documents/Example.odt','c89c560541b952a435783a7d51a27d50',4,'Example.odt',5,3,36227,1423738607,1423738607,0,0,'ef71ca6a346af5ec82912912e4b25e50',27),(7,1,'files/Photos/Squirrel.jpg','de85d1da71bcd6232ad893f959063b8c',3,'Squirrel.jpg',7,6,233724,1423738603,1423738603,0,0,'96475a2ba5fa6358d49f93065550d1f7',27),(8,1,'files/Photos/San Francisco.jpg','9fc714efbeaafee22f7058e73d2b1c3b',3,'San Francisco.jpg',7,6,216071,1423738604,1423738604,0,0,'c725f872022b022f884a1350992ecd56',27),(9,1,'files/Photos/Paris.jpg','a208ddedf08367bbc56963107248dda5',3,'Paris.jpg',7,6,228761,1423738605,1423738605,0,0,'0126a4b89020f14ea58632c8a5662f3e',27),(10,1,'cache','0fea6a13c52b4d4725368f24b045ca84',1,'cache',2,1,0,1423738600,1423738600,0,0,'54dc8d7924d32',31);
/*!40000 ALTER TABLE `oc8_filecache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_files_trash`
--

DROP TABLE IF EXISTS `oc8_files_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_files_trash` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(250) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timestamp` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `location` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(4) COLLATE utf8_bin DEFAULT NULL,
  `mime` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `id_index` (`id`),
  KEY `timestamp_index` (`timestamp`),
  KEY `user_index` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_files_trash`
--

LOCK TABLES `oc8_files_trash` WRITE;
/*!40000 ALTER TABLE `oc8_files_trash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_files_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_group_admin`
--

DROP TABLE IF EXISTS `oc8_group_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_group_admin` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `group_admin_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_group_admin`
--

LOCK TABLES `oc8_group_admin` WRITE;
/*!40000 ALTER TABLE `oc8_group_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_group_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_group_user`
--

DROP TABLE IF EXISTS `oc8_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_group_user` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_group_user`
--

LOCK TABLES `oc8_group_user` WRITE;
/*!40000 ALTER TABLE `oc8_group_user` DISABLE KEYS */;
INSERT INTO `oc8_group_user` VALUES ('admin','admin');
/*!40000 ALTER TABLE `oc8_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_groups`
--

DROP TABLE IF EXISTS `oc8_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_groups` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_groups`
--

LOCK TABLES `oc8_groups` WRITE;
/*!40000 ALTER TABLE `oc8_groups` DISABLE KEYS */;
INSERT INTO `oc8_groups` VALUES ('admin');
/*!40000 ALTER TABLE `oc8_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_jobs`
--

DROP TABLE IF EXISTS `oc8_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `argument` varchar(256) COLLATE utf8_bin NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `job_class_index` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_jobs`
--

LOCK TABLES `oc8_jobs` WRITE;
/*!40000 ALTER TABLE `oc8_jobs` DISABLE KEYS */;
INSERT INTO `oc8_jobs` VALUES (1,'OC\\Cache\\FileGlobalGC','null',1423740279),(2,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',0),(3,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',0);
/*!40000 ALTER TABLE `oc8_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_locks`
--

DROP TABLE IF EXISTS `oc8_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_locks` (
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
-- Dumping data for table `oc8_locks`
--

LOCK TABLES `oc8_locks` WRITE;
/*!40000 ALTER TABLE `oc8_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_mimetypes`
--

DROP TABLE IF EXISTS `oc8_mimetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_mimetypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mimetype` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mimetype_id_index` (`mimetype`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_mimetypes`
--

LOCK TABLES `oc8_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc8_mimetypes` DISABLE KEYS */;
INSERT INTO `oc8_mimetypes` VALUES (3,'application'),(4,'application/pdf'),(5,'application/vnd.oasis.opendocument.text'),(1,'httpd'),(2,'httpd/unix-directory'),(6,'image'),(7,'image/jpeg');
/*!40000 ALTER TABLE `oc8_mimetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_preferences`
--

DROP TABLE IF EXISTS `oc8_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_preferences` (
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin,
  PRIMARY KEY (`userid`,`appid`,`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_preferences`
--

LOCK TABLES `oc8_preferences` WRITE;
/*!40000 ALTER TABLE `oc8_preferences` DISABLE KEYS */;
INSERT INTO `oc8_preferences` VALUES ('admin','firstrunwizard','show','0'),('admin','login','lastLogin','1423740272');
/*!40000 ALTER TABLE `oc8_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_privatedata`
--

DROP TABLE IF EXISTS `oc8_privatedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_privatedata` (
  `keyid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `app` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `key` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`keyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_privatedata`
--

LOCK TABLES `oc8_privatedata` WRITE;
/*!40000 ALTER TABLE `oc8_privatedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_privatedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_properties`
--

DROP TABLE IF EXISTS `oc8_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_properties` (
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
-- Dumping data for table `oc8_properties`
--

LOCK TABLES `oc8_properties` WRITE;
/*!40000 ALTER TABLE `oc8_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_share`
--

DROP TABLE IF EXISTS `oc8_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_share` (
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
-- Dumping data for table `oc8_share`
--

LOCK TABLES `oc8_share` WRITE;
/*!40000 ALTER TABLE `oc8_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_share_external`
--

DROP TABLE IF EXISTS `oc8_share_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_share_external` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remote` varchar(512) COLLATE utf8_bin NOT NULL COMMENT 'Url of the remove owncloud instance',
  `remote_id` int(11) NOT NULL,
  `share_token` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Public share token',
  `password` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'Optional password for the public share',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Original name on the remote server',
  `owner` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'User that owns the public share on the remote server',
  `user` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Local user which added the external share',
  `mountpoint` varchar(4000) COLLATE utf8_bin NOT NULL COMMENT 'Full path where the share is mounted',
  `mountpoint_hash` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'md5 hash of the mountpoint',
  `accepted` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sh_external_mp` (`user`,`mountpoint_hash`),
  KEY `sh_external_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_share_external`
--

LOCK TABLES `oc8_share_external` WRITE;
/*!40000 ALTER TABLE `oc8_share_external` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_share_external` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_storages`
--

DROP TABLE IF EXISTS `oc8_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_storages` (
  `id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `numeric_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`numeric_id`),
  UNIQUE KEY `storages_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_storages`
--

LOCK TABLES `oc8_storages` WRITE;
/*!40000 ALTER TABLE `oc8_storages` DISABLE KEYS */;
INSERT INTO `oc8_storages` VALUES ('home::admin',1),('local::/var/www/oc_testing/mysql/owncloud/data/',2);
/*!40000 ALTER TABLE `oc8_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_users`
--

DROP TABLE IF EXISTS `oc8_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_users` (
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `displayname` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_users`
--

LOCK TABLES `oc8_users` WRITE;
/*!40000 ALTER TABLE `oc8_users` DISABLE KEYS */;
INSERT INTO `oc8_users` VALUES ('admin',NULL,'1|$2y$10$0OLDxhgcCD4Hi0wLMSqj9.AizezDkjjrBp1U5Ka/mLe/5gFHQMojS');
/*!40000 ALTER TABLE `oc8_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_vcategory`
--

DROP TABLE IF EXISTS `oc8_vcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_vcategory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `category` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid_index` (`uid`),
  KEY `type_index` (`type`),
  KEY `category_index` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_vcategory`
--

LOCK TABLES `oc8_vcategory` WRITE;
/*!40000 ALTER TABLE `oc8_vcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_vcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_vcategory_to_object`
--

DROP TABLE IF EXISTS `oc8_vcategory_to_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_vcategory_to_object` (
  `objid` int(10) unsigned NOT NULL DEFAULT '0',
  `categoryid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`,`objid`,`type`),
  KEY `vcategory_objectd_index` (`objid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_vcategory_to_object`
--

LOCK TABLES `oc8_vcategory_to_object` WRITE;
/*!40000 ALTER TABLE `oc8_vcategory_to_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_vcategory_to_object` ENABLE KEYS */;
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

-- Dump completed on 2015-02-12 12:32:18
