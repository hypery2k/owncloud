<?
class OC_RoundCube_DB_Util {

/**
 * Check if a table exists in the current database.
 *
 * @param string $table Table to search for.
 * @return bool TRUE if table exists, FALSE if no table found.
 */
static public function tableExists($table) {

    // Try a select statement against the table
    // Run it in try/catch in case PDO is in ERRMODE_EXCEPTION.
    try {

        $sql = "SELECT 1 FROM $table LIMIT 1";
        $args = array(1);

        $query = \OCP\DB::prepare($sql);
        $result = $query->execute($args);

    } catch (Exception $e) {
        // We got an exception == table not found
        return FALSE;
    }

    // Result is either boolean FALSE (no table found) or PDOStatement Object (table found)
    return $result !== FALSE;

}
}
?>
