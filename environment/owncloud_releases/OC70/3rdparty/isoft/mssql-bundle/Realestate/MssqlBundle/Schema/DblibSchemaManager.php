<?php

namespace Realestate\MssqlBundle\Schema;

use Doctrine\DBAL\Schema\SQLServerSchemaManager;
use Doctrine\DBAL\Schema\ForeignKeyConstraint;

/**
 * Schema manager for the MsSql/Dblib RDBMS.
 *
 * @license     http://www.opensource.org/licenses/lgpl-license.php LGPL
 * @author      Scott Morken <scott.morken@pcmail.maricopa.edu>
 * @author      Konsta Vesterinen <kvesteri@cc.hut.fi>
 * @author      Lukas Smith <smith@pooteeweet.org> (PEAR MDB2 library)
 * @author      Roman Borschel <roman@code-factory.org>
 * @author      Benjamin Eberlei <kontakt@beberlei.de>
 * @version     $Revision$
 * @since       2.0
 */

class DblibSchemaManager extends SQLServerSchemaManager
{
    protected function _getPortableSequenceDefinition($sequence)
    {
        return end($sequence);
    }

    protected function _getPortableTableForeignKeysList($tableForeignKeys)
    {
        $list = array();
        foreach ($tableForeignKeys as $key => $value) {
            $value = \array_change_key_case($value, CASE_LOWER);
            if (!isset($list[$value['constraint_name']])) {
                if ($value['delete_rule'] == "NO ACTION") {
                    $value['delete_rule'] = null;
                }

                $list[$value['pkconstraint_name']] = array(
                    'name' => $value['pkconstraint_name'],
                    'local' => array(),
                    'foreign' => array(),
                    'foreignTable' => $value['fktable_name'],
                    'onDelete' => $value['delete_rule'],
                );
            }
            $list[$value['pkconstraint_name']]['local'][$value['deferrability']] = $value['pkcolumn_name'];
            $list[$value['pkconstraint_name']]['foreign'][$value['deferrability']] = $value['fkcolumn_name'];
        }

        $result = array();
        foreach($list AS $constraint) {
            $result[] = new ForeignKeyConstraint(
                array_values($constraint['local']), $constraint['foreignTable'],
                array_values($constraint['foreign']),  $constraint['name'],
                array('onDelete' => $constraint['onDelete'])
            );
        }

        return $result;
    }

    public function createDatabase($name)
    {
        $query = "CREATE DATABASE $name";
        if ($this->_conn->options['database_device']) {
            $query.= ' ON '.$this->_conn->options['database_device'];
            $query.= $this->_conn->options['database_size'] ? '=' .
                     $this->_conn->options['database_size'] : '';
        }
        return $this->_conn->standaloneQuery($query, null, true);
    }

    /**
     * {@inheritdoc}
     */
    public function createSequence($seqName, $start = 1, $allocationSize = 1)
    {
        $seqcolName = 'seq_col';
        $query = 'CREATE TABLE ' . $seqName . ' (' . $seqcolName .
                 ' INT PRIMARY KEY CLUSTERED IDENTITY(' . $start . ', 1) NOT NULL)';

        $res = $this->_conn->exec($query);

        if ($start == 1) {
            return true;
        }

        try {
            $query = 'SET IDENTITY_INSERT ' . $sequenceName . ' ON ' .
                     'INSERT INTO ' . $sequenceName . ' (' . $seqcolName . ') VALUES ( ' . $start . ')';
            $res = $this->_conn->exec($query);
        } catch (Exception $e) {
            $result = $this->_conn->exec('DROP TABLE ' . $sequenceName);
        }
        return true;
    }

    /**
     * lists all database sequences
     *
     * @param string|null $database
     * @return array
     */
    public function listSequences($database = null)
    {
        $query = "SELECT name FROM sysobjects WHERE xtype = 'U'";
        $tableNames = $this->_conn->fetchAll($query);

        return array_map(array($this->_conn->formatter, 'fixSequenceName'), $tableNames);
    }
   
    /**
     * lists table views
     *
     * @param string $table     database table name
     * @return array
     */
    public function listTableViews($table)
    {
        $keyName = 'INDEX_NAME';
        $pkName = 'PK_NAME';
        if ($this->_conn->getAttribute(Doctrine::ATTR_PORTABILITY) & Doctrine::PORTABILITY_FIX_CASE) {
            if ($this->_conn->getAttribute(Doctrine::ATTR_FIELD_CASE) == CASE_LOWER) {
                $keyName = strtolower($keyName);
                $pkName  = strtolower($pkName);
            } else {
                $keyName = strtoupper($keyName);
                $pkName  = strtoupper($pkName);
            }
        }
        $table = $this->_conn->quote($table, 'text');
        $query = 'EXEC sp_statistics @table_name = ' . $table;
        $indexes = $this->_conn->fetchColumn($query, $keyName);

        $query = 'EXEC sp_pkeys @table_name = ' . $table;
        $pkAll = $this->_conn->fetchColumn($query, $pkName);

        $result = array();

        foreach ($indexes as $index) {
            if ( ! in_array($index, $pkAll) && $index != null) {
                $result[] = $this->_conn->formatter->fixIndexName($index);
            }
        }

        return $result;
    }
}
