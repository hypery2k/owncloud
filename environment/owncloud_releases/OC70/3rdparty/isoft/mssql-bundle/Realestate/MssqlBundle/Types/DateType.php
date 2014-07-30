<?php
/**
 * Overrides default DateTimeType type to fix the issue with MSSQL's smalldatetime fields
 *
 * @author      Ken Golovin <ken@webplanet.co.nz>
 */

namespace Realestate\MssqlBundle\Types;

use Doctrine\DBAL\Platforms\AbstractPlatform;
use Doctrine\DBAL\Types\Type;
use Doctrine\DBAL\Types\DateType as BaseDateType;
use Doctrine\DBAL\Types\ConversionException;

/**
 * Type that maps an SQL DATE to a PHP DateTime object.
 *
 * @since 2.0
 */
class DateType extends BaseDateType
{
    public function getName()
    {   
        return Type::DATE;
    }   

    public function getSQLDeclaration(array $fieldDeclaration, AbstractPlatform $platform)
    {   
        return $platform->getDateTypeDeclarationSQL($fieldDeclaration);
    }   

    public function convertToDatabaseValue($value, AbstractPlatform $platform)
    {   
        return ($value !== null) 
            ? $value->format($platform->getDateFormatString()) : null;
    }   
    
    public function convertToPHPValue($value, AbstractPlatform $platform)
    {   
        if ($value === null) {
            return null;
        }   

        $val = \Realestate\MssqlBundle\Types\RealestateDateTime::createFromFormat('!'.$platform->getDateFormatString(), $value);

        if (!$val) {
            throw ConversionException::conversionFailedFormat($value, $this->getName(), $platform->getDateFormatString());
        }
        return $val;
    }       


}
