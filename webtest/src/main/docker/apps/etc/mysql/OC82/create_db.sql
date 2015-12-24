-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 24, 2015 at 12:40 PM
-- Server version: 5.5.46-0+deb8u1
-- PHP Version: 5.6.14-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `oc_testing`
--

-- --------------------------------------------------------

--
-- Table structure for table `oc8_activity`
--

CREATE TABLE IF NOT EXISTS `oc8_activity` (
`activity_id` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `user` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `affecteduser` varchar(64) COLLATE utf8_bin NOT NULL,
  `app` varchar(255) COLLATE utf8_bin NOT NULL,
  `subject` varchar(255) COLLATE utf8_bin NOT NULL,
  `subjectparams` varchar(4000) COLLATE utf8_bin NOT NULL,
  `message` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `messageparams` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `file` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `link` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `object_type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `object_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_activity`
--

INSERT INTO `oc8_activity` (`activity_id`, `timestamp`, `priority`, `type`, `user`, `affecteduser`, `app`, `subject`, `subjectparams`, `message`, `messageparams`, `file`, `link`, `object_type`, `object_id`) VALUES
(1, 1430076028, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', 'a:1:{i:0;s:18:"/phaser-master.zip";}', '', 'a:0:{}', '/phaser-master.zip', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F', NULL, 0),
(2, 1430076163, 40, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', 'a:1:{i:0;s:15:"/iMovie 211.ipa";}', '', 'a:0:{}', '/iMovie 211.ipa', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F', NULL, 0),
(3, 1436338787, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', '["\\/Documents"]', '', '[]', '/Documents', 'http://localhost:49080/owncloud/index.php/apps/files?dir=%2F', NULL, 0),
(4, 1436338787, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', '["\\/Documents\\/Example.odt"]', '', '[]', '/Documents/Example.odt', 'http://localhost:49080/owncloud/index.php/apps/files?dir=%2FDocuments', NULL, 0),
(5, 1436338787, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', '["\\/Photos"]', '', '[]', '/Photos', 'http://localhost:49080/owncloud/index.php/apps/files?dir=%2F', NULL, 0),
(6, 1436338787, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', '["\\/Photos\\/Squirrel.jpg"]', '', '[]', '/Photos/Squirrel.jpg', 'http://localhost:49080/owncloud/index.php/apps/files?dir=%2FPhotos', NULL, 0),
(7, 1436338787, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', '["\\/Photos\\/Paris.jpg"]', '', '[]', '/Photos/Paris.jpg', 'http://localhost:49080/owncloud/index.php/apps/files?dir=%2FPhotos', NULL, 0),
(8, 1436338787, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', '["\\/Photos\\/San Francisco.jpg"]', '', '[]', '/Photos/San Francisco.jpg', 'http://localhost:49080/owncloud/index.php/apps/files?dir=%2FPhotos', NULL, 0),
(9, 1436338787, 40, 'file_created', 'admin', 'admin', 'files', 'created_self', '["\\/ownCloudUserManual.pdf"]', '', '[]', '/ownCloudUserManual.pdf', 'http://localhost:49080/owncloud/index.php/apps/files?dir=%2F', NULL, 0),
(10, 1450960767, 30, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', '[false]', '', '[]', '', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=', 'files', 14),
(11, 1450960767, 30, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', '["\\/Documents"]', '', '[]', '/Documents', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F', 'files', 40),
(12, 1450960767, 30, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', '["\\/Documents\\/Example.odt"]', '', '[]', '/Documents/Example.odt', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2FDocuments', 'files', 41),
(13, 1450960767, 30, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', '["\\/Photos"]', '', '[]', '/Photos', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F', 'files', 42),
(14, 1450960767, 30, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', '["\\/Photos\\/Squirrel.jpg"]', '', '[]', '/Photos/Squirrel.jpg', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2FPhotos', 'files', 43),
(15, 1450960767, 30, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', '["\\/Photos\\/Paris.jpg"]', '', '[]', '/Photos/Paris.jpg', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2FPhotos', 'files', 44),
(16, 1450960767, 30, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', '["\\/Photos\\/San Francisco.jpg"]', '', '[]', '/Photos/San Francisco.jpg', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2FPhotos', 'files', 45),
(17, 1450960767, 30, 'file_created', 'positive@roundcube.owncloud.org', 'positive@roundcube.owncloud.org', 'files', 'created_self', '["\\/ownCloud_User_Manual.pdf"]', '', '[]', '/ownCloud_User_Manual.pdf', 'http://127.0.0.1:49080/owncloud/index.php/apps/files?dir=%2F', 'files', 46);

-- --------------------------------------------------------

--
-- Table structure for table `oc8_activity_mq`
--

CREATE TABLE IF NOT EXISTS `oc8_activity_mq` (
`mail_id` int(11) NOT NULL,
  `amq_timestamp` int(11) NOT NULL DEFAULT '0',
  `amq_latest_send` int(11) NOT NULL DEFAULT '0',
  `amq_type` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_affecteduser` varchar(64) COLLATE utf8_bin NOT NULL,
  `amq_appid` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_subject` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_subjectparams` varchar(4000) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `oc8_appconfig`
--

CREATE TABLE IF NOT EXISTS `oc8_appconfig` (
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_appconfig`
--

INSERT INTO `oc8_appconfig` (`appid`, `configkey`, `configvalue`) VALUES
('activity', 'enabled', 'yes'),
('activity', 'installed_version', '2.1.3'),
('activity', 'types', 'filesystem'),
('backgroundjob', 'lastjob', '4'),
('core', 'global_cache_gc_lastrun', '1430076256'),
('core', 'installedat', '1430075864.5067'),
('core', 'lastcron', '1450960768'),
('core', 'lastupdateResult', '{"version":{},"versionstring":{},"url":{},"web":{}}'),
('core', 'lastupdatedat', '0'),
('core', 'public_files', 'files_sharing/public.php'),
('core', 'public_gallery', 'gallery/public.php'),
('core', 'public_webdav', 'files_sharing/publicwebdav.php'),
('core', 'remote_files', 'files/appinfo/remote.php'),
('core', 'remote_webdav', 'files/appinfo/remote.php'),
('core', 'repairlegacystoragesdone', 'yes'),
('files', 'enabled', 'yes'),
('files', 'installed_version', '1.2.0'),
('files', 'types', 'filesystem'),
('files_locking', 'enabled', 'yes'),
('files_locking', 'installed_version', ''),
('files_locking', 'types', 'filesystem'),
('files_pdfviewer', 'enabled', 'yes'),
('files_pdfviewer', 'installed_version', '0.7'),
('files_pdfviewer', 'ocsid', '166049'),
('files_pdfviewer', 'types', ''),
('files_sharing', 'enabled', 'yes'),
('files_sharing', 'installed_version', '0.7.0'),
('files_sharing', 'types', 'filesystem'),
('files_texteditor', 'enabled', 'yes'),
('files_texteditor', 'installed_version', '2.0'),
('files_texteditor', 'ocsid', '166051'),
('files_texteditor', 'types', ''),
('files_trashbin', 'enabled', 'yes'),
('files_trashbin', 'installed_version', '0.7.0'),
('files_trashbin', 'types', 'filesystem'),
('files_versions', 'enabled', 'yes'),
('files_versions', 'installed_version', '1.1.0'),
('files_versions', 'types', 'filesystem'),
('files_videoviewer', 'enabled', 'yes'),
('files_videoviewer', 'installed_version', '0.1.3'),
('files_videoviewer', 'ocsid', '166054'),
('files_videoviewer', 'types', ''),
('firstrunwizard', 'enabled', 'yes'),
('firstrunwizard', 'installed_version', '1.1'),
('firstrunwizard', 'ocsid', '166055'),
('firstrunwizard', 'types', ''),
('gallery', 'enabled', 'yes'),
('gallery', 'installed_version', '14.2.0'),
('gallery', 'types', ''),
('provisioning_api', 'enabled', 'yes'),
('provisioning_api', 'installed_version', '0.3.0'),
('provisioning_api', 'types', 'filesystem'),
('revealjs', 'enabled', 'no'),
('revealjs', 'installed_version', '2.6.1'),
('revealjs', 'types', ''),
('roundcube', 'autoLogin', 'on'),
('roundcube', 'enableDebug', 'on'),
('roundcube', 'enabled', 'no'),
('roundcube', 'installed_version', '2.6.1'),
('roundcube', 'maildir', '/roundcube/'),
('roundcube', 'rcHost', ''),
('roundcube', 'rcPort', ''),
('roundcube', 'removeControlNav', ''),
('roundcube', 'removeHeaderNav', ''),
('roundcube', 'types', ''),
('storagecharts2', 'enabled', 'no'),
('storagecharts2', 'installed_version', '2.6.1'),
('storagecharts2', 'types', ''),
('templateeditor', 'enabled', 'yes'),
('templateeditor', 'installed_version', '0.1'),
('templateeditor', 'types', ''),
('updater', 'enabled', 'yes'),
('updater', 'installed_version', '0.6'),
('updater', 'types', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc8_filecache`
--

CREATE TABLE IF NOT EXISTS `oc8_filecache` (
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_filecache`
--

INSERT INTO `oc8_filecache` (`fileid`, `storage`, `path`, `path_hash`, `parent`, `name`, `mimetype`, `mimepart`, `size`, `mtime`, `storage_mtime`, `encrypted`, `unencrypted_size`, `etag`, `permissions`) VALUES
(1, 1, '', 'd41d8cd98f00b204e9800998ecf8427e', -1, '', 2, 1, 2930658, 1436338787, 1436338787, 0, 0, '559cca6391ad2', 23),
(2, 1, 'cache', '0fea6a13c52b4d4725368f24b045ca84', 1, 'cache', 2, 1, 0, 1436338787, 1436338787, 0, 0, '559cca6340a90', 31),
(3, 1, 'files', '45b963397aa40d4a0063e0d85e4fe7a1', 1, 'files', 2, 1, 2930658, 1436338787, 1436338787, 0, 0, '559cca639209c', 31),
(12, 3, '', 'd41d8cd98f00b204e9800998ecf8427e', -1, '', 2, 1, 3259772, 1450960767, 1450960767, 0, 0, '567be77f68e41', 23),
(13, 3, 'cache', '0fea6a13c52b4d4725368f24b045ca84', 12, 'cache', 2, 1, 0, 1450960767, 1450960767, 0, 0, '567be77f25b99', 31),
(14, 3, 'files', '45b963397aa40d4a0063e0d85e4fe7a1', 12, 'files', 2, 1, 3259772, 1450960767, 1450960767, 0, 0, '567be77f6995e', 31),
(23, 4, '', 'd41d8cd98f00b204e9800998ecf8427e', -1, '', 2, 1, 2486024, 1430076363, 1430076363, 0, 0, '553d3bcbdd2c6', 23),
(24, 4, 'cache', '0fea6a13c52b4d4725368f24b045ca84', 23, 'cache', 2, 1, 0, 1430076363, 1430076363, 0, 0, '553d3bcb9372b', 31),
(25, 4, 'files', '45b963397aa40d4a0063e0d85e4fe7a1', 23, 'files', 2, 1, 2486024, 1430076363, 1430076363, 0, 0, '553d3bcbde154', 31),
(26, 4, 'files/Documents', '0ad78ba05b6961d92f7970b2b3922eca', 25, 'Documents', 2, 1, 36227, 1430076363, 1430076363, 0, 0, '553d3bcbab283', 31),
(27, 4, 'files/Documents/Example.odt', 'c89c560541b952a435783a7d51a27d50', 26, 'Example.odt', 4, 3, 36227, 1430076363, 1430076363, 0, 0, '4fb722efd8a68743cfddc2a62151004c', 27),
(28, 4, 'files/Photos', 'd01bb67e7b71dd49fd06bad922f521c9', 25, 'Photos', 2, 1, 678556, 1430076363, 1430076363, 0, 0, '553d3bcbd455a', 31),
(29, 4, 'files/Photos/Squirrel.jpg', 'de85d1da71bcd6232ad893f959063b8c', 28, 'Squirrel.jpg', 6, 5, 233724, 1430076363, 1430076363, 0, 0, 'e32cac50e3d019dd202802af67f21e7a', 27),
(30, 4, 'files/Photos/Paris.jpg', 'a208ddedf08367bbc56963107248dda5', 28, 'Paris.jpg', 6, 5, 228761, 1430076363, 1430076363, 0, 0, '5a396931a41c38eea20c90d56b806dac', 27),
(31, 4, 'files/Photos/San Francisco.jpg', '9fc714efbeaafee22f7058e73d2b1c3b', 28, 'San Francisco.jpg', 6, 5, 216071, 1430076363, 1430076363, 0, 0, '6138bac545662b1718f8971cdac8bffb', 27),
(32, 4, 'files/ownCloudUserManual.pdf', 'c8edba2d1b8eb651c107b43532c34445', 25, 'ownCloudUserManual.pdf', 7, 3, 1771241, 1430076363, 1430076363, 0, 0, 'eb367888b6a8e8e5e222e99cdc59efaf', 27),
(33, 1, 'files/Documents', '0ad78ba05b6961d92f7970b2b3922eca', 3, 'Documents', 2, 1, 36227, 1436338787, 1436338787, 0, 0, '559cca636568f', 31),
(34, 1, 'files/Documents/Example.odt', 'c89c560541b952a435783a7d51a27d50', 33, 'Example.odt', 4, 3, 36227, 1436338787, 1436338787, 0, 0, '998f1ec188e104769df4f92c719dec82', 27),
(35, 1, 'files/Photos', 'd01bb67e7b71dd49fd06bad922f521c9', 3, 'Photos', 2, 1, 678556, 1436338787, 1436338787, 0, 0, '559cca6389f5c', 31),
(36, 1, 'files/Photos/Squirrel.jpg', 'de85d1da71bcd6232ad893f959063b8c', 35, 'Squirrel.jpg', 6, 5, 233724, 1436338787, 1436338787, 0, 0, '1710a072bc2a57e76a001f7da85aa00c', 27),
(37, 1, 'files/Photos/Paris.jpg', 'a208ddedf08367bbc56963107248dda5', 35, 'Paris.jpg', 6, 5, 228761, 1436338787, 1436338787, 0, 0, 'ef86d9c61eb2d446ab781160423b4e3c', 27),
(38, 1, 'files/Photos/San Francisco.jpg', '9fc714efbeaafee22f7058e73d2b1c3b', 35, 'San Francisco.jpg', 6, 5, 216071, 1436338787, 1436338787, 0, 0, 'd023a27f08c0024cc68cb9657b2b4cae', 27),
(39, 1, 'files/ownCloudUserManual.pdf', 'c8edba2d1b8eb651c107b43532c34445', 3, 'ownCloudUserManual.pdf', 7, 3, 2215875, 1436338787, 1436338787, 0, 0, 'dafcc7f032b194087b121efae62c9879', 27),
(40, 3, 'files/Documents', '0ad78ba05b6961d92f7970b2b3922eca', 14, 'Documents', 2, 1, 36227, 1450960767, 1450960767, 0, 0, '567be77f4486f', 31),
(41, 3, 'files/Documents/Example.odt', 'c89c560541b952a435783a7d51a27d50', 40, 'Example.odt', 4, 3, 36227, 1450960767, 1450960767, 0, 0, '6e1426aed904b036b4373be139f1c981', 27),
(42, 3, 'files/Photos', 'd01bb67e7b71dd49fd06bad922f521c9', 14, 'Photos', 2, 1, 678556, 1450960767, 1450960767, 0, 0, '567be77f61f3f', 31),
(43, 3, 'files/Photos/Squirrel.jpg', 'de85d1da71bcd6232ad893f959063b8c', 42, 'Squirrel.jpg', 6, 5, 233724, 1450960767, 1450960767, 0, 0, '02849ddbd87d15e4c579592e398692b4', 27),
(44, 3, 'files/Photos/Paris.jpg', 'a208ddedf08367bbc56963107248dda5', 42, 'Paris.jpg', 6, 5, 228761, 1450960767, 1450960767, 0, 0, '09dab778fb6a99515981abb5b533db77', 27),
(45, 3, 'files/Photos/San Francisco.jpg', '9fc714efbeaafee22f7058e73d2b1c3b', 42, 'San Francisco.jpg', 6, 5, 216071, 1450960767, 1450960767, 0, 0, '2222db2da4f5644b0966c4c50f1ea622', 27),
(46, 3, 'files/ownCloud_User_Manual.pdf', 'fbaae4021d9c766fc309c54e81133013', 14, 'ownCloud_User_Manual.pdf', 7, 3, 2544989, 1450960767, 1450960767, 0, 0, '52309461bae514b65006a82f0fab16bb', 27);

-- --------------------------------------------------------

--
-- Table structure for table `oc8_files_trash`
--

CREATE TABLE IF NOT EXISTS `oc8_files_trash` (
`auto_id` int(11) NOT NULL,
  `id` varchar(250) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timestamp` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `location` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(4) COLLATE utf8_bin DEFAULT NULL,
  `mime` varchar(255) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `oc8_file_locks`
--

CREATE TABLE IF NOT EXISTS `oc8_file_locks` (
`id` int(10) unsigned NOT NULL,
  `lock` int(11) NOT NULL DEFAULT '0',
  `key` varchar(64) COLLATE utf8_bin NOT NULL,
  `ttl` int(11) NOT NULL DEFAULT '-1'
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_file_locks`
--

INSERT INTO `oc8_file_locks` (`id`, `lock`, `key`, `ttl`) VALUES
(1, 0, 'files/183eb48653d8c45a5746c0de2d517d65', 1450964367),
(2, 0, 'files/c31e581b3c2ec56f9b7b1dca2421b72e', 1450964367),
(3, 0, 'files/89c43bdb5c1481427b7a0e0b5ea9435d', 1450964367),
(4, 0, 'files/b2374ead3d8cc2bfa0a4c3568ae7b385', 1450964367),
(5, 0, 'files/4c6011c11882d042a56fd072926f9911', 1450964367),
(6, 0, 'files/696724968f473e1ba1cc7c2687610a12', 1450964367),
(7, 0, 'files/96ae9b3933b3d048718ad0d275b21333', 1450964367),
(8, 0, 'files/b18be3be89c20ff0b04bc7664aa83e73', 1450964367),
(9, 0, 'files/81c280a4f1ea09b25c4fab4a6058c116', 1450964367),
(10, 0, 'files/552f65a0f48be1bb74a9bc4e94cd0792', 1450964367),
(11, 0, 'files/978678bd0dcd9fc31ccd5ba909f6547d', 1450964367);

-- --------------------------------------------------------

--
-- Table structure for table `oc8_file_map`
--

CREATE TABLE IF NOT EXISTS `oc8_file_map` (
  `logic_path` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `logic_path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `physic_path` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `physic_path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `oc8_groups`
--

CREATE TABLE IF NOT EXISTS `oc8_groups` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_groups`
--

INSERT INTO `oc8_groups` (`gid`) VALUES
('admin');

-- --------------------------------------------------------

--
-- Table structure for table `oc8_group_admin`
--

CREATE TABLE IF NOT EXISTS `oc8_group_admin` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `oc8_group_user`
--

CREATE TABLE IF NOT EXISTS `oc8_group_user` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_group_user`
--

INSERT INTO `oc8_group_user` (`gid`, `uid`) VALUES
('admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `oc8_jobs`
--

CREATE TABLE IF NOT EXISTS `oc8_jobs` (
`id` int(10) unsigned NOT NULL,
  `class` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `argument` varchar(4000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_jobs`
--

INSERT INTO `oc8_jobs` (`id`, `class`, `argument`, `last_run`) VALUES
(2, 'OCA\\Activity\\BackgroundJob\\EmailNotification', 'null', 1436338796),
(3, 'OCA\\Activity\\BackgroundJob\\ExpireActivities', 'null', 1450960760),
(4, 'OCA\\Files_sharing\\Lib\\DeleteOrphanedSharesJob', 'null', 1450960768),
(5, 'OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash', 'null', 0),
(6, 'OCA\\Files_Versions\\BackgroundJob\\ExpireVersions', 'null', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc8_mimetypes`
--

CREATE TABLE IF NOT EXISTS `oc8_mimetypes` (
`id` int(11) NOT NULL,
  `mimetype` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_mimetypes`
--

INSERT INTO `oc8_mimetypes` (`id`, `mimetype`) VALUES
(3, 'application'),
(14, 'application/font-sfnt'),
(20, 'application/java'),
(9, 'application/octet-stream'),
(7, 'application/pdf'),
(16, 'application/postscript'),
(23, 'application/rss+xml'),
(13, 'application/vnd.android.package-archive'),
(4, 'application/vnd.oasis.opendocument.text'),
(12, 'application/vnd.openxmlformats-officedocument.presentationml.presentation'),
(11, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
(10, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),
(15, 'application/x-font'),
(19, 'application/yaml'),
(8, 'application/zip'),
(1, 'httpd'),
(2, 'httpd/unix-directory'),
(5, 'image'),
(6, 'image/jpeg'),
(17, 'image/x-dcraw'),
(18, 'text/plain'),
(24, 'text/rtf'),
(22, 'text/x-h'),
(21, 'text/x-java-source');

-- --------------------------------------------------------

--
-- Table structure for table `oc8_preferences`
--

CREATE TABLE IF NOT EXISTS `oc8_preferences` (
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_preferences`
--

INSERT INTO `oc8_preferences` (`userid`, `appid`, `configkey`, `configvalue`) VALUES
('admin', 'core', 'timezone', 'Europe/Berlin'),
('admin', 'firstrunwizard', 'show', '0'),
('admin', 'login', 'lastLogin', '1436338787'),
('positive2@roundcube.owncloud.org', 'core', 'timezone', 'Europe/Berlin'),
('positive2@roundcube.owncloud.org', 'firstrunwizard', 'show', '0'),
('positive2@roundcube.owncloud.org', 'login', 'lastLogin', '1430076363'),
('positive@roundcube.owncloud.org', 'core', 'lang', 'en'),
('positive@roundcube.owncloud.org', 'core', 'timezone', 'Europe/Berlin'),
('positive@roundcube.owncloud.org', 'firstrunwizard', 'show', '0'),
('positive@roundcube.owncloud.org', 'login', 'lastLogin', '1450960767'),
('positive@roundcube.owncloud.org', 'login_token', '57kZISwNvArqpbi68rh63tS3ETq0BsI0', '1450960767'),
('positive@roundcube.owncloud.org', 'roundcube', 'privateSSLKey', '-----BEGIN ENCRYPTED PRIVATE KEY-----\nMIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQItVx1zpKi59MCAggA\nMBQGCCqGSIb3DQMHBAitFMfvwuw5zQSCBMgTYM3bvhq9qb56KIsWdgKoDX7xZBRu\n5VKjZ/0nM2ml4BZy05hX8IpRHNaGJXgzq5YU59bZM5iI628K0CPHSATakEO5AkwV\n0y5Pb5phiJh9mYl4p0qx7sq2r0bHfpDWYXX1bNTcE3pFEmLwYxDmiCwIGS46X5XU\nL5ISvHbTqGoeMphwd2+cIgzAUlizA0/Qehb20P9MGlZOoOO9PZjne+KK9xlvmCfY\n1oRppRsnTpqQXb5zCWe1XkHu4jRjz+2/kiTetNRdU2BEC/e5V3PVLNQ6oZbYx6uu\nqEvhkJ8Dtq49fvxT6qYBDUZjICW8XsUyK+0SZlhQNMo8n7clPK4YkzsoWM2VkFS5\nFZOdzSoDf608GJ4WTLi+QEuLmjxFP+xeQ0BjOMuzvn8BYzA/pUrlbXOt8PK/Ymnw\nwyazUv+x8XFbfqsh/f/oVDtIjm5w1KizYh8J3OS1LTIhrCeh+s8GiZryPZgrse7u\nclmiI/crFfRQgyy/tEtqCpppO0ajBk4EdeoL+M61gVeBQsk+sIUtGFGPfJd0j5uM\nAjm1lT61fjkkauEWYJ0GsZIMaM/KN5AMT3HrSUBKaENIx7sY/F1mUoJa02JEMvM7\nxSTOgNHzoN5mkCyH7Sb+eehDeQBDnmdqBUpVaOqRyAd+CHi4Wv4V2c2Ht+/JeIf2\n1e55QBsQSYuJ+QywQu1ChWcfel7SKFt0uZLB6cKHvgWaEElONH4NgCMIW2z/cJ6l\nhzqKNy4fJeYLKCPJrLhk6mZ4u340IXlvPw3RsS8i4JrXfWzZrVXerK1zNj4u5HBG\nDD+3QsDu176q1aeqpPjzZAcq7xR7mcPZsGtZrb59V3Ag0lISzBlu9M68DlWnVkZ1\nLme+MJghPeygDcviYFQWqmDUJj1Zf34kZyGHBz/CEZTK1YoQqqeO6xobRXhnkwAF\nYzIYArdCc8aOIRcxrv03rEgQnzlf+Aq7+VZ9OEH0hnSyv2zuW96tSSDc0Y1KODsX\nkePi1Hi/9DMNJDNYofmUpmulQaNyxYPhVISAXLuG5NV85nyQmUEXuaybf2GItD4X\nHMkJbtlrVXpB4RNNhCAD7HCocqFCWEDO/FDp9lQxO2mYUxqzriwLaoOu1HFXYiva\n5woYYXfK6s3SrcCllaAxq1HMDn3T6vf7vUuCYh0FhiOQ1Gqj5iY6tI7ShNOgX+aS\nkvWfhHrUsXNC4gFnlKbefkm0XFpodK+gsu1UYGVsnhOAwV/edJAXy1glVLStWlwp\nYgM79yOLZHaAtJebJNaYcvhogkF8r86hCDa8G5OQ8iaz4E91dKGQ0JVPREidodP7\nhScyyiBd/Htn+rnsUIBUbCvYLE/orMW3YAkBo7uoUmBJcjj1rUh7eJb5WtYNA8m+\nl9ywzQe+IiC2ZdZmOVjfDKAUPTlECXHrQOkUqI4QWFv4QG7TDScjYOwYUY3sV3iD\naVnuHEjN91JJOlvvY7wrgB+ROPogRbKyS5QOERmikCIW70JQbz/LtebbB4ZBlg9w\nBty6LLjdxSmwrVWAg5JUqzf/TH2ajAL3KhhUid2kntvG9EnwT4kVONWVkljyAXNk\nuzXrlfy5Hxsdo8n9DVynV7xfnVdXeuvgnYy36opUagrgfwEAYGVIwy3ENPVGZPaQ\nQk8=\n-----END ENCRYPTED PRIVATE KEY-----\n'),
('positive@roundcube.owncloud.org', 'roundcube', 'publicSSLKey', '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnh/Hs3G8qytFmopuXF3j\ndxUFh4PtUNddNtn4KIIYHT/ab1pwXHJHEhMmZ/maMe2JDIMzwbPgv02boUEiWta7\nHec+/3rQak2Z+GQBTKQXuniDR0PoUT3T67hdKMEr0Lsi3GK+Yzs4K8NguQnMKRHP\nf1b2E9KF6OMQ/tvmnmCARtxfBZ0RCtv7s/qas0f0+1ho/AJP7VFKLJRjrC9eQYWv\nSdmESsQtKeyUfKVdQAc0tD6kCjJQ3FZS9jMMd3vb3jry5MLUa2h614cYlNpCUbkL\nuO0d1niTgTwbkSkru9cibHIQY88MTDqcdg4Cq44dnIzAn2rE9T0Xbp/GWvyPNaaY\nDwIDAQAB\n-----END PUBLIC KEY-----\n');

-- --------------------------------------------------------

--
-- Table structure for table `oc8_privatedata`
--

CREATE TABLE IF NOT EXISTS `oc8_privatedata` (
`keyid` int(10) unsigned NOT NULL,
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `app` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `key` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `oc8_properties`
--

CREATE TABLE IF NOT EXISTS `oc8_properties` (
`id` int(11) NOT NULL,
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertypath` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertyname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertyvalue` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `oc8_roundcube`
--

CREATE TABLE IF NOT EXISTS `oc8_roundcube` (
`id` bigint(20) NOT NULL,
  `oc_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_user` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mail_password` varchar(4096) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_roundcube`
--

INSERT INTO `oc8_roundcube` (`id`, `oc_user`, `mail_user`, `mail_password`) VALUES
(1, 'positive@roundcube.owncloud.org', '', ''),
(2, 'admin', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc8_share`
--

CREATE TABLE IF NOT EXISTS `oc8_share` (
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
-- Table structure for table `oc8_share_external`
--

CREATE TABLE IF NOT EXISTS `oc8_share_external` (
`id` int(11) NOT NULL,
  `remote` varchar(512) COLLATE utf8_bin NOT NULL COMMENT 'Url of the remove owncloud instance',
  `remote_id` int(11) NOT NULL DEFAULT '-1',
  `share_token` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Public share token',
  `password` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'Optional password for the public share',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Original name on the remote server',
  `owner` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'User that owns the public share on the remote server',
  `user` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Local user which added the external share',
  `mountpoint` varchar(4000) COLLATE utf8_bin NOT NULL COMMENT 'Full path where the share is mounted',
  `mountpoint_hash` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'md5 hash of the mountpoint',
  `accepted` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `oc8_storagecharts2`
--

CREATE TABLE IF NOT EXISTS `oc8_storagecharts2` (
`stc_id` int(10) unsigned NOT NULL,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `stc_month` bigint(20) NOT NULL,
  `stc_dayts` bigint(20) NOT NULL,
  `stc_used` double NOT NULL,
  `stc_total` double NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_storagecharts2`
--

INSERT INTO `oc8_storagecharts2` (`stc_id`, `oc_uid`, `stc_month`, `stc_dayts`, `stc_used`, `stc_total`) VALUES
(1, 'admin', 201504, 1430006400, 754678215, 16343579079),
(2, 'positive@roundcube.owncloud.org', 201504, 1430006400, 754701244, 16343495612),
(3, 'positive2@roundcube.owncloud.org', 201504, 1430006400, 757211208, 16343269448),
(4, 'admin', 201507, 1436313600, 2930658, 10920235613);

-- --------------------------------------------------------

--
-- Table structure for table `oc8_storagecharts2_uconf`
--

CREATE TABLE IF NOT EXISTS `oc8_storagecharts2_uconf` (
`uc_id` int(10) unsigned NOT NULL,
  `oc_uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_key` varchar(64) COLLATE utf8_bin NOT NULL,
  `uc_val` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_storagecharts2_uconf`
--

INSERT INTO `oc8_storagecharts2_uconf` (`uc_id`, `oc_uid`, `uc_key`, `uc_val`) VALUES
(1, 'admin', 'hu_size', '3'),
(2, 'admin', 'hu_size_hus', '3'),
(3, 'positive@roundcube.owncloud.org', 'hu_size', '3'),
(4, 'positive@roundcube.owncloud.org', 'hu_size_hus', '3');

-- --------------------------------------------------------

--
-- Table structure for table `oc8_storages`
--

CREATE TABLE IF NOT EXISTS `oc8_storages` (
  `id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
`numeric_id` int(11) NOT NULL,
  `available` int(11) NOT NULL DEFAULT '1',
  `last_checked` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_storages`
--

INSERT INTO `oc8_storages` (`id`, `numeric_id`, `available`, `last_checked`) VALUES
('home::admin', 1, 1, NULL),
('local::/var/www/owncloud/data/', 2, 1, NULL),
('home::positive@roundcube.owncloud.org', 3, 1, NULL),
('home::positive2@roundcube.owncloud.org', 4, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `oc8_users`
--

CREATE TABLE IF NOT EXISTS `oc8_users` (
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `displayname` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `oc8_users`
--

INSERT INTO `oc8_users` (`uid`, `displayname`, `password`) VALUES
('admin', NULL, '1|$2y$10$YYUoykjZyfqV3Azh8ADxTOWvz96SUbcVyKuMTBfkDpcndxLqhAWdC'),
('positive2@roundcube.owncloud.org', NULL, '1|$2y$10$c4VIk8.yJ80rLoSJIchcMeb7TZxrcz0V/N3WctFeXUoZ4uKYmyMU2'),
('positive@roundcube.owncloud.org', NULL, '1|$2y$10$D4vIIck/oLwDprW3z/8b..ikpw0xVouIoqpxhS4YZqpG0tChwJnCW');

-- --------------------------------------------------------

--
-- Table structure for table `oc8_vcategory`
--

CREATE TABLE IF NOT EXISTS `oc8_vcategory` (
`id` int(10) unsigned NOT NULL,
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `category` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `oc8_vcategory_to_object`
--

CREATE TABLE IF NOT EXISTS `oc8_vcategory_to_object` (
  `objid` int(10) unsigned NOT NULL DEFAULT '0',
  `categoryid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `oc8_activity`
--
ALTER TABLE `oc8_activity`
 ADD PRIMARY KEY (`activity_id`), ADD KEY `activity_user_time` (`affecteduser`,`timestamp`), ADD KEY `activity_filter_by` (`affecteduser`,`user`,`timestamp`), ADD KEY `activity_filter_app` (`affecteduser`,`app`,`timestamp`);

--
-- Indexes for table `oc8_activity_mq`
--
ALTER TABLE `oc8_activity_mq`
 ADD PRIMARY KEY (`mail_id`), ADD KEY `amp_user` (`amq_affecteduser`), ADD KEY `amp_latest_send_time` (`amq_latest_send`), ADD KEY `amp_timestamp_time` (`amq_timestamp`);

--
-- Indexes for table `oc8_appconfig`
--
ALTER TABLE `oc8_appconfig`
 ADD PRIMARY KEY (`appid`,`configkey`), ADD KEY `appconfig_config_key_index` (`configkey`), ADD KEY `appconfig_appid_key` (`appid`);

--
-- Indexes for table `oc8_filecache`
--
ALTER TABLE `oc8_filecache`
 ADD PRIMARY KEY (`fileid`), ADD UNIQUE KEY `fs_storage_path_hash` (`storage`,`path_hash`), ADD KEY `fs_parent_name_hash` (`parent`,`name`), ADD KEY `fs_storage_mimetype` (`storage`,`mimetype`), ADD KEY `fs_storage_mimepart` (`storage`,`mimepart`), ADD KEY `fs_storage_size` (`storage`,`size`,`fileid`);

--
-- Indexes for table `oc8_files_trash`
--
ALTER TABLE `oc8_files_trash`
 ADD PRIMARY KEY (`auto_id`), ADD KEY `id_index` (`id`), ADD KEY `timestamp_index` (`timestamp`), ADD KEY `user_index` (`user`);

--
-- Indexes for table `oc8_file_locks`
--
ALTER TABLE `oc8_file_locks`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `lock_key_index` (`key`), ADD KEY `lock_ttl_index` (`ttl`);

--
-- Indexes for table `oc8_file_map`
--
ALTER TABLE `oc8_file_map`
 ADD PRIMARY KEY (`logic_path_hash`), ADD UNIQUE KEY `file_map_pp_index` (`physic_path_hash`);

--
-- Indexes for table `oc8_groups`
--
ALTER TABLE `oc8_groups`
 ADD PRIMARY KEY (`gid`);

--
-- Indexes for table `oc8_group_admin`
--
ALTER TABLE `oc8_group_admin`
 ADD PRIMARY KEY (`gid`,`uid`), ADD KEY `group_admin_uid` (`uid`);

--
-- Indexes for table `oc8_group_user`
--
ALTER TABLE `oc8_group_user`
 ADD PRIMARY KEY (`gid`,`uid`), ADD KEY `gu_uid_index` (`uid`);

--
-- Indexes for table `oc8_jobs`
--
ALTER TABLE `oc8_jobs`
 ADD PRIMARY KEY (`id`), ADD KEY `job_class_index` (`class`);

--
-- Indexes for table `oc8_mimetypes`
--
ALTER TABLE `oc8_mimetypes`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `mimetype_id_index` (`mimetype`);

--
-- Indexes for table `oc8_preferences`
--
ALTER TABLE `oc8_preferences`
 ADD PRIMARY KEY (`userid`,`appid`,`configkey`);

--
-- Indexes for table `oc8_privatedata`
--
ALTER TABLE `oc8_privatedata`
 ADD PRIMARY KEY (`keyid`);

--
-- Indexes for table `oc8_properties`
--
ALTER TABLE `oc8_properties`
 ADD PRIMARY KEY (`id`), ADD KEY `property_index` (`userid`);

--
-- Indexes for table `oc8_roundcube`
--
ALTER TABLE `oc8_roundcube`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oc8_share`
--
ALTER TABLE `oc8_share`
 ADD PRIMARY KEY (`id`), ADD KEY `item_share_type_index` (`item_type`,`share_type`), ADD KEY `file_source_index` (`file_source`), ADD KEY `token_index` (`token`);

--
-- Indexes for table `oc8_share_external`
--
ALTER TABLE `oc8_share_external`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `sh_external_mp` (`user`,`mountpoint_hash`), ADD KEY `sh_external_user` (`user`);

--
-- Indexes for table `oc8_storagecharts2`
--
ALTER TABLE `oc8_storagecharts2`
 ADD PRIMARY KEY (`stc_id`);

--
-- Indexes for table `oc8_storagecharts2_uconf`
--
ALTER TABLE `oc8_storagecharts2_uconf`
 ADD PRIMARY KEY (`uc_id`);

--
-- Indexes for table `oc8_storages`
--
ALTER TABLE `oc8_storages`
 ADD PRIMARY KEY (`numeric_id`), ADD UNIQUE KEY `storages_id_index` (`id`);

--
-- Indexes for table `oc8_users`
--
ALTER TABLE `oc8_users`
 ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `oc8_vcategory`
--
ALTER TABLE `oc8_vcategory`
 ADD PRIMARY KEY (`id`), ADD KEY `uid_index` (`uid`), ADD KEY `type_index` (`type`), ADD KEY `category_index` (`category`);

--
-- Indexes for table `oc8_vcategory_to_object`
--
ALTER TABLE `oc8_vcategory_to_object`
 ADD PRIMARY KEY (`categoryid`,`objid`,`type`), ADD KEY `vcategory_objectd_index` (`objid`,`type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `oc8_activity`
--
ALTER TABLE `oc8_activity`
MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `oc8_activity_mq`
--
ALTER TABLE `oc8_activity_mq`
MODIFY `mail_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `oc8_filecache`
--
ALTER TABLE `oc8_filecache`
MODIFY `fileid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `oc8_files_trash`
--
ALTER TABLE `oc8_files_trash`
MODIFY `auto_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `oc8_file_locks`
--
ALTER TABLE `oc8_file_locks`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `oc8_jobs`
--
ALTER TABLE `oc8_jobs`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `oc8_mimetypes`
--
ALTER TABLE `oc8_mimetypes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `oc8_privatedata`
--
ALTER TABLE `oc8_privatedata`
MODIFY `keyid` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `oc8_properties`
--
ALTER TABLE `oc8_properties`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `oc8_roundcube`
--
ALTER TABLE `oc8_roundcube`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `oc8_share`
--
ALTER TABLE `oc8_share`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `oc8_share_external`
--
ALTER TABLE `oc8_share_external`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `oc8_storagecharts2`
--
ALTER TABLE `oc8_storagecharts2`
MODIFY `stc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `oc8_storagecharts2_uconf`
--
ALTER TABLE `oc8_storagecharts2_uconf`
MODIFY `uc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `oc8_storages`
--
ALTER TABLE `oc8_storages`
MODIFY `numeric_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `oc8_vcategory`
--
ALTER TABLE `oc8_vcategory`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
