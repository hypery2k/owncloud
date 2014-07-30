Install
-------

Add the **isoft/mssql-bundle** into **composer.json**

    "require": {
        ....
        "isoft/mssql-bundle": "master-dev"
    },

Usage
-----

Add to section doctrine - dbal in **config.yml** option **driver_class**

    doctrine:
        dbal:
            driver:         %database_driver%
            driver_class:   \Realestate\MssqlBundle\Driver\PDODblib\Driver

make sure your %database_driver% is set to pdo_dblib

*************************
In app/AppKernel.php registerBundles(), add the following line:

    $bundles = array(
        ...
        new Realestate\MssqlBundle\RealestateMssqlBundle(),
        ...
    );

*************************
In Doctrine\DBAL\DriverManager's $_driverMap property, add this driver to the list:

    'pdo_dblib' => 'Realestate\DBAL\Driver\PDODblib\Driver',


*************************
This driver requires version 8.0 (from http://www.ubuntitis.com/?p=64) as default 4.2 version does not have UTF support

In /etc/freetds/freetds.conf, change
tds version = 4.2
to
tds version = 8.0

************************
can't use nvarchar!!


*************************
In SQL 2000 SP4 or newer, SQL 2005 or SQL 2008, if you do a query that returns NTEXT type data, you may encounter the following exception:
_mssql.MssqlDatabaseError: SQL Server message 4004, severity 16, state 1, line 1:
Unicode data in a Unicode-only collation or ntext data cannot be sent to clients using DB-Library (such as ISQL) or ODBC version 3.7 or earlier.

It means that SQL Server is unable to send Unicode data to FTREETDS, because of shortcomings of FTREETDS. You have to CAST or CONVERT the data to equivalent NVARCHAR data type, which does not exhibit this behaviour.



