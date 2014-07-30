<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Driver
 *
 * @author Scott Morken <scott.morken@pcmail.maricopa.edu>
 */

namespace Realestate\MssqlBundle\Driver\PDODblib;
use Realestate\MssqlBundle\Platforms\DblibPlatform;

class Driver implements \Doctrine\DBAL\Driver
{
    /**
     * Attempts to establish a connection with the underlying driver.
     *
     * @param array $params
     * @param string $username
     * @param string $password
     * @param array $driverOptions
     * @return \Doctrine\DBAL\Driver\Connection
     */
    public function connect(array $params, $username = null, $password = null, array $driverOptions = array())
    {
        if (stristr(PHP_OS, 'WIN') && PHP_OS != 'Darwin') {
            $conn = new \Doctrine\DBAL\Driver\PDOConnection(
                $this->_constructPdoDsn($params),
                $username,
                $password,
                $driverOptions
            );
        } else {
            $conn = new Connection(
                $this->_constructPdoDsn($params),
                $username,
                $password,
                $driverOptions
            );
        }
        
        return $conn;
    }

    /**
     * Constructs the Dblib PDO DSN.
     *
     * @return string  The DSN.
     */
    private function _constructPdoDsn(array $params)
    {
        if (stristr(PHP_OS, 'WIN') && PHP_OS != 'Darwin')
        {
            // use for testing on Win
            $dsn = 'sqlsrv:server=';

            if (isset($params['host'])) {
                $dsn .= $params['host'];
            }

            if (isset($params['port']) && !empty($params['port'])) {
                $dsn .= ',' . $params['port'];
            }

            if (isset($params['dbname'])) {
                $dsn .= ';Database=' .  $params['dbname'];
            }
            return $dsn;

        } else {

            $dsn = 'dblib:';
            if (isset($params['host'])) {
                $dsn .= 'host=' . $params['host'] . ';';
            }
            if (isset($params['port'])) {
                $dsn .= 'port=' . $params['port'] . ';';
            }
            if (isset($params['dbname'])) {
                $dsn .= 'dbname=' . $params['dbname'] . ';';
            }
            // Support charset config
            if(isset($params['charset'])) {
                $dsn .= 'charset=' . $params['charset'] .';';
            }

            return $dsn;
        }
    }

    public function getDatabasePlatform()
    {
        return new DblibPlatform();
    }

    public function getSchemaManager(\Doctrine\DBAL\Connection $conn)
    {
        return new \Realestate\MssqlBundle\Schema\DblibSchemaManager($conn);
    }

    public function getName()
    {
        return 'pdo_dblib';
    }

    public function getDatabase(\Doctrine\DBAL\Connection $conn)
    {
        $params = $conn->getParams();
        return $params['dbname'];
    }
}
