StorageCharts 2 for owncloud
========

Storage usage and statistics by using HighCharts charts. Reenable StorageCharts App for OwnCloud (7+)

Complete documentation usage in https://github.com/hypery2k/owncloud/wiki/StorageCharts2-Installation-and-Usage

### Issues known

* Some cpu workload have been reported, the problem its poor DBMS engine such as Mysql, see similar issues at OC bugtracker
* Some rare configs return bad used space if postgres or oracle are used as DB backend, all users are used same space.
