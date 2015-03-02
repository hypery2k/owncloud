-- OWNCLOUD ---

--
-- Table structures
--

DROP TABLE IF EXISTS `oc_roundcube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_roundcube` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `oc_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_password` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `oc_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_preferences` (
  `userid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `appid` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`userid`,`appid`,`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `oc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_users` (
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `displayname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Test Setup
--

LOCK TABLES `oc_roundcube` WRITE;
/*!40000 ALTER TABLE `oc_roundcube` DISABLE KEYS */;
INSERT INTO `oc_roundcube` VALUES (1,'positive@roundcube.owncloud.org','',''),(2,'negative@roundcube.owncloud.org','',''),(3,'admin','','');
/*!40000 ALTER TABLE `oc_roundcube` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `oc_appconfig` WRITE;
/*!40000 ALTER TABLE `oc_appconfig` DISABLE KEYS */;
INSERT INTO `oc_appconfig` VALUES ('roundcube','autoLogin','1'),('roundcube','enabled','yes'),('roundcube','installed_version','2.4.1'),('roundcube','types',''),('revealjs','enabled','yes'),('revealjs','installed_version','2.4.1'),('revealjs','types',''),('search_lucene','enabled','yes'),('storagecharts2','enabled','yes'),('storagecharts2','installed_version','2.3'),('storagecharts2','types','');
/*!40000 ALTER TABLE `oc_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `oc_jobs` WRITE;
/*!40000 ALTER TABLE `oc_jobs` DISABLE KEYS */;
INSERT INTO `oc_jobs` VALUES (999,'OC\\BackgroundJob\\Legacy\\RegularJob','[\"OC_RoundCube_AuthHelper\",\"refresh\"]',0);
/*!40000 ALTER TABLE `oc_jobs` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `oc_preferences` WRITE;
/*!40000 ALTER TABLE `oc_preferences` DISABLE KEYS */;
INSERT INTO `oc_preferences` VALUES ('admin','files','cache_version','5'),('admin','firstrunwizard','show','0'),('admin','login_token','455b6a8f51ec0b363282fab8cbb999a5','1401367750');
/*!40000 ALTER TABLE `oc_preferences` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `oc_users` WRITE;
/*!40000 ALTER TABLE `oc_users` DISABLE KEYS */;
INSERT INTO `oc_users` VALUES ('admin',NULL,'$2a$08$ppgj7UMJoLNEJHNWjKOlaOp/JO3TJ4/9VoOrhFZvsHmFe0Lm4MbDG');
INSERT INTO `oc_users` VALUES ('positive@roundcube.owncloud.org',NULL,'$2a$08$0b7DGj2Y6PS8lAfCuXBOd.H2cj83HX0jfZG2xy1ilnCSU54ZFgRZq');
INSERT INTO `oc_users` VALUES ('negative@roundcube.owncloud.org',NULL,'$2a$08$lkwE4UYlQ90A2b6cUNpgZOeTDRPCZrMEufih50Jeifg/dtOJ4J2MG');
/*!40000 ALTER TABLE `oc_users` ENABLE KEYS */;
UNLOCK TABLES;
