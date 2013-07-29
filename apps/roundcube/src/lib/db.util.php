<?php
/**
 * ownCloud - roundcube db helper methods
 *
 * @author Martin Reinhardt
 * @copyright 2013 Martin Reinhardt contact@martinreinhardt-online.de
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU AFFERO GENERAL PUBLIC LICENSE for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
class OC_RoundCube_DB_Util {

	/**
	 * Check if a table exists in the current database.
	 *
	 * @param string $table Table to search for.
	 * @return bool TRUE if table exists, FALSE if no table found.
	 */
	public static function table_exists($table) {
		OCP\Util::writeLog('roundcube', 'OC_RoundCube_DB_Util.class.php: ' . 'Checking if table ' . $table . ' exists.', OCP\Util::DEBUG);
		// Try a select statement against the table
		// Run it in try/catch in case PDO is in ERRMODE_EXCEPTION.
		try {

			$sql = "SELECT 1 FROM *PREFIX*$table LIMIT 1";
			$args = array(1);

			$query = \OCP\DB::prepare($sql);
			$result = $query -> execute($args);

		} catch (Exception $e) {
			// We got an exception == table not found
			OCP\Util::writeLog('roundcube', 'OC_RoundCube_DB_Util.class.php: ' . 'Table ' . $table . ' does not exists.', OCP\Util::DEBUG);
			return FALSE;
		}

		// Result is either boolean FALSE (no table found) or PDOStatement Object (table found)
		OCP\Util::writeLog('roundcube', 'OC_RoundCube_DB_Util.class.php: ' . 'Result of check for if table ' . $table . ' exists: ' . $result, OCP\Util::DEBUG);
		return $result !== FALSE;

	}

}
?>
