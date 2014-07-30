<?php
/**
 * Overrides default DateTimeType type to fix the issue with MSSQL's smalldatetime fields
 *
 * @author      Ken Golovin <ken@webplanet.co.nz>
 */

namespace Realestate\MssqlBundle\Types;

use Doctrine\DBAL\Platforms\AbstractPlatform;
use Doctrine\DBAL\Types\Type;
use Doctrine\DBAL\Types\DateTimeType as BaseDateTimeType;
use Doctrine\DBAL\Types\ConversionException;

/**
 * Type that maps an SQL DATETIME/TIMESTAMP to a PHP DateTime object.
 *
 * @since 2.0
 */
class DateTimeType extends BaseDateTimeType
{
    public function convertToPHPValue($value, AbstractPlatform $platform)
    {
        if ($value === null) {
            return null;
        }

        if ($value === "") {
            return null;
        }

        //
        // returned format is too unpredictable, so have to resort to strtotime()
        $timestamp = strtotime($value);

        if($timestamp === false)
        {
            $val = \DateTime::createFromFormat($platform->getDateTimeFormatString(), $value);
            //var_dump($value);exit;
            if (!$val) {
                throw ConversionException::conversionFailedFormat($value, $this->getName(), $platform->getDateTimeFormatString());
            }
        }

        $val = new \DateTime();
        $val->setTimestamp($timestamp);

        /*
        if(strpos($value, '.') !== false)
        {
            $val = \DateTime::createFromFormat($platform->getDateTimeFormatString(), $value);
            if (!$val) {
                throw ConversionException::conversionFailedFormat($value, $this->getName(), $platform->getDateTimeFormatString());
            }
        }
        else
        {
            $val = \DateTime::createFromFormat('Y-m-d H:i:s', $value);
            if (!$val) {
                throw ConversionException::conversionFailedFormat($value, $this->getName(), $platform->getDateTimeFormatString());
            }
        }
         */
        return $val;
    }

    /**
     *
     * @param DateTime $value
     * @param AbstractPlatform $platform
     * @return string|null
     */
    public function convertToDatabaseValue($value, AbstractPlatform $platform)
    {
        return ($value !== null)
            ? $value->format('Y-m-d H:i:s' . '.000') : null;
    }
}