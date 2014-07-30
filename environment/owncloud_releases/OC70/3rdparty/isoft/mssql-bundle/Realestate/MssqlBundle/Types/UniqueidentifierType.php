<?php
/**
 * 
 *
 * @author      Ken Golovin <ken@webplanet.co.nz>
 */

namespace Realestate\MssqlBundle\Types;

use Doctrine\DBAL\Platforms\AbstractPlatform;
use Doctrine\DBAL\Types\Type;

/**
 * Type that maps an MSSQL uniqueidentifier to a PHP string.
 *
 */
class UniqueidentifierType extends Type
{
    /** @override */
    public function getSQLDeclaration(array $fieldDeclaration, AbstractPlatform $platform)
    {
        return $platform->getVarcharTypeDeclarationSQL($fieldDeclaration);
    }

    /** @override */
    public function getDefaultLength(AbstractPlatform $platform)
    {
        return null;
    }

    /** @override */
    public function getName()
    {
        return 'uniqueidentifier';
    }

    public function convertToPHPValue($value, AbstractPlatform $platform)
    {
        if(strlen($value) != 36)
        {
            // cast the mssql uniqueidentifier to a string
            $value = mssql_guid_string($value);
        }

        return $value;
    }
}