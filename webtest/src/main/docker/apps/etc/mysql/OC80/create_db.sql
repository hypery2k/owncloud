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
INSERT INTO `oc8_appconfig` VALUES ('activity','enabled','yes'),('activity','installed_version','1.2.0'),('activity','ocsid','166038'),('activity','types','filesystem'),('backgroundjob','lastjob','1'),('core','global_cache_gc_lastrun','1425773949'),('core','installedat','1423740271.9515'),('core','lastcron','1425774051'),('core','lastupdateResult','{\"version\":{},\"versionstring\":{},\"url\":{},\"web\":{}}'),('core','lastupdatedat','1425773959'),('core','public_files','files_sharing/public.php'),('core','public_gallery','gallery/public.php'),('core','public_webdav','files_sharing/publicwebdav.php'),('core','remote_files','files/appinfo/remote.php'),('core','remote_webdav','files/appinfo/remote.php'),('core','repairlegacystoragesdone','yes'),('files','enabled','yes'),('files','installed_version','1.1.9'),('files','types','filesystem'),('files_locking','enabled','yes'),('files_locking','installed_version',''),('files_locking','types','filesystem'),('files_pdfviewer','enabled','yes'),('files_pdfviewer','installed_version','0.7'),('files_pdfviewer','ocsid','166049'),('files_pdfviewer','types',''),('files_sharing','enabled','yes'),('files_sharing','installed_version','0.6.0'),('files_sharing','ocsid','166050'),('files_sharing','types','filesystem'),('files_texteditor','enabled','yes'),('files_texteditor','installed_version','0.4'),('files_texteditor','ocsid','166051'),('files_texteditor','types',''),('files_trashbin','enabled','yes'),('files_trashbin','installed_version','0.6.2'),('files_trashbin','ocsid','166052'),('files_trashbin','types','filesystem'),('files_versions','enabled','yes'),('files_versions','installed_version','1.0.5'),('files_versions','ocsid','166053'),('files_versions','types','filesystem'),('files_videoviewer','enabled','yes'),('files_videoviewer','installed_version','0.1.3'),('files_videoviewer','ocsid','166054'),('files_videoviewer','types',''),('firstrunwizard','enabled','no'),('firstrunwizard','installed_version','1.1'),('firstrunwizard','ocsid','166055'),('firstrunwizard','types',''),('gallery','enabled','yes'),('gallery','installed_version','0.6.0'),('gallery','ocsid','166056'),('gallery','types',''),('provisioning_api','enabled','yes'),('provisioning_api','installed_version','0.2'),('provisioning_api','types','filesystem'),('revealjs','enabled','yes'),('revealjs','installed_version','1.0'),('revealjs','types',''),('roundcube','autoLogin','1'),('roundcube','enableDebug','1'),('roundcube','enabled','yes'),('roundcube','installed_version','2.5.4'),('roundcube','maildir','/roundcube/'),('roundcube','types',''),('storagecharts2','enabled','yes'),('storagecharts2','installed_version','2.6.0.1226'),('storagecharts2','types',''),('templateeditor','enabled','yes'),('templateeditor','installed_version','0.1'),('templateeditor','types',''),('updater','enabled','yes'),('updater','installed_version','0.4'),('updater','ocsid','166059'),('updater','types','');
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_filecache`
--

LOCK TABLES `oc8_filecache` WRITE;
/*!40000 ALTER TABLE `oc8_filecache` DISABLE KEYS */;
INSERT INTO `oc8_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,2486024,1425773959,1425773956,0,0,'54fb95871d2ee',23),(2,1,'files','45b963397aa40d4a0063e0d85e4fe7a1',1,'files',2,1,2486024,1425773959,1425773958,0,0,'54fb95872532c',31),(10,1,'cache','0fea6a13c52b4d4725368f24b045ca84',1,'cache',2,1,0,1425773955,1425773955,0,0,'54fb9583c713c',31),(18,3,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,2486024,1423759485,1423759479,0,0,'54dcd87dce1f6',23),(19,3,'cache','0fea6a13c52b4d4725368f24b045ca84',18,'cache',2,1,0,1423759479,1423759479,0,0,'54dcd877602d2',31),(20,3,'files','45b963397aa40d4a0063e0d85e4fe7a1',18,'files',2,1,2486024,1423759485,1423759485,0,0,'54dcd87de247c',31),(21,3,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',20,'Photos',2,1,678556,1423759483,1423759482,0,0,'54dcd87ba5d29',31),(22,3,'files/Photos/Squirrel.jpg','de85d1da71bcd6232ad893f959063b8c',21,'Squirrel.jpg',7,6,233724,1423759481,1423759481,0,0,'5c79c56960e888e7e8f7eb3b6ef8a044',27),(23,3,'files/Photos/San Francisco.jpg','9fc714efbeaafee22f7058e73d2b1c3b',21,'San Francisco.jpg',7,6,216071,1423759482,1423759482,0,0,'c2aeb32606b4aa78831864d42165da9f',27),(24,3,'files/Photos/Paris.jpg','a208ddedf08367bbc56963107248dda5',21,'Paris.jpg',7,6,228761,1423759483,1423759483,0,0,'4a5c51e63d7853dfe53b250ddff07a4c',27),(25,3,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',20,'Documents',2,1,36227,1423759484,1423759484,0,0,'54dcd87d26ea4',31),(26,3,'files/Documents/Example.odt','c89c560541b952a435783a7d51a27d50',25,'Example.odt',5,3,36227,1423759485,1423759485,0,0,'9797419ebcde1a1c520edd7de6dad345',27),(27,3,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',20,'ownCloudUserManual.pdf',4,3,1771241,1423759486,1423759486,0,0,'30e4d02f42e370e10636697e9fc9db88',27),(28,1,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',2,'Photos',2,1,678556,1425773957,1425773957,0,0,'54fb9585e32ed',31),(29,1,'files/Photos/Squirrel.jpg','de85d1da71bcd6232ad893f959063b8c',28,'Squirrel.jpg',7,6,233724,1425773956,1425773956,0,0,'ac023f70647eb9506409b792894609b8',27),(30,1,'files/Photos/San Francisco.jpg','9fc714efbeaafee22f7058e73d2b1c3b',28,'San Francisco.jpg',7,6,216071,1425773957,1425773957,0,0,'1f7da44cd7362538d05fb978f9b700e6',27),(31,1,'files/Photos/Paris.jpg','a208ddedf08367bbc56963107248dda5',28,'Paris.jpg',7,6,228761,1425773957,1425773957,0,0,'f2417a22078d1eae144d0fa2f45e70a4',27),(32,1,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',2,'Documents',2,1,36227,1425773958,1425773958,0,0,'54fb9586b3635',31),(33,1,'files/Documents/Example.odt','c89c560541b952a435783a7d51a27d50',32,'Example.odt',5,3,36227,1425773958,1425773958,0,0,'ac39529a8f6a05589e1dc8f90a65137a',27),(34,1,'files/ownCloudUserManual.pdf','c8edba2d1b8eb651c107b43532c34445',2,'ownCloudUserManual.pdf',4,3,1771241,1425773959,1425773959,0,0,'bd630335b8e9b016dc70b98432e57ad8',27);
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
INSERT INTO `oc8_jobs` VALUES (1,'OC\\Cache\\FileGlobalGC','null',1425774051),(2,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',1425773960),(3,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',1425774037);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_mimetypes`
--

LOCK TABLES `oc8_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc8_mimetypes` DISABLE KEYS */;
INSERT INTO `oc8_mimetypes` VALUES (3,'application'),(4,'application/pdf'),(11,'application/vnd.android.package-archive'),(5,'application/vnd.oasis.opendocument.text'),(10,'application/vnd.openxmlformats-officedocument.presentationml.presentation'),(9,'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),(8,'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),(1,'httpd'),(2,'httpd/unix-directory'),(6,'image'),(7,'image/jpeg');
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
INSERT INTO `oc8_preferences` VALUES ('admin','core','timezone','Europe/Berlin'),('admin','firstrunwizard','show','0'),('positive@roundcube.owncloud.org','core','timezone','Europe/Berlin'),('positive@roundcube.owncloud.org','firstrunwizard','show','0'),('positive@roundcube.owncloud.org','login','lastLogin','1423759738');
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
-- Table structure for table `oc8_roundcube`
--

DROP TABLE IF EXISTS `oc8_roundcube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_roundcube` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `oc_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_password` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_roundcube`
--

LOCK TABLES `oc8_roundcube` WRITE;
/*!40000 ALTER TABLE `oc8_roundcube` DISABLE KEYS */;
INSERT INTO `oc8_roundcube` VALUES (1,'admin','','');
/*!40000 ALTER TABLE `oc8_roundcube` ENABLE KEYS */;
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
-- Table structure for table `oc8_storagecharts2`
--

DROP TABLE IF EXISTS `oc8_storagecharts2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_storagecharts2` (
  `stc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `stc_month` bigint(20) NOT NULL,
  `stc_dayts` bigint(20) NOT NULL,
  `stc_used` double NOT NULL,
  `stc_total` double NOT NULL,
  PRIMARY KEY (`stc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_storagecharts2`
--

LOCK TABLES `oc8_storagecharts2` WRITE;
/*!40000 ALTER TABLE `oc8_storagecharts2` DISABLE KEYS */;
INSERT INTO `oc8_storagecharts2` VALUES (1,'admin',201502,1423699200,4992319,1783621537087),(2,'positive@roundcube.owncloud.org',201502,1423699200,5015405,1783621498733),(3,'admin',201503,1425772800,2590206,1715799594494);
/*!40000 ALTER TABLE `oc8_storagecharts2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc8_storagecharts2_uconf`
--

DROP TABLE IF EXISTS `oc8_storagecharts2_uconf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc8_storagecharts2_uconf` (
  `uc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_key` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_val` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`uc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_storagecharts2_uconf`
--

LOCK TABLES `oc8_storagecharts2_uconf` WRITE;
/*!40000 ALTER TABLE `oc8_storagecharts2_uconf` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc8_storagecharts2_uconf` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc8_storages`
--

LOCK TABLES `oc8_storages` WRITE;
/*!40000 ALTER TABLE `oc8_storages` DISABLE KEYS */;
INSERT INTO `oc8_storages` VALUES ('home::admin',1),('home::positive@roundcube.owncloud.org',3),('local::/var/www/oc_testing/mysql/owncloud/data/',2),('local::/var/www/owncloud/data/',4);
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
INSERT INTO `oc8_users` VALUES ('admin',NULL,'1|$2y$10$0OLDxhgcCD4Hi0wLMSqj9.AizezDkjjrBp1U5Ka/mLe/5gFHQMojS'),('negative@roundcube.owncloud.org ',NULL,'1|$2y$10$m//yY5coeUI0LjSMDUkVUusxiYnqkUptDx/g1BYOO8xub6EEDRdyi'),('positive@roundcube.owncloud.org',NULL,'1|$2y$10$cqE5p3atHjIwbdDnV5GdyOqY1bo79giTdrQXIVp7/2M9bK2CtEZYO');
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

-- Dump completed on 2015-03-08  0:20:58
