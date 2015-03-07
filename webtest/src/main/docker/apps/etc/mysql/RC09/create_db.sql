-- ROUNDCUBE ---

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
INSERT INTO `system` VALUES ('roundcube-version','2013011700');
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
  `preferences` text,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`,`mail_host`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'mreinhardt','localhost','2014-05-30 00:23:10','2014-05-30 00:23:10','en_US',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


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
  `data` longtext NOT NULL,
  KEY `created_index` (`created`),
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
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `valid` tinyint(1) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `changed_index` (`changed`),
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
CREATE TABLE `cache_messages` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `data` longtext NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`mailbox`,`uid`),
  KEY `changed_index` (`changed`),
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
-- Table structure for table `cache_thread`
--

DROP TABLE IF EXISTS `cache_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_thread` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `changed_index` (`changed`),
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
INSERT INTO `identities` VALUES (1,1,'2014-05-30 00:23:10',0,1,'mreinhardt','','mreinhardt@localhost','','',NULL,0);
/*!40000 ALTER TABLE `identities` ENABLE KEYS */;
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
INSERT INTO `session` VALUES ('q9b176qsnpf5q19l6b9jm6pnl3','2014-05-30 00:23:10','2014-05-30 00:29:17','146.52.169.230','bGFuZ3VhZ2V8czo1OiJlbl9VUyI7c2tpbnxzOjU6ImxhcnJ5IjtpbWFwX25hbWVzcGFjZXxhOjQ6e3M6ODoicGVyc29uYWwiO2E6MTp7aTowO2E6Mjp7aTowO3M6MDoiIjtpOjE7czoxOiIuIjt9fXM6NToib3RoZXIiO047czo2OiJzaGFyZWQiO047czo2OiJwcmVmaXgiO3M6MDoiIjt9aW1hcF9kZWxpbWl0ZXJ8czoxOiIuIjt1c2VyX2lkfHM6MToiMSI7dXNlcm5hbWV8czoxMDoibXJlaW5oYXJkdCI7c3RvcmFnZV9ob3N0fHM6OToibG9jYWxob3N0IjtzdG9yYWdlX3BvcnR8aToxNDM7c3RvcmFnZV9zc2x8TjtwYXNzd29yZHxzOjMyOiJrTFZQajJ2R1kzeUYvZjMwaXdNeW1kemdYbyszdHhZbiI7bG9naW5fdGltZXxpOjE0MDE0MDIxOTA7dGltZXpvbmV8czoxMzoiRXVyb3BlL0JlcmxpbiI7dGFza3xzOjQ6Im1haWwiO2ltYXBfaG9zdHxzOjk6ImxvY2FsaG9zdCI7bWJveHxzOjU6IklOQk9YIjtzb3J0X2NvbHxzOjA6IiI7c29ydF9vcmRlcnxzOjQ6IkRFU0MiO1NUT1JBR0VfVEhSRUFEfGE6Mjp7aTowO3M6MTA6IlJFRkVSRU5DRVMiO2k6MTtzOjQ6IlJFRlMiO31TVE9SQUdFX1FVT1RBfGI6MDtTVE9SQUdFX0xJU1QtRVhURU5ERUR8YjoxO2xpc3RfYXR0cmlifGE6NDp7czo0OiJuYW1lIjtzOjg6Im1lc3NhZ2VzIjtzOjI6ImlkIjtzOjExOiJtZXNzYWdlbGlzdCI7czo1OiJjbGFzcyI7czoyNDoicmVjb3Jkcy10YWJsZSBzb3J0aGVhZGVyIjtzOjE1OiJvcHRpb25zbWVudWljb24iO3M6NDoidHJ1ZSI7fXNraW5fcGF0aHxzOjExOiJza2lucy9sYXJyeSI7dW5zZWVuX2NvdW50fGE6Mzp7czo1OiJJTkJPWCI7aTowO3M6NjoiRHJhZnRzIjtpOjA7czo0OiJTZW50IjtpOjA7fWZvbGRlcnN8YToxOntzOjU6IklOQk9YIjthOjI6e3M6MzoiY250IjtpOjA7czo2OiJtYXh1aWQiO2k6MDt9fQ==');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

