<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinCore Dolphin Core
 * @{
 */

bx_import("BxDolPaginate");

/**
 * @see BxDolPaginate
 */
class BxBasePaginate extends BxDolPaginate
{
    function __construct($aParams, $oTemplate)
    {
        parent::__construct($aParams, $oTemplate);
    }
}

/** @} */
