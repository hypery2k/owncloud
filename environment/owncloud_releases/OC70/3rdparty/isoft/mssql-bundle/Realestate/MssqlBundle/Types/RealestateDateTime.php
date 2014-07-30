<?php
/**
 * 
 *
 * @author      Ken Golovin <ken@webplanet.co.nz>
 */

namespace Realestate\MssqlBundle\Types;

class RealestateDateTime extends \DateTime
{
    public function __toString()
    {
        return $this->format('Y-m-d');
    }
}

