<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinCore Dolphin Core
 * @{
 */

bx_import('BxBaseSearch');

class BxTemplSearch extends BxBaseSearch
{
    public function __construct ($aChoice = '', $oTemplate = false)
    {
        parent::__construct ($aChoice, $oTemplate);
    }
}

/** @} */
